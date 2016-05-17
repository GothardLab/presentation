#	Touch Movie Choice (touchMovieChoice)
#	Philip Putnam, 2016, University of Arizona
#
#	This program is designed to train and test a monkey's ability to choose between
#	different catagories of movie stimuli, shown pairwise. The core functionality is
#	to present two different movies, and the monkey can choose between left or right
#	to receive variable amounts of juice. The condition and item files determine what
#	pairwise comparisons are made, and what the catagories, movies, and related juice 
#	values are.
#
#	Note that this program is written for two monitors, one is the 
#	touchscreen the monkey is using (display 1) and one is the
#	experimenter's monitor (display 2). Depending on the resolution
#	of these two monitors, you will need to change the X offset,
#	which is the pixel value of the center of the monkey's touchscreen.
#
#	Verison History
#		v0.1	03/01/16		Branched from touchTrain
#		v0.2	03/09/16		Now functional
#		v0.3	04/26/16		Major overhaul for smaller touchscreen size and improvements
#		v0.4 	05/02/16		Added touch cues behind stimuli
#		v0.5 	05/09/16		Added delay period with possble random float
#		v0.6 	05/11/16		Added encodes
#		v0.7	05/11/16		Branched to touchMovieChoice

# Scenario file parameters
scenario = "Touch Movie Choice";
active_buttons = 2;
default_font = "Courier New";
default_font_size = 15;

# ---------------------------------------------------------------------------
#										Begin SDL code
# ---------------------------------------------------------------------------
begin;

#Blank default screen
picture {} default;

#Define the sounds we are going to be using
wavefile { filename = "cash_register_x.wav"; } correctSoundWav;
wavefile { filename = "quick_fart_x.wav"; } incorrectSoundWav;

#Define bitmap structures to show two movies, don't load them yet
bitmap { filename = "rose01.bmp"; preload = false; } leftImg;
bitmap { filename = "apple01.bmp"; preload = false; } rightImg;

array{
 LOOP $i 300;
   $k = '$i + 1';
   bitmap { filename = "placeholder.bmp";preload=false;};
   ENDLOOP;
} leftMovieBMPs;

array{
 LOOP $i 300;
   $k = '$i + 1';
   bitmap { filename = "placeholder.bmp";preload=false;};
   ENDLOOP;
} rightMovieBMPs;

# Trial structure for presenting frames
trial {    

	trial_duration=stimuli_length;
	
	
   picture {  
      # Placeholder, to be set by PCL
      box { height = 1; width = 1; color = 0,0,0; };
      x = 0; y = 0;
		#on_top=true;
   } leftFrameMonkey;
	duration = next_picture;
	
	picture {  
      # Placeholder, to be set by PCL
      box { height = 1; width = 1; color = 0,0,0; };
      x = 0; y = 0;
		on_top=true;
   } rightFrameMonkey;
	duration = next_picture;
	
	/*picture {  
	#display_index=2;
      # Placeholder, to be set by PCL
      box { height = 1; width = 1; color = 0,0,0; };
      x = 0; y = 0;
   } leftFrameExperimenter;

	picture {  
	#display_index=2;
      # Placeholder, to be set by PCL
      box { height = 1; width = 1; color = 0,0,0; };
      x = 0; y = 0;
   } rightFrameExperimenter;*/
   
} framesPresent;


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
	
	#draw a white box, this is the touchbox, height/width are temporary and are updated later
	box {color = 0,255,0;height=10;width=10;display_index=1;}startCueM;
	x=0; y=0;  			# The position of the start cue
} pretrialMonkey;

#Screen to show the experimenter before the trial begins
picture {
	display_index=2;
	
	box {color = 255,0,0;height=10;width=10;display_index=2;}startCueBoundary;
	x=0; y=0;  			# The position of the touch box boundary
	
	box {color = 0,0,0; height=9;width=9; display_index=2;}startCueBoundaryBlack;
	x=0; y=0; 			# The position of the touch box boundary
	on_top=true; 		# Draw the black box ontop of the touch box: this makes a boundary
	
	# Draw a green box, this is the touch box, height/width are temporary and are updated later
	box {color = 0,255,0;height=10;width=10;display_index=2;}startCueE;
	x=0; y=0;
	on_top=true;
	
	#draw a blue box, this is the touch marker, height/width are 3 pixels
	box {color=0,0,255;height=10;width=10;display_index=2;}touchMarkerPretrial;
	x=5000; y=5000; #the touch position is updated throughout
	on_top=true; # plot the touch positon on the top layer of the picture
	
	text { caption = "Touch_Info"; display_index=2;} touchTextPretrial;
	x = 400; y = 400; # String to display touch position
	
	text { caption = "Pre_trial"; display_index=2;} countdownTextPretrial;
	x = 0; y = 0; # String to display count down until trial
	
	text { caption = "Trial_Info"; display_index=2;} trialTextPretrial;
	x = -400; y = 400; # String to display touch position

} pretrialExperimenter;


#Touch stimulus (touchbox) to show the monkey
picture{

	#display this picture on the monkey's monitor (monitor 1)
	display_index=1;
	
	bitmap {display_index=1;filename="placeholder.bmp";
		width=500;
		height=500;}leftMovieMonkey;
		x=-300; y=0;	# Position of the movie on screen
		on_top=true;
		
	bitmap {display_index=1;filename="placeholder.bmp";
		width=500;
		height=500;}rightMovieMonkey;
		x=300; y=0;	# Position of the movie on screen
		on_top=true; 
	
	box {color = 0,255,0;height=500;width=500;display_index=1;}leftTouchCueMonkey;
	x=-9999; y=9999;  			# The position of the right touch cue
	
	box {color = 0,255,0;height=500;width=500;display_index=1;}rightTouchCueMonkey;
	x=9999; y=9999;  			# The position of the right touch cue
		

	
}stimulusMonkey;


#Touch stimulus (touchbox) to show the experimenter
picture{

	#display this picture on the experimenter's monitor (monitor 2)
	display_index=2;
	
	box {color = 255,0,0;height=10;width=10;display_index=2;}leftTouchBoxBoundary;
	x=-300; y=0;  			# The position of the touch box boundary
	
	box {color = 0,0,0; height=9;width=9; display_index=2;}leftTouchBoxBoundaryBlack;
	x=-300; y=0; 			# The position of the touch box boundary
	#on_top=true; 		# Draw the black box ontop of the touch box: this makes a boundary
	
	bitmap {display_index=2;filename="placeholder.bmp";
		width=500;
		height=500;}leftMovieExperimenter;
		x=-300; y=0;	# Position of the movie on screen
		on_top=true;
		
	box {color = 255,0,0;height=10;width=10;display_index=2;}rightTouchBoxBoundary;
	x=300; y=0;  			# The position of the touch box boundary
	
	box {color = 0,0,0; height=9;width=9; display_index=2;}rightTouchBoxBoundaryBlack;
	x=300; y=0; 			# The position of the touch box boundary
	#on_top=true; 		# Draw the black box ontop of the touch box: this makes a boundary
		
	bitmap {display_index=2;filename="placeholder.bmp";
		width=500;
		height=500;}rightMovieExperimenter;
		x=300; y=0;	# Position of the movie on screen
		on_top=true;
		
		box {color=0,0,255;height=10;width=10;display_index=2;}stimulusTouchMarker;
	x=5000; y=5000;		# The touch position is updated throughout
	on_top=true; 			# plot the touch positon on the top layer of the picture
	
	text { caption = "Touch_Info"; display_index=2;} touchTextStimulus;
	x = 400; y = 400; # String to display touch position
	
	text { caption = "Trial_Info"; display_index=2;} trialTextStimulus;
	x = -400; y = 400;# String to display touch position
	
	text { caption = "LeftVal"; display_index=2;} leftRewardValueText;
	x = -450; y = -500;# String to display touch position
	on_top=true; 
	
	text { caption = "RightVal"; display_index=2;} rightRewardValueText;
	x = 450; y = -500;# String to display touch position
	on_top=true; 
	
	box {color = 0,255,0;height=500;width=500;display_index=2;}leftTouchCueExperimenter;
	x=-9999; y=9999;  			# The position of the right touch cue
	
	box {color = 0,255,0;height=500;width=500;display_index=2;}rightTouchCueExperimenter;
	x=9999; y=9999;  			# The position of the right touch cue
	
}stimulusExperimenter;


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
	x = 400; y = 400;		# String to display touch position
	
	text { caption = "Trial_Info"; display_index=2;} trialTextITI;
	x = -400; y = 400;	# String to display touch position

}itiExperimenter;



# ---------------------------------------------------------------------------
#										Begin PCL code
# ---------------------------------------------------------------------------
begin_pcl;

# Variables for task settings (You can change these)
int stimulusHeight	=	341;				# Height of stimulus (pixels)
int stimulusWidth	=	512;					# Width of stimulus (pixels)
int stimulusTouchWindow	=	0; 			# Extra room (pixels) that the monkey has around the edge of the stimulus(pixels)
													# if stimulusTouchWindow is 100, then there is a leniency of 100 pixels on all sides of the touch box
int startCueX		=	0;						# X-position of the start cue (pixels)
int startCueY		=-100; 					# X-postition of the start cue (pixels)
int startCueSize = 125;						# size of start cue box (pixels)
int startCueWindow =150;					# Size of window, in pixels, around the start cue
int postStartCueDelay = 2500;				# Time delay (ms) after the start cue is touched/not touched
int stimulusTime	=	7000; 				# time that monkey is allowed to get to touch box (ms) per trial
int correctItiDuration	=	5000; 		# Duration of the inter-trial-interval(ms)for correct trials
int startCueMissItiDuration=	5000; 	# Duration of the inter-trial-interval(ms) for start cue errors
int missedItiDuration	=	7000;		 	# Duration of the inter-trial-interval(ms) for missed trials
int ignoredItiDuration   =	8000;			# Duration of the inter-trial-interval(ms) for ignored trials
int preTrialTime	=  5000;					# Length of pretrial period in ms
int monitorXZeroPoint = -1280;			# -1280The pixel touch value of the center of the monkey's monitor (important for calibrating!) (-1920)
int feedbackLength = 250; 					# Time (ms) per trial which the monkey gets visual feedback of correct or incorrect response
int holdTimeLimit = 5000;					# Time (ms) which the monkey can hold the screen before getting an error
int bottomTouchLimit = -300;				# Pixel space below which the monkey can touch free (so that they can hold bottom of monitor)
bool writeResultsToLog = true;			# Boolean value for writing results to log file 
bool catchPreTrialTouches = false;		# Set to true to cancel trials if monkey touches in the pre-trial period
bool catchPreTrialHolding = false;		# Set to true to pause progress if monkey is holding in the pre-trial period
bool catchITITouches = false;				# Set to true to show negative feedback if monkey touches in the ITI
bool catchITIHolding = false;				# Set to true to pause progress if monkey is holding in the ITI
bool catchStimulusHolding = false;		# Set to true to pause progress if monkey is holding in the stimulus period
bool catchMissedStimulusTouches = false;# Set to true to  show negative feedback if monkey touches in the stimulus period
int leftStimulusXPosition = -350;		# X position of left stimulus (in pixels)
int rightStimulusXPosition = 350;		# X position of right stimulus (in pixels)
int stimulusYPosition = 250;				# Y position of both stimuli (in pixels)
int rewardValueTextYPosition = -300;	# Y position of both reward value text on experimenter's screen (in pixels)
int rewardDelayTime = 1000;				# Time (ms) which the monkey sees the postStim
bool showStartCue = false;					# Set to 'true' to show start cue, set to 'false' to skip start cue
bool catchTouchesInDelayPeriod = true;	# Set to 'true' to present incorrect feedback to any response made in the delay period
int delayChoiceFrameLength = 75;			# Number of frames to delay monkey's ability to make a response
int touchCueYOffset = -100;				# Offset (in pixels) on y-axis from which the touch cue is offset from the stimuli
string taskName = "TouchMovieChoice";  # String of task name

# Encode Values (You can change these, but have a really good reason)
int trialStartCode		= 11;				# Code for start of trial
int trialEndCode			= 21;				# Code for end of trial
int startCueOnCode 		= 12;				# Code for start cue on
int startCueHitCode 		= 22;				# Code for monkey missing start cue
int startCueMissCode 	= 23;				# Code for monkey hitting start cue
int startCueIgnoreCode 	= 24;				# Code for monkey ignoring start cue
int stimulusOnCode		= 15;				# Code for stimulus onset
int stimulusOffCode		= 25;				# Code for stimulus offset
int earlyTouchCode		= 14;				# Code for monkey making an early touch
int touchAvailableCode 	= 26;				# Code for availability of choice
int leftChoiceCode 		= 16;				# Code for left option chosen
int rightChoiceCode 		= 17;				# Code for right option chosen
int ignoreChoiceCode 	= 18;				# Code for ignored stimulus
int missChoiceCode 		= 19;				# Code for missed choice
int ITIStartCode			= 20;				# Code for start of ITI
int ITIEndCode				= 30;				# Code for end of ITI
int rewardGivenCode 		= 3;				# Code for reward delivered
int taskStartCode 		= 1;				# Code for start of task (presentation start)
int taskEndCode 			= 2;				# Code for end of task (presentation exit)
int leftItmNumIDCode 	= 6;				# Code precending left item number
int rightItmNumIDCode 	= 7;				# Code precending right item number
int cndNumIDCode 			= 5;				# Code precending condition number
int conditionOffsetValue= 100;			# Offset of condition values
int frameOffsetValue		= 1000;			# Offset of frame indicies
int itemOffsetValue 		= 200;			# Offset of item values

# Variables for running the task (Don't change these)
int clockticker	=	0; 			# Counter for time
int holdticker		=	0; 			# Counter for time
int postStimClockticker = 0;		# Counter for time
int currentBlock = 	0;				# Counter for current trial
int hasTouched 	=	0;				# Boolean for touches
int earlyTouch		= 	0;				# Boolean for early touches
int missedTouches = 	0;				# Counter for missed trials
int ignoredTouches = 0;				# Counter for ignored trials
int startCueMisses	=	0;			# Counter for early touches
int goodTouches = 0;					# Counter for correct trials
int ITItouches		=	0;				# Counter for ITI touches
int numberConditions = 0;			# Number of conditions
int numberTrials  =	0;				# Number of total touchbox presentations (numberTrails * numberConditions)
int trialCount = 0;					# Counter for this presentation
array<int>ordered_cnds_to_show[0];# Integer array in which we will store the ordered condition numbers
int currentConditionIdx;			# Counter for the current condition being shown
int currentConditionVal;			# Value of the current condition being shown
int trialStartTime;					# Time when trial starts
int trialResponseTime; 				# Time when the trial response occurs
int correctResponseCount = 0;		# Tracks number of correct responses
int leftTouchCount = 0;				# Tracks number of left touches
int rightTouchCount = 0;			# Trackers number of right touches
int leftPossibleCorrect = 0;		# Tracks the number of times the left response would be correct
int rightPossibleCorrect = 0;		# Tracks the number of times the right response would be correct
int leftItemValue = 0;				# The value (not index!) of the left item
int rightItemValue = 0;				# The value (not index!) of the right item
string leftMovieDir = "";			# String containing the location of the frames in the left movie
string rightMovieDir = "";			# String containing the location of the frames in the right movie

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
int upperX			= (stimulusWidth/2) + stimulusTouchWindow; # Upper touchbox limits (X)
int lowerX			= (stimulusWidth/2) + stimulusTouchWindow; # Lower touchbox limits (X)
int upperY			= (stimulusHeight/2) + stimulusTouchWindow; # Upper touchbox limits (Y)
int lowerY			= (stimulusHeight/2) + stimulusTouchWindow; # Lower touchbox limits (Y)
int response_count = 0;				# Total response counter
string monkeyResponse = "";		# String to hold monkey's response from trial subroutines

# ------------------ Access national instruments card ------------------
dio_device card = new dio_device( ni_dio_device, 1, 0 );

# ------------------ Setup output ports  ------------------
output_port juicePulse = output_port_manager.get_port(1);
output_port openData = output_port_manager.get_port(2);
output_port openPulse = output_port_manager.get_port(3);

# ------------------ Check for touch device  ------------------
touch_device tdevice = touch_device( response_manager.get_mouse( 1 ) );
if (is_null( tdevice )) then
	exit( "touch_device required for this scenario" )
end;
tdevice.set_max_buffer_count( 100 );

#  ------------------ Create log file ------------------
string logFileName ="";
logFileName = date_time();
logFileName.set_char(11, 95);
logFileName.set_char(3, 45);
logFileName.set_char(6, 45);
logFileName.set_char(14, 45);
logFileName.set_char(17, 45);
logFileName.append("_log.txt");
term.print_line("Writing output to: " + logFileName );
string logFilePath = "\logs";
logFilePath.append(logFileName);
output_file logFile = new output_file;
logFile.open( logFileName, false ); # Don't overwrite
logFile.print( "SCEN:\t"+taskName+"\n" );  


# ------------------ Get the experimental parameters ------------------
string exp_par="touch_parameters.txt"; 				# Name of the text file with the experiment information
input_file exp_info = new input_file;					# Create an input file
exp_info.open( exp_par );									# Load the experimental parameters into the input file
string temp_name;												# Create a string variable for temporary use
temp_name=exp_info.get_line();							# Get the first line of the experimental file (item file)
string item_file=temp_name.substring(12,temp_name.count()-11);	# Filename of the item file
temp_name=exp_info.get_line();  							# Get the next line (just dashes) and ignore
string cnd_file=temp_name.substring(17,temp_name.count()-16);	# Filename of the condition file
temp_name=exp_info.get_line();  							# Get the next line (just dashes) and ignore
temp_name=exp_info.get_line();							# Get the 4th line (number of trials)
int numberBlocks=int(double(temp_name.substring(temp_name.count()-1,2)));	# Write down the number of trials to be shown

#Print out the parameters from the file
term.print_line( "Reading parameters from: " + exp_par );
term.print_line( "Item file: " + item_file);
term.print_line( "Condition file: " + cnd_file);
term.print_line( "Number of blocks " + string(numberBlocks));

#Write parameters to log fileqqq
logFile.print( "PARM:\t"+exp_par+"\n" ); 
logFile.print( "ITEM:\t"+item_file+"\n" );  
logFile.print( "COND:\t"+cnd_file+"\n" );   
logFile.print( "DATE:\t"+date_time()+"\n" );   

# ------------------ Load filenames from item file  ------------------
int i; 															# Create counter variables	
int name_index;												# Create variable to hold name index in item file	
int juiceDrops_index; 										# Create variable to hold amount of juice reward index in item file	
int startFrame_index;										# Create variable to hold starting frame index in item file	
int endFrame_index;											# Create variable to hold ending frame index in item file									
string currentLine;							  		# Create a string variable for the item names
input_file fil = new input_file;   						# Create an input file
fil.open( item_file );										# Load the item file data into the input file
currentLine=fil.get_line();							# Get the first line of the item file (column headers)
name_index=currentLine.find("moviename");
juiceDrops_index=currentLine.find("reward");
startFrame_index=currentLine.find("start");
endFrame_index=currentLine.find("end");

int num_items=int(double(currentLine.substring(currentLine.find("totalitems=")+11,2))); # Assign how many items there are to a avariable
array<int>juiceDrops[num_items];							# Create an array which will contain the associated juice drops for each movie
array<string>movies[num_items];							# Create an array which will movie filenames
array<int>startFrame[num_items];							# Create an array which will starting frame of each movie
array<int>endFrame[num_items];							# Create an array which will ending frame of each movie

#term.print_line( "Filename idx: " + string(name_index));
#term.print_line( "Juice idx: " + string(juiceDrops_index));
#term.print_line( "Start frame idx: " + string(startFrame_index));
#term.print_line( "End frame idx: " + string(endFrame_index));



loop  # Loop through each line in the item file
	i=1
until
	i>(num_items) 
begin 
	
   currentLine = fil.get_line();					# Get the list of characters that compose the current line in the itm file

	movies[i] = currentLine.substring(name_index,currentLine.find(".avi")-name_index);	# Get the item filename
 	juiceDrops[i] = int(double(currentLine.substring(juiceDrops_index,2))); 						# Get the number of juice drops
	startFrame[i] = int(double(currentLine.substring(startFrame_index,3))); 						# Get the starting frame
   endFrame[i] = int(double(currentLine.substring(endFrame_index,3))); 							# Get the ending frame

   term.print_line( "Item: " + string(i) + "\tName: " + movies[i] + "\tReward: " + string(juiceDrops[i]) + "\tStart: " + string(startFrame[i]) + "\tEnd: " + string(endFrame[i]));
	i=i+1;														# Increment the counter                 
end;

# ------------------ Load conditions from condition file  ------------------					
string cnd_name;  											# Create a string variable for the condition names	
input_file fil2 = new input_file;   					# Create an input file
fil2.open(cnd_file);											# Load the item file data into the input file
cnd_name=fil2.get_line();									# Get the first line of the condition file (column headers)
int num_cnds=int(double(cnd_name.substring(cnd_name.find("totalconditions=")+16,3)));#assign how many cnds there are to a variable

int left_index=cnd_name.find("left");
int right_index=cnd_name.find("right");
array<string>left_itm[num_cnds];
array<string>right_itm[num_cnds];        				# Create an array which will contain the item numbers for each condition  			
loop 
	i=1 
until
	i>num_cnds 
begin							# Loop through each line in the cnd file
	cnd_name=fil2.get_line();								# Get the list of characters that compose the current line in the cnd file  
	left_itm[i]=cnd_name.substring(left_index,3);	# Get just the item numbers (not the condition number) for the left side	
	right_itm[i]=cnd_name.substring(right_index-1,3);	# Get just the item numbers (not the condition number) for the right00 side	
	term.print_line( "Cnd: " + string(i) + "\t\tLeft item #: " + left_itm[i] + "\tRight item #: " +right_itm[i]);
   i=i+1;  														# Increment the counter                           
end;                               



#  ------------------ Determine what conditions to show  ------------------

array<int>cnds_to_show[0];									# Create an array that we'll fill with the conditions we want to show
temp_name=exp_info.get_line();							# Get the 5th line of the experimental parameters file (conditions to show)
if (temp_name.find("all")!=0) then						# If the word "all" is typed in the condition line then...
	array<int>cnds_temp[num_cnds];						# Create an array the length of all cnds
	cnds_temp.fill(1, num_cnds, 1, 1);					# Fill the array with all cnds in order
	cnds_to_show.append(cnds_temp);						# Append the cnd array to the global cnd array
	term.print_line( "Showing ALL conditions.\n" );
	logFile.print( "Showing ALL conditions.\n" );  
elseif (temp_name.find("-->")!=0) then					# If an arrow --> is typed in the condition line then...
	int start_cnd = int(double(temp_name.substring(temp_name.find("-->")-3,3)));	# Get the number before the arrow
	int end_cnd = int(double(temp_name.substring(temp_name.find("-->")+3,3)));		# Get the number after the arrow
	array<int>cnds_temp[end_cnd-start_cnd+1];			# Create an array the length of the number of cnds in the range
	cnds_temp.fill(1, end_cnd-start_cnd+1, start_cnd, 1);	#fill the array with cnds in the specified range
	cnds_to_show.append(cnds_temp);						# Append the cnd array to the global cnd array
	logFile.print( "Showing conditions: "+string(start_cnd)+"-->"+string(end_cnd)+".\n" );  
	term.print_line( "Showing conditions: "+string(start_cnd)+"-->"+string(end_cnd)+".\n" );
else																# Otherwise the cnds must be specified as a list
	int start_int=temp_name.find("[");					# Get the start of the list (noted by a bracket [)
	int end_int=temp_name.find("]");						# Get the end of the list (noted by a bracket ])
	array<int>cnds_temp[int(round((1.0/3.0)*(double(end_int-start_int)-1.0)+(1.0/3.0),0))]; # Create an array the length of the number of cnds specified
	int j;														# Create an integer counter
	logFile.print( "Showing conditions: ");
	term.print( "Showing conditions: ");  
	loop j=1 until j>(int(round((1.0/3.0)*(double(end_int-start_int)-1.0)+(1.0/3.0),0))) begin	# Loop through the cnd array
		cnds_temp[j]=int(double(temp_name.substring(start_int+3*j-2,2)));	# Fill the array with the specified cnd
		logFile.print( string(cnds_temp[j])+ " ");
		term.print( string(cnds_temp[j])+ " ");
		j=j+1;													# Increment the integer counter
	end;
	logFile.print( "\n");
	term.print_line( "\n");
	cnds_to_show.append(cnds_temp);						# Append the cnd array to the global cnd array
end;


# ------------------ Determine condition order  ------------------~~
string order;
temp_name=exp_info.get_line();							# Get the 6th line of the experimental parameters file (condition order)
if (temp_name.find("random")!=0) then					# If the specified order is "random"
	order="random";											# Then store this "random" information as a string
else
	order="incremental";										# Otherwise default to "incremental" order
end;

numberConditions = cnds_to_show.count();

#Print out number of conditions
term.print_line( "Number of Conditions " + string(numberConditions) + " Order: " + order);

# ------------------ Determine how to deal with error trials  ------------------
string onErrorBehav;
temp_name=exp_info.get_line();							# Get the 7th line of the experimental parameters file (trial order)
if (temp_name.find("delayed")!=0) then					# If the trial order is "delayed"
	onErrorBehav="delayed";									# Then store this "delayed" information as a string
elseif (temp_name.find("immediate")!=0) then 		# If the trial order is "immediate"
	onErrorBehav="immediate";								# Then store this "incremental" information as a string
else;
	onErrorBehav="ignore";									# Otherwise default to "ignore" trial
end;

# Print blank line to seperate the pre-trial info from trials
term.print_line( "");

# ------------------ Send Encode Subroutine ------------------
sub
	encode ( int codeValue )
begin
	openData.send_code(codeValue, 2);
	openPulse.send_code(255,1)
	#wait_interval(150);
end;

# ------------------ Give Juice Reward Subroutine ------------------
sub
	giveJuiceReward ( int dropsToGive )
begin
	int dropsGiven=1;											# Counter for number of juice drops given already
	loop until 
		dropsGiven > dropsToGive 
	begin
		juicePulse.send_code(10,150);						# Give juice to the monkey
		wait_interval(150);
		juicePulse.send_code(0,150);						# Give juice to the monkey
		wait_interval(150);
		encode(rewardGivenCode); 							# Mark that we are giving juice
		dropsGiven=dropsGiven+1;
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
	
	# Set the size and position of the start cue
	startCueM.set_height(startCueSize);
	startCueM.set_width(startCueSize); 
	int thisTrialStartCueX = startCueX;
	int thisTrialStartCueY = startCueY;
	pretrialMonkey.set_part_x( 1, thisTrialStartCueX); 			# Set the X position of the touch box on the monkey's monitor
	pretrialMonkey.set_part_y( 1, thisTrialStartCueY); 			# Set the Y position of the touch box on the monkey's monitor
	
	# Update the experimenter's screen
	startCueBoundary.set_height(startCueSize+2*startCueWindow); # Set the height boundary of the touchspot (the extra space the monkey is allowed)
	startCueBoundary.set_width(startCueSize+2*startCueWindow); # Set the width boundary of the touchspot (the extra space the monkey is allowed)
	startCueBoundaryBlack.set_height(startCueSize+2*startCueWindow-2); # The above two lines will set the red box height, this is setting the black box height(see picture code for details)
	startCueBoundaryBlack.set_width(startCueSize+2*startCueWindow-2);
	pretrialExperimenter.set_part_x( 3, thisTrialStartCueX); 	# Set the X position of the touch box on the experimenter's monitor
	pretrialExperimenter.set_part_y( 3, thisTrialStartCueY); 	# Set the Y position of the touch box on the experimenter's monitor
	pretrialExperimenter.set_part_x( 2, thisTrialStartCueX); 	# Set the X position of the black touch box on the experimenter's monitor
	pretrialExperimenter.set_part_y( 2, thisTrialStartCueY); 	# Set the Y position of the black touch box on the experimenter's monitor
	pretrialExperimenter.set_part_x( 1, thisTrialStartCueX); 	# Set the X position of the red outline on the experimenter's monitor
	pretrialExperimenter.set_part_y( 1, thisTrialStartCueY); 	# Set the Y position of the red outline on the experimenter's monitor
	startCueE.set_width(startCueSize); 
	startCueE.set_height(startCueSize); 
	
	# Get the limits of a correct touch on the start cue
	int startCueUpperX = thisTrialStartCueX + (startCueSize/2) + startCueWindow; # touchBoxX + (stimulusSize/2) + stimulusTouchWindow;
	int startCueUpperY = thisTrialStartCueY + (startCueSize/2) + startCueWindow;
	int startCueLowerX = thisTrialStartCueX - (startCueSize/2) - startCueWindow;
	int startCueLowerY = thisTrialStartCueY - (startCueSize/2) - startCueWindow;
	
	# Set the caption of the experimenter's trial information string
	trialTextPretrial.set_caption( "Block: " + printf( currentBlock, "%2d" ) + "/" + printf( numberBlocks, "%2d" ) + 
									"\n Condition: "+ printf( currentConditionIdx, "%2d" ) + "/" + printf( numberConditions, "%2d" ) +
									"\n Trial: "+ printf( trialCount, "%2d" ) + "/" + printf( numberTrials, "%2d" ) +
									"\n Good: "+ printf( goodTouches, "%2d" ) + "/" + printf( trialCount, "%2d" ) +
									"\n Missed: "+ printf( missedTouches, "%2d" ) + "/" + printf( trialCount, "%2d" ) +
									"\n Correct: "+ printf( correctResponseCount, "%2d" ) + "/" + printf( goodTouches, "%2d" ) +
									"\n Start Cue Errors: "+ printf( startCueMisses, "%2d" ) + "/" + printf( trialCount, "%2d" ) +
									"\n Left: "+ printf( leftTouchCount, "%2d" ) + "/" +  printf( leftPossibleCorrect, "%2d" )  + "\tRight" + printf( rightTouchCount, "%2d" ) + "/" +  printf( rightPossibleCorrect, "%2d" ) +
									"\n Ignored: "+ printf( ignoredTouches, "%2d" ) + "/" + printf( trialCount, "%2d" ) +
									"\n ITI: "+ printf( ITItouches, "%2d" ), true );
	
	# Present the pretrial screens to monkey and experimenter
	pretrialMonkey.present();
	pretrialExperimenter.present();
	
	# Mark that we have presented the startCue
	encode(startCueOnCode); 								
	
	# Get the current time
	clockticker=clock.time();
	
	# Set boolean for detecting touch to null
	hasTouched = 0;
	bool goodTouch = false;
	
	# Loop until time is up, or if monkey has touched
	loop until 
		(clock.time()-clockticker) > preTrialTime || hasTouched == 1
	begin	
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
			"\nx: " + printf( tr.x(), "%6.1f" ) +
			"\ny: " + printf( tr.y(), "%6.1f" ),
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
				stimulusExperimenter.set_part_x( 7, monkeyX );  
				stimulusExperimenter.set_part_y( 7, monkeyY );
				itiExperimenter.set_part_x( 1, monkeyX );  
				itiExperimenter.set_part_y( 1, monkeyY );
				pretrialExperimenter.set_part_x( 4, monkeyX );  
				pretrialExperimenter.set_part_y( 4, monkeyY );									
				pretrialExperimenter.present();
					
				# Wait for release
				if # It was a touch and not a release
					state == "Down"
				then			
					hasTouched = 1;#Record that the monkey has made a touch response
						
					# Modify the caption in the touch state text
					touchTextPretrial.set_caption( "HOLDING time: " + printf( tr.time_double(), "%9.2f" ) + " " + state + " " +
					"\nx: " + printf( tr.x(), "%6.1f" ) +
					"\ny: " + printf( tr.y(), "%6.1f" ),
					true );
						
					# Update these elements
					touchTextPretrial.redraw();
					pretrialExperimenter.present();
									
					if # The touch was within the boundy of the touch box
						monkeyX <= startCueUpperX && monkeyX >= startCueLowerX && currentY <= startCueUpperY && currentY >= startCueLowerY && state == "Down"
					then # Record that the monkey has made a correct touch
						goodTouch = true; 				# Set our correct touch boolean to true
						
						encode(startCueHitCode); 		# Mark that the monkey has correctly touched the startCue
						
						presentCorrectFeedback(); 		# Present the correct feedback
					else # If the monkey did not touch within the correct boundry
						hasTouched = 1;
						
						encode(startCueMissCode); 		# Mark that the monkey has missed the startCue
						
						presentIncorrectFeedback();	# Present the incorrect feedback
					end;
							
					if
						catchPreTrialHolding == true
					then
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
				end; 
			else
			end;
		end;
			
			
	end;
	
	clockticker=clock.time(); # Get the current time
	
	loop until # Wait until the post start cue delay period is over
		(clock.time()-clockticker) > postStartCueDelay
	begin	
		
	end;
	
		
	if 		# If the monkey has touched the start cue
		goodTouch == true
	then 		# Set the Return variable to be correct
		monkeyResponseSub = "Correct";
	elseif 	# If the monkey has touched but missed the start cue
		hasTouched == 1
	then 
		monkeyResponseSub = "PreTrialMiss";
	else 		# If the monkey has ignored the start cue
		monkeyResponseSub = "PreTrialIgnore";
		encode(startCueIgnoreCode); 		# Mark that the monkey has ignored the startCue	
	end;
	
	# Return 'monkeyResponseSub'
	return monkeyResponseSub
end;

# ------------------ Present ITI Subroutine ------------------
sub
	presentITI( int itiDuration )
begin
	# Mark that we are starting the ITI
	wait_interval(10);
	encode(ITIStartCode);
		
	# Set the caption of the experimenter's trial information string
	trialTextITI.set_caption( "Block: " + printf( currentBlock, "%2d" ) + "/" + printf( numberBlocks, "%2d" ) + 
										"\n Condition: "+ printf( currentConditionIdx, "%2d" ) + "/" + printf( numberConditions, "%2d" ) +
										"\n Trial: "+ printf( trialCount, "%2d" ) + "/" + printf( numberTrials, "%2d" ) +
										"\n Good: "+ printf( goodTouches, "%2d" ) + "/" + printf( trialCount, "%2d" ) +
										"\n Missed: "+ printf( missedTouches, "%2d" ) + "/" + printf( trialCount, "%2d" ) +
										"\n Correct: "+ printf( correctResponseCount, "%2d" ) + "/" + printf( goodTouches, "%2d" ) +
										"\n Start Cue Errors: "+ printf( startCueMisses, "%2d" ) + "/" + printf( trialCount, "%2d" ) +
										"\n Left: "+ printf( leftTouchCount, "%2d" ) + "/" +  printf( leftPossibleCorrect, "%2d" )  + "\tRight" + printf( rightTouchCount, "%2d" ) + "/" +  printf( rightPossibleCorrect, "%2d" ) +
										"\n Ignored: "+ printf( ignoredTouches, "%2d" ) + "/" + printf( trialCount, "%2d" ) +
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
			"\nx: " + printf( tr.x(), "%6.1f" ) +
			"\ny: " + printf( tr.y(), "%6.1f" ),
			true );
			touchTextITI.redraw();
			
			# Update the positon of the touch marker in the experimenter's screen
			stimulusExperimenter.set_part_x( 7, monkeyX );  
			stimulusExperimenter.set_part_y( 7, monkeyY );
			itiExperimenter.set_part_x( 1, monkeyX );  
			itiExperimenter.set_part_y( 1, monkeyY );
			pretrialExperimenter.set_part_x( 4, monkeyX );  
			pretrialExperimenter.set_part_y( 4, monkeyY ); 	
			
			# Update these elements
			itiExperimenter.present();
			itiMonkey.present();
			
				# Wait for release
				if # It was a touch and not a release
				 state == "Down"
				then
					
					if
						catchITITouches == true
					then
						# Present incorrect feedback
						presentIncorrectFeedback();
					end;
					
					#Increase our ITI touch count
					ITItouches = ITItouches + 1;
					
					# Re-present the ITI screen to the monkey and experimenter
					itiExperimenter.present();
					itiMonkey.present();
					
					# Modify the caption in the touch state text
					touchTextITI.set_caption( "HOLDING time: " + printf( tr.time_double(), "%9.2f" ) + " " + state + " " +
					"\nx: " + printf( tr.x(), "%6.1f" ) +
					"\ny: " + printf( tr.y(), "%6.1f" ),
					true );
					
					# Update these elements
					touchTextITI.redraw();
					itiExperimenter.present();
					
					if # If we are going to catch holding in the ITI
						catchITIHolding == true
					then
						
						# Get the current time for managing holding
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
					end
				end; 
			else
			end;
		end;
	end;
	
	# Mark that we are finished with the ITI
	encode(ITIEndCode);	
end;

# ------------------ Present Post-stimulus Subroutine ------------------
sub
	presentPostStimulus ( string choice )
begin
	

	# Find juice values of left and right stimulus
	int leftJuiceValue = juiceDrops[int(double(left_itm[ordered_cnds_to_show[currentConditionIdx]].substring(1,2)))];
	int rightJuiceValue = juiceDrops[int(double(right_itm[ordered_cnds_to_show[currentConditionIdx]].substring(1,2)))];
	
	if
		choice == "Left"
	then
		stimulusMonkey.set_part_x( 2, 9999); 			# Move the right stimulus off the monkey's screen
		stimulusMonkey.set_part_y( 2, 9999); 			# Move the right stimulus off the monkey's  screen
		stimulusMonkey.set_part_x( 4, 9999); 			# Move the right touch cue box on the monkey's monitor
		stimulusMonkey.set_part_y( 4, 9999);   		# Move the right touch cue box on the monkey's monitor
		leftTouchCueMonkey.set_color( 0, 0, 255 );	# Set the left touch cue color on the monkey's monitor
		stimulusMonkey.present();							# Update the monkey's screen
		stimulusExperimenter.set_part_x( 6, 9999); 	# Move the right stimulus off the the experimenter's monitor
		stimulusExperimenter.set_part_y( 6, 9999); 	# Move the right stimulus off the the experimenter's monitor
		stimulusExperimenter.set_part_x( 5, 9999); 	# Move the right stimulus off the the experimenter's monitor
		stimulusExperimenter.set_part_y( 5, 9999); 	# Move the right stimulus off the the experimenter's monitor
		stimulusExperimenter.set_part_x( 4, 9999); 	# Move the right stimulus off the the experimenter's monitor
		stimulusExperimenter.set_part_y( 4, 9999); 	# Move the right stimulus off the the experimenter's monitor
		stimulusExperimenter.set_part_x( 13, -9999); # Move the right touch cue box on the experimenter's monitor
		stimulusExperimenter.set_part_y( 13, -9999); # Move the right touch cue box on theexperimenter's monitor
		leftTouchCueExperimenter.set_color( 0, 0, 255 );	# Set the right touch cue color on the monkey's monitor
		stimulusExperimenter.present();					# Update the experimenter's screen
		
		#Get the current time
		postStimClockticker=clock.time();
		loop until # Loop until time is up
			(clock.time()-postStimClockticker) > rewardDelayTime
		begin
		end;
		
		giveJuiceReward ( leftJuiceValue );
		leftTouchCount = leftTouchCount+1;
		if leftJuiceValue > rightJuiceValue
		then
			correctResponseCount = correctResponseCount+1;
		end;
		
	elseif
		choice == "Right"
	then
		# Set the Y position of the touch box on the monkey's monitor
		
		stimulusMonkey.set_part_x( 1, 9999); 			# Move the left stimulus off the monkey's screen
		stimulusMonkey.set_part_y( 1, 9999); 			# Move the left stimulus off the monkey's screen
		stimulusMonkey.set_part_x( 3, -9999); 			# Move the left touch cue on the monkey's monitor
		stimulusMonkey.set_part_y( 3, 9999); 			# Move the left touch cue on the monkey's monitor
		rightTouchCueMonkey.set_color( 0, 0, 255 );	# Set the right touch cue color on the monkey's monitor
		stimulusMonkey.present();							# Update the monkey's screen
		stimulusExperimenter.set_part_x( 3, 9999); 	# Move the left stimulus off the the experimenter's monitor
		stimulusExperimenter.set_part_y( 3, 9999); 	# Move the left stimulus off the the experimenter's monitor
		stimulusExperimenter.set_part_x( 2, 9999); 	# Move the left stimulus off the the experimenter's monitor
		stimulusExperimenter.set_part_y( 2, 9999); 	# Move the left stimulus off the the experimenter's monitor
		stimulusExperimenter.set_part_x( 1, 9999); 	# Move the left stimulus off the the experimenter's monitor
		stimulusExperimenter.set_part_y( 1, 9999); 	# Move the left stimulus off the the experimenter's monitor
		stimulusExperimenter.set_part_x( 12, -9999); # Move the left touch cue box on the experimenter's monitor
		stimulusExperimenter.set_part_y( 12, -9999); # Move the left touch cue box on theexperimenter's monitor
		rightTouchCueExperimenter.set_color( 0, 0, 255 );	# Set the right touch cue color on the monkey's monitor
		stimulusExperimenter.present();					# Update the experimenter's screen

		#Get the current time
		postStimClockticker=clock.time();
		loop until # Loop until time is up
			(clock.time()-postStimClockticker) > rewardDelayTime
		begin
		end;
		
		giveJuiceReward (rightJuiceValue );
		rightTouchCount = rightTouchCount+1;
		if rightJuiceValue > leftJuiceValue
		then
			correctResponseCount = correctResponseCount+1;
			
		end;
	else
		
	end;
	
	
	stimulusMonkey.set_part_x( 3, -9999); 						# Set the X position of the left touch cue on the monkey's monitor
	stimulusMonkey.set_part_y( 3, 9999); 						# Set the Y position of the left touch cue on the monkey's monitor
	stimulusMonkey.set_part_x( 4, 9999); 						# Set the X position of the right touch cue box on the monkey's monitor
	stimulusMonkey.set_part_y( 4, 9999);   					# Set the Y position of the right touch cue box on the monkey's monitor
	leftTouchCueMonkey.set_color( 0, 255, 0 );				# Set the left touch cue color on the monkey's monitor
	rightTouchCueMonkey.set_color( 0, 255, 0 );				# Set the right touch cue color on the monkey's monitor
	
	stimulusExperimenter.set_part_x( 12, -9999); 			# Set the X position of the left touch cue on the experimenter's monitor
	stimulusExperimenter.set_part_y( 12, 9999); 				# Set the Y position of the left touch cue on the experimenter's monitor
	stimulusExperimenter.set_part_x( 13, 9999); 				# Set the X position of the right touch cue box on the experimenter's monitor
	stimulusExperimenter.set_part_y( 13, 9999);   			# Set the Y position of the right touch cue box on the experimenter's monitor
	leftTouchCueExperimenter.set_color( 0, 255, 0 );		# Set the left touch cue color on the experimenter's monitor
	rightTouchCueExperimenter.set_color( 0, 255, 0 );		# Set the right touch cue color on the experimenter's monitor
	
	stimulusMonkey.present();
	stimulusExperimenter.present();

	

	
end;
# ------------------ Present Stimulus Subroutine ------------------
sub
   string presentStimulus 
begin
	
	# Create variables for stimulus period
	response_data lastTouch; 			# Variable for tracking the last touch
   string monkeyResponseSub = ""; 	# String to return with results of trial
	bool goodChoiceTouch = false; 	# Variable for tracking if the touch was correct or not
	bool earlyChoiceTouch = false;	# Variable for tracking if the the monkey made an early touch
	
	# Find juice values of left and right stimulus
	int leftJuiceValue = juiceDrops[int(double(left_itm[ordered_cnds_to_show[currentConditionIdx]].substring(1,2)))];
	int rightJuiceValue = juiceDrops[int(double(right_itm[ordered_cnds_to_show[currentConditionIdx]].substring(1,2)))];
	
	# Determine the choice with the higher value (i.e. correct choice)
	if leftJuiceValue > rightJuiceValue then
		leftPossibleCorrect = leftPossibleCorrect+1;
	else
		rightPossibleCorrect = rightPossibleCorrect+1;
	end;
	
	# Get the position of the stimuli on the screen
	int leftStimulusX = leftStimulusXPosition;							# Get the left stimulus X position
	int leftStimulusY = stimulusYPosition;									# Get the left stimulus Y position
	int rightStimulusX = rightStimulusXPosition;							# Get the right stimulus X position
	int rightStimulusY = -300;								# Get the right stimulus Y position
	
	leftFrameMonkey.set_part_x(1, leftStimulusX);
	leftFrameMonkey.set_part_y(1, leftStimulusY);
	rightFrameMonkey.set_part_x(1, rightStimulusX);
	rightFrameMonkey.set_part_y(1, rightStimulusY);


	# Offset existing pixel boundry for correct touch on left stimulus
	int leftUpperX = leftStimulusX + upperX;
	int leftLowerX = leftStimulusX - lowerX;
	int leftUpperY = leftStimulusY + upperY +touchCueYOffset;
	int leftLowerY = leftStimulusY - lowerY +touchCueYOffset;

	# Offset existing pixel boundry for correct touch on right stimulus	
	int rightUpperX = rightStimulusX + upperX;
	int rightLowerX = rightStimulusX - lowerX;
	int rightUpperY = rightStimulusY + upperY +touchCueYOffset;
	int rightLowerY = rightStimulusY - lowerY +touchCueYOffset;
	

										
	
	#delayChoiceFrameLength
	
	#--------------------------------------------- Play movies loop ---------------------------------------------
	
	# Create index and value integers for looping through frames
	int frameIndex = 0;
	int leftFrameValue = 0;
	int rightFrameValue = 0;
	int numberFrames = 0;
	
	if # If the length of the two movies are not equal (should not be the case usually)
		(endFrame[leftItemValue]-startFrame[leftItemValue]) != (endFrame[rightItemValue]-startFrame[rightItemValue])
	then
		# Find the length of the shorter movie
		if 
			(endFrame[leftItemValue]-startFrame[leftItemValue]) > (endFrame[rightItemValue]-startFrame[rightItemValue])
		then
			numberFrames = (endFrame[rightItemValue]-startFrame[rightItemValue]);
		else
			numberFrames = (endFrame[leftItemValue]-startFrame[leftItemValue]);
		end;
		
	else # Otherwise find the 
		numberFrames = (endFrame[leftItemValue]-startFrame[leftItemValue]);
	end;
	
	clockticker = clock.time();
	
	loop # Loop through each frame
		frameIndex = 1
	until 
		frameIndex >= numberFrames
	begin
		
		# Find the actual frame values of the left and right movies
		#leftFrameValue = startFrame[leftItemValue] + frameIndex - 1;
		#rightFrameValue = startFrame[rightItemValue] + frameIndex - 1;
		
		leftFrameMonkey.set_part( 1, leftMovieBMPs[frameIndex] ); 
		#rightFrameMonkey.set_part( 1, rightMovieBMPs[frameIndex] ); 
		
		#leftFrameExperimenter.set_part( 1, leftMovieBMPs[frameIndex] ); 
		#rightFrameExperimenter.set_part( 1, rightMovieBMPs[frameIndex] ); 
		
		# Present the trial
		framesPresent.present();
		
		leftMovieBMPs[frameIndex].unload();
		#rightMovieBMPs[frameIndex].unload();
		
		# Increment the counter
		frameIndex = frameIndex+1;
	end;
	
	int movieActualTimeMs = clock.time()-clockticker;
	
	term.print_line("Actual play time (ms): " + string(movieActualTimeMs));
	
	
	/*
		# Update the trial text to the current trial
	trialTextStimulus.set_caption( "Block: " + printf( currentBlock, "%2d" ) + "/" + printf( numberBlocks, "%2d" ) + 
										"\n Condition: "+ printf( currentConditionIdx, "%2d" ) + "/" + printf( numberConditions, "%2d" ) +
										"\n Trial: "+ printf( trialCount, "%2d" ) + "/" + printf( numberTrials, "%2d" ) +
										"\n Good: "+ printf( goodTouches, "%2d" ) + "/" + printf( trialCount, "%2d" ) +
										"\n Missed: "+ printf( missedTouches, "%2d" ) + "/" + printf( trialCount, "%2d" ) +
										"\n Correct: "+ printf( correctResponseCount, "%2d" ) + "/" + printf( goodTouches, "%2d" ) +
										"\n Start Cue Errors: "+ printf( startCueMisses, "%2d" ) + "/" + printf( trialCount, "%2d" ) +
										"\n Left: "+ printf( leftTouchCount, "%2d" ) + "/" +  printf( leftPossibleCorrect, "%2d" )  + "\tRight" + printf( rightTouchCount, "%2d" ) + "/" +  printf( rightPossibleCorrect, "%2d" ) +
										"\n Ignored: "+ printf( ignoredTouches, "%2d" ) + "/" + printf( trialCount, "%2d" ) +
										"\n ITI: "+ printf( ITItouches, "%2d" ), true );
	
	# Move the touchCue off the screen
	stimulusMonkey.set_part_x( 3, -9999); 						# Set the X position of the left touch cue on the monkey's monitor
	stimulusMonkey.set_part_y( 3, 9999); 						# Set the Y position of the left touch cue on the monkey's monitor
	stimulusMonkey.set_part_x( 4, 9999); 						# Set the X position of the right touch cue box on the monkey's monitor
	stimulusMonkey.set_part_y( 4, 9999);   					# Set the Y position of the right touch cue box on the monkey's monitor
	leftTouchCueMonkey.set_color( 0, 255, 0 );				# Set the left touch cue color on the monkey's monitor
	rightTouchCueMonkey.set_color( 0, 255, 0 );				# Set the right touch cue color on the monkey's monitor
	stimulusExperimenter.set_part_x( 12, -9999); 			# Set the X position of the left touch cue on the experimenter's monitor
	stimulusExperimenter.set_part_y( 12, 9999); 				# Set the Y position of the left touch cue on the experimenter's monitor
	stimulusExperimenter.set_part_x( 13, 9999); 				# Set the X position of the right touch cue box on the experimenter's monitor
	stimulusExperimenter.set_part_y( 13, 9999);   			# Set the Y position of the right touch cue box on the experimenter's monitor
	
	# Update the position of the stimuli on the monkey's screen
	stimulusMonkey.set_part_x( 1, leftStimulusX); 						# Set the X position of the left stimulus on the monkey's monitor
	stimulusMonkey.set_part_y( 1, leftStimulusY); 						# Set the Y position of the left stimulus on the monkey's monitor
	stimulusMonkey.set_part_x( 2, rightStimulusX); 						# Set the X position of the right stimulus on the monkey's monitor
	stimulusMonkey.set_part_y( 2, rightStimulusY); 						# Set the Y position of the right stimulus on the monkey's monitor
	
	
	

	# Update the position of the stimuli on the experimenter's screen
	leftRewardValueText.set_caption(printf( leftJuiceValue, "%2d" ), true );
	rightRewardValueText.set_caption(printf( rightJuiceValue, "%2d" ), true );
	leftTouchBoxBoundary.set_height(stimulusSize+2*stimulusTouchWindow);# Set the height boundary of the stimulus (the extra space the monkey is allowed)
	leftTouchBoxBoundary.set_width(stimulusSize+2*stimulusTouchWindow); # Set the width boundary of the stimulus (the extra space the monkey is allowed)
	leftTouchBoxBoundaryBlack.set_height(stimulusSize+2*stimulusTouchWindow-2); # The above two lines will set the red box height, this is setting the black box height(see picture code for details)
	leftTouchBoxBoundaryBlack.set_width(stimulusSize+2*stimulusTouchWindow-2);
	stimulusExperimenter.set_part_x( 3, leftStimulusX); 				# Set the X position of the touch box on the experimenter's monitor
	stimulusExperimenter.set_part_y( 3, leftStimulusY); 				# Set the Y position of the touch box on the experimenter's monitor
	stimulusExperimenter.set_part_x( 2, leftStimulusX); 				# Set the X position of the black touch box on the experimenter's monitor
	stimulusExperimenter.set_part_y( 2, leftStimulusY +touchCueYOffset); 				# Set the Y position of the black touch box on the experimenter's monitor
	stimulusExperimenter.set_part_x( 1, leftStimulusX); 				# Set the X position of the red outline on the experimenter's monitor
	stimulusExperimenter.set_part_y( 1, leftStimulusY +touchCueYOffset); 				# Set the Y position of the red outline on the experimenter's monitor
	rightTouchBoxBoundary.set_height(stimulusSize+2*stimulusTouchWindow);# Set the height boundary of the stimulus (the extra space the monkey is allowed)
	rightTouchBoxBoundary.set_width(stimulusSize+2*stimulusTouchWindow); # Set the width boundary of the stimulus (the extra space the monkey is allowed)
	rightTouchBoxBoundaryBlack.set_height(stimulusSize+2*stimulusTouchWindow-2); # The above two lines will set the red box height, this is setting the black box height(see picture code for details)
	rightTouchBoxBoundaryBlack.set_width(stimulusSize+2*stimulusTouchWindow-2);
	stimulusExperimenter.set_part_x( 6, rightStimulusX); 				# Set the X position of the touch box on the experimenter's monitor
	stimulusExperimenter.set_part_y( 6, rightStimulusY); 				# Set the Y position of the touch box on the experimenter's monitor
	stimulusExperimenter.set_part_x( 5, rightStimulusX); 				# Set the X position of the black touch box on the experimenter's monitor
	stimulusExperimenter.set_part_y( 5, rightStimulusY +touchCueYOffset); 				# Set the Y position of the black touch box on the experimenter's monitor
	stimulusExperimenter.set_part_x( 4, rightStimulusX); 				# Set the X position of the red outline on the experimenter's monitor
	stimulusExperimenter.set_part_y( 4, rightStimulusY +touchCueYOffset); 				# Set the Y position of the red outline on the experimenter's monitor
	#--------------------------------------------- Delay period loop ---------------------------------------------
	if # If we are delaying the monkey's choice
		delayChoice ==  true
	then
		# Present the updated stimuli screens
		stimulusMonkey.present();
		stimulusExperimenter.present();
		
		#Mark that the stimulus is coming on
		encode(stimulusOnCode);
		
		int actualDelayChoiceLength = delayChoiceLength;
		
		if 
			randomizeDelayChoiceLength == true
		then
			int randomFloatAddition = random( -delayChoiceFloat, delayChoiceFloat );
			actualDelayChoiceLength = delayChoiceLength + randomFloatAddition;
		end;
		
		
		# Wait until the choice delay is up
		postStimClockticker=clock.time(); # Get the current time
		loop until 								 # Loop until time is up
			(clock.time()-postStimClockticker) > actualDelayChoiceLength || noEarlyStimTouch == false
		begin
			
			if
				catchTouchesInDelayPeriod == true
			then
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
						
						#timeRemainingPostChoice = (clockticker+stimulusTime) - clock.time();
						
						# Convert to relative coordinates on the monkey's monitor
						monkeyX = currentX - monitorXZeroPoint;
						monkeyY = currentY ;
						
						# Set the default state of the touch to donw
						string state = "Down";
						
						# If this was a release, mark state as "Up "
						if (tr.button() == 2) then state = "Up  " end;
						
						# Modify the caption in the touch state text
						touchTextStimulus.set_caption( "Touch time: " + printf( tr.time_double(), "%9.2f" ) + " " + state + " " +
						"\nx: " + printf( tr.x(), "%6.1f" ) +
						"\ny: " + printf( tr.y(), "%6.1f" ),
						true );
						
						# Set the location of the touch marker
						stimulusExperimenter.set_part_x( 7, monkeyX );  
						stimulusExperimenter.set_part_y( 7, monkeyY );
						itiExperimenter.set_part_x( 1, monkeyX );  
						itiExperimenter.set_part_y( 1, monkeyY );
						pretrialExperimenter.set_part_x( 4, monkeyX );  
						pretrialExperimenter.set_part_y( 4, monkeyY );
						
						# Update the experimenter's screen
						stimulusExperimenter.present();
						
						if # It was a touch and not a release
							state == "Down"
						then
							if # The touch was within the boundy of the left touch box
								monkeyX <= leftUpperX && monkeyX >= leftLowerX && currentY <= leftUpperY && currentY >= leftLowerY && state == "Down"
							then 
								#Set 'noEarlyStimTouch' to false to indicate the monkey has touched before touchCue is on
								noEarlyStimTouch = false;
								
								#Mark that the monkey has made an early response
								encode(earlyTouchCode);
								
								# Present incorrect feedback
								presentIncorrectFeedback();
									
							elseif # The touch was within the boundy of the right touch box
								monkeyX <= rightUpperX && monkeyX >= rightLowerX && currentY <= rightUpperY && currentY >= rightLowerY && state == "Down"
							then
									#Set 'noEarlyStimTouch' to false to indicate the monkey has touched before touchCue is on
									noEarlyStimTouch = false;
									
									#Mark that the monkey has made an early response
									encode(earlyTouchCode);
									
									# Present incorrect feedback
									presentIncorrectFeedback();
							end;
							
							#Set positions of touch cues off screen again for next trial
							stimulusMonkey.set_part_x( 3, -9999); 						# Set the X position of the left touch cue on the monkey's monitor
							stimulusMonkey.set_part_y( 3, 9999); 						# Set the Y position of the left touch cue on the monkey's monitor
							stimulusMonkey.set_part_x( 4, 9999); 						# Set the X position of the right touch cue box on the monkey's monitor
							stimulusMonkey.set_part_y( 4, 9999);   					# Set the Y position of the right touch cue box on the monkey's monitor
							leftTouchCueMonkey.set_color( 0, 255, 0 );				# Set the left touch cue color on the monkey's monitor
							rightTouchCueMonkey.set_color( 0, 255, 0 );				# Set the right touch cue color on the monkey's monitor
							stimulusExperimenter.set_part_x( 12, -9999); 			# Set the X position of the left touch cue on the experimenter's monitor
							stimulusExperimenter.set_part_y( 12, 9999); 				# Set the Y position of the left touch cue on the experimenter's monitor
							stimulusExperimenter.set_part_x( 13, 9999); 				# Set the X position of the right touch cue box on the experimenter's monitor
							stimulusExperimenter.set_part_y( 13, 9999);   			# Set the Y position of the right touch cue box on the experimenter's monitor
														
						end;
					end;
				end;
			end;		
		end;
	else
		#Mark that the stimulus is coming on
		encode(stimulusOnCode);
	end;
	
	# Show the touch cue
	stimulusMonkey.set_part_x( 3, leftStimulusX); 						# Set the X position of the left touch cue on the monkey's monitor
	stimulusMonkey.set_part_y( 3, leftStimulusY+touchCueYOffset); 	# Set the Y position of the left touch cue on the monkey's monitor
	stimulusMonkey.set_part_x( 4, rightStimulusX); 						# Set the X position of the right touch cue box on the monkey's monitor
	stimulusMonkey.set_part_y( 4, rightStimulusY+touchCueYOffset); # Set the Y position of the right touch cue box on the monkey's monitor
	leftTouchCueMonkey.set_height(stimulusSize+2*stimulusTouchWindow);	# Set the left touch cue height on the monkey's monitor
	leftTouchCueMonkey.set_width(stimulusSize+2*stimulusTouchWindow);	# Set the left touch cue width on the monkey's monitor
	rightTouchCueMonkey.set_height(stimulusSize+2*stimulusTouchWindow); # Set the right touch cue height on the monkey's monitor
	rightTouchCueMonkey.set_width(stimulusSize+2*stimulusTouchWindow);  # Set the right touch cue width on the monkey's monitor
	leftTouchCueMonkey.set_color( 0, 255, 0 );							# Set the left touch cue color on the monkey's monitor
	rightTouchCueMonkey.set_color( 0, 255, 0 );							# Set the right touch cue color on the monkey's monitor
	stimulusExperimenter.set_part_x( 12, leftStimulusX); 						# Set the X position of the left touch cue on the experimenter's monitor
	stimulusExperimenter.set_part_y( 12, leftStimulusY+touchCueYOffset); # Set the Y position of the left touch cue on the experimenter's monitor
	stimulusExperimenter.set_part_x( 13, rightStimulusX); 				   # Set the X position of the right touch cue box on tthe experimenter's monitor
	stimulusExperimenter.set_part_y( 13, rightStimulusY+touchCueYOffset);# Set the Y position of the right touch cue box on the experimenter's monitor
	leftTouchCueExperimenter.set_height(stimulusSize+2*stimulusTouchWindow);	# Set the left touch cue height on the experimenter's monitor
	leftTouchCueExperimenter.set_width(stimulusSize+2*stimulusTouchWindow);	# Set the left touch cue width on the experimenter's monitor
	rightTouchCueExperimenter.set_height(stimulusSize+2*stimulusTouchWindow); # Set the right touch cue height on the experimenter's monitor
	rightTouchCueExperimenter.set_width(stimulusSize+2*stimulusTouchWindow);  # Set the right touch cue width on the experimenter's monitor
	leftTouchCueExperimenter.set_color( 0, 255, 0 );							# Set the left touch cue color on the experimenter's monitor
	rightTouchCueExperimenter.set_color( 0, 255, 0 );							# Set the right touch cue color on the experimenter's monitor
	
	#Get the current time
	clockticker=clock.time();

	# Write stimulus values to log file
	logFile.print( "LVal:\t"+string(leftJuiceValue)+"\tRVal:\t"+string(rightJuiceValue)+"\t" );  
	
	# Present the updated stimuli screens
	stimulusMonkey.present();
	stimulusExperimenter.present();
	
	#--------------------------------------------- Response period loop ---------------------------------------------
	if 
		noEarlyStimTouch == true
	then
		# Variable for tracking if the monkey has touched on this trial
		hasTouched = 0;
		
		#Mark that the monkey can now make a response
		encode(touchAvailableCode);
		
		loop until # Loop until time is up or the monkey has touched
				(clock.time()-clockticker) > stimulusTime || hasTouched == 1
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
					
					timeRemainingPostChoice = (clockticker+stimulusTime) - clock.time();
					
					# Convert to relative coordinates on the monkey's monitor
					monkeyX = currentX - monitorXZeroPoint;
					monkeyY = currentY ;
					
					# Set the default state of the touch to donw
					string state = "Down";
					
					# If this was a release, mark state as "Up "
					if (tr.button() == 2) then state = "Up  " end;
					
					# Modify the caption in the touch state text
					touchTextStimulus.set_caption( "Touch time: " + printf( tr.time_double(), "%9.2f" ) + " " + state + " " +
					"\nx: " + printf( tr.x(), "%6.1f" ) +
					"\ny: " + printf( tr.y(), "%6.1f" ),
					true );
					
					# Set the location of the touch marker
					stimulusExperimenter.set_part_x( 7, monkeyX );  
					stimulusExperimenter.set_part_y( 7, monkeyY );
					itiExperimenter.set_part_x( 1, monkeyX );  
					itiExperimenter.set_part_y( 1, monkeyY );
					pretrialExperimenter.set_part_x( 4, monkeyX );  
					pretrialExperimenter.set_part_y( 4, monkeyY );
					
					# Update the experimenter's screen
					stimulusExperimenter.present();
					
					# Wait for release
					if # It was a touch and not a release
						state == "Down"
					then
						
						
							#term.print("rUpX:"+string(rightUpperX)+"\trLwX:"+string(rightLowerX)+"\trUpY:"+string(rightUpperY)+"\trLwY:"+string(rightUpperY)+"\n");
							#term.print("lUpX:"+string(leftUpperX)+"\tlLwX:"+string(leftLowerX)+"\tlUpY:"+string(leftUpperY)+"\tlLwY:"+string(leftUpperY)+"\n");
							#term.print("mkyX:"+string(monkeyX)+"\tmkyY:"+string(currentY)+"\n");
							
								if # The touch was within the boundy of the touch box
									monkeyX <= leftUpperX && monkeyX >= leftLowerX && currentY <= leftUpperY && currentY >= leftLowerY && state == "Down"
								then # Record that the monkey has made a correct touch
									goodTouch = 1; 							# Set our correct touch boolean to true
									monkeyResponseSub = "Left";
									
									#Mark that the monkey has chosen the left option
									encode(leftChoiceCode);
									
									presentPostStimulus( monkeyResponseSub);
									hasTouched = 1;							#Record that the monkey has made a touch response	
										
								elseif # Otherwise, if the monkey released on the square
									monkeyX <= rightUpperX && monkeyX >= rightLowerX && currentY <= rightUpperY && currentY >= rightLowerY && state == "Down"
								then
									goodTouch = 1; 							# Set our correct touch boolean to true
									monkeyResponseSub = "Right";
									
									#Mark that the monkey has chosen the right option
									encode(rightChoiceCode);
									
									presentPostStimulus( monkeyResponseSub);
									hasTouched = 1;							#Record that the monkey has made a touch response
								else # If the monkey did not touch within the correct boundry
									if 
										catchMissedStimulusTouches == true
									then
										hasTouched = 1;
										#Mark that the monkey has missed the targets
										encode(missChoiceCode);
										presentIncorrectFeedback();		# Present the incorrect feedback
										monkeyResponseSub = "Miss";
									end;
								end;
								
							# Modify the caption in the touch state text
							touchTextStimulus.set_caption( "HOLDING time: : " + printf( tr.time_double(), "%9.2f" ) + " " + state + " " +
							"\nx: " + printf( tr.x(), "%6.1f" ) +
							"\ny: " + printf( tr.y(), "%6.1f" ),
							true );
							
							#Update these elements
							touchTextStimulus.redraw();
							stimulusExperimenter.present();
							
							if
								catchStimulusHolding == true
							then
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
						end; 
				else
				end;
			end;	
		end;
	end;
	
	# Parse out the boolean markers to determine the outcome of the trial

	if # If no response was recorded
		hasTouched != 1
	then # Set the response string to 'Ignore'
		monkeyResponseSub = "Ignore";
		#Mark that the monkey has ignored the targets
		encode(ignoreChoiceCode);
	end;
	
	if #If the monkey touched early
		noEarlyStimTouch == false
	then # Set the response string to 'Early'
		monkeyResponseSub = "Early";
	end;
	
	#Mark that stimulus offset
	wait_interval(10);
	encode(stimulusOffCode);
	*/
	
	# Return the monkey's response
	return monkeyResponseSub
end;

# ------------------ Main trial loop ------------------

# Mark that we are starting the main task
encode(taskStartCode);
wait_interval(10);

# Calculate the total number of touchbox presentations (number of trails X number of conditions) 
numberTrials = numberBlocks * numberConditions;

wait_interval(1000); # Short wait period at beginning of experiment

logFile.print( "Starting Task\n" );  

loop # Loop through the number of specified blocks
		currentBlock = 1 
until 
		currentBlock > numberBlocks 
begin 
	
	# Arrange the conditions for random or incremental presentation
	if # If the specification of cnd order is random
		order=="random" 
	then# Randomly shuffle the conditions
			ordered_cnds_to_show.resize(0);
			ordered_cnds_to_show.append(cnds_to_show);
			ordered_cnds_to_show.shuffle();
	else # Otherwise default to incremental ordering
			ordered_cnds_to_show.resize(0);
			ordered_cnds_to_show.append(cnds_to_show); 
	end;

	loop # Loop through all the ordered conditions
		currentConditionIdx = 1 
	until 
		currentConditionIdx > ordered_cnds_to_show.count() 
	begin
		
		#Get the value (NOT index) of the current condition 
		currentConditionVal = ordered_cnds_to_show[currentConditionIdx];
		
		# Mark the current condition
		encode(cndNumIDCode);
		wait_interval(10);
		encode(conditionOffsetValue+currentConditionVal);
		wait_interval(10);
		
		# Get the item values of both left and right movies
		leftItemValue = int(double(left_itm[currentConditionVal].substring(1,2)));
		rightItemValue = int(double(right_itm[currentConditionVal].substring(1,2)));
		
		# Mark the current items
		encode(leftItmNumIDCode);
		wait_interval(10);
		encode(itemOffsetValue+leftItemValue);
		wait_interval(10);
		encode(rightItmNumIDCode);
		wait_interval(10);
		encode(itemOffsetValue+rightItemValue);
		wait_interval(10);
		
		# Set the movies to be shown on this trial
		leftMovieDir = movies[leftItemValue];
		rightMovieDir = movies[rightItemValue];
		
		# Load the movies
		string leftFrameBMPFilename;
		string rightFrameBMPFilename;
		
		# Create a index to load the frames
		int frameIndex = 0;
		
		# Create a counter to loop through the desired the frames
		int actualFrameNumber = 0;
		
		# Loop to load the left movie BMPs
		loop 
			actualFrameNumber = startFrame[leftItemValue]
		until 
			actualFrameNumber >= endFrame[leftItemValue] 
		begin;
		
			# Get the index of the frame we are loading
			frameIndex = actualFrameNumber-startFrame[leftItemValue]+1;
		
			# Unload any prexisting data
			leftMovieBMPs[frameIndex].unload();
			
			# Create the filename of this frame
			leftFrameBMPFilename = leftMovieDir;
			leftFrameBMPFilename.append("\\");
			leftFrameBMPFilename.append(string(actualFrameNumber));
			leftFrameBMPFilename.append(".bmp");
			
			# Load this frame
			leftMovieBMPs[frameIndex].set_filename(leftFrameBMPFilename);
			leftMovieBMPs[frameIndex].load();
			
			# Increment our counter
			actualFrameNumber=actualFrameNumber+1;
			
		end;
		
		# Loop to load the right movie BMPs
		loop 
			actualFrameNumber = startFrame[rightItemValue]
		until 
			actualFrameNumber >= endFrame[rightItemValue] 
		begin;
		
			# Get the index of the frame we are loading
			frameIndex = actualFrameNumber-startFrame[rightItemValue]+1;
		
			# Unload any prexisting data
			rightMovieBMPs[frameIndex].unload();
			
			# Create the filename of this frame
			rightFrameBMPFilename = rightMovieDir;
			rightFrameBMPFilename.append("\\");
			rightFrameBMPFilename.append(string(actualFrameNumber));
			rightFrameBMPFilename.append(".bmp");
			
			# Load this frame
			rightMovieBMPs[frameIndex].set_filename(rightFrameBMPFilename);
			rightMovieBMPs[frameIndex].load();
			
			# Increment our counter
			actualFrameNumber=actualFrameNumber+1;
			
		end;
		
		#Increment the trial counter
		trialCount = trialCount +1;
		
		#Mark the start of this trial
		trialStartTime = clock.time();
		
		#Print the trial information to the log file
		logFile.print( "Trl:\t"+string(trialCount)+"\t" ); 
		logFile.print( "Blk:\t"+string(currentBlock)+"\t" );  
		logFile.print( "Cnd:\t"+string(currentConditionVal)+"\t" );  
		
		
		#These two strings track the monkey's response to different parts of the trial
		string preTrialResponse = "";	
		string stimulusResponse = "";
		
		if # If we are showing the start cue
			showStartCue == true
		then #Present the pretrial period
			preTrialResponse = presentPreTrial();
		else #Otherwise just pretend it was correct
			preTrialResponse = "Correct";
		end;
		
	
		if #If the monkey had a correct pretrial period
			preTrialResponse == "Correct"
		then
			#Present the stimulus period
			stimulusResponse = presentStimulus();
			
			if #If there was a correct response
				stimulusResponse == "Right" || stimulusResponse == "Left"
			then
				
				# Present the correct ITI period
				presentITI(correctItiDuration );
				
				#Increment the good touch counter
				goodTouches = goodTouches + 1;
				
				# Advance the condition
				currentConditionIdx=currentConditionIdx+1;
				
			elseif # If the monkey missed any of the targets
				stimulusResponse == "Missed"
			then
				# Present the correct ITI period
				presentITI(missedItiDuration );
				
				#Increment the missed touch counter
				missedTouches = missedTouches + 1;
				
				# If we are ignoring incorrect trials, advance to the next condition
				if onErrorBehav == "ignore" then currentConditionIdx=currentConditionIdx+1; end;
			
			elseif # If the monkey missed any of the targets
				stimulusResponse == "Early"
			then
				# Present the correct ITI period
				presentITI(missedItiDuration );
				
				#Increment the missed touch counter
				missedTouches = missedTouches + 1;
				
				# If we are ignoring incorrect trials, advance to the next condition
				if onErrorBehav == "ignore" then currentConditionIdx=currentConditionIdx+1; end;
				
			else
				# Present the correct ITI period
				presentITI(ignoredItiDuration );
				
				#Increment the ignored touch counter
				ignoredTouches = ignoredTouches + 1;
				
				# If we are ignoring incorrect trials, advance to the next condition
				if onErrorBehav == "ignore" then currentConditionIdx=currentConditionIdx+1;   end;
				
			end;
			
		else #If the monkey had a failed pretrial period
			# Present the correct ITI period
			presentITI( startCueMissItiDuration );
			
			#Increment the start cue misses counter
			startCueMisses = startCueMisses + 1;
			
			#Save the behavioral response
			stimulusResponse = "StartCueMiss";
		end;
		
		#Get the trial response time
		trialResponseTime = clock.time();
		
		logFile.print( "Rsp:\t"+stimulusResponse+"\t" );  
	
		#Write the start and end time of the trial to the log
		logFile.print( "Start:\t"+string(trialStartTime)+"\t" );  
		logFile.print( "End:\t"+string(trialResponseTime)+"\t" );  
		
		#currentConditionIdx=currentConditionIdx+1;
		
		# Terminate the line on the logfile, indicating the end of a trial
		logFile.print( "END\n");
		
		#Print trial information out to terminal
		term.print_line( "Block: " + string (currentBlock) + "\tCnd: " + string(currentConditionIdx));
		term.print_line( "Correct touches: " + string( goodTouches ) + "/" + string(trialCount) + "   Missed touches: " + string( missedTouches ) + "/" + string(trialCount) + "   Ignored touches: " + string( ignoredTouches ) + "/" + string(trialCount) + "   Early touches: " + string( startCueMisses ) + "/" + string(trialCount));
		term.print_line( "Good choices: "+string(correctResponseCount) + "/" + string(goodTouches) );
		term.print_line( "\n");
			
		
	end; # End of condition loop
	
	# Increment the current trial counter
	currentBlock = currentBlock + 1;
	
end; # End of block loop

#Close the log file
logFile.print( "PROGRAM EXIT" );   
logFile.close();

# Mark that we are finished the main task
encode(taskEndCode);

#Print out behavior information in terminal
term.print_line( " Correct touches: " + string( goodTouches ) + "/" + string(trialCount));
term.print_line( "  Missed touches: " + string( missedTouches ) + "/" + string(trialCount) );
term.print_line( "Start Cue errors: " + string( startCueMisses ) + "/" + string(trialCount) );
term.print_line( " Ignored touches: " + string( ignoredTouches ) + "/" + string(trialCount) );

