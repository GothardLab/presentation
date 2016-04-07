#Touch Training Simple (touchTrainSimple)
#Philip Putnam, 2016, University of Arizona
#This is designed to train non-human primates with a touch screen


active_buttons = 2;
button_codes = 1,2;
default_font_size = 64;
default_font = "Arial";


#-----------------------------	BEGIN SDL	-----------------------------
begin;

#Blank screen to show between trials
picture {} default;

# The box the monkey touches
picture{

	#display this picture on the monkey's monitor (monitor 1)
	display_index=1;
	
	#draw a white box, this is the fixspot, height/width are temporary and are updated later
	box {color = 0,255,0;height=10;width=10;display_index=1;}touchBoxM;
	
	#the position of the fixspot, this is updated according to the condition
	x=0; y=0;
}touchBoxMonkey;

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
	box {color=0,0,255;height=5;width=5;display_index=2;}touchMarker;
	x=0; y=0; #the touch position is updated throughout
	on_top=true; # plot the eye positon on the top layer of the picture
	
}touchBoxExperimenter;

picture{

	#display this picture on the monkey's monitor (monitor 1)
	display_index=1;

}itiMonkey;

picture{

	#display this picture on the experimenter's monitor (monitor 2)
	display_index=2;

}itiExperimenter;


picture{

	#display this picture on the monkey's monitor (monitor 1)
	display_index=1;

}preTrialMonkey;

picture{

	#display this picture on the experimenter's monitor (monitor 2)
	display_index=2;
	
}preTrialExperimenter;



#-----------------------------	BEGIN PCL	-----------------------------
begin_pcl;

# Variables for task settings (You can change these)
int touchBoxSize	=	500;			# size of touch box (pixels)
int touchWindow	=	100; 			# this is the extra room that the monkey has around the edge of the touch box (pixels)
											# if touchWindow is 10, then there is a leniency of 10 pixels on all sides of the touch box
int touchBoxX		=	0;				# x-position of the touch box (pixels)
int touchBoxY		=	0; 			# y-postition of the touch box (pixels)
int touchBoxTime	=	1000; 		# time that monkey is allowed to get to touch box (ms) per trial
int correctItiDuration	=	100; 			# duration of the inter-trial-interval (ms)
int earlyItiDuration		=	5000; 			# duration of the inter-trial-interval (ms)
int missedItiDuration	=	5000; 			# duration of the inter-trial-interval (ms)
int numTrials 		=	5;				# Number of trials the monkey should complete
int preTrialTime	=  500;			#Length of pretrial period in ms
int monitorWidthOffset 	= 1080;
int monitorHeightOffset = 0;

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
int pastX 			= 0; 				# Past X Coordinate of joystick
int pastY 			= 0; 				# Past Y Coordinate of joystick
int currentX 		= 0; 				# Current X Coordinate of joystick
int currentY 		= 0; 				# Current Y Coordinate of joystick
int upperX			= touchBoxX + (touchBoxSize/2) + touchWindow;
int lowerX			= touchBoxX - (touchBoxSize/2) - touchWindow;
int upperY			= touchBoxY + (touchBoxSize/2) + touchWindow;
int lowerY			= touchBoxY - (touchBoxSize/2) - touchWindow;
int relativeX		= 0;
int relativeY		= 0;

# Get the touch position
mouse touch = response_manager.get_mouse( 1 );
#mouse release = response_manager.get_mouse( 2 );


touch.poll(); #Find starting touch postions

pastX = touch.x(); #Set starting X position
pastY = touch.y(); #Set starting Y position

loop current_trial=1 until current_trial>numTrials begin 
	
	
	
	
	# Start the pretrial no-touching period
	clockticker=clock.time(); 
	
	# Set 'earlyTouch' to null
	earlyTouch = 0;
	
	# Present the pre-trial screens to both parties
	#preTrialExperimenter.present();
	#preTrialMonkey.present();
	
	#Keep checking the time until end or pre-trial period or if early touch
	/*oop until (clock.time()-clockticker) > preTrialTime || earlyTouch == 1
	begin
		
		# Update a countdown for the pretrial
		#countdownText.set_caption(string( (preTrialTime - (clock.time()-clockticker) ) ));
		#countdownText.redraw();
		
		# Get the last touch location
		touch.poll();
		
		if # The most current touch is different than last recorded touch
			touch.x() != pastX && touch.y() != pastY
		then
			earlyTouch = 1;
		end;
		
	end;*/
	
	earlyTouch = 0;
	if 
		earlyTouch == 0
	then
		# Update the size of the touch box to what is set in variables (above)
		touchBoxM.set_height(touchBoxSize);
		touchBoxM.set_width(touchBoxSize); 
		touchBoxBoundary.set_height(touchBoxSize+2*touchWindow); # set the height boundary of the fixspot (the extra space the monkey is allowed)
		touchBoxBoundary.set_width(touchBoxSize+2*touchWindow); # set the width boundary of the fixspot (the extra space the monkey is allowed)
		touchBoxBoundaryBlack.set_height(touchBoxSize+2*touchWindow-2); # the above two lines will set the red box height, this is setting the black box height(see picture code for details)
		touchBoxBoundaryBlack.set_width(touchBoxSize+2*touchWindow-2);
		touchBoxE.set_width(touchBoxSize); 
		touchBoxE.set_height(touchBoxSize); 
		
		# Set 'hasTouched' to null
		hasTouched = 0;
		

		
		# Present the touch box
		touchBoxMonkey.present();
		touchBoxExperimenter.present();
		
		
		
		# Get the current time
		clockticker=clock.time(); 
		
		#Keep checking the time
		loop until 
			(clock.time()-clockticker) > touchBoxTime || hasTouched == 1
		begin
			
			#Get touch location
			pastX = currentX;
			pastY = currentY;
			touch.poll(); 
			currentX = touch.x();
			currentY = touch.y();
			
			string state = "Down";
			if (tr.button() == 2) then state = "Up  " end;
			
			/*if
				currentX != pastX && currentY != pastY
			then*/
				
				relativeX = currentX ;#- monitorWidthOffset;
				relativeY = currentY ;#- monitorHeightOffset;
				
			
				touchBoxExperimenter.set_part_x( 4, relativeX );  
				touchBoxExperimenter.set_part_y( 4, relativeY ); 
				touchBoxExperimenter.present();
				
				# Debug
				term.print_line( "Touch at " + string( currentX ) + ", " + string(currentY ) );
			
				
			
				if 
					currentX <= upperX && currentX >= lowerX && currentY <= upperY && currentY >= lowerY 
				then
					hasTouched = 1;
				end;
				
				#Reset to last touch	location
				pastX = currentX; 
				pastY = currentY;
			
			end;
		end; 
		if 
			hasTouched == 1
		then
			correctTouches = correctTouches + 1;
			
			clockticker=clock.time(); 
			loop until 
				(clock.time()-clockticker) > correctItiDuration 
			begin
				itiMonkey.present();
				itiExperimenter.present();
			end;
			
			term.print_line( "Correct response!");
		else
			missedTouches = missedTouches + 1;
			
			clockticker=clock.time(); 
			loop until 
				(clock.time()-clockticker) > missedItiDuration 
			begin
				itiMonkey.present();
				itiExperimenter.present();
			end;

			term.print_line( "Missed touch!");
		end;
		
	/*else
		earlyTouches = earlyTouches + 1;
		clockticker=clock.time(); 
			loop until 
				(clock.time()-clockticker) > earlyItiDuration 
			begin
				itiMonkey.present();
				itiExperimenter.present();
			end;
		term.print_line( "Early touch!");
	end;*/
	

	current_trial=current_trial+1;
end;


term.print_line( "Correct touches" + string( correctTouches ));
term.print_line( "Missed touches" + string( missedTouches ));
term.print_line( "Early touches" + string( earlyTouches ));