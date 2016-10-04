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


#Button stimulus to show the experimenter
picture{

	#display this picture on the experimenter's monitor (monitor 2)
	display_index=2;
	
	# 1
	box {color = 0,255,0;height=250;width=250;display_index=2;}experimenterLeftButtonCue;
	x=-500; y=0;  			# The position of the experimenter's button cue
	
	# 2
	box {color = 0,255,0;height=250;width=250;display_index=2;}experimenterCenterButtonCue;
	x=0; y=0;  			# The position of the experimenter's button cue
	
	# 3
	box {color = 0,255,0;height=250;width=250;display_index=2;}experimenterRightButtonCue;
	x=300; y=0;  			# The position of the experimenter's button cue

	
	text { caption = "Button_Info"; display_index=2;} buttonTextStimulus;
	x = 400; y = -300; # String to display button position
	
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
	
	# 2
	box {color = 0,255,0;height=250;width=250;display_index=1;}monkeyCenterButtonCue;
	x=0; y=0;  			# The position of the experimenter's button cue
	
	# 3
	box {color = 0,255,0;height=250;width=250;display_index=1;}monkeyRightButtonCue;
	x=300; y=0;  			# The position of the experimenter's button cue
	
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
	
	box {color=0,0,255;height=10;width=10;display_index=2;}itibuttonMarker;
	x=5000; y=5000;		# The button position is updated throughout
	on_top=true; 			# plot the button positon on the top layer of the picture
	
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
int stimulusHeight	=	250;				# Height of stimulus (pixels)341
int stimulusWidth	=	250;					# Width of stimulus (pixels)512
int stimulusDuration	=	10000; 				# time that monkey is allowed to get to button box (ms) per trial
int correctItiDuration	=	3000; 		# Duration of the inter-trial-interval(ms)for correct trials
int missedItiDuration	=	3000;		 	# Duration of the inter-trial-interval(ms) for missed trials
int holdItiDuration	=	100;		 	# Duration of the inter-trial-interval(ms) for holding the button before the trial
int ignoredItiDuration   =	3000;			# Duration of the inter-trial-interval(ms) for ignored trials
int feedbackLength = 250; 					 # Time (ms) per trial which the monkey gets visual feedback of correct or incorrect response
int buttonTouchTime = 0;					# Time (ms) the monkey has to touch the button for to make a response
int cueTouchTime = 1000;					# Time (ms) the monkey has to touch the starting cue for to make a response
int leftStimulusXPosition = -400;		# X position of left stimulus (in pixels)
int centerStimulusXPosition = 0;		# X position of left stimulus (in pixels)
int rightStimulusXPosition = 400;		# X position of right stimulus (in pixels)
int stimulusYPosition = 250;				# Y position of both stimuli (in pixels)
int numMagicNumbers = 5;					# Number of magic numbers to log/encode out
string taskName = "ButtonTrain";  # String of task name
double voltageThreshold = 1.0;	# Voltage threshold the sensor needs to reach before being considered active (they should hover around +/- mV and go to +5V if wired correctly)
int juiceRewardDrops = 5;				# Number of drops of juice to give the monkey when a correct button is pressed
bool catchHolding	= true;				#Set 'true' for the program to catch when a button is being held before trial start
bool pauseTrialUntilStopHolding = true; #Set 'true' for the program to pause a trial when a button is being held before trial start, requires (catchHolding == true), if false the trial is aborted
bool giveIncorrectFeedbackOnIgnore = false; #Set 'true' for the program to provide incorrect feedback when a trial is ignored
bool giveIncorrectFeedbackOnMissed = false; #Set 'true' for the program to provide incorrect feedback when the wrong button is pressed
bool giveIncorrectFeedbackOnHold = false; #Set 'true' for the program to provide incorrect feedback when a button is being held before trial start, requires (catchHolding == true)

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
			monkeyLeftButtonCue.set_color(211, 211, 211);
			experimenterLeftButtonCue.set_color(211, 211, 211);
		elseif 
			trialLeftButton == 2
		then
			leftButtonTrials = leftButtonTrials +1;
			monkeyLeftButtonCue.set_color(0, 0, 255);
			experimenterLeftButtonCue.set_color(0, 0, 255);
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
			monkeyCenterButtonCue.set_color(211, 211, 211);
			experimenterCenterButtonCue.set_color(211, 211, 211);
		elseif 
			trialCenterButton == 2
		then
			centerButtonTrials = centerButtonTrials +1;
			monkeyCenterButtonCue.set_color(0, 0, 255);
			experimenterCenterButtonCue.set_color(0, 0, 255);
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
			monkeyRightButtonCue.set_color(211, 211, 211);
			experimenterRightButtonCue.set_color(211, 211, 211);
		elseif 
			trialRightButton == 2
		then
			rightButtonTrials = rightButtonTrials +1;
			monkeyRightButtonCue.set_color(0, 0, 255);
			experimenterRightButtonCue.set_color(0, 0, 255);
		end;
	else
		stimulusMonkey.set_part_x(3, 9999);
		stimulusMonkey.set_part_y(3, 9999);
		stimulusExperimenter.set_part_x(3, 9999);
		stimulusExperimenter.set_part_y(3, 9999);
	end;
	
	bool endStimulusPresentation = false;
	
	leftButtonV =card.read_analog(lV); 
	centerButtonV =card.read_analog(cV);
	rightButtonV =card.read_analog(rV);
	
	bool presentTrial = false;
	
	if 
		catchHolding == true 
	then
			if  
				leftButtonV < voltageThreshold && centerButtonV < voltageThreshold && rightButtonV < voltageThreshold
			then
				presentTrial = true;
			else
				monkeyResponseStr = "Hold";
				
				if
					giveIncorrectFeedbackOnHold == true
				then
						presentIncorrectFeedback();
				end;
				
				if
					pauseTrialUntilStopHolding == true
				then
					
					loop until # Loop until the ITI is over
						leftButtonV < voltageThreshold && centerButtonV < voltageThreshold && rightButtonV < voltageThreshold
					begin
						leftButtonV =card.read_analog(lV); 
						centerButtonV =card.read_analog(cV);
						rightButtonV =card.read_analog(rV);
					end; 
				end;

			end;
			
	else
		presentTrial = true;
	end;
	
	if # If we are to present a start cue on this condition
		trialCue > 0
	then
	end;
	
	
	
	# Get the current time
	clockticker=clock.time();
	
	if 
		presentTrial == true
	then
		
		
		stimulusExperimenter.present();
		stimulusMonkey.present();
		
		loop until # Loop until the ITI is over
				((clock.time()-clockticker) > stimulusDuration) || monkeyResponseStr != "Ignored"
		begin
			leftButtonV =card.read_analog(lV); 
			centerButtonV =card.read_analog(cV);
			rightButtonV =card.read_analog(rV);
			
			if 
				trialLeftButton > 0 && leftButtonV > voltageThreshold
			then
				holdticker=clock.time();
				
				bool monkeyStillTouching = true;
				
				if buttonTouchTime > 0 then
					loop until # Loop until the ITI is over
							((clock.time()-clockticker) > buttonTouchTime ) || monkeyStillTouching == false
					begin
						leftButtonV =card.read_analog(lV);
						
						if leftButtonV < voltageThreshold then monkeyStillTouching = false end;
					end; 
				end;
				
				if monkeyStillTouching ==  true then
					monkeyLeftButtonCue.set_color(0, 255, 0);
					experimenterLeftButtonCue.set_color(0, 255, 0);
					stimulusExperimenter.present();
					stimulusMonkey.present();
					monkeyResponseStr = "Left";
					leftButtonPresses = leftButtonPresses + 1;
				end
			end;
			
			if 
				trialCenterButton > 0 && centerButtonV > voltageThreshold
			then
				holdticker=clock.time();
				
				bool monkeyStillTouching = true;
				
				if buttonTouchTime > 0 then
					loop until # Loop until the ITI is over
							((clock.time()-clockticker) > buttonTouchTime ) || monkeyStillTouching == false
					begin
						centerButtonV =card.read_analog(cV);
						
						if centerButtonV < voltageThreshold then monkeyStillTouching = false end;
					end; 
				end;
				
				if monkeyStillTouching ==  true then
					monkeyCenterButtonCue.set_color(0, 255, 0);
					experimenterCenterButtonCue.set_color(0, 255, 0);
					stimulusExperimenter.present();
					stimulusMonkey.present();
					monkeyResponseStr = "Center";
					centerButtonPresses = centerButtonPresses + 1;
				end
				
			end;
			
			if 
				trialRightButton > 0 && rightButtonV > voltageThreshold
			then
				holdticker=clock.time();
				
				bool monkeyStillTouching = true;
				
				if buttonTouchTime > 0 then
					loop until # Loop until the ITI is over
							((clock.time()-clockticker) > buttonTouchTime ) || monkeyStillTouching == false
					begin
						rightButtonV =card.read_analog(rV);
						
						if rightButtonV < voltageThreshold then monkeyStillTouching = false end;
					end; 
				end;
				
				if monkeyStillTouching ==  true then
					monkeyRightButtonCue.set_color(0, 255, 0);
					experimenterRightButtonCue.set_color(0, 255, 0);
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
			wait_interval(250);
			presentCorrectFeedback();
			giveJuiceReward(juiceRewardDrops);
			monkeyResponseStr = "Correct";
		elseif 
			trialCenterButton == 2 && monkeyResponseStr == "Center" 
		then 
			wait_interval(250);
			presentCorrectFeedback();
			giveJuiceReward(juiceRewardDrops);
			monkeyResponseStr = "Correct";
		elseif 
			trialRightButton == 2  && monkeyResponseStr == "Right"
		then 
			wait_interval(250);
			presentCorrectFeedback();
			giveJuiceReward(juiceRewardDrops);
			monkeyResponseStr = "Correct";
		elseif
			monkeyResponseStr != "Ignored"
		then
			wait_interval(250);
			monkeyResponseStr = "Missed";
			if
				giveIncorrectFeedbackOnMissed == true
			then
				presentIncorrectFeedback();
			end;	
		else
			wait_interval(250);
			monkeyResponseStr = "Ignored";
			if
				giveIncorrectFeedbackOnIgnore == true
			then
				presentIncorrectFeedback();
			end;
			
		end; 
	end;
	
	
	
	#Move the button cue into place
	
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
