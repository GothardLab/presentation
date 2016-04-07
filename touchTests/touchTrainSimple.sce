#	Touch Training Simple (touchTrainSimple)
#	Philip Putnam, 2016, University of Arizona
#
#	This program is designed to train monkeys to use a touchscreen
#	by presenting a single square and rewarding them for touching it.
#	All parameters of the square, including the task timing, dimensions
#	and properties of the square, and touch properties are changable in
#	variables below.
#
#	Note that this program is written for two monitors, one is the 
#	touchscreen the monkey is using (display 1) and one is the
#	experimenter's monitor (display 2). Depending on the resolution
#	of these two monitors, you will need to change the X offset,
#	which is the pixel value of the center of the monkey's touchscreen.
#
#	Verison History
#		v0.1	02/03/16		First functional verison
#		v0.2	02/05/16		Added experimenter info
#
#
#




# Scenario file parameters
scenario = "Touch Training (Simple)";
active_buttons = 2;
default_font = "Courier New";
default_font_size = 20;

# ---------------------------------------------------------------------------
#										Begin SDL code
# ---------------------------------------------------------------------------
begin;

#Blank default screen
picture {} default;

#Screen to show the monkey for incorrect responses
picture {
	display_index=1;

} incorrectMonkey;

#Screen to show the monkey for correct responses
picture {
	display_index=1;

} correctMonkey;

#Screen to show the experimenter for incorrect responses
picture {
	display_index=2;

} incorrectExperimenter;

#Screen to show the experimenter for correct responses
picture {
	display_index=2;

} correctExperimenter;

#Screen to show the monkey before the trial begins
picture {
	display_index=1;

} pretrialMonkey;

#Screen to show the experimenter before the trial begins
picture {
	display_index=2;
	
	
	#draw a blue box, this is the touch marker, height/width are 3 pixels
	box {color=0,0,255;height=10;width=10;display_index=2;}touchMarkerPretrial;
	x=5000; y=5000; #the touch position is updated throughout
	on_top=true; # plot the touch positon on the top layer of the picture
	
	text { caption = "Touch_Info"; display_index=2;} touchTextPretrial;
	x = 500; y = 500; # String to display touch position
	
	text { caption = "Pre_trial"; display_index=2;} countdownTextPretrial;
	x = 0; y = 0; # String to display count down until trial
	
	text { caption = "Trial_Info"; display_index=2;} trialTextPretrial;
	x = -700; y = 500; # String to display touch position

} pretrialExperimenter;


#Touch stimulus (touchbox) to show the monkey
picture{

	#display this picture on the monkey's monitor (monitor 1)
	display_index=1;
	
	#draw a white box, this is the touchbox, height/width are temporary and are updated later
	box {color = 0,255,0;height=10;width=10;display_index=1;}touchBoxM;
	
	#the position of the touchbox
	x=0; y=0;
}touchBoxMonkey;

#Touch stimulus (touchbox) to show the experimenter
picture{

	#display this picture on the experimenter's monitor (monitor 2)
	display_index=2;
	
	box {color = 255,0,0;height=10;width=10;display_index=2;}touchBoxBoundary;
	x=0; y=0;  #the position of the touch box boundary
	
	box {color = 0,0,0; height=9;width=9; display_index=2;}touchBoxBoundaryBlack;
	x=0; y=0; #the position of the touch box boundary
	on_top=true; #draw the black box ontop of the touch box: this makes a boundary
	
	#draw a green box, this is the touch box, height/width are temporary and are updated later
	box {color = 0,255,0;height=10;width=10;display_index=2;}touchBoxE;
	x=0; y=0;
	on_top=true;
	
	#draw a blue box, this is the touch marker, height/width are 3 pixels
	box {color=0,0,255;height=10;width=10;display_index=2;}touchMarker;
	x=5000; y=5000; #the touch position is updated throughout
	on_top=true; # plot the touch positon on the top layer of the picture
	
	text { caption = "Touch_Info"; display_index=2;} touchTextTouchbox;
	x = 500; y = 500; # String to display touch position
	
	text { caption = "Trial_Info"; display_index=2;} trialTextTouchbox;
	x = -700; y = 500; # String to display touch position
	
}touchBoxExperimenter;

#Screen to show the monkey during the ITI
picture{

	#display this picture on the monkey's monitor (monitor 1)
	display_index=1;

}itiMonkey;

#Screen to show the experimenter during the ITI
picture{

	#display this picture on the monkey's monitor (monitor 1)
	display_index=2;
	
	box {color=0,0,255;height=10;width=10;display_index=2;}ititouchMarker;
	x=5000; y=5000; #the touch position is updated throughout
	on_top=true; # plot the touch positon on the top layer of the picture
	
	text { caption = "Touch_Info"; display_index=2;} touchTextITI;
	x = 500; y = 500; # String to display touch position
	
	text { caption = "Trial_Info"; display_index=2;} trialTextITI;
	x = -700; y = 500; # String to display touch position

}itiExperimenter;



# ---------------------------------------------------------------------------
#										Begin PCL code
# ---------------------------------------------------------------------------
begin_pcl;

# Variables for task settings (You can change these)
int touchBoxSize	=	500;			# size of touch box (pixels)
int touchWindow	=	100; 			# this is the extra room that the monkey has around the edge of the touch box (pixels)
											# if touchWindow is 100, then there is a leniency of 100 pixels on all sides of the touch box
int touchBoxX		=	0;				# x-position of the touch box (pixels)
int touchBoxY		=	0; 			# y-postition of the touch box (pixels)
int touchBoxTime	=	4000; 		# time that monkey is allowed to get to touch box (ms) per trial
int correctItiDuration	=	3000; # Duration of the inter-trial-interval(ms)for correct trials
int earlyItiDuration		=	10000;# Duration of the inter-trial-interval(ms) for early touches
int missedItiDuration	=	10000;# Duration of the inter-trial-interval(ms) for missed trials
int ignoredItiDuration   =	8000;	# Duration of the inter-trial-interval(ms) for ignored trials
int numTrials 		=	5;				# Number of trials the monkey should complete
int preTrialTime	=  1000;			# Length of pretrial period in ms
int monitorXZeroPoint = -1920;	# The pixel touch value of the center of the monkey's monitor (important for calibrating!)
int feedbackLength = 250; 			# time (ms) per trial which the monkey gets visual feedback of correct or incorrect response

# Variables for running the task (Don't change these)
int clockticker	=	0; 			# Counter for time
int current_trial = 	0;				# Counter for current trial
int hasTouched 	=	0;				# Boolean for touches
int earlyTouch		= 	0;				# Boolean for early touches
int missedTouches = 	0;				# Counter for missed trials
int ignoredTouches = 0;				# Counter for ignored trials
int earlyTouches	=	0;				# Counter for early touches
int correctTouches = 0;				# Counter for correct trials
int ITItouches		=	0;				# Counter for ITI touches

# Variables for tracking touches (Don't change these)
int responseCount = 0; 				# Reponse count
int pastX 			= 0; 				# Past X Coordinate of touch
int pastY 			= 0; 				# Past Y Coordinate of touch
double currentX 	= 0; 				# Current X Coordinate of touch
double currentY 	= 0; 				# Current Y Coordinate of touch
double monkeyX		= 0;				# Monkey monitor relative X Coordinate of touch
double monkeyY		= 0;				# Monkey monitor relative Y Coordinate of touch
double lastX		= 0;				# Monkey's last touch position (X Coordinate)
double lastY		= 0;				# Monkey's last touch position (Y Coordinate)
int upperX			= touchBoxX + (touchBoxSize/2) + touchWindow; # Upper touchbox limits (X)
int lowerX			= touchBoxX - (touchBoxSize/2) - touchWindow; # Lower touchbox limits (X)
int upperY			= touchBoxY + (touchBoxSize/2) + touchWindow; # Upper touchbox limits (Y)
int lowerY			= touchBoxY - (touchBoxSize/2) - touchWindow; # Lower touchbox limits (Y)
int response_count = 0;				# Total response counter
string monkeyResponse = "";		# String to hold monkey's response from trial subroutines


# Check for touch device, exit if we can't find one
touch_device tdevice = touch_device( response_manager.get_mouse( 1 ) );
if (is_null( tdevice )) then
	exit( "touch_device required for this scenario" )
end;
tdevice.set_max_buffer_count( 100 );




# ------------------ Present Incorrect Feedback Subroutine ------------------
sub
	presentIncorrectFeedback
begin
	#Get current time
	clockticker=clock.time(); 
	
	#Change background to red
	incorrectMonkey.set_background_color( 255,0,0 );
	incorrectMonkey.present();
	incorrectExperimenter.set_background_color( 255,0,0 );
	incorrectExperimenter.present();
	
	#Loop until feedback time is over
	loop until 
			(clock.time()-clockticker) > feedbackLength 
	begin
	end;

	#Change colors back to normal (black)
	incorrectMonkey.set_background_color( 0,0,0 );
	incorrectMonkey.present();
	incorrectExperimenter.set_background_color( 0,0,0 );
	incorrectExperimenter.present();
	#default.present();
end;

# ------------------ Present Correct Feedback Subroutine ------------------
sub
	presentCorrectFeedback
begin
	#Get current time
	clockticker=clock.time();
	
	#Change background to green
	correctMonkey.set_background_color( 0,255,0 );
	correctMonkey.present();
	correctExperimenter.set_background_color( 0,255,0 );
	correctExperimenter.present();
	
	#Loop until feedback time is over
	loop until 
			(clock.time()-clockticker) > feedbackLength 
	begin
	end;
	
	#Change colors back to normal (black)
	correctMonkey.set_background_color( 0,0,0 );
	correctMonkey.present();
	correctExperimenter.set_background_color( 0,0,0 );
	correctExperimenter.present();
	#default.present();
end;

# ------------------ Present Pre-Trial Subroutine ------------------
sub
   string presentPreTrial
begin
	response_data lastTouch;
	string monkeyResponseSub = "";

	/*lastTouch = response_manager.last_response_data();
	touch_response tr2 = touch_response( lastTouch );
	
	string isHolding = "Down";
	
	if (tr2.button() == 2) then isHolding = "Up" end;
	
	if #Only start the pretrial if the "button" is "up"
		isHolding == "Up"
	then*/
			trialTextPretrial.set_caption( "Trial: " + printf( current_trial, "%2d" ) + "/" + printf( numTrials, "%2d" ) + 
										"\n Correct: "+ printf( correctTouches, "%2d" ) + "/" + printf( numTrials, "%2d" ) +
										"\n Missed: "+ printf( missedTouches, "%2d" ) + "/" + printf( numTrials, "%2d" ) +
										"\n Early: "+ printf( earlyTouches, "%2d" ) + "/" + printf( numTrials, "%2d" ) +
										"\n Ignored: "+ printf( ignoredTouches, "%2d" ) + "/" + printf( numTrials, "%2d" ), true );
		pretrialMonkey.present();
		pretrialExperimenter.present();
		
		clockticker=clock.time();
		
		hasTouched = 0;
		loop until 
				(clock.time()-clockticker) > preTrialTime || hasTouched == 1
		begin
			
			/*countdownTextPretrial.set_caption( "time: " + printf( (clock.time()-clockticker), "%9d" ) ,
				true );
			countdownTextPretrial.redraw();*/
			
			if (response_manager.response_data_count() > response_count) then
				response_count = response_manager.response_data_count();
				lastTouch = response_manager.last_response_data();
				touch_response tr = touch_response( lastTouch );
													
				string state = "Down";
				if (tr.button() == 2) then state = "Up  " end;
				
				
				
				touchTextPretrial.set_caption( "Touch time: " + printf( tr.time_double(), "%9.2f" ) + " " + state + " " +
				"x: " + printf( tr.x(), "%6.1f" ) +
				"y: " + printf( tr.y(), "%6.1f" ),
				true );
													
				
													
				currentX = tr.x();
				currentY =tr.y();
				
				# Convert to relative coordinates on the monkey's monitor
				monkeyX = currentX - monitorXZeroPoint;
				monkeyY = currentY ;
				
				pretrialExperimenter.set_part_x( 1, monkeyX );  
				pretrialExperimenter.set_part_y( 1, monkeyY ); 										
				pretrialExperimenter.present();
				
				# Wait for release
				if # It was a touch and not a release
				 state == "Down"
				then
					touchTextPretrial.set_caption( "HOLDING time: " + printf( tr.time_double(), "%9.2f" ) + " " + state + " " +
					"x: " + printf( tr.x(), "%6.1f" ) +
					"y: " + printf( tr.y(), "%6.1f" ),
					true );
					touchTextPretrial.redraw();
					pretrialExperimenter.present();
					
					
					loop until 
						(response_manager.response_data_count() > response_count)
					begin
					
					end;
				end; 
					
				if  #If this was a touch and not a release
					state == "Down"
				then
					hasTouched = 1;
					presentIncorrectFeedback();
				end
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
	/*else
		monkeyResponseSub = "Holding";
	end;*/
	
	return monkeyResponseSub
end;

# ------------------ Present ITI Subroutine ------------------
sub
	presentITI( int itiDuration )
begin
	
	trialTextITI.set_caption( "Trial: " + printf( current_trial, "%2d" ) + "/" + printf( numTrials, "%2d" ) + 
										"\n Correct: "+ printf( correctTouches, "%2d" ) + "/" + printf( numTrials, "%2d" ) +
										"\n Missed: "+ printf( missedTouches, "%2d" ) + "/" + printf( numTrials, "%2d" ) +
										"\n Early: "+ printf( earlyTouches, "%2d" ) + "/" + printf( numTrials, "%2d" ) +
										"\n Ignored: "+ printf( ignoredTouches, "%2d" ) + "/" + printf( numTrials, "%2d" ), true );
	itiExperimenter.present();
	itiMonkey.present();

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
			
			currentX = tr.x();
			currentY =tr.y();
			
			# Convert to relative coordinates on the monkey's monitor
			monkeyX = currentX - monitorXZeroPoint;
			monkeyY = currentY ;
				
			string state = "Down";
			if (tr.button() == 2) then state = "Up  " end;
				
			touchTextITI.set_caption( "Touch time: " + printf( tr.time_double(), "%9.2f" ) + " " + state + " " +
			"x: " + printf( tr.x(), "%6.1f" ) +
			"y: " + printf( tr.y(), "%6.1f" ),
			true );
			touchTextITI.redraw();
			
			
			
			itiExperimenter.set_part_x( 1, monkeyX );  
			itiExperimenter.set_part_y( 1, monkeyY ); 
			itiExperimenter.present();
			itiMonkey.present();
			
				# Wait for release
				if # It was a touch and not a release
				 state == "Down"
				then
					presentIncorrectFeedback();
					itiExperimenter.present();
					itiMonkey.present();
					
					touchTextITI.set_caption( "HOLDING time: " + printf( tr.time_double(), "%9.2f" ) + " " + state + " " +
					"x: " + printf( tr.x(), "%6.1f" ) +
					"y: " + printf( tr.y(), "%6.1f" ),
					true );
					touchTextITI.redraw();
					itiExperimenter.present();
					
					loop until 
						(response_manager.response_data_count() > response_count)
					begin
					
					end;
				end; 
			
			
		end;
	end;
end;

# ------------------ Present Stimulus Subroutine ------------------
sub
   string presentStimulus 
begin
	response_data lastTouch; # Variable for tracking the last touch
   string monkeyResponseSub = ""; # String to return with results of trial
	int goodTouch = 0; # Variable for tracking if the touch was correct or not
	
	# Update the monkey's screen
   touchBoxM.set_height(touchBoxSize);
	touchBoxM.set_width(touchBoxSize); 
	
	# Update the experimenter's screen
	touchBoxBoundary.set_height(touchBoxSize+2*touchWindow); # set the height boundary of the fixspot (the extra space the monkey is allowed)
	touchBoxBoundary.set_width(touchBoxSize+2*touchWindow); # set the width boundary of the fixspot (the extra space the monkey is allowed)
	touchBoxBoundaryBlack.set_height(touchBoxSize+2*touchWindow-2); # the above two lines will set the red box height, this is setting the black box height(see picture code for details)
	touchBoxBoundaryBlack.set_width(touchBoxSize+2*touchWindow-2);
	touchBoxE.set_width(touchBoxSize); 
	touchBoxE.set_height(touchBoxSize); 
	
	#Get the current time
	clockticker=clock.time();
	
	# Update the trial text to the current trial
	trialTextTouchbox.set_caption( "Trial: " + printf( current_trial, "%2d" ) + "/" + printf( numTrials, "%2d" ) + 
										"\n Correct: "+ printf( correctTouches, "%2d" ) + "/" + printf( numTrials, "%2d" ) +
										"\n Missed: "+ printf( missedTouches, "%2d" ) + "/" + printf( numTrials, "%2d" ) +
										"\n Early: "+ printf( earlyTouches, "%2d" ) + "/" + printf( numTrials, "%2d" ) +
										"\n Ignored: "+ printf( ignoredTouches, "%2d" ) + "/" + printf( numTrials, "%2d" ), true );
	
	# Present the updated touch boxes
	touchBoxMonkey.present();
	touchBoxExperimenter.present();
	
	# Variable for tracking if the monkey has touched on this trial
	hasTouched = 0;
	
	loop until # Loop until time is up or the monkey has touched
			(clock.time()-clockticker) > touchBoxTime || hasTouched == 1
	begin
		
		
		if # Check if the monkey has touched since last count
			(response_manager.response_data_count() > response_count)
		then
			
			#Update the response count
			response_count = response_manager.response_data_count();
			
			#Record the last touch
			lastTouch = response_manager.last_response_data();
			touch_response tr = touch_response( lastTouch );
			
			# Get the X/Y positon of the touch
			currentX = tr.x();
			currentY =tr.y();
			
			# Convert to relative coordinates on the monkey's monitor
			monkeyX = currentX - monitorXZeroPoint;
			monkeyY = currentY ;
			
			string state = "Down";
			if (tr.button() == 2) then state = "Up  " end;
			
			touchTextTouchbox.set_caption( "Touch time: " + printf( tr.time_double(), "%9.2f" ) + " " + state + " " +
			"x: " + printf( tr.x(), "%6.1f" ) +
			"y: " + printf( tr.y(), "%6.1f" ),
			true );
			
			

			touchBoxExperimenter.set_part_x( 4, monkeyX );  
			touchBoxExperimenter.set_part_y( 4, monkeyY ); 
			touchBoxExperimenter.present();
			
				
			if # The touch was within the boundy of the touch box
				monkeyX <= upperX && monkeyX >= lowerX && currentY <= upperY && currentY >= lowerY && state == "Down"
			then # Record that the monkey has made a correct touch
				goodTouch = 1;
				presentCorrectFeedback();
			elseif 
				monkeyX <= upperX && monkeyX >= lowerX && currentY <= upperY && currentY >= lowerY
			then
				hasTouched = 1;
				presentIncorrectFeedback();
			end;
			
				# Wait for release
				if # It was a touch and not a release
				 state == "Down"
				then
					touchTextTouchbox.set_caption( "HOLDING time: : " + printf( tr.time_double(), "%9.2f" ) + " " + state + " " +
					"x: " + printf( tr.x(), "%6.1f" ) +
					"y: " + printf( tr.y(), "%6.1f" ),
					true );
					touchTextTouchbox.redraw();
					touchBoxExperimenter.present();
					
					loop until 
						(response_manager.response_data_count() > response_count)
					begin
					
					end;
				end; 
				
				
			#Record that the monkey has made a touch response
			hasTouched = 1;
		end;
		
	end;
	
	if
		goodTouch == 1
	then
		monkeyResponseSub = "Correct";
	elseif
		hasTouched == 1
	then
		monkeyResponseSub = "Missed";
	else
		monkeyResponseSub = "Ignore";
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
		
		if #If there was a correct response
			stimulusResponse == "Correct"
		then
			presentITI(correctItiDuration );
			correctTouches = correctTouches + 1;
			
		elseif 
			stimulusResponse == "Missed"
		then

			presentITI(missedItiDuration );
			missedTouches = missedTouches + 1;
		else

			presentITI(ignoredItiDuration );
			ignoredTouches = ignoredTouches + 1;
		end;
		
	else

		presentITI( earlyItiDuration );
		earlyTouches = earlyTouches + 1;
		
	end;
	
	# Increment the current trial counter
	current_trial = current_trial + 1;
end;

#Print out behavior information in terminal
term.print_line( "Correct touches: " + string( correctTouches ));
term.print_line( " Missed touches: " + string( missedTouches ));
term.print_line( "  Early touches: " + string( earlyTouches ));
term.print_line( "Ignored touches: " + string( ignoredTouches ));