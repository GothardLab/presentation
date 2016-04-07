scenario = "Touch Input Example";
active_buttons = 2;
default_font = "Courier New";
default_font_size = 20;

begin;

picture {} default;

picture {
	text { caption = " "; } resp_text;
	x = 0; y = 300;
} pic;

picture {
	text { caption = "TEST"; } debugText;
	x = 500; y = 500;
} debug;

picture {
	display_index=1;

} incorrectMonkey;

picture {
	display_index=1;

} correctMonkey;


picture{

	#display this picture on the monkey's monitor (monitor 1)
	display_index=1;
	
	#draw a white box, this is the fixspot, height/width are temporary and are updated later
	box {color = 0,255,0;height=10;width=10;display_index=1;}touchBoxM;
	
	#the position of the fixspot, this is updated according to the condition
	x=0; y=0;
}touchBoxMonkey;

picture{

	#display this picture on the monkey's monitor (monitor 1)
	display_index=1;

}itiMonkey;


begin_pcl;

# Variables for task settings (You can change these)
int touchBoxSize	=	500;			# size of touch box (pixels)
int touchWindow	=	100; 			# this is the extra room that the monkey has around the edge of the touch box (pixels)
											# if touchWindow is 10, then there is a leniency of 10 pixels on all sides of the touch box
int touchBoxX		=	0;				# x-position of the touch box (pixels)
int touchBoxY		=	0; 			# y-postition of the touch box (pixels)
int touchBoxTime	=	4000; 		# time that monkey is allowed to get to touch box (ms) per trial
int correctItiDuration	=	3000; 			# duration of the inter-trial-interval (ms)
int earlyItiDuration		=	10000; 			# duration of the inter-trial-interval (ms)
int missedItiDuration	=	10000; 			# duration of the inter-trial-interval (ms)
int numTrials 		=	5;				# Number of trials the monkey should complete
int preTrialTime	=  1000;			#Length of pretrial period in ms
int monitorWidthOffset 	= 1920;
int monitorHeightOffset = 0;
int monitorXZeroPoint = -1920;
int feedbackLength = 250; 			# time (ms) per trial which the monkey gets visual feedback of correct or incorrect response

# Variables for running the task (Don't change these)
int clockticker	=	0; 			# Used as a counter for time
int current_trial = 	0;				# Used as a counter for current trial
int hasTouched 	=	0;				# Used as a boolean for touches
int earlyTouch		= 	0;				# Used as a boolean for early touches
int missedTouches = 	0;
int earlyTouches	=	0;
int correctTouches = 0;

# Variables for tracking touches (Don't change these)
int responseCount = 0; 				# Reponse count
int pastX 			= 0; 				# Past X Coordinate of touch
int pastY 			= 0; 				# Past Y Coordinate of touch
double currentX 		= 0; 				# Current X Coordinate of touch
double currentY 		= 0; 				# Current Y Coordinate of touch
double monkeyX			= 0;				# Monkey X Coordinate of touch
double monkeyY			= 0;				# Monkey Y Coordinate of touch
int upperX			= touchBoxX + (touchBoxSize/2) + touchWindow;
int lowerX			= touchBoxX - (touchBoxSize/2) - touchWindow;
int upperY			= touchBoxY + (touchBoxSize/2) + touchWindow;
int lowerY			= touchBoxY - (touchBoxSize/2) - touchWindow;
int relativeX		= 0;
int relativeY		= 0;
int interact_display_count = 8;
int min_active_index = 1;
int response_count = 0;
string monkeyResponse = "";


# Check for touch device
touch_device tdevice = touch_device( response_manager.get_mouse( 1 ) );
if (is_null( tdevice )) then
	exit( "touch_device required for this scenario" )
end;
tdevice.set_max_buffer_count( 100 );




# ------------------ Present Incorrect Feedback Subroutine ------------------
sub
	presentIncorrectFeedback
begin
	clockticker=clock.time();
	incorrectMonkey.set_background_color( 255,0,0 );
	incorrectMonkey.present();
	loop until 
			(clock.time()-clockticker) > feedbackLength 
	begin
	end;
	default.present();
end;

# ------------------ Present Correct Feedback Subroutine ------------------
sub
	presentCorrectFeedback
begin
	clockticker=clock.time();
	correctMonkey.set_background_color( 0,255,0 );
	correctMonkey.present();
	loop until 
			(clock.time()-clockticker) > feedbackLength 
	begin
	end;
	default.present();
end;

# ------------------ Present Pre-Trial Subroutine ------------------
sub
   string presentPreTrial
begin
	
	response_data lastTouch;
   string monkeyResponseSub = "";

	
	clockticker=clock.time();
	
	hasTouched = 0;
	loop until 
			(clock.time()-clockticker) > preTrialTime || hasTouched == 1
	begin
		
		if (response_manager.response_data_count() > response_count) then
			response_count = response_manager.response_data_count();
			lastTouch = response_manager.last_response_data();
			touch_response tr = touch_response( lastTouch );
			
				debugText.set_caption( "time: " + printf( tr.time_double(), "%9.2f" ) + " "  + " " +
												"     x: " + printf( tr.x(), "%8.2f" ) +
												"     y: " + printf( tr.y(), "%8.2f" ),
												true );
				debug.present();
			
			hasTouched = 1;
			#term.print_line( "EARLY TOUCH!");
		end;
		
	end;
	
	if 
		hasTouched == 1
	then
		monkeyResponseSub = "Early";
	else 
		monkeyResponseSub = "Correct";
	end;
	
	return monkeyResponseSub
end;

# ------------------ Present ITI Subroutine ------------------
sub
	presentITI( int itiDuration )
begin
	clockticker=clock.time();
	response_data lastTouch;
	
	loop until 
			(clock.time()-clockticker) > itiDuration 
	begin
		if (response_manager.response_data_count() > response_count) then
			response_count = response_manager.response_data_count();
			#draw_response( response_manager.last_response_data(), resp_text );
			lastTouch = response_manager.last_response_data();
			touch_response tr = touch_response( lastTouch );
			
				debugText.set_caption( "time: " + printf( tr.time_double(), "%9.2f" ) + " "  + " " +
												"     x: " + printf( tr.x(), "%8.2f" ) +
												"     y: " + printf( tr.y(), "%8.2f" ),
												true );
				debug.present();
			
			#presentIncorrectFeedback();
			#term.print_line( "ITI TOUCH!");
		end;
	end;
end;

# ------------------ Present Stimulus Subroutine ------------------
sub
   string presentStimulus 
begin
	
	response_data lastTouch;
   string monkeyResponseSub = "";
	int goodTouch = 0;
	
   touchBoxM.set_height(touchBoxSize);
	touchBoxM.set_width(touchBoxSize); 
	
	clockticker=clock.time();
	
	touchBoxMonkey.present();
	hasTouched = 0;
	loop until 
			(clock.time()-clockticker) > touchBoxTime || hasTouched == 1
	begin
		
		if (response_manager.response_data_count() > response_count) then
			response_count = response_manager.response_data_count();
			#draw_response( response_manager.last_response_data(), resp_text );
			lastTouch = response_manager.last_response_data();
			touch_response tr = touch_response( lastTouch );
			
			
		
			
			currentX = tr.x();
			currentY =tr.y();
			monkeyX = currentX - monitorXZeroPoint;
			monkeyY = currentY ;
			
			
			term.print_line( "Touch at " + string( monkeyX ) + ", " + string(monkeyY ) );
				debugText.set_caption( "time: " + printf( tr.time_double(), "%9.2f" ) + " "  + " " +
												"     x: " + printf( tr.x(), "%8.2f" ) +
												"     y: " + printf( tr.y(), "%8.2f" ),
												true );
				debug.present();
				
				if 
					monkeyX <= upperX && monkeyX >= lowerX && currentY <= upperY && currentY >= lowerY 
				then
					goodTouch = 1;
				end;
				
				
			
			hasTouched = 1;
			#term.print_line( "STIIMULUS TOUCH!");
		end;
		
	end;
	
	if 
		goodTouch == 1
	then
		monkeyResponseSub = "Correct";
	else 
		monkeyResponseSub = "Missed";
	end;
	
	return monkeyResponseSub
end;

# ------------------ Main trial loop ------------------
loop 
		current_trial = 1 
until 
		current_trial > numTrials 
begin 
		
	#These two strings track the monkey's response to different parts of the trial
	string preTrialResponse = "";	
	string stimulusResponse = "";
	
	#Present the pretrial period
	preTrialResponse = presentPreTrial();
	
	#If the monkey did not respond in the pretrial period
	if 
		preTrialResponse == "Correct"
		
	then

		#Present the stimulus period
		stimulusResponse = presentStimulus();
		
		if
			stimulusResponse == "Correct"
		then
			presentCorrectFeedback();
			presentITI(correctItiDuration );
			correctTouches = correctTouches + 1;
			
		else
			presentIncorrectFeedback();
			presentITI(missedItiDuration );
			missedTouches = missedTouches + 1;
		end;
		
	else
		presentIncorrectFeedback();
		presentITI( earlyItiDuration );
		earlyTouches = earlyTouches + 1;
		
	end;
	
	current_trial = current_trial + 1;
end;

term.print_line( "Correct touches: " + string( correctTouches ));
term.print_line( " Missed touches: " + string( missedTouches ));
term.print_line( "  Early touches: " + string( earlyTouches ));