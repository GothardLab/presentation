#	Button Train (buttonTrain)
#	Philip Putnam, 2016, University of Arizona
#
#	Note that this program is written for two monitors, one is the 
#	buttonscreen the monkey is using (display 1) and one is the
#	experimenter's monitor (display 2). 
#
#	Verison History
#		v0.1	09/24/16		Branched buttonTrain from buttonThreeTrain
#

# Scenario file parameters
scenario = "Button Train";
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
	
	# 1
	box {color = 0,255,0;height=250;width=250;display_index=2;}experimenterStartButtonCue;
	x=0; y=0;  			# The position of the experimenter's button cue
	on_top=true;
	
	#2
	ellipse_graphic {
      ellipse_width = 300;
      ellipse_height = 300;
      color = 0, 255, 0;
      rotation = 30;
		display_index=2;
   }experimenterStartChoiceEllipse;
	x = 0; y = 0;
	
	#3
	line_graphic {
		coordinates = 100, 100, -100, -100;
		coordinates = -100, 100, 100, -100;
		line_width = 15;
		line_color = 255, 0, 0, 255;
		display_index=2;
	}experimenterLeftButtonStartHoldCue;
	x = 9999; y = 9999;
	
	#4
	line_graphic {
		coordinates = 100, 100, -100, -100;
		coordinates = -100, 100, 100, -100;
		line_width = 15;
		line_color = 255, 0, 0, 255;
		display_index=2;
	} experimenterCenterButtonStartHoldCue;
	x = 9999; y = 9999; # String to display button position
	
	#5
	line_graphic {
		coordinates = 100, 100, -100, -100;
		coordinates = -100, 100, 100, -100;
		line_width = 15;
		line_color = 255, 0, 0, 255;
		display_index=2;
	}experimenterRightButtonStartHoldCue;
	x = 9999; y = 9999; # String to display button position
	
	text { caption = "Button_Info"; display_index=2;} buttonTextCue;
	x = 400; y = -300; # String to display button position
	
	text { caption = "Trial_Info"; display_index=2;} trialTextCue;
	x = -400; y = -300;# String to display trial info
	
}startCueExperimenter;

#Start cue to show the monkey
picture{

	#display this picture on the experimenter's monitor (monitor 2)
	display_index=1;
	
	# 1
	box {color = 0,255,0;height=250;width=250;display_index=1;}monkeyStartButtonCue;
	x=0; y=0;  			# The position of the experimenter's button cue
	on_top=true;
	
	#2
	ellipse_graphic {
      ellipse_width = 300;
      ellipse_height = 300;
      color = 0, 255, 0;
      rotation = 30;
		display_index=1;
   }monkeyStartChoiceEllipse;
	x = 0; y = 0;
	
	#3
	line_graphic {
		coordinates = 100, 100, -100, -100;
		coordinates = -100, 100, 100, -100;
		line_width = 15;
		line_color = 255, 0, 0, 255;
		display_index=1;
	}monkeyLeftButtonStartHoldCue;
	x = 9999; y = 9999;
	
	#4
	line_graphic {
		coordinates = 100, 100, -100, -100;
		coordinates = -100, 100, 100, -100;
		line_width = 15;
		line_color = 255, 0, 0, 255;
		display_index=1;
	} monkeyCenterButtonStartHoldCue;
	x = 9999; y = 9999; # String to display button position
	
	#5
	line_graphic {
		coordinates = 100, 100, -100, -100;
		coordinates = -100, 100, 100, -100;
		line_width = 15;
		line_color = 255, 0, 0, 255;
		display_index=1;
	}monkeyRightButtonStartHoldCue;
	x = 9999; y = 9999; # String to display button position
	
}startCueMonkey;


#Button stimulus to show the experimenter
picture{

	#display this picture on the experimenter's monitor (monitor 2)
	display_index=2;
	
	# 1
	box {color = 0,255,0;height=250;width=250;display_index=2;}experimenterLeftButtonCue;
	x=-500; y=0;  			# The position of the experimenter's button cue
	on_top=true;
	
	# 2
	box {color = 0,255,0;height=250;width=250;display_index=2;}experimenterCenterButtonCue;
	x=0; y=0;  			# The position of the experimenter's button cue
	on_top=true;
	
	# 3
	box {color = 0,255,0;height=250;width=250;display_index=2;}experimenterRightButtonCue;
	x=300; y=0;  			# The position of the experimenter's button cue
	on_top=true;
	
	#4
	ellipse_graphic {
      ellipse_width = 300;
      ellipse_height = 300;
      color = 0, 255, 0;
      rotation = 30;
		display_index=2;
   }experimenterLeftStimulusChoiceEllipse;
	x = 0; y = 0;
	
	#5
	ellipse_graphic {
      ellipse_width = 300;
      ellipse_height = 300;
      color = 0, 255, 0;
      rotation = 30;
		display_index=2;
   }experimenterCenterStimulusChoiceEllipse;
	x = 0; y = 0;
	
	#6
	ellipse_graphic {
      ellipse_width = 300;
      ellipse_height = 300;
      color = 0, 255, 0;
      rotation = 30;
		display_index=2;
   }experimenterRightStimulusChoiceEllipse;
	x = 0; y = 0;
	

	
	#10
	text { caption = "Button_Info"; display_index=2;} buttonTextStimulus;
	x = 400; y = -300; # String to display button position
	
	#11
	text { caption = "Trial_Info"; display_index=2;} trialTextStimulus;
	x = -400; y = -300;# String to display trial info
	
}stimulusExperimenter;

#Button stimulus to show the monkey
picture{

	#display this picture on the experimenter's monitor (monitor 2)
	display_index=1;
	
	# 1
	box {color = 0,255,0;height=250;width=250;display_index=1;}monkeyLeftButtonCue;
	x=-500; y=0;  			# The position of the experimenter's button cue
	on_top=true;
	
	# 2
	box {color = 0,255,0;height=250;width=250;display_index=1;}monkeyCenterButtonCue;
	x=0; y=0;  			# The position of the experimenter's button cue
	on_top=true;
	
	# 3
	box {color = 0,255,0;height=250;width=250;display_index=1;}monkeyRightButtonCue;
	x=300; y=0;  			# The position of the experimenter's button cue
	on_top=true;
	
	#4
	ellipse_graphic {
      ellipse_width = 300;
      ellipse_height = 300;
      color = 0, 255, 0;
      rotation = 30;
		display_index=1;
   }monkeyLeftStimulusChoiceEllipse;
	x = 0; y = 0;
	
	#5
	ellipse_graphic {
      ellipse_width = 300;
      ellipse_height = 300;
      color = 0, 255, 0;
      rotation = 30;
		display_index=1;
   }monkeyCenterStimulusChoiceEllipse;
	x = 0; y = 0;
	
	#6
	ellipse_graphic {
      ellipse_width = 300;
      ellipse_height = 300;
      color = 0, 255, 0;
      rotation = 30;
		display_index=1;
   }monkeyRightStimulusChoiceEllipse;
	x = 0; y = 0;
	
	
}stimulusMonkey;


#Screen to show the monkey during the ITI
picture{

	#display this picture on the monkey's monitor (monitor 1)
	display_index=1;

}itiMonkey;

#Screen to show the experimenter during the ITI
picture{

	#display this picture on the monkey's monitor (monitor 1)
	display_index=2;
	
	text { caption = "Button_Info"; display_index=2;} buttonTextITI;
	x = 400; y = -300;		# String to display button position
	
	text { caption = "Trial_Info"; display_index=2;} trialTextITI;
	x = -400; y = -300;	# String to display button position

	text { caption = "Time Remaining:"; display_index=2;} timeTextITI;
	x = 0; y = 0;	# String to display button position
}itiExperimenter;



# ---------------------------------------------------------------------------
#										Begin PCL code
# ---------------------------------------------------------------------------
begin_pcl;

# Variables for task settings (You can change these)
int stimulusHeight	=	200;				# Height of stimulus (pixels)341
int stimulusWidth	=	200;					# Width of stimulus (pixels)512
int stimulusDuration	=	10000; 			# time that monkey is allowed to touch button (ms) per trial
int cueDuration	=	10000; 				# time that monkey is allowed to get to center pre-trial cue box (ms) 
int correctItiDuration	=	3000; 		# Duration of the inter-trial-interval(ms)for correct trials
int missedItiDuration	=	3000;		 	# Duration of the inter-trial-interval(ms) for missed trials
int holdItiDuration	=	100;		 		# Duration of the inter-trial-interval(ms) for holding the button before the trial
int ignoredItiDuration   =	3000;			# Duration of the inter-trial-interval(ms) for ignored trials
int feedbackLength = 250; 					# Time (ms) per trial which the monkey gets visual feedback of correct or incorrect response
int buttonTouchTime = 1250;					# Time (ms) the monkey has to touch the button for to make a response, set to zero to make instantanous 
int cueTouchTime = 1000;					# Time (ms) the monkey has to touch the starting cue for to make a response, set to zero to make instantanous 
int leftStimulusXPosition = -500;		# X position of left stimulus (in pixels)
int centerStimulusXPosition = 0;			# X position of left stimulus (in pixels)
int rightStimulusXPosition = 500;		# X position of right stimulus (in pixels)
int stimulusYPosition = 250;				# Y position of both stimuli (in pixels)
int numMagicNumbers = 5;					# Number of magic numbers to log/encode out
string taskName = "ButtonTrain";  		# String of task name
double voltageThreshold = 1.0;			# Voltage threshold the sensor needs to reach before being considered active (they should hover around +/- mV and go to +5V if wired correctly)
int leftJuiceRewardDrops = 5;				# Number of drops of juice to give the monkey when a correct (left) button is pressed
int centerJuiceRewardDrops = 5;			# Number of drops of juice to give the monkey when a correct (center) button is pressed	
int rightJuiceRewardDrops = 5;			# Number of drops of juice to give the monkey when a correct (right)button is pressed	
bool catchHolding	= true;					#Set 'true' for the program to catch when a button is being held before trial start
bool pauseTrialUntilStopHolding = true; #Set 'true' for the program to pause a trial when a button is being held before trial start, requires (catchHolding == true), if false the trial is aborted
bool giveIncorrectFeedbackOnIgnore = false; #Set 'true' for the program to provide incorrect feedback when a trial is ignored
bool giveIncorrectFeedbackOnMissed = true; #Set 'true' for the program to provide incorrect feedback when the wrong button is pressed
bool giveIncorrectFeedbackOnHold = false; #Set 'true' for the program to provide incorrect feedback when a button is being held before trial start, requires (catchHolding == true)
bool catchMissedCueResponse = false ;	#Set 'true' for the program to catch a wrong button press during the start cue (left or right)
bool endTrialOnEarlyRelease = false;	#Ends trial if monkey releases button early
bool showImmediateCorrectFeedback = true; # Set
bool showCorrectOrIncorrectFeedback = true;
int cueJuiceRewardDrops = 5;				# Number of drops of juice to give the monkey when a the start cue button is correctly pressed
int cueChoiceSizeIncrease = 100; 		# Size to increase the chosen cue

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
int touchColorR = 255; #86
int touchColorG = 255;#237
int touchColorB = 255;#253
int correctColorR = 0; #86
int correctColorG = 255;#237
int correctColorB = 0;#253
int incorrectColorR =255; #86
int incorrectColorG = 0;#237
int incorrectColorB = 0;#253
int correctlyChoosingColorR = 153;
int correctlyChoosingColorG = 255;
int correctlyChoosingColorB = 153;
int incorrectlyChoosingColorR = 255;
int incorrectlyChoosingColorG = 204;
int incorrectlyChoosingColorB = 204;


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
int clockticker	=	0; 			# Counter for time
int holdticker		=	0; 			# Counter for time
int currentBlock = 	0;				# Counter for current trial
int missedTrials = 	0;				# Counter for missed trials
int holdTrials = 0;
int ignoredTrials = 0;				# Counter for ignored trials
int trialsCompleted = 0;			# Counter for correct trials
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
int leftButtonPresses = 0;			# Tracks number of left buttons presses
int rightButtonPresses = 0;			# Trackers number of right buttons presses
int centerButtonPresses = 0;			# Trackers number of center buttons presses
int leftButtonTrials = 0;			# Tracks number of left buttons presses
int rightButtonTrials  = 0;			# Trackers number of right buttons presses
int centerButtonTrials  = 0;			# Trackers number of center buttons presses
string monkeyResponse = "";		# String to hold monkey's response from trial subroutines	
int correctCuePresses = 0;
int timeTouchingProportion = 0;


# ------------------ Access national instruments card ------------------
dio_device card = new dio_device( ni_dio_device, 1, 0 );

# ------------------ Setup output ports  ------------------
output_port juicePulse = output_port_manager.get_port(1);
output_port openData = output_port_manager.get_port(2);
output_port openPulse = output_port_manager.get_port(3);

# ------------------ Setup input ports  ------------------
int lV = card.acquire_analog_input("ButtonTask,leftButton");  # set up retrieval of the left button voltage state
int cV = card.acquire_analog_input("ButtonTask,centerButton");  # set up retrieval of the center button voltage state
int rV = card.acquire_analog_input("ButtonTask,rightButton");  # set up retrieval of the right button voltage state
double leftButtonV; # initialize variable for eye tracker x postion
double centerButtonV; # initialize variable for eye tracker y postion
double rightButtonV; # initialize variable for eye tracker y postion

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
string exp_par="button_parameters.txt"; 				# Name of the text file with the experiment information
input_file exp_info = new input_file;					# Create an input file
exp_info.open( exp_par );									# Load the experimental parameters into the input file
string temp_name;												# Create a string variable for temporary use
temp_name=exp_info.get_line();							# Get the first line of the experimental file (item file)
string cnd_file=temp_name.substring(17,temp_name.count()-16);	# Filename of the condition file
temp_name=exp_info.get_line();  							# Get the next line (just dashes) and ignore
temp_name=exp_info.get_line();							# Get the 4th line (number of trials)
int numberBlocks=int(double(temp_name.substring(temp_name.count()-1,2)));	# Write down the number of trials to be shown

#Print out the parameters from the file
term.print_line( "Reading parameters from: " + exp_par );
term.print_line( "Condition file: " + cnd_file);
term.print_line( "Number of blocks " + string(numberBlocks));

#Write parameters to log fileqqq
logFile.print( "PARM:\t"+exp_par+"\n" ); 
logFile.print( "COND:\t"+cnd_file+"\n" );   
logFile.print( "DATE:\t"+date_time()+"\n" );   

# ------------------ Load conditions from condition file  ------------------					
string cnd_name;  											# Create a string variable for the condition names	
input_file cndFileObj = new input_file;   					# Create an input file
cndFileObj.open(cnd_file);											# Load the item file data into the input file
cnd_name=cndFileObj.get_line();									# Get the first line of the condition file (column headers)
int num_cnds=int(double(cnd_name.substring(cnd_name.find("totalconditions=")+16,3)));#assign how many cnds there are to a variable

int left_index=cnd_name.find("lft");
int center_index=cnd_name.find("cnt");
int right_index=cnd_name.find("rgt");
int cue_index=cnd_name.find("cue");

term.print_line( "Left Idx: " + string(left_index) + "\t\tCenterIdx: " + string(center_index) + "\t\tRight Idx: " + string(right_index) + "\t\tCue Idx: "  + string(cue_index));

array<string>left_cnd[num_cnds];       				
array<string>cent_cnd[num_cnds];       					
array<string>right_cnd[num_cnds];       				
array<string>cue_cnd[num_cnds];       		

int i = 0; 														# Create a counter to loop through conditions
loop 
	i=1 
until
	i>num_cnds 
begin							# Loop through each line in the cnd file
	cnd_name=cndFileObj.get_line();								# 
	left_cnd[i]=cnd_name.substring(left_index-1,3);	
	cent_cnd[i]=cnd_name.substring(center_index-1,3);
	right_cnd[i]=cnd_name.substring(right_index-1,3);
	cue_cnd[i]=cnd_name.substring(cue_index-1,3);
	
	term.print_line( "Cnd: " + string(i) + "\t\tLeft Button: " +left_cnd[i] + "\t\tCenter Button: " +cent_cnd[i] + "\t\tRight Button: " +right_cnd[i] + "\t\tCue: " +cue_cnd[i]);
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
		#encode(rewardGivenCode); 							# Mark that we are giving juice
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


# ------------------ Present ITI Subroutine ------------------
sub
	presentITI( int itiDuration )
begin
	# Mark that we are starting the ITI
	wait_interval(10);
	#encode(ITIStartCode);
	
		
	# Update the trial text to the current trial
	trialTextITI.set_caption( "Block: " + printf( currentBlock, "%2d" ) + "/" + printf( numberBlocks, "%2d" ) + 
										"\n Condition: "+ printf( currentConditionIdx, "%2d" ) + "/" + printf( numberConditions, "%2d" ) + " (" + printf( currentConditionVal, "%2d" )+ ")" +
										"\n Completed: "+ printf( trialsCompleted, "%2d" ) + "/" + printf( trialsAttempted, "%2d" ) +
										"\n Missed: "+ printf( missedTrials, "%2d" ) + "/" + printf( trialsAttempted, "%2d" ) +
										"\n Ignored: "+ printf( ignoredTrials, "%2d" ) + "/" + printf( trialsAttempted, "%2d" ) +
										"\n Hold Errors: "+ printf( holdTrials, "%2d" ) + "/" + printf( trialsAttempted, "%2d" ), true );
										
	buttonTextITI.set_caption( "Left: " + printf( leftButtonPresses, "%2d" ) + "/" + printf( leftButtonTrials, "%2d" ) + 
										"\n Center: "+ printf( centerButtonPresses, "%2d" ) + "/" + printf( centerButtonTrials, "%2d" ) +
										"\n Right: "+ printf( rightButtonPresses, "%2d" ) + "/" + printf( rightButtonTrials, "%2d" ), true );
	
	# Present the ITI screen to the monkey and the experimenter
	itiExperimenter.present();
	itiMonkey.present();

	# Get the current time
	clockticker=clock.time();
	
	int timeRemaining = 0;
	
	# Create a response_data class for the last button
	response_data lastButton;
	
	loop until # Loop until the ITI is over
			(clock.time()-clockticker) > itiDuration 
	begin
		timeRemaining = (itiDuration - (clock.time()-clockticker));
		timeTextITI.set_caption( "Time Remaining: " + printf(timeRemaining, "%6d" ));
		timeTextITI.redraw();
		itiExperimenter.present();
	end;
	
	# Mark that we are finished with the ITI
	#encode(ITIEndCode);	
end;

# ------------------ Present Start Cue Subroutine ------------------
sub
   string presentCue 
begin
	term.print_line("Presenting start cue");
	# Assume the default behavior of the monkey is to ignore the stimulus
	string monkeyCueResponseStr = "Ignored";
	int trialCue = int(cue_cnd[ordered_cnds_to_show[currentConditionIdx]].substring(1,3));
	
	# Update the trial text to the current trial
	trialTextCue.set_caption( "Block: " + printf( currentBlock, "%2d" ) + "/" + printf( numberBlocks, "%2d" ) + 
										"\n Condition: "+ printf( currentConditionIdx, "%2d" ) + "/" + printf( numberConditions, "%2d" ) + " (" + printf( currentConditionVal, "%2d" )+ ")" +
										"\n Completed: "+ printf( trialsCompleted, "%2d" ) + "/" + printf( trialsAttempted, "%2d" ) +
										"\n Missed: "+ printf( missedTrials, "%2d" ) + "/" + printf( trialsAttempted, "%2d" ) +
										"\n Ignored: "+ printf( ignoredTrials, "%2d" ) + "/" + printf( trialsAttempted, "%2d" ) +
										"\n Hold Errors: "+ printf( holdTrials, "%2d" ) + "/" + printf( trialsAttempted, "%2d" ), true );
										
	buttonTextCue.set_caption( "Left: " + printf( leftButtonPresses, "%2d" ) + "/" + printf( leftButtonTrials, "%2d" ) + 
										"\n Center: "+ printf( centerButtonPresses, "%2d" ) + "/" + printf( centerButtonTrials, "%2d" ) +
										"\n Right: "+ printf( rightButtonPresses, "%2d" ) + "/" + printf( rightButtonTrials, "%2d" ), true );
										
	startCueMonkey.set_part_x(3, 9999);
	startCueMonkey.set_part_y(3, 9999);
	startCueExperimenter.set_part_x(3, 9999);
	startCueExperimenter.set_part_y(3, 9999);
	monkeyLeftButtonStartHoldCue.redraw();
	experimenterLeftButtonStartHoldCue.redraw();

	startCueMonkey.set_part_x(4, 9999);
	startCueMonkey.set_part_y(4, 9999);
	startCueExperimenter.set_part_x(4, 9999);
	startCueExperimenter.set_part_y(4, 9999);
	monkeyCenterButtonStartHoldCue.redraw();
	experimenterCenterButtonStartHoldCue.redraw();
	
	startCueMonkey.set_part_x(5, 9999);
	startCueMonkey.set_part_y(5, 9999);
	startCueExperimenter.set_part_x(5, 9999);
	startCueExperimenter.set_part_y(5, 9999);
	monkeyCenterButtonStartHoldCue.redraw();
	experimenterCenterButtonStartHoldCue.redraw();
	
	startCueMonkey.set_part_x(1, 9999);
	startCueMonkey.set_part_y(1, 9999);
	startCueExperimenter.set_part_x(1, 9999);
	startCueExperimenter.set_part_y(1, 9999);
	startCueMonkey.set_part_x(2, 9999);
	startCueMonkey.set_part_y(2, 9999);
	startCueExperimenter.set_part_x(2, 9999);
	startCueExperimenter.set_part_y(2, 9999);
										
	#Assume we are not going to present the start cue
	bool continueStartCue= false;
	
	if # As long as the monkey is not holding one of the buttons
		leftButtonV < voltageThreshold && centerButtonV < voltageThreshold && rightButtonV < voltageThreshold
	then # Present the start cue
		continueStartCue = true;
	else # Otherwise (if the monkey is holding one of the buttons)
	
		#Present incorrect feedback, if this is enabled
		if
			giveIncorrectFeedbackOnHold == true
		then
			presentIncorrectFeedback();
		end;	
		
		if # If we are going to pause the trial until the monkey releases
			pauseTrialUntilStopHolding == true
		then
			loop until # Loop until the monkey releases all of the buttons
				leftButtonV < voltageThreshold && centerButtonV < voltageThreshold && rightButtonV < voltageThreshold
			begin
				#Read the voltages
				leftButtonV =card.read_analog(lV); 
				centerButtonV =card.read_analog(cV);
				rightButtonV =card.read_analog(rV);
				
				if leftButtonV > voltageThreshold then
					startCueMonkey.set_part_x(3, leftStimulusXPosition);
					startCueMonkey.set_part_y(3, stimulusYPosition);
					startCueExperimenter.set_part_x(3, leftStimulusXPosition);
					startCueExperimenter.set_part_y(3, stimulusYPosition);
					monkeyLeftButtonStartHoldCue.redraw();
					experimenterLeftButtonStartHoldCue.redraw();
					startCueExperimenter.present();
					startCueMonkey.present();
				else
					startCueMonkey.set_part_x(3, 9999);
					startCueMonkey.set_part_y(3, 9999);
					startCueExperimenter.set_part_x(3, 9999);
					startCueExperimenter.set_part_y(3, 9999);
					monkeyLeftButtonStartHoldCue.redraw();
					experimenterLeftButtonStartHoldCue.redraw();
					startCueExperimenter.present();
					startCueMonkey.present();
				end;
				
				if centerButtonV > voltageThreshold then
					startCueMonkey.set_part_x(4, centerStimulusXPosition);
					startCueMonkey.set_part_y(4, stimulusYPosition);
					startCueExperimenter.set_part_x(4, centerStimulusXPosition);
					startCueExperimenter.set_part_y(4, stimulusYPosition);
					monkeyCenterButtonStartHoldCue.redraw();
					experimenterCenterButtonStartHoldCue.redraw();
					startCueExperimenter.present();
					startCueMonkey.present();
				else
					startCueMonkey.set_part_x(4, 9999);
					startCueMonkey.set_part_y(4, 9999);
					startCueExperimenter.set_part_x(4, 9999);
					startCueExperimenter.set_part_y(4, 9999);
					monkeyCenterButtonStartHoldCue.redraw();
					experimenterCenterButtonStartHoldCue.redraw();
					startCueExperimenter.present();
					startCueMonkey.present();
				end;
				
				if rightButtonV > voltageThreshold then
					startCueMonkey.set_part_x(5, rightStimulusXPosition);
					startCueMonkey.set_part_y(5, stimulusYPosition);
					startCueExperimenter.set_part_x(5, rightStimulusXPosition);
					startCueExperimenter.set_part_y(5, stimulusYPosition);
					monkeyRightButtonStartHoldCue.redraw();
					experimenterRightButtonStartHoldCue.redraw();
					startCueExperimenter.present();
					startCueMonkey.present();
				else
					startCueMonkey.set_part_x(5, 9999);
					startCueMonkey.set_part_y(5, 9999);
					startCueExperimenter.set_part_x(5, 9999);
					startCueExperimenter.set_part_y(5, 9999);
					monkeyRightButtonStartHoldCue.redraw();
					experimenterRightButtonStartHoldCue.redraw();
					startCueExperimenter.present();
					startCueMonkey.present();
				end;
			end; 
			#The monkey has released, so now we can present the start cue
			continueStartCue = true;
		else #Otherwise, return the response of 'Hold'
			monkeyCueResponseStr = "Hold";
		end;
		
	end;
	
	if (trialCue == 1 && continueStartCue == true) then 
	
		# Set up the start cue
		startCueMonkey.set_part_x(1, centerStimulusXPosition);
		startCueMonkey.set_part_y(1, stimulusYPosition);
		startCueExperimenter.set_part_x(1, centerStimulusXPosition);
		startCueExperimenter.set_part_y(1, stimulusYPosition);
		monkeyStartButtonCue.set_height(stimulusHeight);
		monkeyStartButtonCue.set_width(stimulusWidth);
		experimenterStartButtonCue.set_height(stimulusHeight);
		experimenterStartButtonCue.set_width(stimulusWidth);
		monkeyStartButtonCue.set_color(centerColorR,  centerColorG, centerColorB);
		experimenterStartButtonCue.set_color(centerColorR, centerColorG, centerColorB);
		startCueMonkey.set_part_x(2, 9999);
		startCueMonkey.set_part_y(2, 9999);
		startCueExperimenter.set_part_x(2, 9999);
		startCueExperimenter.set_part_y(2, 9999);
		experimenterStartChoiceEllipse.set_dimensions( stimulusHeight+cueChoiceSizeIncrease, stimulusWidth+cueChoiceSizeIncrease);
		monkeyStartChoiceEllipse.set_dimensions( stimulusHeight+cueChoiceSizeIncrease, stimulusWidth+cueChoiceSizeIncrease);
		
		# Get the current time
		clockticker=clock.time();

		# Update the monkey's and experimenter's screens
		startCueExperimenter.present();
		startCueMonkey.present();
			
		loop until # Loop until the cue duration is over
				((clock.time()-clockticker) > cueDuration) || monkeyCueResponseStr != "Ignored"
		begin
			#Read the button voltages
			leftButtonV =card.read_analog(lV); 
			centerButtonV =card.read_analog(cV);
			rightButtonV =card.read_analog(rV);
			
				
			if # If the monkey is touching the center button (cue)
				centerButtonV > voltageThreshold
			then
					
				# Set 'monkeyTouching' to true to track that he is touching
				bool monkeyTouching = true;
				
				startCueMonkey.set_part_x(2, centerStimulusXPosition);
				startCueMonkey.set_part_y(2, stimulusYPosition);
				startCueExperimenter.set_part_x(2, centerStimulusXPosition);
				startCueExperimenter.set_part_y(2, stimulusYPosition);
				experimenterStartChoiceEllipse.set_color(touchColorR, touchColorG, touchColorB, 255);
				monkeyStartChoiceEllipse.set_color(touchColorR, touchColorG, touchColorB, 255);
				experimenterStartChoiceEllipse.redraw();
				monkeyStartChoiceEllipse.redraw();
				startCueExperimenter.present();
				startCueMonkey.present();
				
				# If the monkey is required to hold for any period of time
				if cueTouchTime > 0 then
					
					#Get the current time
				holdticker=clock.time();
					
					loop until # Loop until the hold time is over OR the monkey stopped holding
						((clock.time()-holdticker) > cueTouchTime ) || monkeyTouching == false
					begin
					#Update the curent voltage of the center button
					centerButtonV = card.read_analog(cV);
					
					#If the monkey is no longer touching, update the 'monkeyTouching' boolean
					if 
						centerButtonV < voltageThreshold 
					then 
						monkeyTouching = false;
						startCueMonkey.set_part_x(2, 9999);
						startCueMonkey.set_part_y(2, 9999);
						startCueExperimenter.set_part_x(2, 9999);
						startCueExperimenter.set_part_y(2, 9999);
						experimenterStartChoiceEllipse.redraw();
						monkeyStartChoiceEllipse.redraw();
						startCueExperimenter.present();
						startCueMonkey.present();
					end;
					
					end; 
				end;
				
				#If the monkey touched (and held) the center button
				if monkeyTouching ==  true then 
					
					#startCueMonkey.set_part_x(2, centerStimulusXPosition);
					#startCueMonkey.set_part_y(2, stimulusYPosition);
					#startCueExperimenter.set_part_x(2, centerStimulusXPosition);
					#startCueExperimenter.set_part_y(2, stimulusYPosition);
					if showCorrectOrIncorrectFeedback == true then
						experimenterStartChoiceEllipse.set_color(correctColorR, correctColorG, correctColorB, 255);
						monkeyStartChoiceEllipse.set_color(correctColorR, correctColorG, correctColorB, 255);
						experimenterStartChoiceEllipse.redraw();
						monkeyStartChoiceEllipse.redraw();
						startCueExperimenter.present();
						startCueMonkey.present();
					else
						
					end;
					
					monkeyCueResponseStr = "Correct";
					correctCuePresses = correctCuePresses + 1;
					giveJuiceReward(cueJuiceRewardDrops);
				elseif
					endTrialOnEarlyRelease == true
				then
					monkeyCueResponseStr = "EarlyRelease";
				end;
				
			elseif # If we are tracking the other buttons and the left button was pressed
				catchMissedCueResponse == true && leftButtonV > voltageThreshold
			then
				monkeyCueResponseStr = "Missed";
			elseif # If we are tracking the other buttons and the right button was pressed
				catchMissedCueResponse == true && rightButtonV > voltageThreshold
			then
					monkeyCueResponseStr = "Missed";
			end;
			
		end;
	elseif #If we are not showing the cue and the monkey did not hold
		continueStartCue == true
	then
		monkeyCueResponseStr = "Correct";
	else
	
	end;
	
	return monkeyCueResponseStr;
end;


# ------------------ Present Stimulus Subroutine ------------------
sub
   string presentStimulus 
begin
	string monkeyResponseStr = "Ignored"; # Assume that the monkey ignored the stimulus unless proven otherewise
	string correctResponseStr = "Unknown";# We don't yet know what the correct response on this trial should be
	
	# Update the trial text to the current trial
	trialTextStimulus.set_caption( "Block: " + printf( currentBlock, "%2d" ) + "/" + printf( numberBlocks, "%2d" ) + 
										"\n Condition: "+ printf( currentConditionIdx, "%2d" ) + "/" + printf( numberConditions, "%2d" ) + " (" + printf( currentConditionVal, "%2d" )+ ")" +
										"\n Completed: "+ printf( trialsCompleted, "%2d" ) + "/" + printf( trialsAttempted, "%2d" ) +
										"\n Missed: "+ printf( missedTrials, "%2d" ) + "/" + printf( trialsAttempted, "%2d" ) +
										"\n Ignored: "+ printf( ignoredTrials, "%2d" ) + "/" + printf( trialsAttempted, "%2d" ) +
										"\n Hold Errors: "+ printf( holdTrials, "%2d" ) + "/" + printf( trialsAttempted, "%2d" ), true );
										
	buttonTextStimulus.set_caption( "Left: " + printf( leftButtonPresses, "%2d" ) + "/" + printf( leftButtonTrials, "%2d" ) + 
										"\n Center: "+ printf( centerButtonPresses, "%2d" ) + "/" + printf( centerButtonTrials, "%2d" ) +
										"\n Right: "+ printf( rightButtonPresses, "%2d" ) + "/" + printf( rightButtonTrials, "%2d" ), true );
	
	int trialLeftButton = int(left_cnd[ordered_cnds_to_show[currentConditionIdx]].substring(1,3));
	int trialCenterButton = int(cent_cnd[ordered_cnds_to_show[currentConditionIdx]].substring(1,3));
	int trialRightButton = int(right_cnd[ordered_cnds_to_show[currentConditionIdx]].substring(1,3));
	int trialCue = int(cue_cnd[ordered_cnds_to_show[currentConditionIdx]].substring(1,3));
	
	# Set position of choice cue
	stimulusMonkey.set_part_x(4, 9999);
	stimulusMonkey.set_part_y(4, 9999);
	stimulusExperimenter.set_part_x(4, 9999);
	stimulusExperimenter.set_part_y(4, 9999);
	experimenterLeftStimulusChoiceEllipse.set_dimensions( stimulusHeight+cueChoiceSizeIncrease, stimulusWidth+cueChoiceSizeIncrease);
	monkeyLeftStimulusChoiceEllipse.set_dimensions( stimulusHeight+cueChoiceSizeIncrease, stimulusWidth+cueChoiceSizeIncrease);
	
	stimulusMonkey.set_part_x(5, 9999);
	stimulusMonkey.set_part_y(5, 9999);
	stimulusExperimenter.set_part_x(5, 9999);
	stimulusExperimenter.set_part_y(5, 9999);
	experimenterCenterStimulusChoiceEllipse.set_dimensions( stimulusHeight+cueChoiceSizeIncrease, stimulusWidth+cueChoiceSizeIncrease);
	monkeyCenterStimulusChoiceEllipse.set_dimensions( stimulusHeight+cueChoiceSizeIncrease, stimulusWidth+cueChoiceSizeIncrease);
	
	stimulusMonkey.set_part_x(6, 9999);
	stimulusMonkey.set_part_y(6, 9999);
	stimulusExperimenter.set_part_x(6, 9999);
	stimulusExperimenter.set_part_y(6, 9999);
	experimenterRightStimulusChoiceEllipse.set_dimensions( stimulusHeight+cueChoiceSizeIncrease, stimulusWidth+cueChoiceSizeIncrease);
	monkeyRightStimulusChoiceEllipse.set_dimensions( stimulusHeight+cueChoiceSizeIncrease, stimulusWidth+cueChoiceSizeIncrease);
	
	# Set position/size/color of the left button cue
	if
		trialLeftButton > 0
	then
		stimulusMonkey.set_part_x(1, leftStimulusXPosition);
		stimulusMonkey.set_part_y(1, stimulusYPosition);
		stimulusExperimenter.set_part_x(1, leftStimulusXPosition);
		stimulusExperimenter.set_part_y(1, stimulusYPosition);
		monkeyLeftButtonCue.set_height(stimulusHeight);
		monkeyLeftButtonCue.set_width(stimulusWidth);
		experimenterLeftButtonCue.set_height(stimulusHeight);
		experimenterLeftButtonCue.set_width(stimulusWidth);
		
		if 
			trialLeftButton == 1
		then
			monkeyLeftButtonCue.set_color(neutralColorR, neutralColorG, neutralColorB);
			experimenterLeftButtonCue.set_color(neutralColorR, neutralColorG, neutralColorB);
		elseif 
			trialLeftButton == 2
		then
			leftButtonTrials = leftButtonTrials +1;
			monkeyLeftButtonCue.set_color(leftColorR, leftColorG, leftColorB);
			experimenterLeftButtonCue.set_color(leftColorR, leftColorG, leftColorB);
		end;
	else
		stimulusMonkey.set_part_x(1, 9999);
		stimulusMonkey.set_part_y(1, 9999);
		stimulusExperimenter.set_part_x(1, 9999);
		stimulusExperimenter.set_part_y(1, 9999);
	end;
	
	# Set position/size/color of the center button cue
	if
		trialCenterButton > 0
	then
		stimulusMonkey.set_part_x(2, centerStimulusXPosition);
		stimulusMonkey.set_part_y(2, stimulusYPosition);
		stimulusExperimenter.set_part_x(2, centerStimulusXPosition);
		stimulusExperimenter.set_part_y(2, stimulusYPosition);
		monkeyCenterButtonCue.set_height(stimulusHeight);
		monkeyCenterButtonCue.set_width(stimulusWidth);
		experimenterCenterButtonCue.set_height(stimulusHeight);
		experimenterCenterButtonCue.set_width(stimulusWidth);
		
		if 
			trialCenterButton == 1
		then
			monkeyCenterButtonCue.set_color(neutralColorR, neutralColorG, neutralColorB);
			experimenterCenterButtonCue.set_color(neutralColorR, neutralColorG, neutralColorB);
		elseif 
			trialCenterButton == 2
		then
			centerButtonTrials = centerButtonTrials +1;
			monkeyCenterButtonCue.set_color(centerColorR, centerColorG, centerColorB);
			experimenterCenterButtonCue.set_color(centerColorR, centerColorG, centerColorB);
		end;
	else
		stimulusMonkey.set_part_x(2, 9999);
		stimulusMonkey.set_part_y(2, 9999);
		stimulusExperimenter.set_part_x(2, 9999);
		stimulusExperimenter.set_part_y(2, 9999);
	end;
	
	# Set position/size/color of the right button cue
	if
		trialRightButton > 0
	then
		stimulusMonkey.set_part_x(3, rightStimulusXPosition);
		stimulusMonkey.set_part_y(3, stimulusYPosition);
		stimulusExperimenter.set_part_x(3, rightStimulusXPosition);
		stimulusExperimenter.set_part_y(3, stimulusYPosition);
		monkeyRightButtonCue.set_height(stimulusHeight);
		monkeyRightButtonCue.set_width(stimulusWidth);
		experimenterRightButtonCue.set_height(stimulusHeight);
		experimenterRightButtonCue.set_width(stimulusWidth);
		
		if 
			trialRightButton == 1
		then
			monkeyRightButtonCue.set_color(neutralColorR, neutralColorG, neutralColorB);
			experimenterRightButtonCue.set_color(neutralColorR, neutralColorG, neutralColorB);
		elseif 
			trialRightButton == 2
		then
			rightButtonTrials = rightButtonTrials +1;
			monkeyRightButtonCue.set_color(rightColorR, rightColorG, rightColorB);
			experimenterRightButtonCue.set_color(rightColorR, rightColorG, rightColorB);
		end;
	else
		stimulusMonkey.set_part_x(3, 9999);
		stimulusMonkey.set_part_y(3, 9999);
		stimulusExperimenter.set_part_x(3, 9999);
		stimulusExperimenter.set_part_y(3, 9999);
	end;
	
	
	leftButtonV =card.read_analog(lV); 
	centerButtonV =card.read_analog(cV);
	rightButtonV =card.read_analog(rV);
	
	bool presentStimulus = false;
	
	#Present the start cue
	string cueResponse = presentCue();
		
	if #If the monkey correctly responded to the start cue
		cueResponse == "Correct"
	then
		#Set 'presentStimulus' to true to continue presenting the trial
		presentStimulus = true;
	else
		#Otherwise set 'presentStimulus' to false so that the stimulus is not presented
		presentStimulus = false;
	end;

	# Get the current time
	clockticker=clock.time();
	
	if #If 'presentStimulus' is true, we present the stimulus
		presentStimulus == true
	then
		
		# Get the experimenter's and monkey's screens
		stimulusExperimenter.present();
		stimulusMonkey.present();
		
		# Loop until the stimulus presentation is over OR the monkey has made a response
		loop until
				((clock.time()-clockticker) > stimulusDuration) || monkeyResponseStr != "Ignored"
		begin
			
			# Sample the button voltages
			leftButtonV =card.read_analog(lV); 
			centerButtonV =card.read_analog(cV);
			rightButtonV =card.read_analog(rV);
			
			if leftButtonV > voltageThreshold then
				stimulusMonkey.set_part_x(4, leftStimulusXPosition);
				stimulusMonkey.set_part_y(4, stimulusYPosition);
				stimulusExperimenter.set_part_x(4, leftStimulusXPosition);
				stimulusExperimenter.set_part_y(4, stimulusYPosition);
				experimenterLeftStimulusChoiceEllipse.set_color(touchColorR, touchColorG, touchColorB, 255);
				monkeyLeftStimulusChoiceEllipse.set_color(touchColorR, touchColorG, touchColorB, 255);
				experimenterLeftStimulusChoiceEllipse.redraw();
				monkeyLeftStimulusChoiceEllipse.redraw();
				stimulusExperimenter.present();
				stimulusMonkey.present();
			else
				stimulusMonkey.set_part_x(4, 9999);
				stimulusMonkey.set_part_y(4, 9999);
				stimulusExperimenter.set_part_x(4, 9999);
				stimulusExperimenter.set_part_y(4, 9999);
				experimenterLeftStimulusChoiceEllipse.redraw();
				monkeyLeftStimulusChoiceEllipse.redraw();
				stimulusExperimenter.present();
				stimulusMonkey.present();
			end;
			
			if centerButtonV > voltageThreshold then
				stimulusMonkey.set_part_x(5, centerStimulusXPosition);
				stimulusMonkey.set_part_y(5, stimulusYPosition);
				stimulusExperimenter.set_part_x(5, centerStimulusXPosition);
				stimulusExperimenter.set_part_y(5, stimulusYPosition);
				experimenterCenterStimulusChoiceEllipse.set_color(touchColorR, touchColorG, touchColorB, 255);
				monkeyCenterStimulusChoiceEllipse.set_color(touchColorR, touchColorG, touchColorB, 255);
				experimenterCenterStimulusChoiceEllipse.redraw();
				monkeyCenterStimulusChoiceEllipse.redraw();
				stimulusExperimenter.present();
				stimulusMonkey.present();
			else
				stimulusMonkey.set_part_x(5, 9999);
				stimulusMonkey.set_part_y(5, 9999);
				stimulusExperimenter.set_part_x(5, 9999);
				stimulusExperimenter.set_part_y(5, 9999);
				experimenterCenterStimulusChoiceEllipse.redraw();
				monkeyCenterStimulusChoiceEllipse.redraw();
				stimulusExperimenter.present();
				stimulusMonkey.present();
			end;
			
			if rightButtonV > voltageThreshold then
				stimulusMonkey.set_part_x(6, rightStimulusXPosition);
				stimulusMonkey.set_part_y(6, stimulusYPosition);
				stimulusExperimenter.set_part_x(6, rightStimulusXPosition);
				stimulusExperimenter.set_part_y(6, stimulusYPosition);
				experimenterRightStimulusChoiceEllipse.set_color(touchColorR, touchColorG, touchColorB, 255);
				monkeyRightStimulusChoiceEllipse.set_color(touchColorR, touchColorG, touchColorB, 255);
				experimenterRightStimulusChoiceEllipse.redraw();
				monkeyRightStimulusChoiceEllipse.redraw();
				stimulusExperimenter.present();
				stimulusMonkey.present();
			else
				stimulusMonkey.set_part_x(6, 9999);
				stimulusMonkey.set_part_y(6, 9999);
				stimulusExperimenter.set_part_x(6, 9999);
				stimulusExperimenter.set_part_y(6, 9999);
				experimenterRightStimulusChoiceEllipse.redraw();
				monkeyRightStimulusChoiceEllipse.redraw();
				stimulusExperimenter.present();
				stimulusMonkey.present();
			end;
			
			
			if # If the left button voltage is active, and above threshold
				trialLeftButton > 0 && leftButtonV > voltageThreshold
			then
				
				bool monkeyTouching = true; # The monkey is currently touching the button
				
				if buttonTouchTime > 0 then #If the monkey is required to hold the button for any amount of time
					
					if showImmediateCorrectFeedback == true && trialLeftButton == 2 then
						experimenterLeftStimulusChoiceEllipse.set_color(correctlyChoosingColorR, correctlyChoosingColorG, correctlyChoosingColorB, 255);
						monkeyLeftStimulusChoiceEllipse.set_color(correctlyChoosingColorR, correctlyChoosingColorG, correctlyChoosingColorB, 255);
						experimenterLeftStimulusChoiceEllipse.redraw();
						monkeyLeftStimulusChoiceEllipse.redraw();
						stimulusExperimenter.present();
						stimulusMonkey.present();
						
					elseif showImmediateCorrectFeedback == true then
						experimenterLeftStimulusChoiceEllipse.set_color(incorrectlyChoosingColorR, incorrectlyChoosingColorG, incorrectlyChoosingColorB, 255);
						monkeyLeftStimulusChoiceEllipse.set_color(incorrectlyChoosingColorR, incorrectlyChoosingColorG, incorrectlyChoosingColorB, 255);
						experimenterLeftStimulusChoiceEllipse.redraw();
						monkeyLeftStimulusChoiceEllipse.redraw();
						stimulusExperimenter.present();
						stimulusMonkey.present();
					end;
					
					holdticker=clock.time(); # Get the current time

					loop until #Loop until the holding time is over or the monkey stopped touching
							((clock.time()-holdticker) > buttonTouchTime ) || monkeyTouching == false
					begin
						leftButtonV =card.read_analog(lV); # Sample the button voltage
						
						# If the monkey releases the button, set 'monkeyTouching' to false
						if leftButtonV < voltageThreshold then monkeyTouching = false end;
					end; 
				end;
				
				if monkeyTouching ==  true then

					stimulusMonkey.set_part_x(4, leftStimulusXPosition);
					stimulusMonkey.set_part_y(4, stimulusYPosition);
					stimulusExperimenter.set_part_x(4, leftStimulusXPosition);
					stimulusExperimenter.set_part_y(4, stimulusYPosition);
					
					if showCorrectOrIncorrectFeedback == true && trialLeftButton == 2 then
						experimenterLeftStimulusChoiceEllipse.set_color(correctColorR, correctColorG, correctColorB, 255);
						monkeyLeftStimulusChoiceEllipse.set_color(correctColorR, correctColorG, correctColorB, 255);
					elseif showCorrectOrIncorrectFeedback == true then
						experimenterLeftStimulusChoiceEllipse.set_color(incorrectColorR, incorrectColorG, incorrectColorB, 255);
						monkeyLeftStimulusChoiceEllipse.set_color(incorrectColorR, incorrectColorG, incorrectColorB, 255);
					else
						experimenterLeftStimulusChoiceEllipse.set_color(touchColorR, touchColorG, touchColorB, 127);
						monkeyLeftStimulusChoiceEllipse.set_color(touchColorR, touchColorG, touchColorB, 127);
					end;
					experimenterLeftStimulusChoiceEllipse.redraw();
					monkeyLeftStimulusChoiceEllipse.redraw();
					stimulusExperimenter.present();
					stimulusMonkey.present();
					monkeyResponseStr = "Left";
					leftButtonPresses = leftButtonPresses + 1;
				end
			end;
			
			if # If the center button voltage is active, and above threshold
				trialCenterButton > 0 && centerButtonV > voltageThreshold
			then
				
				
				bool monkeyTouching = true; # The monkey is currently touching the button
				
				if buttonTouchTime > 0 then #If the monkey is required to hold the button for any amount of time
				
					holdticker=clock.time(); # Get the current time
					
					if showImmediateCorrectFeedback == true && trialCenterButton == 2 then
						experimenterCenterStimulusChoiceEllipse.set_color(correctlyChoosingColorR, correctlyChoosingColorG, correctlyChoosingColorB, 255);
						monkeyCenterStimulusChoiceEllipse.set_color(correctlyChoosingColorR, correctlyChoosingColorG, correctlyChoosingColorB, 255);
						experimenterCenterStimulusChoiceEllipse.redraw();
						monkeyCenterStimulusChoiceEllipse.redraw();
						stimulusExperimenter.present();
						stimulusMonkey.present();
					elseif showImmediateCorrectFeedback == true then
						experimenterCenterStimulusChoiceEllipse.set_color(incorrectlyChoosingColorR, incorrectlyChoosingColorG, incorrectlyChoosingColorB, 255);
						monkeyCenterStimulusChoiceEllipse.set_color(incorrectlyChoosingColorR, incorrectlyChoosingColorG, incorrectlyChoosingColorB, 255);
						experimenterCenterStimulusChoiceEllipse.redraw();
						monkeyCenterStimulusChoiceEllipse.redraw();
						stimulusExperimenter.present();
						stimulusMonkey.present();
					end;
					
					loop until #Loop until the holding time is over or the monkey stopped touching
							((clock.time()-holdticker) > buttonTouchTime ) || monkeyTouching == false
					begin
						centerButtonV =card.read_analog(cV); # Sample the button voltage
						
						# If the monkey releases the button, set 'monkeyTouching' to false
						if centerButtonV < voltageThreshold then monkeyTouching = false end;
					end; 
				end;
				
				if monkeyTouching ==  true then
					
					stimulusMonkey.set_part_x(5, centerStimulusXPosition);
					stimulusMonkey.set_part_y(5, stimulusYPosition);
					stimulusExperimenter.set_part_x(5, centerStimulusXPosition);
					stimulusExperimenter.set_part_y(5, stimulusYPosition);
					
					
					if showCorrectOrIncorrectFeedback == true && trialCenterButton == 2 then
						experimenterCenterStimulusChoiceEllipse.set_color(correctColorR, correctColorG, correctColorB, 255);
						monkeyCenterStimulusChoiceEllipse.set_color(correctColorR, correctColorG, correctColorB, 255);
					elseif showCorrectOrIncorrectFeedback == true then
						experimenterCenterStimulusChoiceEllipse.set_color(incorrectColorR, incorrectColorG, incorrectColorB, 255);
						monkeyCenterStimulusChoiceEllipse.set_color(incorrectColorR, incorrectColorG, incorrectColorB, 255);
					else
						experimenterCenterStimulusChoiceEllipse.set_color(touchColorR, touchColorG, touchColorB, 127);
						monkeyCenterStimulusChoiceEllipse.set_color(touchColorR, touchColorG, touchColorB, 127);
					end;
					
					experimenterCenterStimulusChoiceEllipse.redraw();
					monkeyCenterStimulusChoiceEllipse.redraw();
					stimulusExperimenter.present();
					stimulusMonkey.present();
					monkeyResponseStr = "Center";
					centerButtonPresses = centerButtonPresses + 1;
				end
				
			end;
			
			if # If the right button voltage is active, and above threshold
				trialRightButton > 0 && rightButtonV > voltageThreshold
			then
				
				bool monkeyTouching = true; # The monkey is currently touching the button
								
				if buttonTouchTime > 0 then  #If the monkey is required to hold the button for any amount of time
				
					holdticker=clock.time(); # Get the current time
				
					if showImmediateCorrectFeedback == true && trialRightButton == 2 then
						experimenterRightStimulusChoiceEllipse.set_color(correctlyChoosingColorR, correctlyChoosingColorG, correctlyChoosingColorB, 255);
						monkeyRightStimulusChoiceEllipse.set_color(correctlyChoosingColorR, correctlyChoosingColorG, correctlyChoosingColorB, 255);
						experimenterRightStimulusChoiceEllipse.redraw();
						monkeyRightStimulusChoiceEllipse.redraw();
						stimulusExperimenter.present();
						stimulusMonkey.present();
					elseif showImmediateCorrectFeedback == true then
						experimenterRightStimulusChoiceEllipse.set_color(incorrectlyChoosingColorR, incorrectlyChoosingColorG, incorrectlyChoosingColorB, 255);
						monkeyRightStimulusChoiceEllipse.set_color(incorrectlyChoosingColorR, incorrectlyChoosingColorG, incorrectlyChoosingColorB, 255);
						experimenterRightStimulusChoiceEllipse.redraw();
						monkeyRightStimulusChoiceEllipse.redraw();
						stimulusExperimenter.present();
						stimulusMonkey.present();
					end;
				
					loop until #Loop until the holding time is over or the monkey stopped touching
							((clock.time()-holdticker) > buttonTouchTime ) || monkeyTouching == false
					begin 
						rightButtonV =card.read_analog(rV); # Sample the button voltage
						
						# If the monkey releases the button, set 'monkeyTouching' to false
						if rightButtonV < voltageThreshold then monkeyTouching = false end;
					end; 
				end;
				
				if monkeyTouching ==  true then
					stimulusMonkey.set_part_x(6, rightStimulusXPosition);
					stimulusMonkey.set_part_y(6, stimulusYPosition);
					stimulusExperimenter.set_part_x(6, rightStimulusXPosition);
					stimulusExperimenter.set_part_y(6, stimulusYPosition);
					
					
					if showCorrectOrIncorrectFeedback == true && trialRightButton == 2 then
						experimenterRightStimulusChoiceEllipse.set_color(correctColorR, correctColorG, correctColorB, 255);
						monkeyRightStimulusChoiceEllipse.set_color(correctColorR, correctColorG, correctColorB, 255);
					elseif showCorrectOrIncorrectFeedback == true then
						experimenterRightStimulusChoiceEllipse.set_color(incorrectColorR, incorrectColorG, incorrectColorB, 255);
						monkeyRightStimulusChoiceEllipse.set_color(incorrectColorR, incorrectColorG, incorrectColorB, 255);
					else
						experimenterRightStimulusChoiceEllipse.set_color(touchColorR, touchColorG, touchColorB, 127);
						monkeyRightStimulusChoiceEllipse.set_color(touchColorR, touchColorG, touchColorB, 127);
					end;
					
					experimenterRightStimulusChoiceEllipse.redraw();
					monkeyRightStimulusChoiceEllipse.redraw();
					stimulusExperimenter.present();
					stimulusMonkey.present();
					monkeyResponseStr = "Right";
					rightButtonPresses = rightButtonPresses + 1;
				end
			end;
			
		end; # End stimulus presentation loop
		
		if 
			trialLeftButton == 2 && monkeyResponseStr == "Left"
		then 
			giveJuiceReward(leftJuiceRewardDrops);
			wait_interval(750);
			presentCorrectFeedback();
			
			monkeyResponseStr = "Correct";
		elseif 
			trialCenterButton == 2 && monkeyResponseStr == "Center" 
		then 
			giveJuiceReward(centerJuiceRewardDrops);
			wait_interval(750);
			presentCorrectFeedback();
			monkeyResponseStr = "Correct";
		elseif 
			trialRightButton == 2  && monkeyResponseStr == "Right"
		then 
			giveJuiceReward(rightJuiceRewardDrops);
			wait_interval(750);
			presentCorrectFeedback();
			monkeyResponseStr = "Correct";
		elseif
			monkeyResponseStr != "Ignored"
		then
			wait_interval(750);
			monkeyResponseStr = "Missed";
			if
				giveIncorrectFeedbackOnMissed == true
			then
				presentIncorrectFeedback();
			end;	
		else
			wait_interval(750);
			monkeyResponseStr = "Ignored";
			if
				giveIncorrectFeedbackOnIgnore == true
			then
				presentIncorrectFeedback();
			end;
			
		end; 
	else
		
	end;
	
	
	# Return the monkey's response
	return monkeyResponseStr;
end;

# ------------------ Main trial loop ------------------

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
	#encode(magicNumberCode);
	magicNumber = random(1, 255);
	wait_interval(10);
	#encode(magicNumber);
	logFile.print(string(magicNumber) + "\t");
	wait_interval(10);
	
	magicNumberIdx = magicNumberIdx + 1;
end; 

logFile.print("\n");

# Mark that we are starting the main task
#encode(taskStartCode);
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
		
		#Get the value (NOT index) of the current condition 
		currentConditionVal = ordered_cnds_to_show[currentConditionIdx];
		
		#Print trial information out to terminal
		term.print_line( "\nBlock: " + string (currentBlock) + "\tCondition: " + string(currentConditionVal) + "\tAttempt: " + string(trialsAttempted));
		
		# Mark the current condition
		#encode(cndNumIDCode);
		wait_interval(25);
		#encode(conditionOffsetValue+currentConditionVal);
		wait_interval(25);
		
		#Print the trial information to the log file
		logFile.print( "Trl:\t"+string(trialsAttempted)+"\t" ); 
		logFile.print( "Blk:\t"+string(currentBlock)+"\t" );  
		logFile.print( "Cnd:\t"+string(currentConditionVal)+"\t" );  

		#Increment the trial counter
		trialsAttempted = trialsAttempted +1;
		
		#These two strings track the monkey's response to different parts of the trial
		string stimulusResponse = "";
		
		#Mark the start of this trial
		trialStartTime = clock.time();
		
		#Present the stimulus period
		stimulusResponse = presentStimulus();
		
		term.print_line( "Response: "+ stimulusResponse );
			
		if #If there was a correct response
			stimulusResponse == "Correct"
		then
			#Increment the good button counter
			trialsCompleted = trialsCompleted + 1;
			
			# Present the correct ITI period
			presentITI(correctItiDuration );
			
			# Advance the condition
			currentConditionIdx=currentConditionIdx+1;
			
		elseif # If the monkey missed any of the targets
			stimulusResponse == "Missed"
		then
			#Increment the missed button counter
			missedTrials = missedTrials + 1;
			
			# Present the correct ITI period
			presentITI(missedItiDuration );
			
			# If we are ignoring incorrect trials, advance to the next condition
			if onErrorBehav == "ignore" then currentConditionIdx=currentConditionIdx+1; end;
		
		elseif # If the monkey missed any of the targets
			stimulusResponse == "Hold"
		then
			#Increment the missed button counter
			holdTrials = holdTrials + 1;
			
			# Present the correct ITI period
			presentITI(holdItiDuration );
			
			# If we are ignoring incorrect trials, advance to the next condition
			if onErrorBehav == "ignore" then currentConditionIdx=currentConditionIdx+1; end;
			
		else
			#Increment the ignored button counter
			ignoredTrials = ignoredTrials + 1;

			# Present the correct ITI period
			presentITI(ignoredItiDuration );

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
		
		#Print trial information out to terminal
		term.print_line( "Completed trials: " + string( trialsCompleted ) + "/" + string(trialsAttempted) + "   Missed trials: " + string( missedTrials ) + "/" + string(trialsAttempted) + "   Ignored trials: " + string( ignoredTrials ) + "/" + string(trialsAttempted) + "   Holding Trials: " + string( holdTrials ) + "/" + string(trialsAttempted));
		term.print_line( "\n");
		
	end; # End of condition loop
	
	# Increment the current trial counter
	currentBlock = currentBlock + 1;
	
end; # End of block loop

#Close the log file
logFile.print( "PROGRAM EXIT" );   
logFile.close();

# Mark that we are finished the main task
#encode(taskEndCode);

#Print out behavior information in terminal
term.print_line( " Correct Buttons: " + string( trialsCompleted ) + "/" + string(trialsAttempted));
term.print_line( "  Missed Buttons: " + string( missedTrials ) + "/" + string(trialsAttempted) );
term.print_line( " Ignored Buttons: " + string( ignoredTrials ) + "/" + string(trialsAttempted) );
