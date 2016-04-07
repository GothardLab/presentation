#	Touch Training (touchTrain)
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
#		v0.2	02/05/16		Added experimenter screens
#		v0.3	02/11/16		Branched from touchTrainSimple, added conditions/item file
#		v0.4	02/12/16		Multiple touch locations working correctly
#		v0.5	02/22/16		Ignores touches on bottom, added juice, added hold-limit, added sound 

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

#Define the sounds we are going to be using
wavefile { filename = "cash_register_x.wav"; } correctSoundWav;
wavefile { filename = "quick_fart_x.wav"; } incorrectSoundWav;

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

# Trial
trial {
   sound { wavefile correctSoundWav; } correctSound;
	picture correctMonkey;
	time = 200;
} correctFeedbackSound; 
trial {
   sound { wavefile incorrectSoundWav; } incorrectSound;
	picture incorrectMonkey;
	time = 200;
} incorrectFeedbackSound;

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
	x = -700; y = 400; # String to display touch position

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
	x=0; y=0;  			# The position of the touch box boundary
	
	box {color = 0,0,0; height=9;width=9; display_index=2;}touchBoxBoundaryBlack;
	x=0; y=0; 			# The position of the touch box boundary
	on_top=true; 		# Draw the black box ontop of the touch box: this makes a boundary
	
	# Draw a green box, this is the touch box, height/width are temporary and are updated later
	box {color = 0,255,0;height=10;width=10;display_index=2;}touchBoxE;
	x=0; y=0;
	on_top=true;
	
	# Draw a blue box, this is the touch marker, height/width are 3 pixels
	box {color=0,0,255;height=10;width=10;display_index=2;}touchMarker;
	x=5000; y=5000;	# The touch position is updated throughout
	on_top=true; 		# Plot the touch positon on the top layer of the picture
	
	text { caption = "Touch_Info"; display_index=2;} touchTextTouchbox;
	x = 500; y = 500; # String to display touch position
	
	text { caption = "Trial_Info"; display_index=2;} trialTextTouchbox;
	x = -700; y = 400;# String to display touch position
	
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
	x=5000; y=5000;		# The touch position is updated throughout
	on_top=true; 			# plot the touch positon on the top layer of the picture
	
	text { caption = "Touch_Info"; display_index=2;} touchTextITI;
	x = 500; y = 500;		# String to display touch position
	
	text { caption = "Trial_Info"; display_index=2;} trialTextITI;
	x = -700; y = 400;	# String to display touch position

}itiExperimenter;



# ---------------------------------------------------------------------------
#										Begin PCL code
# ---------------------------------------------------------------------------
begin_pcl;

# Variables for task settings (You can change these)
int touchBoxSize	=	500;			# size of touch box (pixels)
int touchWindow	=	100; 			# this is the extra room that the monkey has around the edge of the touch box (pixels)
											# if touchWindow is 100, then there is a leniency of 100 pixels on all sides of the touch box
int touchBoxX		=	0;				# x-position of the touch box (pixels)(Default, can change by condition)
int touchBoxY		=	0; 			# y-postition of the touch box (pixels)(Default, can change by condition)
int touchBoxTime	=	5000; 		# time that monkey is allowed to get to touch box (ms) per trial
int correctItiDuration	=	5000; # Duration of the inter-trial-interval(ms)for correct trials
int earlyItiDuration		=	7000;# Duration of the inter-trial-interval(ms) for early touches
int missedItiDuration	=	7000;# Duration of the inter-trial-interval(ms) for missed trials
int ignoredItiDuration   =	8000;	# Duration of the inter-trial-interval(ms) for ignored trials
int preTrialTime	=  1000;			# Length of pretrial period in ms
int monitorXZeroPoint = -1920;	# The pixel touch value of the center of the monkey's monitor (important for calibrating!) (-1920)
int feedbackLength = 250; 			# Time (ms) per trial which the monkey gets visual feedback of correct or incorrect response
int numberOfJuiceDrops = 5;		# Number of juice drops to give monkey for a correct response
int holdTimeLimit = 5000;			# Time (ms) which the monkey can hold the screen before getting an error
int bottomTouchLimit = -300;		# Pixel space below which the monkey can touch free (so that they can hold bottom of monitor)

# Variables for running the task (Don't change these)
int clockticker	=	0; 			# Counter for time
int holdticker		=	0; 			# Counter for time
int currentTrial = 	0;				# Counter for current trial
int hasTouched 	=	0;				# Boolean for touches
int earlyTouch		= 	0;				# Boolean for early touches
int missedTouches = 	0;				# Counter for missed trials
int ignoredTouches = 0;				# Counter for ignored trials
int earlyTouches	=	0;				# Counter for early touches
int correctTouches = 0;				# Counter for correct trials
int ITItouches		=	0;				# Counter for ITI touches
int numberConditions = 0;			# Number of conditions
int numberPresentations  =	0;		# Number of total touchbox presentations (numberTrails * numberConditions)
int thisPresentation = 0;			# Counter for this presentation
array<int>ordered_cnds_to_show[0];# Integer array in which we will store the ordered condition numbers
int currentCondition;				# Counter for the current condition being shown

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

# ------------------ Access national instruments card ------------------
dio_device card = new dio_device( ni_dio_device, 1, 0 );

# ------------------ Setup output ports  ------------------
output_port juicePulse = output_port_manager.get_port(1);

# ------------------ Check for touch device  ------------------
touch_device tdevice = touch_device( response_manager.get_mouse( 1 ) );
if (is_null( tdevice )) then
	exit( "touch_device required for this scenario" )
end;
tdevice.set_max_buffer_count( 100 );


# ------------------ Get the experimental parameters ------------------
string exp_par="touch_parameters.txt"; # Name of the text file with the experiment information
input_file exp_info = new input_file;	# Create an input file
exp_info.open( exp_par );					# Load the experimental parameters into the input file
string temp_name;								# Create a string variable for temporary use
temp_name=exp_info.get_line();			# Get the first line of the experimental file (item file)
string item_file=temp_name.substring(12,temp_name.count()-11);	# Filename of the item file
temp_name=exp_info.get_line();  			# Get the next line (just dashes) and ignore
temp_name=exp_info.get_line();			# Get the 4th line (number of trials)
int numberTrials=int(double(temp_name.substring(temp_name.count()-1,2)));	# Write down the number of trials to be shown

#Print out the parameters from the file
term.print_line( "Reading parameters from: " + exp_par );
term.print_line( "Item file: " + item_file);
term.print_line( "Number of trials " + string(numberTrials));


# ------------------ Load touchspot positions from item file  ------------------
int i; int touchspotX_index; int touchspotY_index; # Create counter variables													
string current_filename;							  		# Create a string variable for the item names
input_file fil = new input_file;   						# Create an input file
fil.open( item_file );										# Load the item file data into the input file
current_filename=fil.get_line();							# Get the first line of the item file (column headers)
touchspotX_index=current_filename.find("tchX");
touchspotY_index=current_filename.find("tchY");

int num_items=int(double(current_filename.substring(current_filename.find("totalitems=")+11,2))); # Assign how many items there are to a avariable
array<int>touchspotXs[num_items];						# Create an array which will contain the X touch positions
array<int>touchspotYs[num_items];						# Create an array which will contain the Y touch positions

loop  # Loop through each line in the item file
	i=1
until
	i>(num_items) 
begin 
   current_filename=fil.get_line();	# Get the list of characters that compose the current line in the itm file
 	touchspotXs[i]=int(double(current_filename.substring(touchspotX_index,4))); # Get just the item filename from that line
   touchspotYs[i]=int(double(current_filename.substring(touchspotY_index,4))); # Get just the item filename from that line
	i=i+1;	# Increment the counter                 
end;

#  ------------------ Determine what conditions to show  ------------------
array<int>cnds_to_show[0];					# Create an array that we'll fill with the conditions we want to show
temp_name=exp_info.get_line();			# Get the 5th line of the experimental parameters file (conditions to show)
if (temp_name.find("all")!=0) then		# If the word "all" is typed in the condition line then...
	array<int>cnds_temp[num_items];		# Create an array the length of all cnds
	cnds_temp.fill(1, num_items, 1, 1);	# Fill the array with all cnds in order
	cnds_to_show.append(cnds_temp);		# Append the cnd array to the global cnd array
elseif (temp_name.find("-->")!=0) then	# If an arrow --> is typed in the condition line then...
	int start_cnd = int(double(temp_name.substring(temp_name.find("-->")-2,2)));	# Get the number before the arrow
	int end_cnd = int(double(temp_name.substring(temp_name.find("-->")+3,2)));		# Get the number after the arrow
	array<int>cnds_temp[end_cnd-start_cnd+1];						# Create an array the length of the number of cnds in the range
	cnds_temp.fill(1, end_cnd-start_cnd+1, start_cnd, 1);		# Fill the array with cnds in the specified range
	cnds_to_show.append(cnds_temp);									# Append the cnd array to the global cnd array
else																			# Otherwise the cnds must be specified as a list
	int start_int=temp_name.find("[");								# Get the start of the list (noted by a bracket [)
	int end_int=temp_name.find("]");									# Get the end of the list (noted by a bracket ])
	array<int>cnds_temp[int(round((1.0/3.0)*(double(end_int-start_int)-1.0)+(1.0/3.0),0))]; 	# Create an array the length of the number of cnds specified
	int j;		# Create an integer counter
	loop 			# Loop through the cnd array
		j=1
	until 
		j>(int(round((1.0/3.0)*(double(end_int-start_int)-1.0)+(1.0/3.0),0))) 
	begin			# Fill the array with the specified cnd
		cnds_temp[j]=int(double(temp_name.substring(start_int+3*j-2,2)));	
		j=j+1;	# Increment the integer counter
	end;
	cnds_to_show.append(cnds_temp);	# Append the cnd array to the global cnd array
end;

# ------------------ Determine condition order  ------------------~~
string order;
temp_name=exp_info.get_line();			# Get the 6th line of the experimental parameters file (condition order)
if (temp_name.find("random")!=0) then	# If the specified order is "random"
	order="random";							# Then store this "random" information as a string
else
	order="incremental";						# Otherwise default to "incremental" order
end;

numberConditions = cnds_to_show.count();

#Print out number of conditions
term.print_line( "Number of Conditions " + string(numberConditions) + " Order: " + order);

# ------------------ Determine how to deal with error trials  ------------------
string tnext;
temp_name=exp_info.get_line();			# Get the 7th line of the experimental parameters file (trial order)
if (temp_name.find("delayed")!=0) then	# If the trial order is "delayed"
	tnext="delayed";							# Then store this "delayed" information as a string
elseif (temp_name.find("immediate")!=0) then # If the trial order is "immediate"
	tnext="immediate";						# Then store this "incremental" information as a string
else;
	tnext="ignore";							# Otherwise default to "ignore" trial
end;

# Print blank line to seperate the pre-trial info from trials
term.print_line( "");

# ------------------ Give Juice Reward Subroutine ------------------
sub
	giveJuiceReward
begin
	int nojo=1;							# Counter for number of juice drops given already
	loop until 
		nojo > numberOfJuiceDrops 
	begin
		juicePulse.send_code(10,150);	# Give juice to the monkey
		wait_interval(150);
		juicePulse.send_code(0,150);	# Give juice to the monkey
		wait_interval(150);
		nojo=nojo+1;
	end;
end;

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
	
	#Play the sound
	incorrectFeedbackSound.present();
	
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
	
	#Give juice reward
	giveJuiceReward();
	
	#Play the sound
	#correctFeedbackSound.present();
	
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
end;

# ------------------ Present Pre-Trial Subroutine ------------------
sub
   string presentPreTrial
begin
	response_data lastTouch;
	string monkeyResponseSub = "";

		# Set the caption of the experimenter's trial information string
		trialTextPretrial.set_caption( "Trial: " + printf( currentTrial, "%2d" ) + "/" + printf( numberTrials, "%2d" ) + 
										"\n Condition: "+ printf( currentCondition, "%2d" ) + "/" + printf( numberConditions, "%2d" ) +
										"\n Presentations: "+ printf( thisPresentation, "%2d" ) + "/" + printf( numberPresentations, "%2d" ) +
										"\n Correct: "+ printf( correctTouches, "%2d" ) + "/" + printf( thisPresentation, "%2d" ) +
										"\n Missed: "+ printf( missedTouches, "%2d" ) + "/" + printf( thisPresentation, "%2d" ) +
										"\n Early: "+ printf( earlyTouches, "%2d" ) + "/" + printf( thisPresentation, "%2d" ) +
										"\n Ignored: "+ printf( ignoredTouches, "%2d" ) + "/" + printf( thisPresentation, "%2d" ) +
										"\n ITI: "+ printf( ITItouches, "%2d" ), true );
	
										
		# Present the pretrial screens to monkey and experimenter
		pretrialMonkey.present();
		pretrialExperimenter.present();
		
		# Get the current time
		clockticker=clock.time();
		
		# Set boolean for detecting touch to null
		hasTouched = 0;
		
		# Loop until time is up, or if monkey has touched
		loop until 
			(clock.time()-clockticker) > preTrialTime || hasTouched == 1
		begin
			
			/*countdownTextPretrial.set_caption( "time: " + printf( (clock.time()-clockticker), "%9d" ) ,
				true );
			countdownTextPretrial.redraw();*/
			
			# If the current number of touches is greater than when we last recorded a touch
			if (response_manager.response_data_count() > response_count) then
				
				# Set out response count tracker to the new count
				response_count = response_manager.response_data_count();
				
				# Get the last touch from response manager
				lastTouch = response_manager.last_response_data();
				
				# Extract the touch response
				touch_response tr = touch_response( lastTouch );
													
				# Set the default touch state to be down
				string state = "Down";
				
				# If this was a release, mark the state as "Up"
				if (tr.button() == 2) then state = "Up  " end;
				
				# Modify the caption in the touch state text
				touchTextPretrial.set_caption( "Touch time: " + printf( tr.time_double(), "%9.2f" ) + " " + state + " " +
				"x: " + printf( tr.x(), "%6.1f" ) +
				"y: " + printf( tr.y(), "%6.1f" ),
				true );
					
				# Update our current touch position trackers
				currentX = tr.x();
				currentY = tr.y();
				
				if # If this touch was above the Y-axis limit
					tr.y() > bottomTouchLimit
				then
				
					# Convert to relative coordinates on the monkey's monitor
					monkeyX = currentX - monitorXZeroPoint;
					monkeyY = currentY ;
					
					# Move the touch marker on the experimenter's screen
					touchBoxExperimenter.set_part_x( 4, monkeyX );  
					touchBoxExperimenter.set_part_y( 4, monkeyY );
					itiExperimenter.set_part_x( 1, monkeyX );  
					itiExperimenter.set_part_y( 1, monkeyY );
					pretrialExperimenter.set_part_x( 1, monkeyX );  
					pretrialExperimenter.set_part_y( 1, monkeyY );									
					pretrialExperimenter.present();
					
					# Wait for release
					if # It was a touch and not a release
					 state == "Down"
					then
						
						# Modify the caption in the touch state text
						touchTextPretrial.set_caption( "HOLDING time: " + printf( tr.time_double(), "%9.2f" ) + " " + state + " " +
						"x: " + printf( tr.x(), "%6.1f" ) +
						"y: " + printf( tr.y(), "%6.1f" ),
						true );
						
						# Update these elements
						touchTextPretrial.redraw();
						pretrialExperimenter.present();
						
						#Get current time
						holdticker=clock.time(); 
						
						# Loop until there is another response, i.e. the monkey has released touch
						loop until 
							(response_manager.response_data_count() > response_count)
						begin
							if 
								(clock.time()-holdticker) > holdTimeLimit
							then
								presentIncorrectFeedback();
								#Reset current time
								holdticker=clock.time(); 
							end
						end;
					end; 
						
					if  #If this was a touch and not a release
						state == "Down"
					then
						hasTouched = 1; # Mark the touch boolean as true
						presentIncorrectFeedback(); # Present the incorrect feedback
					end
				
				else
				
				end;
			end;
			
			
		end;
		
		if 	# If the monkey has touched
			hasTouched == 1
		then 	#Set the Return variable to be early
			monkeyResponseSub = "Early";
		else 	# Otherwise, a no-touch is a correct response
			monkeyResponseSub = "Correct";
		end;
	
	
	
	# Return 'monkeyResponseSub'
	return monkeyResponseSub
end;

# ------------------ Present ITI Subroutine ------------------
sub
	presentITI( int itiDuration )
begin
	
	# Set the caption of the experimenter's trial information string
	trialTextITI.set_caption( "Trial: " + printf( currentTrial, "%2d" ) + "/" + printf( numberTrials, "%2d" ) + 
										"\n Condition: "+ printf( currentCondition, "%2d" ) + "/" + printf( numberConditions, "%2d" ) +
										"\n Presentations: "+ printf( thisPresentation, "%2d" ) + "/" + printf( numberPresentations, "%2d" ) +
										"\n Correct: "+ printf( correctTouches, "%2d" ) + "/" + printf( thisPresentation, "%2d" ) +
										"\n Missed: "+ printf( missedTouches, "%2d" ) + "/" + printf( thisPresentation, "%2d" ) +
										"\n Early: "+ printf( earlyTouches, "%2d" ) + "/" + printf( thisPresentation, "%2d" ) +
										"\n Ignored: "+ printf( ignoredTouches, "%2d" ) + "/" + printf( thisPresentation, "%2d" ) +
										"\n ITI: "+ printf( ITItouches, "%2d" ), true );
	
										
	# Present the ITI screen to the monkey and the experimenter
	itiExperimenter.present();
	itiMonkey.present();

	# Get the current time
	clockticker=clock.time();
	
	# Create a response_data class for the last touch
	response_data lastTouch;
	
	loop until # Loop until the ITI is over
			(clock.time()-clockticker) > itiDuration 
	begin
		if # If the current number of touches is greater than when we last recorded a touch
			(response_manager.response_data_count() > response_count) 
		then
			
		
			# Update our response count
			response_count = response_manager.response_data_count(); 

			# Get the last touch
			lastTouch = response_manager.last_response_data();
			
			# Extract the touch response from the last touch
			touch_response tr = touch_response( lastTouch );
			
			# Update the current X/Y touch positions
			currentX = tr.x();
			currentY =tr.y();
			
			
			if # If this touch was above the Y-axis limit
				tr.y() > bottomTouchLimit
			then
			
			# Convert to relative coordinates on the monkey's monitor
			monkeyX = currentX - monitorXZeroPoint;
			monkeyY = currentY ;
			
			# Set the default state to the touch being down
			string state = "Down";
			
			# If the touch was a release, mark it as "Up "
			if (tr.button() == 2) then state = "Up  " end;
				
			# Modify the caption in the touch state text
			touchTextITI.set_caption( "Touch time: " + printf( tr.time_double(), "%9.2f" ) + " " + state + " " +
			"x: " + printf( tr.x(), "%6.1f" ) +
			"y: " + printf( tr.y(), "%6.1f" ),
			true );
			touchTextITI.redraw();
			
			# Update the positon of the touch marker in the experimenter's screen
			touchBoxExperimenter.set_part_x( 4, monkeyX );  
			touchBoxExperimenter.set_part_y( 4, monkeyY );
			itiExperimenter.set_part_x( 1, monkeyX );  
			itiExperimenter.set_part_y( 1, monkeyY );
			pretrialExperimenter.set_part_x( 1, monkeyX );  
			pretrialExperimenter.set_part_y( 1, monkeyY ); 	
			
			# Update these elements
			itiExperimenter.present();
			itiMonkey.present();
			
				# Wait for release
				if # It was a touch and not a release
				 state == "Down"
				then
					# Present incorrect feedback
					presentIncorrectFeedback();
					
					#Increase our ITI touch count
					ITItouches = ITItouches + 1;
					
					# Re-present the ITI screen to the monkey and experimenter
					itiExperimenter.present();
					itiMonkey.present();
					
					# Modify the caption in the touch state text
					touchTextITI.set_caption( "HOLDING time: " + printf( tr.time_double(), "%9.2f" ) + " " + state + " " +
					"x: " + printf( tr.x(), "%6.1f" ) +
					"y: " + printf( tr.y(), "%6.1f" ),
					true );
					
					# Update these elements
					touchTextITI.redraw();
					itiExperimenter.present();
					
					holdticker=clock.time();
					
					loop until #Loop until there is another response, i.e. the monkey released their touch
						(response_manager.response_data_count() > response_count)
					begin
						if 
							(clock.time()-holdticker) > holdTimeLimit
						then
							presentIncorrectFeedback();
							#Reset current time
							holdticker=clock.time(); 
						end
					end;
				end; 
			else
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
	int thisTrialTouchspotX = touchspotXs[ordered_cnds_to_show[currentCondition]];
	int thisTrialTouchspotY = touchspotYs[ordered_cnds_to_show[currentCondition]];
	touchBoxMonkey.set_part_x( 1, thisTrialTouchspotX); 			#set the X position of the touch box on the monkey's monitor
	touchBoxMonkey.set_part_y( 1, thisTrialTouchspotY); 			#set the Y position of the touch box on the monkey's monitor
	
	# Update the experimenter's screen
	touchBoxBoundary.set_height(touchBoxSize+2*touchWindow); # Set the height boundary of the touchspot (the extra space the monkey is allowed)
	touchBoxBoundary.set_width(touchBoxSize+2*touchWindow); # Set the width boundary of the touchspot (the extra space the monkey is allowed)
	touchBoxBoundaryBlack.set_height(touchBoxSize+2*touchWindow-2); # The above two lines will set the red box height, this is setting the black box height(see picture code for details)
	touchBoxBoundaryBlack.set_width(touchBoxSize+2*touchWindow-2);
	touchBoxExperimenter.set_part_x( 3, thisTrialTouchspotX); 	#set the X position of the touch box on the experimenter's monitor
	touchBoxExperimenter.set_part_y( 3, thisTrialTouchspotY); 	#set the Y position of the touch box on the experimenter's monitor
	touchBoxExperimenter.set_part_x( 2, thisTrialTouchspotX); 	#set the X position of the black touch box on the experimenter's monitor
	touchBoxExperimenter.set_part_y( 2, thisTrialTouchspotY); 	#set the Y position of the black touch box on the experimenter's monitor
	touchBoxExperimenter.set_part_x( 1, thisTrialTouchspotX); 	#set the X position of the red outline on the experimenter's monitor
	touchBoxExperimenter.set_part_y( 1, thisTrialTouchspotY); 	#set the Y position of the red outline on the experimenter's monitor
	touchBoxE.set_width(touchBoxSize); 
	touchBoxE.set_height(touchBoxSize); 
	
	#Get the current time
	clockticker=clock.time();
	
	# Update the trial text to the current trial
	trialTextTouchbox.set_caption( "Trial: " + printf( currentTrial, "%2d" ) + "/" + printf( numberTrials, "%2d" ) + 
										"\n Condition: "+ printf( currentCondition, "%2d" ) + "/" + printf( numberConditions, "%2d" ) +
										"\n Presentations: "+ printf( thisPresentation, "%2d" ) + "/" + printf( numberPresentations, "%2d" ) +
										"\n Correct: "+ printf( correctTouches, "%2d" ) + "/" + printf( thisPresentation, "%2d" ) +
										"\n Missed: "+ printf( missedTouches, "%2d" ) + "/" + printf( thisPresentation, "%2d" ) +
										"\n Early: "+ printf( earlyTouches, "%2d" ) + "/" + printf( thisPresentation, "%2d" ) +
										"\n Ignored: "+ printf( ignoredTouches, "%2d" ) + "/" + printf( thisPresentation, "%2d" ) +
										"\n ITI: "+ printf( ITItouches, "%2d" ), true );
										
	# Offset existing pixel boundry for correct touch
	int thisCndUpperX = thisTrialTouchspotX + upperY;
	int thisCndUpperY = thisTrialTouchspotY + upperX;
	int thisCndLowerX = thisTrialTouchspotX + lowerX;
	int thisCndLowerY = thisTrialTouchspotY + lowerY;

	
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
			currentY = tr.y();
			
			if # If this touch was above the Y-axis limit
				tr.y() > bottomTouchLimit
			then
				
				# Convert to relative coordinates on the monkey's monitor
				monkeyX = currentX - monitorXZeroPoint;
				monkeyY = currentY ;
				
				# Set the default state of the touch to donw
				string state = "Down";
				
				# If this was a release, mark state as "Up "
				if (tr.button() == 2) then state = "Up  " end;
				
				# Modify the caption in the touch state text
				touchTextTouchbox.set_caption( "Touch time: " + printf( tr.time_double(), "%9.2f" ) + " " + state + " " +
				"x: " + printf( tr.x(), "%6.1f" ) +
				"y: " + printf( tr.y(), "%6.1f" ),
				true );
				
				# Set the location of the touch marker
				touchBoxExperimenter.set_part_x( 4, monkeyX );  
				touchBoxExperimenter.set_part_y( 4, monkeyY );
				itiExperimenter.set_part_x( 1, monkeyX );  
				itiExperimenter.set_part_y( 1, monkeyY );
				pretrialExperimenter.set_part_x( 1, monkeyX );  
				pretrialExperimenter.set_part_y( 1, monkeyY );
				
				# Update the experimenter's screen
				touchBoxExperimenter.present();
				
					
				if # The touch was within the boundy of the touch box
					monkeyX <= thisCndUpperX && monkeyX >= thisCndLowerX && currentY <= thisCndUpperY && currentY >= thisCndLowerY && state == "Down"
				then # Record that the monkey has made a correct touch
					goodTouch = 1; 					# Set our correct touch boolean to true
					presentCorrectFeedback(); 		# Present the correct feedback
				elseif # Otherwise, if the monkey released on the square
					monkeyX <= thisCndUpperX && monkeyX >= thisCndLowerX && currentY <= thisCndUpperY && currentY >= thisCndLowerY
				then
					hasTouched = 1; 					# Set our did touch boolean to true
					presentIncorrectFeedback(); 	# Present the incorrect feedback
				else # If the monkey did not touch within the correct boundry
					hasTouched = 1;
					presentIncorrectFeedback();	# Present the incorrect feedback
				end;
				
					# Wait for release
					if # It was a touch and not a release
					 state == "Down"
					then
						
						# Modify the caption in the touch state text
						touchTextTouchbox.set_caption( "HOLDING time: : " + printf( tr.time_double(), "%9.2f" ) + " " + state + " " +
						"x: " + printf( tr.x(), "%6.1f" ) +
						"y: " + printf( tr.y(), "%6.1f" ),
						true );
						
						#Update these elements
						touchTextTouchbox.redraw();
						touchBoxExperimenter.present();
						
						holdticker=clock.time(); 
						
						loop until # Loop until there is another touch event, the release
							(response_manager.response_data_count() > response_count)
						begin
							if 
								(clock.time()-holdticker) > holdTimeLimit
							then
								presentIncorrectFeedback();
								#Reset current time
								holdticker=clock.time(); 
							end
						end;
					end; 
					#Record that the monkey has made a touch response
				hasTouched = 1;
			else
			end;
				
			
		end;
		
	end;
	
	# Parse out the boolean markers to determine the outcome of the trial
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
	
	# Return the monkey's response
	return monkeyResponseSub
end;

# ------------------ Main trial loop ------------------

# Calculate the total number of touchbox presentations (number of trails X number of conditions) 
numberPresentations = numberTrials * numberConditions;

wait_interval(1000); # Short wait period at beginning of experiment

loop 
		currentTrial = 1 
until 
		currentTrial > numberTrials 
begin 
	
	
	# Arrange the conditions for random or incremental presentation
	if order=="random" then							# If the specification of cnd order is random then...
			ordered_cnds_to_show.resize(0);
			ordered_cnds_to_show.append(cnds_to_show);
			ordered_cnds_to_show.shuffle();				# ...randomly shuffle the conditions
	else
			ordered_cnds_to_show.append(cnds_to_show); # Otherwise default to incremental ordering
	end;

	loop 
		currentCondition = 1 
	until 
		currentCondition > ordered_cnds_to_show.count() 
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
				currentCondition=currentCondition+1;
				
			elseif 
				stimulusResponse == "Missed"
			then

				presentITI(missedItiDuration );
				missedTouches = missedTouches + 1;
				
				# If we are ignoring incorrect trials, advance to the next condition
				if tnext == "ignore" then currentCondition=currentCondition+1; end;
				
			else

				presentITI(ignoredItiDuration );
				ignoredTouches = ignoredTouches + 1;
				
				# If we are ignoring incorrect trials, advance to the next condition
				if tnext == "ignore" then currentCondition=currentCondition+1;   end;
				
			end;
			
		else
			presentITI( earlyItiDuration );
			earlyTouches = earlyTouches + 1;
		end;
		
		thisPresentation = thisPresentation +1;
	end;
	
	# Increment the current trial counter
	currentTrial = currentTrial + 1;
end;

#Print out behavior information in terminal
term.print_line( "Correct touches: " + string( correctTouches ) + "/" + string(thisPresentation));
term.print_line( " Missed touches: " + string( missedTouches ) + "/" + string(thisPresentation) );
term.print_line( "  Early touches: " + string( earlyTouches ) + "/" + string(thisPresentation) );
term.print_line( "Ignored touches: " + string( ignoredTouches ) + "/" + string(thisPresentation) );