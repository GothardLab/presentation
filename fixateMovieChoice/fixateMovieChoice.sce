#	Fixate Movie Choice (fixateMovieChoice)
#	Philip Putnam, 2017, University of Arizona
#
#	Note that this program is written for two monitors, one is the 
#	screen the monkey is using (display 1) and one is the
#	experimenter's monitor (display 2). 
#
#	Verison History
#		v0.1	08/09/17		Branched fixateMovieChoice from buttonMovieChoice
#

# Scenario file parameters
scenario = "Fixate Movie Choice";
active_buttons = 2;
default_font = "Courier New";
default_font_size = 15;

# ---------------------------------------------------------------------------
#										Begin SDL code
# ---------------------------------------------------------------------------
begin;

#Blank default screen
#picture {} default;
picture {
	text { caption = "Hello world 1!"; font_size = 48; };
	x = 0; y = 0;
} pic1;
picture {} default;

picture {
	display_index = 2;
	text { caption = "Hello world 2!"; font_size = 48; display_index = 2; };
	x = 0; y = 0;
} pic2;
picture { display_index = 2; } default2;

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

#Start cue to show the experimenter
picture{

	#display this picture on the experimenter's monitor (monitor 2)
	display_index=2;
		
	#1	#draw a red box, this is the fixspot boundary, height/width are temporary and are updated later
	box {color = 255,0,0;height=150;width=150;display_index=2;}experimenterCueFixspotBoundary;
	x=0; y=0;  #the position of the fixspot boundary, this is updated according to the condition

	#2 #draw a black box, this is still part of the fixspot boundary, height/width are temporary and are updated later
	box {color = 0,0,0; height=148;width=148; display_index=2;}experimenterCueFixspotBoundaryBlack;
	x=0; y=0; #the position of the fixspot boundary, this is updated according to the condition
	on_top=true; #draw the black box ontop of the red box: this makes a red boundary

	
	#3
	box {
      width = 25;
      height = 25;
      color = 255, 255, 255;
		display_index=2;
		
   }experimenterCueFixspotDot;
	x = 0; y = 0;
	on_top=true;
	
	#4
	box {
      width = 5;
      height = 5;
      color = 0, 255, 0;
		display_index=2;
		
   }experimenterCueEyePos;
	x = 9999; y = 9999;
	on_top=true;
	
	
	
	
	text { caption = "Button_Info"; display_index=2;} responseTextCue;
	x = 400; y = -300; # String to display button position
	on_top=true;
	
	text { caption = "Trial_Info"; display_index=2;} trialTextCue;
	x = -400; y = -300;# String to display trial info
	on_top=true;
	
}startCueExperimenter;

#Start cue to show the monkey
picture{

	#display this picture on the experimenter's monitor (monitor 2)
	display_index=1;

	
	#1
	box {
      width = 25;
      height = 25;
      color = 255, 255, 255;
		display_index=1;
   }monkeyCueFixspotDot;
	x = 0; y = 0;
	
}startCueMonkey;


#Button stimulus to show the experimenter
picture{

	#display this picture on the experimenter's monitor (monitor 2)
	display_index=2;
	
	
	#1	#draw a red box, this is the fixspot boundary, height/width are temporary and are updated later
	box {color = 255,0,0;height=150;width=150;display_index=2;}experimenterStimulusFixspotBoundary;
	x=0; y=0;  #the position of the fixspot boundary, this is updated according to the condition

	#2 #draw a black box, this is still part of the fixspot boundary, height/width are temporary and are updated later
	box {color = 0,0,0; height=148;width=148; display_index=2;}experimenterStimulusFixspotBoundaryBlack;
	x=0; y=0; #the position of the fixspot boundary, this is updated according to the condition
	on_top=true; #draw the black box ontop of the red box: this makes a red boundary

	
	#3
	box {
      width = 25;
      height = 25;
      color = 255, 255, 255;
		display_index=2;
		
   }experimenterStimulusFixspotDot;
	x = 0; y = 0;
	on_top=true;
	
	#4
	box {
      width = 5;
      height = 5;
      color = 0, 255, 0;
		display_index=2;
		
   }experimenterStimulusEyePos;
	x = 9999; y = 9999;
	on_top=true;
	
	#5	#draw a red box, this is the fixspot boundary, height/width are temporary and are updated later
	box {color = 255,0,0;height=150;width=150;display_index=2;}experimenterStimulusLeftBoundary;
	x=9999; y=9999;  #the position of the fixspot boundary, this is updated according to the condition

	#6 #draw a black box, this is still part of the fixspot boundary, height/width are temporary and are updated later
	box {color = 0,0,0; height=148;width=148; display_index=2;}experimenterStimulusLeftBoundaryBlack;
	x=9999; y=9999; #the position of the fixspot boundary, this is updated according to the condition
	on_top=true; #draw the black box ontop of the red box: this makes a red boundary
	
	#7	#draw a red box, this is the fixspot boundary, height/width are temporary and are updated later
	box {color = 255,0,0;height=150;width=150;display_index=2;}experimenterStimulusRightBoundary;
	x=9999; y=9999;  #the position of the fixspot boundary, this is updated according to the condition

	#8 #draw a black box, this is still part of the fixspot boundary, height/width are temporary and are updated later
	box {color = 0,0,0; height=148;width=148; display_index=2;}experimenterStimulusRightBoundaryBlack;
	x=9999; y=9999; #the position of the fixspot boundary, this is updated according to the condition
	on_top=true; #draw the black box ontop of the red box: this makes a red boundary
	
	
	#9
	text { caption = "Button_Info"; display_index=2;} responseTextStimulus;
	x = 400; y = -300; # String to display button position
	
	#10
	text { caption = "Trial_Info"; display_index=2;} trialTextStimulus;
	x = -400; y = -300;# String to display trial info
	
	#11
	text { caption = "Left_Stimulus"; display_index=2;} leftStimulusText;
	x = -500; y = 0;# String to display trial info
	
	#12
	text { caption = "Right_Stimulus"; display_index=2;} rightStimulusText;
	x = 500; y = 0;# String to display trial info
	
	#13
	text { caption = "Left_Value"; display_index=2;} leftRewardValueText;
	x = -500; y = -100;# String to display trial info
	
	#14
	text { caption = "Right_Value"; display_index=2;} rightRewardValueText;
	x = 500; y = -100;# String to display trial info
	
}stimulusExperimenter;

#Button stimulus to show the monkey
trial {
   stimulus_event {
      picture {
			#display this picture on the monkey's monitor (monitor 1)
			display_index=1;
			
		
			
			#1 Left video (3D object #1)
			plane { 
            width = 512.0; height = 341.0;
            emissive = 1.0, 1.0, 1.0;
         } leftVideoPlane;
         x = -320; y = 200; z = 0;
			
			#2 Right video (3D object #2)
			plane { 
            width = 512.0; height = 341.0;
            emissive = 1.0, 1.0, 1.0;
         } rightVideoPlane;
         x = 320; y = 200; z = 0;

			#3 Fixation spot
			box {
				width = 25;
				height = 25;
				color = 255, 255, 255;
				display_index=1;
			}monkeyStimulusFixspotDot;
			x = 9999; y = 9999;

      } stimulusPictureMonkey;
   } stimulusEventMonkey;
} stimulusMonkey;



#Screen to show the monkey during the ITI
picture{

	#display this picture on the monkey's monitor (monitor 1)
	display_index=1;

}itiMonkey;

#Screen to show the experimenter during the ITI
picture{

	#display this picture on the monkey's monitor (monitor 1)
	display_index=2;
	
	
	
	text { caption = "Button_Info"; display_index=2;} responseTextITI;
	x = 400; y = -300;		# String to display button position
	
	text { caption = "Trial_Info"; display_index=2;} trialTextITI;
	x = -400; y = -300;	# String to display button position

	text { caption = "Time Remaining:"; display_index=2;} timeTextITI;
	x = 0; y = 0;	# String to display button position
}itiExperimenter;



# ---------------------------------------------------------------------------------------------------------------------------------
#										Begin PCL code
# ---------------------------------------------------------------------------------------------------------------------------------
begin_pcl;

bool testMode =false;

# Variables for task settings (You can change these)
int fixspotDotSize = 15;					# The size (in pixels) of the fixation spot
int fixationWindowSize =  50;				# The amount (in pixels) added around the edges of the fixation spot for it's fixation window
int stimulusWindowSize =  50;				# The amount (in pixels) added around the edges of the stimulus for it's fixation window
double monitorX=1920; 						# Monitor width (pixels)1024.0
double monitorY=1080; 						# Monitor height (pixels)768.0
double ratioX=((monitorX/2.0)/4.0); 	# Ratio to multiply X voltage by (want 5Volts to be at least 1/2 the width of the monitor)
double ratioY=((monitorY/2.0)/4.0); 	# Ratio to multiply X voltage by (want 5Volts to be at least 1/2 the height of the monitor)
int fixspotX = 0;								# X position (in pixels) for the fixation spot
int fixspotY = 0;								# Y position (in pixels) for the fixation spot
int postStimFixationWindow = 5000; 		# How long the monkey has to complete a fixation
int postStimFixationDuration = 500; 	# How long the monkey has to stay within fixation window to complete post-stim fixation
int choiceFixationDuration = 500; 		# How long the monkey has to stay within fixation window to make left/right choice
int postStimChoiceDuration = 20000;		# How long the monkey has to choose between left or right stimulus
int videoStimulusHeight	=	480;			# Height of stimulus (pixels)341
int videoStimulusWidth	=	720;			# Width of stimulus (pixels)512
int stimulusDuration	=	5000; 			# Time that monkey is allowed to touch button (ms) per trial
int cueDuration	=	10000; 				# Time that monkey is allowed to get to center pre-trial cue box (ms) 
int cueFixationDuration	=	1000; 		# Time that monkey is allowed to get to center pre-trial cue box (ms) 
int correctItiDuration	=	3000; 		# Duration of the inter-trial-interval(ms)for correct trials
int missedItiDuration	=	5000;		 	# Duration of the inter-trial-interval(ms) for missed trials
int holdItiDuration	=	100;		 		# Duration of the inter-trial-interval(ms) for holding the button before the trial
int ignoredItiDuration   =	4000;			# Duration of the inter-trial-interval(ms) for ignored trials
int startCueMissItiDuration = 3000;		# Duration of the inter-trial-interval(ms) for start cue miss
int feedbackLength = 250; 					# Time (ms) per trial which the monkey gets visual feedback of correct or incorrect response
int leftStimulusXPosition = -500;		# X position of left stimulus (in pixels)
int centerStimulusXPosition = 0;			# X position of left stimulus (in pixels)
int rightStimulusXPosition = 500;		# X position of right stimulus (in pixels)
int stimulusYPosition = 250;				# Y position of both stimuli (in pixels)
int numMagicNumbers = 5;					# Number of magic numbers to log/encode out
string taskName = "fixationMovieChoice"; # String of task name
bool showStartCue = true;					# Set to true to show the pre-trial fixation cue, set to false to skip this
int cueJuiceRewardDrops = 0;				# Number of drops of juice to give the monkey start cue fixation spot is correctly fixated
int timeLengthFloat = 25; 					# Range of randomization in ms, (-X:+X), for timing

# Colors of the shape stimuli (You can change these)
int leftColorR = 255;
int leftColorG = 0;
int leftColorB = 127; 
int centerColorR = 255; 
int centerColorG = 255;
int centerColorB = 0;#22
int rightColorR = 0;
int rightColorG = 0;
int rightColorB = 255;
int neutralColorR = 111;
int neutralColorG = 111;
int neutralColorB = 111;
int readyColorR = 0;
int readyColorG = 0;
int readyColorB = 255;
int touchColorR = 153; #86
int touchColorG = 255;#237
int touchColorB = 153;#253
int correctColorR = 0; #86
int correctColorG = 255;#237
int correctColorB = 0;#253
int incorrectColorR =255; #86
int incorrectColorG = 0;#237
int incorrectColorB = 0;#253


# Encode Values (You can change these, but have a really good reason)
int trialStartCode		= 11;				# Code for start of trial
int trialEndCode			= 21;				# Code for end of trial
int startCueOnCode 		= 12;				# Code for start cue on
int startCueHitCode 		= 22;				# Code for monkey missing start cue
int startCueMissCode 	= 23;				# Code for monkey hitting start cue
int startCueIgnoreCode 	= 24;				# Code for monkey ignoring start cue
int stimulusOnCode		= 15;				# Code for stimulus onset
int stimulusOffCode		= 25;				# Code for stimulus offset
int earlyButtonCode		= 14;				# Code for monkey making an early button
int buttonAvailableCode = 26;				# Code for availability of choice
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
int magicNumberCode		= 9;				# Code precending magic numbers
int conditionOffsetValue= 100;			# Offset of condition values
int frameOffsetValue		= 1000;			# Offset of frame indicies
int itemOffsetValue 		= 200;			# Offset of item values

# Variables for running the task (Don't change these)
int clockTicker	=	0; 			# Counter for time
int fixationTicker		=	0; 			# Counter for time
int currentBlock = 	0;				# Counter for current trial
int missedTrials = 	0;				# Counter for missed trials
int holdTrials = 0;					# Counter for holding trials
int ignoredTrials = 0;				# Counter for ignored trials
int trialsCompleted = 0;			# Counter for correct trials
int earlyTrials = 0;					# Counter for correct trials
int correctTrials = 0;				# Tracks number of correct responses
int earlyButtons = 0;				# Counter for early Buttons
int ITIButtons		=	0;				# Counter for ITI Buttons
int numberConditions = 0;			# Number of conditions
int estimatedTrials  =	0;			# Number of total buttonbox presentations (numberTrails * numberConditions)
int trialsAttempted = 0;			# Counter for this presentation
array<int>ordered_cnds_to_show[0];# Integer array in which we will store the ordered condition numbers
int currentConditionIdx;			# Counter for the current condition being shown
int currentConditionVal;			# Value of the current condition being shown
int trialStartTime;					# Time when trial starts
int trialResponseTime; 				# Time when the trial response occurs
int leftStimulusChoices = 0;			# Tracks number of left buttons presses
int rightStimulusChoices = 0;		# Tracks number of right buttons presses
int startCuesFixated = 0;		# Tracks number of center buttons presses
int leftStimulusTrials = 0;			# Tracks number of left buttons presses
int rightStimulusTrials  = 0;		# Tracks number of right buttons presses
int startCuesPresented  = 0;		# Tracks number of center buttons presses
int leftStimulusCorrectTrials = 0; # Tracks number of trials where the left buttons is correct
int rightStimulusCorrectTrials = 0;# Tracks number of trials where the left buttons is correct
string monkeyResponse = "";		# String to hold monkey's response from trial subroutines	
int correctCuePresses = 0;			# Tracks number of correct start cue presses
int randomTimeFloat = 0;
int leftItemValue = 0;				# The value (not index!) of the left item
int rightItemValue = 0;				# The value (not index!) of the right item
int currentFrame = 0;				# Counter for the frame being shown
string leftMovieName = "";			# String containing the location of the frames in the left movie
string rightMovieName = "";		# String containing the location of the frames in the right movie
video rightStream = new video;	# Video stream object for the right movie
video leftStream = new video;		# Video stream object for the left movie
int postStimFixationsCompleted = 0;

# ------------------------------------------------------ Access national instruments card ------------------------------------------------------
dio_device card = new dio_device( ni_dio_device, 1, 0 );

# ------------------------------------------------------ Setup output ports  ------------------------------------------------------
output_port juicePulse = output_port_manager.get_port(1);
output_port openData = output_port_manager.get_port(2);
output_port openPulse = output_port_manager.get_port(3);

# ------------------------------------------------------ Setup input ports  ------------------------------------------------------
int xV = card.acquire_analog_input("ISCANTask,x");  # set up retrieval of the eye X  voltage state
int yV = card.acquire_analog_input("ISCANTask,y");  # set up retrieval of the eye Y  voltage state

double eyeX; # initialize variable for eye tracker x postion
double eyeY; # initialize variable for eye tracker y postion


#  ------------------------------------------------------ Create log file ------------------------------------------------------
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

# ------------------------------------------------------ Get the experimental parameters ------------------------------------------------------
string exp_par="button_parameters.txt"; 				# Name of the text file with the experiment information
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

# ------------------------------------------------------ Load filenames from item file  ------------------------------------------------------
int i; 															# Create counter variables	
int name_index;												# Create variable to hold name index in item file	
int juiceDrops_index; 										# Create variable to hold amount of juice reward index in item file	
int startFrame_index;										# Create variable to hold starting frame index in item file	
int endFrame_index;											# Create variable to hold ending frame index in item file									
string currentLine;							  				# Create a string variable for the item names
input_file fil = new input_file;   						# Create an input file
fil.open( item_file );										# Load the item file data into the input file
currentLine=fil.get_line();								# Get the first line of the item file (column headers)
name_index=currentLine.find("moviename");
juiceDrops_index=currentLine.find("reward");

int num_items=int(double(currentLine.substring(currentLine.find("totalitems=")+11,2))); # Assign how many items there are to a avariable
array<int>juiceDrops[num_items];							# Create an array which will contain the associated juice drops for each movie
array<string>movies[num_items];							# Create an array which will movie filenames

term.print_line("Reading " + string(num_items) + " items from file.");

loop  # Loop through each line in the item file
	i=1
until
	i>(num_items) 
begin 
		
   currentLine = fil.get_line();							# Get the list of characters that compose the current line in the itm file

	movies[i] = currentLine.substring(name_index,currentLine.find(".avi")-name_index);	# Get the item filename
 	juiceDrops[i] = int(double(currentLine.substring(juiceDrops_index,2))); 						# Get the number of juice drops
   term.print_line( "Item: " + string(i) + "\tName: " + movies[i] + "\tReward: " + string(juiceDrops[i]));
	i=i+1;														# Increment the counter                 
end;

# ------------------------------------------------------ Load conditions from condition file  ------------------------------------------------------					
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
	#term.print_line( "Cnd: " + string(i) + "\t\tLeft item #: " + left_itm[i] + "\tRight item #: " +right_itm[i]);
   i=i+1;  														# Increment the counter                           
end;             

#  ------------------------------------------------------ Determine what conditions to show  ------------------------------------------------------

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


# ------------------------------------------------------ Determine condition order  ------------------------------------------------------
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

if testMode == true then
	ignoredItiDuration = 10;
	showStartCue = false;
end;

# ------------------------------------------------------ Send Encode Subroutine ------------------------------------------------------
sub
	encode ( int codeValue )
begin
	openData.send_code(codeValue, 2);
	openPulse.send_code(255,1)
	#wait_interval(150);
end;

# ------------------------------------------------------ Give Juice Reward Subroutine ------------------------------------------------------
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

# ------------------------------------------------------ Present Incorrect Feedback Subroutine ------------------------------------------------------
sub
	presentIncorrectFeedback
begin
	
	#Get current time
	clockTicker=clock.time(); 
	
	#Change background to red
	incorrectMonkey.set_background_color( 255,0,0 );
	incorrectMonkey.present();
	incorrectExperimenter.set_background_color( 255,0,0 );
	incorrectExperimenter.present();
	
	#Play the sound
	incorrectFeedbackSound.present();
	
	#Loop until feedback time is over
	loop until 
			(clock.time()-clockTicker) > feedbackLength 
	begin
	end;

	#Change colors back to normal (black)
	incorrectMonkey.set_background_color( 0,0,0 );
	incorrectMonkey.present();
	incorrectExperimenter.set_background_color( 0,0,0 );
	incorrectExperimenter.present();
end;

# ------------------------------------------------------ Present Correct Feedback Subroutine ------------------------------------------------------
sub
	presentCorrectFeedback
begin
	#Get current time
	clockTicker=clock.time();
	
	#Change background to green
	correctMonkey.set_background_color( 0,255,0 );
	correctMonkey.present();
	correctExperimenter.set_background_color( 0,255,0 );
	correctExperimenter.present();
	
	#Loop until feedback time is over
	loop until 
			(clock.time()-clockTicker) > feedbackLength 
	begin
	end;
	
	#Change colors back to normal (black)
	correctMonkey.set_background_color( 0,0,0 );
	correctMonkey.present();
	correctExperimenter.set_background_color( 0,0,0 );
	correctExperimenter.present();
end;


# ------------------------------------------------------ Present ITI Subroutine ------------------------------------------------------
sub
	presentITI( int itiDuration )
begin
	# Mark that we are starting the ITI
	wait_interval(10);
	encode(ITIStartCode);
	
		
	# Update the trial text to the current trial
	trialTextITI.set_caption( "Block: " + printf( currentBlock, "%2d" ) + "/" + printf( numberBlocks, "%2d" ) + 
										"\n Condition: "+ printf( currentConditionIdx, "%2d" ) + "/" + printf( numberConditions, "%2d" ) + " (" + printf( currentConditionVal, "%2d" )+ ")" +
										"\n Correct: "+ printf( correctTrials, "%2d" ) + "/" + printf( trialsCompleted, "%2d" ) +
										"\n Completed: "+ printf( trialsCompleted, "%2d" ) + "/" + printf( trialsAttempted, "%2d" ) +
										"\n Early: "+ printf( earlyTrials, "%2d" ) + "/" + printf( trialsAttempted, "%2d" ) +
										"\n Missed: "+ printf( missedTrials, "%2d" ) + "/" + printf( trialsAttempted, "%2d" ) +
										"\n Ignored: "+ printf( ignoredTrials, "%2d" ) + "/" + printf( trialsAttempted, "%2d" ) +
										"\n Hold Errors: "+ printf( holdTrials, "%2d" ) + "/" + printf( trialsAttempted, "%2d" ), true );
										
	responseTextITI.set_caption( "Left: " + printf( leftStimulusChoices, "%2d" ) + "/" + printf( leftStimulusCorrectTrials, "%2d" )  + 
										"\n Start-cues: "+ printf( startCuesFixated, "%2d" ) + "/" + printf( startCuesPresented, "%2d" ) +
										"\n Right: "+ printf( rightStimulusChoices, "%2d" ) + "/" + printf( rightStimulusCorrectTrials, "%2d" ) , true );
	
	# Present the ITI screen to the monkey and the experimenter
	itiExperimenter.present();
	itiMonkey.present();

	# Get the current time
	clockTicker=clock.time();
	
	int timeRemaining = 0;
	
	randomTimeFloat = random(-timeLengthFloat, timeLengthFloat);
	
	int itiDurationRandom = itiDuration +randomTimeFloat;
	
	loop until # Loop until the ITI is over
			(clock.time()-clockTicker) > itiDurationRandom 
	begin
		timeRemaining = (itiDurationRandom - (clock.time()-clockTicker));
		timeTextITI.set_caption( "Time Remaining: " + printf(timeRemaining, "%6d" ));
		timeTextITI.redraw();
		itiExperimenter.present();
	end;
	
	# Mark that we are finished with the ITI
	encode(ITIEndCode);	
end;

# ------------------------------------------------------ Present Start Cue Subroutine ------------------------------------------------------
sub
   string presentCue 
begin
	
	# Print that we are presenting the start cue to the terminal
	term.print_line("Presenting start cue...");
	
	# Update the trial text to the current trial
	trialTextCue.set_caption( "Block: " + printf( currentBlock, "%2d" ) + "/" + printf( numberBlocks, "%2d" ) + 
										"\n Condition: "+ printf( currentConditionIdx, "%2d" ) + "/" + printf( numberConditions, "%2d" ) + " (" + printf( currentConditionVal, "%2d" )+ ")" +
										"\n Correct: "+ printf( correctTrials, "%2d" ) + "/" + printf( trialsCompleted, "%2d" ) +
										"\n Completed: "+ printf( trialsCompleted, "%2d" ) + "/" + printf( trialsAttempted, "%2d" ) +
										"\n Early: "+ printf( earlyTrials, "%2d" ) + "/" + printf( trialsAttempted, "%2d" ) +
										"\n Missed: "+ printf( missedTrials, "%2d" ) + "/" + printf( trialsAttempted, "%2d" ) +
										"\n Ignored: "+ printf( ignoredTrials, "%2d" ) + "/" + printf( trialsAttempted, "%2d" ) +
										"\n Hold Errors: "+ printf( holdTrials, "%2d" ) + "/" + printf( trialsAttempted, "%2d" ), true );
										
	responseTextCue.set_caption( "Left: " + printf( leftStimulusChoices, "%2d" ) + "/" + printf( leftStimulusCorrectTrials, "%2d" )  + 
										"\n Start-cues: "+ printf( startCuesFixated, "%2d" ) + "/" + printf( startCuesPresented, "%2d" ) +
										"\n Right: "+ printf( rightStimulusChoices, "%2d" ) + "/" + printf( rightStimulusCorrectTrials, "%2d" ) , true );
	
	# Assume the default behavior of the monkey is to ignore the stimulus
	string monkeyCueResponseStr = "CueIgnore";

		# Send out the startCue encode
		encode(startCueOnCode);
		
		#Set the size of the fixation dot on the monkey and experimenter's screen
		monkeyCueFixspotDot.set_height(fixspotDotSize); # set the height of the experimenter's fixspot
		monkeyCueFixspotDot.set_width(fixspotDotSize); # set the width of the experimenter's fixspot
		experimenterCueFixspotDot.set_height(fixspotDotSize); # set the height of the monkey's fixspot
		experimenterCueFixspotDot.set_width(fixspotDotSize); # set the width of the monkey's fixspot
		
		#Set the size of the fixation window and black boundry on the experimenter's screen
		experimenterCueFixspotBoundary.set_height(fixspotDotSize+2*fixationWindowSize); # set the height boundary of the fixspot (the extra space the monkey is allowed)
		experimenterCueFixspotBoundary.set_width(fixspotDotSize+2*fixationWindowSize); # set the width boundary of the fixspot (the extra space the monkey is allowed)
		experimenterCueFixspotBoundaryBlack.set_height(fixspotDotSize+2*fixationWindowSize-2); # the above two lines will set the red box height, this is setting the black box height(see picture code for details)
		experimenterCueFixspotBoundaryBlack.set_width(fixspotDotSize+2*fixationWindowSize-2); # the above two lines will st the red box width, this is setting the black box width(see picture code for details)
		
		# Move the experimenter's fix spot in position
		startCueExperimenter.set_part_x( 1, fixspotX );  
		startCueExperimenter.set_part_y( 1, fixspotY );  
		startCueExperimenter.set_part_x( 2, fixspotX );  
		startCueExperimenter.set_part_y( 2, fixspotY );  
		startCueExperimenter.set_part_x( 3, fixspotX );  
		startCueExperimenter.set_part_y( 3, fixspotY );
		
		# Move the monkey's fix spot in position
		startCueMonkey.set_part_x( 1, fixspotX );  
		startCueMonkey.set_part_y( 1, fixspotY );  
	
		# Update the monkey's and experimenter's screens
		startCueExperimenter.present();
		startCueMonkey.present();
		
		startCuesPresented = startCuesPresented+1;
		
		# Boolean variable to indicate if we need to break out of the current fixation loop
		bool breakFixationLoop = false;
		
		# Get the current time
		clockTicker=clock.time();
			
		loop until # Loop until the cue duration is over
				((clock.time()-clockTicker) > cueDuration) || breakFixationLoop ==  true
		begin
			
			# Update the eye position
			eyeX =card.read_analog(xV)*ratioX; # get the X eye position
			eyeY =card.read_analog(yV)*ratioY; # get the Y eye position
			
			# Update the eye position on the experimenter's screen
			startCueExperimenter.set_part_x( 4, eyeX );  
			startCueExperimenter.set_part_y( 4, eyeY );  
			startCueExperimenter.present();  
			
			if # If the monkey enters the fixation window
				eyeX<double(fixspotX+fixspotDotSize/2+fixationWindowSize) &&
				eyeX>double(fixspotX-fixspotDotSize/2-fixationWindowSize) &&
				eyeY<double(fixspotY+fixspotDotSize/2+fixationWindowSize) && 
				eyeY>double(fixspotY-fixspotDotSize/2-fixationWindowSize)
			then
				# Start the fixation timer at the current time
				fixationTicker = clock.time();
				
				#Set the response string to 'CueFixating'
				monkeyCueResponseStr = "CueFixating";
				
				loop until # Loop until the cue duration is over
					((clock.time()-fixationTicker) > cueFixationDuration) || breakFixationLoop ==  true
				begin
					
						# Update the eye position
						eyeX =card.read_analog(xV)*ratioX; # get the X eye position
						eyeY =card.read_analog(yV)*ratioY; # get the Y eye position
			
						# Update the eye position on the experimenter's screen
						startCueExperimenter.set_part_x( 4, eyeX );  
						startCueExperimenter.set_part_y( 4, eyeY );  
						startCueExperimenter.present();
						
						if # If the monkey leaves the fixation window after fixating
							eyeX>double(fixspotX+fixspotDotSize/2+fixationWindowSize) ||
							eyeX<double(fixspotX-fixspotDotSize/2-fixationWindowSize) ||
							eyeY>double(fixspotY+fixspotDotSize/2+fixationWindowSize) || 
							eyeY<double(fixspotY-fixspotDotSize/2-fixationWindowSize)
						then
							#Set the response string to 'CueBrokeFixation'
							monkeyCueResponseStr = "CueBrokeFixation";
							
							#Break out of fixation loop
							breakFixationLoop =  true;
						end;
				end;
				
				if # If the monkey didn't break fixation
					monkeyCueResponseStr == "CueFixating"
				then
					#Set the response string to 'CueFixated'
					monkeyCueResponseStr = "CueFixated";
					
					#Break out of fixation loop
					breakFixationLoop =  true;
					
					#Increase the start-cue counter
					startCuesFixated = startCuesFixated +1;
					
					
					#If we are to give juice to the monkey for fixation on the start cue, do so
					if 
						cueJuiceRewardDrops > 0
					then
						giveJuiceReward(cueJuiceRewardDrops);
					end;
					
				end;
				
			end;
			
		end;

	return monkeyCueResponseStr;
end;


# ------------------------------------------------------ Present Stimulus Subroutine ------------------------------------------------------
sub
   string presentStimulus 
begin
	
	# Move the monkeyStimulusFixspotDot off the screen
	stimulusPictureMonkey.set_part_x( 1, 9999 );  
	stimulusPictureMonkey.set_part_y( 1, 9999 );  
	
	# Move the experimenter's fix spot back off the screen
	stimulusExperimenter.set_part_x( 1, 9999 );  
	stimulusExperimenter.set_part_y( 1, 9999 );  
	stimulusExperimenter.set_part_x( 2, 9999 );  
	stimulusExperimenter.set_part_y( 2, 9999 );  
	stimulusExperimenter.set_part_x( 3, 9999 );  
	stimulusExperimenter.set_part_y( 3, 9999 );  
	
	# Move the experimenter's fixation windows off the screen
	stimulusExperimenter.set_part_x( 5, 9999 );  
	stimulusExperimenter.set_part_y( 5, 9999 );  
	stimulusExperimenter.set_part_x( 6, 9999 );  
	stimulusExperimenter.set_part_y( 6, 9999 );  
	stimulusExperimenter.set_part_x( 7, 9999 );  
	stimulusExperimenter.set_part_y( 7, 9999 );  
	stimulusExperimenter.set_part_x( 8, 9999 );  
	stimulusExperimenter.set_part_y( 8, 9999 );  
	
	# Move the experimenter's eye position marker off the screen
	stimulusExperimenter.set_part_x( 4, 9999);  
	stimulusExperimenter.set_part_y( 4, 9999 );  
	
	#Create two strings to track the response parameters of the monkey
	string monkeyResponseStr = "Ignored"; # Assume that the monkey ignored the stimulus unless proven otherewise
	string correctResponseStr = "Unknown";# We don't yet know what the correct response on this trial should be
	
	# Update the trial text to the current trial 
	trialTextStimulus.set_caption( "Block: " + printf( currentBlock, "%2d" ) + "/" + printf( numberBlocks, "%2d" ) + 
										"\n Condition: "+ printf( currentConditionIdx, "%2d" ) + "/" + printf( numberConditions, "%2d" ) + " (" + printf( currentConditionVal, "%2d" )+ ")" +
										"\n Correct: "+ printf( correctTrials, "%2d" ) + "/" + printf( trialsCompleted, "%2d" ) +
										"\n Completed: "+ printf( trialsCompleted, "%2d" ) + "/" + printf( trialsAttempted, "%2d" ) +
										"\n Early: "+ printf( earlyTrials, "%2d" ) + "/" + printf( trialsAttempted, "%2d" ) +
										"\n Missed: "+ printf( missedTrials, "%2d" ) + "/" + printf( trialsAttempted, "%2d" ) +
										"\n Ignored: "+ printf( ignoredTrials, "%2d" ) + "/" + printf( trialsAttempted, "%2d" ) +
										"\n Hold Errors: "+ printf( holdTrials, "%2d" ) + "/" + printf( trialsAttempted, "%2d" ), true );
										
	responseTextStimulus.set_caption( "Left: " + printf( leftStimulusChoices, "%2d" ) + "/" + printf( leftStimulusCorrectTrials, "%2d" )  + 
										"\n Start-cues: "+ printf( startCuesFixated, "%2d" ) + "/" + printf( startCuesPresented, "%2d" ) +
										"\n Right: "+ printf( rightStimulusChoices, "%2d" ) + "/" + printf( rightStimulusCorrectTrials, "%2d" ) , true );
	
	# Create boolean variable to set left and right button/stimuli to active or inactive
	bool rightActive = true;
	bool leftActive = true;
	
	# Create two intergers to track the left and right juice rewards
	int leftJuiceValue = 0;
	int rightJuiceValue = 0;
	
	# Get the item numbers for the left and right items									
	int leftItemNumber = int(double(left_itm[ordered_cnds_to_show[currentConditionIdx]].substring(1,2)));
	int rightItemNumber = int(double(right_itm[ordered_cnds_to_show[currentConditionIdx]].substring(1,2)));
	
	if # If this is a normal trial where we are showing both left and right stimuli
		leftItemNumber > 0 && rightItemNumber > 0 
	then
		# Find juice values of left and right stimulus
		leftJuiceValue = juiceDrops[int(double(left_itm[ordered_cnds_to_show[currentConditionIdx]].substring(1,2)))];
		rightJuiceValue = juiceDrops[int(double(right_itm[ordered_cnds_to_show[currentConditionIdx]].substring(1,2)))];
		
		# Set both sides to active
		rightActive = true;
		leftActive = true;
		
		# Increase the left/right trial counters
		leftStimulusTrials = leftStimulusTrials +1;
		rightStimulusTrials = rightStimulusTrials +1;
		
	
		
			
	elseif # If this is a trial where we only showing the left stimulus
		leftItemNumber > 0 && rightItemNumber <= 0 
	then
		# Find juice values of left stimulus
		leftJuiceValue = juiceDrops[int(double(left_itm[ordered_cnds_to_show[currentConditionIdx]].substring(1,2)))];
		
		# Set the right juice value to zero
		rightJuiceValue = 0;
		
		# Set the left side to active
		leftActive = true;
		
		# Set he right side to inactive
		rightActive = false;
		
		# Increase the left trial counter
		leftStimulusTrials = leftStimulusTrials +1;
		
		
	elseif # If this is a trial where we only showing the right stimulus
		rightItemNumber > 0 && leftItemNumber <= 0 
	then
		# Find juice values of right stimulus
		rightJuiceValue = juiceDrops[int(double(right_itm[ordered_cnds_to_show[currentConditionIdx]].substring(1,2)))];
		
		# Set the left juice value to zero
		leftJuiceValue = 0;
		
		# Set the right side to active
		rightActive = true;
		
		# Set the left side to inactive
		leftActive = false;
		
		# Increase the right trial counter
		rightStimulusTrials = rightStimulusTrials +1;
		
		
	end;
										

	
	# Find juice values of left and right stimulus
	#string leftStimulusName =  movies[int(double(left_itm[ordered_cnds_to_show[currentConditionIdx]].substring(1,2)))]; 
	#string rightStimulusName =  movies[int(double(right_itm[ordered_cnds_to_show[currentConditionIdx]].substring(1,2)))];
	
	# Set the text for the reward values on the monitor
	leftRewardValueText.set_caption(printf( leftJuiceValue, "%2d" ), true );
	rightRewardValueText.set_caption(printf( rightJuiceValue, "%2d" ), true );
	
	
	if 
		leftActive == true
	then
		# Set position of the left video plane
		stimulusPictureMonkey.set_3dpart_xyz( 1, leftStimulusXPosition, stimulusYPosition, 0 );
	else
		# Move left video plane off the monitor
		stimulusPictureMonkey.set_3dpart_xyz( 1, 9999, 9999, 0 );
	end;
	
	if 
		rightActive == true
	then
		# Set position of the right video plane
		stimulusPictureMonkey.set_3dpart_xyz( 2 , rightStimulusXPosition, stimulusYPosition, 0 );
	else
		# Move right video plane off the monitor
		stimulusPictureMonkey.set_3dpart_xyz( 2 , 9999, 9999, 0 );
	end;

	# Assume we are NOT going present this stimulus
	bool presentStimulus = true;
	
	#Present the start cue
	string cueResponse = presentCue();
	
	term.print_line( "Cue Response: "+ cueResponse );
		
	if #If the monkey correctly responded to the start cue
		cueResponse == "CueFixated"
	then
		#Set 'presentStimulus' to true to continue presenting the trial
		presentStimulus = true;
	else
		#Otherwise set 'presentStimulus' to false so that the stimulus is not presented
		presentStimulus = false;
		monkeyResponseStr = "StartCueMiss";
	end;

	# Get the current time
	clockTicker=clock.time();
	
	if #If 'presentStimulus' is true, we present the stimulus
		presentStimulus == true
	then
		
		term.print_line("Presenting stimulus...");
		
		#Increment the trial counter
		trialsAttempted = trialsAttempted +1;
		
		
		# Get the experimenter's and monkey's screens
		stimulusExperimenter.present();
		
		# Start the movie event
		stimulusEventMonkey.set_event_code( "start" );
		
		# Present the movie choice trial
		stimulusMonkey.present();
		
		# Reset the current frame to zero
		currentFrame = 0;
		
		# Variable which tracks the start time of the video
		int video_start_time = stimulus_manager.last_stimulus_data().time();
		
		# Mark that we are starting the movie
		encode(stimulusOnCode);
		
		# Loop through the frames of the video until the video stream is over
		loop
			int next_frame = video_start_time + int( leftStream.current_frame_end() )
		until false begin
			if (clock.time() >= next_frame) then
				
				#If the steam cannot advance, break out of the loop
				if (!leftStream.advance() || !rightStream.advance()) then break end;
				
				#Get the current frame being shown
				currentFrame = leftStream.frame_position();

				# Encode the current frame + offset value
				encode(currentFrame + frameOffsetValue);
				
				# Get the time of the next frame
				next_frame = video_start_time + int( leftStream.current_frame_end()  )
			end; #End of if statement to detect next frame
			
			
			stimulusPictureMonkey.present();
			
		end; # End of frame loop
		
		# Increase the count of the left correct, right correct or both trials
		if 
			leftJuiceValue > rightJuiceValue
		then
			leftStimulusCorrectTrials = leftStimulusCorrectTrials+1;
		elseif
			rightJuiceValue> leftJuiceValue
		then
			rightStimulusCorrectTrials = rightStimulusCorrectTrials+1;	
		else
			leftStimulusCorrectTrials = leftStimulusCorrectTrials+1;
			rightStimulusCorrectTrials = rightStimulusCorrectTrials+1;	
		end;
	
	
		# Mark that we are finished the movie
		wait_interval(15);
		encode(stimulusOffCode);
		
		
		
		#------------------------------------------------------------------
		
		# Move the two stimuli off the screen for now so that the monkey can do a fixation
		stimulusPictureMonkey.set_3dpart_xyz( 1, 9999, 9999, 0 );
		stimulusPictureMonkey.set_3dpart_xyz( 2, 9999, 9999, 0 );
		
		# Move the monkeyStimulusFixspotDot back in position
		stimulusPictureMonkey.set_part_x( 1, fixspotX );  
		stimulusPictureMonkey.set_part_y( 1, fixspotY );  
		
		# Move the experimenter's fix spot back in position
		stimulusExperimenter.set_part_x( 1, fixspotX );  
		stimulusExperimenter.set_part_y( 1, fixspotY );  
		stimulusExperimenter.set_part_x( 2, fixspotX );  
		stimulusExperimenter.set_part_y( 2, fixspotY );  
		stimulusExperimenter.set_part_x( 3, fixspotX );  
		stimulusExperimenter.set_part_y( 3, fixspotY );  
		
		# Refresh the experimenter's and monkey's screens
		stimulusExperimenter.present();
		stimulusMonkey.present();
		
		# Boolean variable to indicate if we need to break out of the current fixation loop
		bool breakFixationLoop = false;
		string postStimFixationResponseStr = "PostStimFixIgnored";
		
		# Get the current time
		clockTicker=clock.time();
			
		loop until # Loop until the cue duration is over
				((clock.time()-clockTicker) > postStimFixationWindow) || breakFixationLoop ==  true
		begin
			# Update the eye position
			eyeX =card.read_analog(xV)*ratioX; # get the X eye position
			eyeY =card.read_analog(yV)*ratioY; # get the Y eye position
				
			# Update the eye position on the experimenter's screen
			stimulusExperimenter.set_part_x( 4, eyeX );  
			stimulusExperimenter.set_part_y( 4, eyeY );  
			stimulusExperimenter.present();  
				
			if # If the monkey enters the fixation window
				eyeX<double(fixspotX+fixspotDotSize/2+fixationWindowSize) &&
				eyeX>double(fixspotX-fixspotDotSize/2-fixationWindowSize) &&
				eyeY<double(fixspotY+fixspotDotSize/2+fixationWindowSize) && 
				eyeY>double(fixspotY-fixspotDotSize/2-fixationWindowSize)
			then
				# Start the fixation timer at the current time
				fixationTicker = clock.time();
				
				#Set the response string to 'CueFixating'
				postStimFixationResponseStr = "PostStimFixating";
					
				loop until # Loop until the cue duration is over
					((clock.time()-fixationTicker) > postStimFixationDuration) || breakFixationLoop ==  true
				begin
			
					# Update the eye position
					eyeX =card.read_analog(xV)*ratioX; # get the X eye position
					eyeY =card.read_analog(yV)*ratioY; # get the Y eye position
			
					# Update the eye position on the experimenter's screen
					stimulusExperimenter.set_part_x( 4, eyeX );  
					stimulusExperimenter.set_part_y( 4, eyeY );  
					stimulusExperimenter.present();
						
					if # If the monkey leaves the fixation window after fixating
						eyeX>double(fixspotX+fixspotDotSize/2+fixationWindowSize) ||
						eyeX<double(fixspotX-fixspotDotSize/2-fixationWindowSize) ||
						eyeY>double(fixspotY+fixspotDotSize/2+fixationWindowSize) || 
						eyeY<double(fixspotY-fixspotDotSize/2-fixationWindowSize)
					then
						#Set the response string to 'CueBrokeFixation'
						postStimFixationResponseStr = "PostStimBrokeFixation";
						
						#Break out of fixation loop
						breakFixationLoop =  true;
					end;
				end;
				
				if # If the monkey didn't break fixation
					postStimFixationResponseStr == "PostStimFixating"
				then
					#Set the response string to 'CueFixated'
					postStimFixationResponseStr = "PostStimFixated";
					
					#Break out of fixation loop
					breakFixationLoop =  true;
					
					#Increase the start-cue counter
					postStimFixationsCompleted = postStimFixationsCompleted+1;
				end;
			end;
		end;
		
		#------------------------------------------------------------------
		
		if 
			leftActive == true
		then
			stimulusPictureMonkey.set_3dpart_xyz( 1, leftStimulusXPosition, stimulusYPosition, 0 );
		end;
			
		if
			rightActive == true
		then
			stimulusPictureMonkey.set_3dpart_xyz( 2, rightStimulusXPosition, stimulusYPosition, 0 );
		end;
		
		# Move the monkey's fix spot off the screen again
		stimulusPictureMonkey.set_part_x( 1, 9999 );  
		stimulusPictureMonkey.set_part_y( 1, 9999 );  
		
		# Move the experimenter's fix spot off the screen again
		stimulusExperimenter.set_part_x( 1, 9999 );  
		stimulusExperimenter.set_part_y( 1, 9999 );  
		stimulusExperimenter.set_part_x( 2, 9999 );  
		stimulusExperimenter.set_part_y( 2, 9999 );  
		stimulusExperimenter.set_part_x( 3, 9999 );  
		stimulusExperimenter.set_part_y( 3, 9999 );  
		
		# Move the experimenter's fixation windows for the left and right stimulus into place
		stimulusExperimenter.set_part_x( 5, leftStimulusXPosition );  
		stimulusExperimenter.set_part_y( 5, stimulusYPosition );  
		stimulusExperimenter.set_part_x( 6, leftStimulusXPosition );  
		stimulusExperimenter.set_part_y( 6, stimulusYPosition );  
		stimulusExperimenter.set_part_x( 7, rightStimulusXPosition );  
		stimulusExperimenter.set_part_y( 7, stimulusYPosition );  
		stimulusExperimenter.set_part_x( 8, rightStimulusXPosition );  
		stimulusExperimenter.set_part_y( 8, stimulusYPosition );  
		
		# Calculate the bounds for the left stimulus
		int leftStimulusUpperBounds = (stimulusYPosition + (videoStimulusHeight/2) ) + stimulusWindowSize;
		int leftStimulusLowerBounds = (stimulusYPosition - (videoStimulusHeight/2) ) - stimulusWindowSize;
		int leftStimulusOuterBounds = (leftStimulusXPosition - (videoStimulusWidth/2) ) - stimulusWindowSize;
		int leftStimulusInnerBounds = (leftStimulusXPosition + (videoStimulusWidth/2) ) + stimulusWindowSize;
		
		# Calculate the bounds for the right stimulus
		int rightStimulusUpperBounds = (stimulusYPosition + (videoStimulusHeight/2) ) + stimulusWindowSize;
		int rightStimulusLowerBounds = (stimulusYPosition - (videoStimulusHeight/2) ) - stimulusWindowSize;
		int rightStimulusInnerBounds = (rightStimulusXPosition - (videoStimulusWidth/2) ) - stimulusWindowSize;
		int rightStimulusOuterBounds = (rightStimulusXPosition + (videoStimulusWidth/2) ) + stimulusWindowSize;
		
		#Set the size of the fixation window and black boundry on the experimenter's screen for the left stimulus
		experimenterStimulusLeftBoundary.set_height(videoStimulusHeight + (2*stimulusWindowSize)); 
		experimenterStimulusLeftBoundary.set_width(videoStimulusWidth + (2*stimulusWindowSize));
		experimenterStimulusLeftBoundaryBlack.set_height(videoStimulusHeight + ((2*stimulusWindowSize)-2)); 
		experimenterStimulusLeftBoundaryBlack.set_width(videoStimulusWidth + ((2*stimulusWindowSize)-2)); 
		
		#Set the size of the fixation window and black boundry on the experimenter's screen for the right stimulus
		experimenterStimulusRightBoundary.set_height(videoStimulusHeight + (2*stimulusWindowSize)); 
		experimenterStimulusRightBoundary.set_width(videoStimulusWidth + (2*stimulusWindowSize));
		experimenterStimulusRightBoundaryBlack.set_height(videoStimulusHeight + ((2*stimulusWindowSize)-2)); 
		experimenterStimulusRightBoundaryBlack.set_width(videoStimulusWidth + ((2*stimulusWindowSize)-2)); 
		
		# Refresh the experimenter's and monkey's screens
		stimulusExperimenter.present();
		stimulusMonkey.present();
		
		bool madeChoice = false;
		monkeyResponseStr = "choiceIgnored";
		
		# Get the current time
		clockTicker=clock.time();
			
		loop until # Loop until the post-stim period is over
				((clock.time()-clockTicker) > postStimChoiceDuration) || madeChoice ==  true
		begin
			# Update the eye position
			eyeX =card.read_analog(xV)*ratioX; # get the X eye position
			eyeY =card.read_analog(yV)*ratioY; # get the Y eye position
				
			# Update the eye position on the experimenter's screen
			stimulusExperimenter.set_part_x( 4, eyeX );  
			stimulusExperimenter.set_part_y( 4, eyeY );  
			stimulusExperimenter.present(); 
			
			if # If the monkey enters the left stimulus fixation window
				eyeX<double(leftStimulusInnerBounds) &&
				eyeX>double(leftStimulusOuterBounds) &&
				eyeY<double(leftStimulusUpperBounds) && 
				eyeY>double(leftStimulusLowerBounds)
			then
				# Start the fixation timer at the current time
				fixationTicker = clock.time();
				
				#Set the response string to 'leftStimFixating'
				monkeyResponseStr = "leftStimFixating";
					
				loop until # Loop until the cue duration is over
					((clock.time()-fixationTicker) > choiceFixationDuration) || breakFixationLoop ==  true
				begin
			
					# Update the eye position
					eyeX =card.read_analog(xV)*ratioX; # get the X eye position
					eyeY =card.read_analog(yV)*ratioY; # get the Y eye position
			
					# Update the eye position on the experimenter's screen
					stimulusExperimenter.set_part_x( 4, eyeX );  
					stimulusExperimenter.set_part_y( 4, eyeY );  
					stimulusExperimenter.present();
						
					if # If the monkey leaves the fixation window after fixating
						eyeX>double(leftStimulusInnerBounds) ||
						eyeX<double(leftStimulusOuterBounds) ||
						eyeY>double(leftStimulusUpperBounds) || 
						eyeY<double(leftStimulusLowerBounds)
					then
						#Set the response string to 'PostStimBrokeFixation'
						monkeyResponseStr = "choiceStimBrokeFixation";
						
						#Break out of fixation loop
						breakFixationLoop =  true;
					end;
				end;
				
				if # If the monkey didn't break fixation
					monkeyResponseStr == "leftStimFixating"
				then
					#Set the response string to 'CueFixated'
					monkeyResponseStr = "Left";
					
					#Break out of fixation loop
					madeChoice =  true;
				end;
				
			end;
				
			if # If the monkey enters the right stimulus fixation window
				eyeX>double(rightStimulusInnerBounds) &&
				eyeX<double(rightStimulusOuterBounds) &&
				eyeY<double(rightStimulusUpperBounds) && 
				eyeY>double(rightStimulusLowerBounds)
			then
				# Start the fixation timer at the current time
				fixationTicker = clock.time();
				
				#Set the response string to 'rightStimFixating'
				monkeyResponseStr = "rightStimFixating";
					
				loop until # Loop until the cue duration is over
					((clock.time()-fixationTicker) > choiceFixationDuration) || breakFixationLoop ==  true
				begin
			
					# Update the eye position
					eyeX =card.read_analog(xV)*ratioX; # get the X eye position
					eyeY =card.read_analog(yV)*ratioY; # get the Y eye position
			
					# Update the eye position on the experimenter's screen
					stimulusExperimenter.set_part_x( 4, eyeX );  
					stimulusExperimenter.set_part_y( 4, eyeY );  
					stimulusExperimenter.present();
						
					if # If the monkey leaves the fixation window after fixating
						eyeX>double(rightStimulusInnerBounds) ||
						eyeX<double(rightStimulusOuterBounds) ||
						eyeY>double(rightStimulusUpperBounds) || 
						eyeY<double(rightStimulusLowerBounds)
					then
						#Set the response string to 'PostStimBrokeFixation'
						monkeyResponseStr = "choiceStimBrokeFixation";
						
						#Break out of fixation loop
						breakFixationLoop =  true;
					end;
				end;
				
				if # If the monkey didn't break fixation
					monkeyResponseStr == "rightStimFixating"
				then
					#Set the response string to 'CueFixated'
					monkeyResponseStr = "Right";
					
					#Break out of fixation loop
					madeChoice =  true;
				end;
			end;
		end;
		
		
	else
		
	end;
	
	
	if
		monkeyResponseStr == "Left"
	then	
		stimulusPictureMonkey.set_3dpart_xyz( 2 , 9999, 9999, 0 );
		stimulusPictureMonkey.present();
		term.print_line("Monkey choose left stimulus, giving " + string(leftJuiceValue) + "drops of juice.");
		giveJuiceReward ( leftJuiceValue );
		leftStimulusChoices = leftStimulusChoices+1;
		if leftJuiceValue > rightJuiceValue
		then
			correctTrials = correctTrials+1;
		end;
	elseif
		monkeyResponseStr == "Right"
	then
		stimulusPictureMonkey.set_3dpart_xyz( 1, 9999, 9999, 0 );
		stimulusPictureMonkey.present();
		term.print_line("Monkey choose right stimulus, giving " + string(rightJuiceValue) + "drops of juice.");
		giveJuiceReward (rightJuiceValue );
		rightStimulusChoices = rightStimulusChoices+1;
		if rightJuiceValue > leftJuiceValue
		then
			correctTrials = correctTrials+1;
		end;
	elseif
		monkeyResponseStr == "Early"
	then
		presentIncorrectFeedback();
	end;
	
	if
		monkeyResponseStr == "Ignore"
	then	
		term.print_line("Monkey ignored both stimuli.");
		wait_interval( 10 );
		encode(ignoreChoiceCode);
		wait_interval( 10 );
	end;
	
	
	# Return the monkey's response
	return monkeyResponseStr;
end;

# ------------------------------------------------------ Main trial loop ------------------------------------------------------

# Create a variable to hold magic numbers
int magicNumber = 0;

# Start the line in the log file for magic numbers
logFile.print("MagicNumbers:\t");

loop
	int magicNumberIdx = 0
until
		magicNumberIdx >= numMagicNumbers
begin
	
	# Encode 
	encode(magicNumberCode);
	magicNumber = random(1, 255);
	wait_interval(10);
	encode(magicNumber);
	logFile.print(string(magicNumber) + "\t");
	wait_interval(10);
	
	magicNumberIdx = magicNumberIdx + 1;
end; 

logFile.print("\n");

# Mark that we are starting the main task
encode(taskStartCode);
wait_interval(10);

# Calculate the total number of buttonbox presentations (number of trails X number of conditions) 
estimatedTrials = numberBlocks * numberConditions;

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
		encode(trialStartCode);
		wait_interval(25);
		
		#Get the value (NOT index) of the current condition 
		currentConditionVal = ordered_cnds_to_show[currentConditionIdx];
		
		#Print trial information out to terminal
		term.print_line( "\nBlock: " + string (currentBlock) + "\tCondition: " + string(currentConditionVal) + "\tAttempt: " + string(trialsAttempted));
		
		# Mark the current condition
		encode(cndNumIDCode);
		wait_interval(25);
		encode(conditionOffsetValue+currentConditionVal);
		wait_interval(25);
		
		#Print the trial information to the log file
		logFile.print( "Trl:\t"+string(trialsAttempted)+"\t" ); 
		logFile.print( "Blk:\t"+string(currentBlock)+"\t" );  
		logFile.print( "Cnd:\t"+string(currentConditionVal)+"\t" );  	
			
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
		

		int leftJuiceValue = 0;
		int rightJuiceValue = 0;
	
		
		if # If we are presenting the left stimulus
			leftItemValue > 0
		then
			# Get the amount of juice drops associated with the left stimulus
			 leftJuiceValue = juiceDrops[int(double(left_itm[ordered_cnds_to_show[currentConditionIdx]].substring(1,2)))];
			
			# Get the left movie name to be shown on this trial
			leftMovieName = movies[leftItemValue];
			
		else
			# Set the amount of juice drops associated with the left stimulus
			 leftJuiceValue = 0;
			
			# Set the left movie name as the placeholder
			leftMovieName = "placeholder";

		end;
		
		if # If we are presenting the right stimulus
			rightItemValue > 0
		then
			# Get the amount of juice drops associated with the right stimulus
			 rightJuiceValue = juiceDrops[int(double(right_itm[ordered_cnds_to_show[currentConditionIdx]].substring(1,2)))];
			
			# Get the right movie name to be shown on this trial
			rightMovieName = movies[rightItemValue];
			
		else
			# Set the amount of juice drops associated with the right stimulus
			rightJuiceValue = 0;
			
			# Set the right movie name as the placeholder
			rightMovieName = "placeholder";
		end;
		
		# Write stimulus values to log file
		logFile.print( "LVal:\t"+string(leftJuiceValue)+"\tRVal:\t"+string(rightJuiceValue)+"\t" );  

		# Write stimulus values to log file
		logFile.print( "LName:\t"+leftMovieName+"\tRName:\t"+rightMovieName+"\t" );  
		
		# Load and prepare the left movie
		leftStream.set_filename( leftMovieName+".avi" );
		leftStream.set_use_audio( false );
		leftStream.prepare(); # not using audio
		leftVideoPlane.set_texture( leftStream.get_texture() );
		leftVideoPlane.set_size( videoStimulusWidth, videoStimulusHeight );
			
		# Load and prepare the right movie
		rightStream.set_filename( rightMovieName+".avi" );
		rightStream.set_use_audio( false );
		rightStream.prepare(); # not using audio
		rightVideoPlane.set_texture( rightStream.get_texture() );
		rightVideoPlane.set_size( videoStimulusWidth, videoStimulusHeight );
		
	

		
		
		#These two strings track the monkey's response to different parts of the trial
		string stimulusResponse = "";
		
		#Mark the start of this trial
		trialStartTime = clock.time();
		
		#Present the stimulus period
		stimulusResponse = presentStimulus();
		
		term.print_line( "Stimulus Response: "+ stimulusResponse );
			
		if #If there was a correct response
			stimulusResponse == "Left"
		then
			#Increment the completed counter
			trialsCompleted = trialsCompleted + 1;
			
			# Present the correct ITI period
			presentITI(correctItiDuration );
			
			# Advance the condition
			currentConditionIdx=currentConditionIdx+1;
			
		elseif #If there was a correct response
			stimulusResponse == "Right"
		then
			#Increment the completed trial counter
			trialsCompleted = trialsCompleted + 1;
			
			# Present the correct ITI period
			presentITI(correctItiDuration );
			
			# Advance the condition
			currentConditionIdx=currentConditionIdx+1;
			
		elseif # If the monkey missed any of the targets
			stimulusResponse == "Missed"
		then
			#Increment the missed trial counter
			missedTrials = missedTrials + 1;
			
			# Present the correct ITI period
			presentITI(missedItiDuration );
			
			# If we are ignoring incorrect trials, advance to the next condition
			if onErrorBehav == "ignore" then currentConditionIdx=currentConditionIdx+1; end;
		
		elseif
			stimulusResponse == "StartCueMiss"
		then
			# Present the correct ITI period
			presentITI(ignoredItiDuration );
		elseif
			stimulusResponse == "Early"
		then
			#Increment the ignored trial counter
			earlyTrials = earlyTrials + 1;
			
			# Present the correct ITI period
			presentITI(missedItiDuration );

			# If we are ignoring incorrect trials, advance to the next condition
			if onErrorBehav == "ignore" then currentConditionIdx=currentConditionIdx+1;   end;
		else
			#Increment the ignored trial counter
			ignoredTrials = ignoredTrials + 1;

			# Present the correct ITI period
			presentITI(startCueMissItiDuration );

			# If we are ignoring incorrect trials, advance to the next condition
			if onErrorBehav == "ignore" then currentConditionIdx=currentConditionIdx+1;   end;
			
		end;
			
		
		
		#Get the trial response time
		trialResponseTime = clock.time();
		
		logFile.print( "Rsp:\t"+stimulusResponse+"\t" );  
	
		#Write the start and end time of the trial to the log
		logFile.print( "Start:\t"+string(trialStartTime)+"\t" );  
		logFile.print( "End:\t"+string(trialResponseTime)+"\t" );  
		
		
		# Terminate the line on the logfile, indicating the end of a trial
		logFile.print( "END\n");
		
		
		wait_interval(25);
		encode(trialEndCode);
		wait_interval(25);
		
		#Print trial information out to terminal
		term.print_line( "Completed trials: " + string( trialsCompleted ) + "/" + string(trialsAttempted) + "   Correct trials: " + string( correctTrials  ) + "/" + string(trialsCompleted) + "   Missed trials: " + string( missedTrials ) + "/" + string(trialsAttempted) + "   Ignored trials: " + string( ignoredTrials ) + "/" + string(trialsAttempted) + "   Holding Trials: " + string( holdTrials ) + "/" + string(trialsAttempted));
		term.print_line( "Start-cues: " + string( startCuesFixated ) + "/" + string(startCuesPresented) + "   Left Choices: " + string( leftStimulusChoices  ) + "/" + string(leftStimulusCorrectTrials) + "   Right Presses: " + string( rightStimulusChoices ) + "/" + string(rightStimulusCorrectTrials) + "   Early trials: " + string( earlyTrials ) + "/" + string(trialsAttempted));
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
term.print_line( "  Correct Trials: " + string( correctTrials ) + "/" + string(trialsCompleted));
term.print_line( "Completed Trials: " + string( trialsCompleted ) + "/" + string(trialsAttempted));
term.print_line( "      Start Cues: " + string( startCuesFixated ) + "/" + string(startCuesPresented) );
term.print_line( "   Missed Trials: " + string( missedTrials ) + "/" + string(trialsAttempted) );
term.print_line( "  Ignored Trials: " + string( ignoredTrials ) + "/" + string(trialsAttempted) );
term.print_line( "   Left Choices: " + string( leftStimulusChoices ) + "/" + string(leftStimulusCorrectTrials) );
term.print_line( "  Right Choices: " + string( rightStimulusChoices ) + "/" + string(rightStimulusCorrectTrials) );
