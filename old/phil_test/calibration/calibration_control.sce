#active_buttons=1;
#~~~~~~~~~~~~ SET UP PICTURES FOR THE EXPERIMENT (SDL) ~~~~~~~~~~~~~~~~~
begin;



#~~~~~~~~~~~~ fixspot pictures ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# this is the picture that the experimenter sees on the monitor during the fixspot presentation
picture{
	display_index=2;  #display this picutre on the experimenter's monitor (monitor 2)
	
	#draw a red box, this is the fixspot boundary, height/width are temporary and are updated later
	box {color = 255,0,0;height=10;width=10;display_index=2;}fixspotBoundary;
	x=0; y=0;  #the position of the fixspot boundary, this is updated according to the condition

	#draw a black box, this is still part of the fixspot boundary, height/width are temporary and are updated later
	box {color = 0,0,0; height=9;width=9; display_index=2;}fixspotBoundaryBlack;
	x=0; y=0; #the position of the fixspot boundary, this is updated according to the condition
	on_top=true; #draw the black box ontop of the red box: this makes a red boundary
	
	#draw a white box, this is the fixspot, height/width are temporary and are updated later
	box {color = 255,255,255;height=10;width=10;display_index=2;}fixspot;
	x=0; y=0; #the position of the fixspot, this is updated according to the condition
	on_top=true; #draw the fixspot on top layer of the picture
	
	#draw a green box, this is the eyeposition, height/width are 3 pixels
	box {color=0,255,0;height=3;width=3;display_index=2;};
	x=0; y=0; #the eye position is updated throughout the fixspot presentation
	on_top=true; # plot the eye positon on the top layer of the picture
	
	text {
    caption = "Hello pandas?";
    font_size = 10;
    width = 300;
    height = 200;
    font = "Arial Black";
    font_color = 255,255,255;
	text_align=align_left;
    background_color = 0,0,0;
	 display_index=2;
	}text1;
	x=-240; y=250;
}fixspot_copy; #the name of this picture is "fixspot_copy"

# this is the picture that the monkey sees on the monitor during the fixspot presentation
picture{
	display_index=1; #display this picture on the monkey's monitor (monitor 1)
	
	#draw a white box, this is the fixspot, height/width are temporary and are updated later
	box {color = 255,255,255;height=10;width=10;display_index=1;}fixspot2;
	x=0; y=0; #the position of the fixspot, this is updated according to the condition
}fixspot_real; #the name of this picture is "fixspot_real"




#~~~~~~~~~~~~~~~ iti pictures ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# this is the picture that the experimenter sees on the monitor during the ITI presentation
picture {
	display_index=2; #display this picutre on the experimenter's monitor (monitor 2)
	#draw a green box, this is the eyeposition, height/width are 3 pixels		
	box {color=0,255,0;height=3;width=3;display_index=2;};
	x=0; y=0; #the eye position is updated throughout the ITI
	
	text {
    caption = "Hello bear!";
    font_size = 10;
    width = 300;
    height = 200;
    font = "Arial Black";
    font_color = 255,255,255;
text_align=align_left;
    background_color = 0,0,0;
	 display_index=2;
	}text2;
	x=-240; y=250;
}iti_copy; #the name of this picture is "iti_copy"

# this is the picture that the monkey sees on the monitor during the ITI presentation
picture {
	display_index=1; #display a blank screen on the monkey's monitor (monitor 1)
	}iti_real; #the name of this picture is "iti_real"


#~~~~~~~~~~~~~~~~~~~~~~ BEGIN THE EXPERIMENT (PCL) ~~~~~~~~~~~~~~~~~
begin_pcl; # begin the pcl portion of the code

# ~~~~~~~~~~~~~~~~~~ INITIALIZATION VARIABLES AND SET THEIR VALUES ~~~~~~~~~~~~~~~~~~~~~
double monitorX=1024.0; #monitor width (pixels)
double monitorY=768.0; #monitor height (pixels)
double ratioX=((monitorX/2.0)/4.0); #ratio to multiply X voltage by (want 5Volts to be at least 1/2 the width of the monitor)
double ratioY=((monitorY/2.0)/4.0); #ratio to multiply X voltage by (want 5Volts to be at least 1/2 the height of the monitor)
int fixspotsize=7; #7  # size of fixspot (pixels)
int fixwin=20; #20 #this is the extra room that the monkey has around the edge of the fixspot (pixels)
					# so, if fixwin is 10, then there is a leniency of 10 pixels on all sides of the fixspot
int fixspotX=0; # x-position of the fixspot (pixels)
int fixspotY=0; # y-postition of the fixspot (pixels)
int fixspotTime=1500; #1500 # Clayton had 100 #time that monkey is allowed to get to fixspot (ms)
int fixationDuration=120;#120 # time required for the monkey to maintain fixation on the fixspot (ms)
int itiDuration=3000; #duration of the inter-trial-interval (ms)
int numberOfJuiceDrops=3;	# was at 5 the duration of the juice TTL pulse
int clockticker=0; # just an integer counter to hold the clock time
array<int>trialCounter[99]; #just an integer counter to count the number of times each condition has been shown
trialCounter.fill(1,99,0,0);
double fail2look=0.0; # a counter to keep track of the number of times the monkey failed to look at the fixspot
double fail2hold=0.0; # a counter to keep track of the number of times the monkey failed to hold his gaze on the fixspot
double totalFixspots=0.0; # a counter to keep track of the number of times a fixspot was presented
string trialInfo;
string input = "";
string quitTrialKey = "q";
string rewardKey = "r";
#~~~~~~~~~~~~~~~~ OPEN PORTS FOR SENDING/RECEIVING DATA ~~~~~~~~~~~~~~
output_port oportData=output_port_manager.get_port(1); # open the port to send encodes on
output_port oportPulse=output_port_manager.get_port(2); # the 1401 has to see a TTL pulse before it can receive an encode, open the port that the pulse will be sent on
output_port oportJuice=output_port_manager.get_port(2); # open the port that will send the juice TTL pulse
dio_device iscan = new dio_device(ni_dio_device, 1, 0); # initialize the analog portion of the NI DIO card in the presentaiton computer
int idX = iscan.acquire_analog_input("ISCANTask,x");  # set up retrieval of the x coordinate of eye tracker
int idY = iscan.acquire_analog_input("ISCANTask,y");  # set up retrieval of the y coordinate of eye tracker
double iscan_x; # initialize variable for eye tracker x postion
double iscan_y; # initialize variable for eye tracker y postion

#~~~~~~ GET THE EXPERIMENTAL PARAMETERS ~~~~~~~~~~~~~~~~~~~~
string exp_par="calibration_parameters.txt"; #the name of the text file with the experiment information
input_file exp_info = new input_file;	#create an input file
exp_info.open( exp_par );	#load the experimental parameters into the input file
string temp_name;	#create a string variable for temporary use
temp_name=exp_info.get_line();	#get the first line of the experimental file (item file)
string item_file=temp_name.substring(12,temp_name.count()-11);	#filename of the item file
temp_name=exp_info.get_line();  	#get the next line (just dashes) and ignore
temp_name=exp_info.get_line();	#get the 4th line (number of trials)
int num_trials=int(double(temp_name.substring(temp_name.count()-1,2)));	#write down the number of trials to be shown

#~~~~~~~~~ LOAD THE FIXSPOT POSITIONS FROM THE ITM FILE ~~~~~~~~~~~~
int i; int fixspotX_index; int fixspotY_index; #create counter variables													
string current_filename;	#create a string variable for the item names
input_file fil = new input_file;   #create an input file
fil.open( item_file );	#load the item file data into the input file
current_filename=fil.get_line();	#get the first line of the item file (column headers)
fixspotX_index=current_filename.find("fixX");
fixspotY_index=current_filename.find("fixY");

int num_items=int(double(current_filename.substring(current_filename.find("totalitems=")+11,2))); #assign how many items there are to a avariable
array<int>fixspotXs[num_items];	#create an array which will contain the start frame of each movie
array<int>fixspotYs[num_items];	#create an array which will contain the end frame of each movie
loop i=1 until i>(num_items) begin  #loop through each line in the item file
   current_filename=fil.get_line();	#get the list of characters that compose the current line in the itm file
 	fixspotXs[i]=int(double(current_filename.substring(fixspotX_index,4))); #get just the item filename from that line
   fixspotYs[i]=int(double(current_filename.substring(fixspotY_index,4))); #get just the item filename from that line
	i=i+1;	#increment the counter                 
end;

system_beep(500, 50);

loop
	
until
	input == quitTrialKey
begin
	system_keyboard.set_max_length( 1 );
	system_keyboard.set_time_out( 5000 );
	input = system_keyboard.get_input();
	

	trialInfo = "Key: ";
	trialInfo.append(input);
	#trialInfo.append(" (Press 'q' to quit)");
	text2.set_caption(trialInfo);
	text2.redraw();
	iti_copy.present(); #present the fixspot copy on the users screen


	
	if input == rewardKey then; #If the key pressed is 'r', send juice commands
		trialInfo = "Reward! :-)";
		text2.set_caption(trialInfo);
		text2.redraw();
	iti_copy.present(); #present the fixspot copy on the users screen

		oportJuice.send_code(1,1);
	end;
	
	if input == " " then; #If the key pressed is space, change to blank screen
		trialInfo = "Clear screen";
		text2.set_caption(trialInfo);
		text2.redraw();
		iti_real.present();
		iti_copy.present();
	end;
	
	if input == "1" then;
		trialInfo = "Fixspot: ";
		trialInfo.append(input);
		text1.set_caption(trialInfo);
		text1.redraw();
		fixspotX=fixspotXs[1];
		fixspotY=fixspotYs[1];
		fixspot_copy.set_part_x( 3, fixspotX); #set the X position of the fixspot on the experimenter's monitor
		fixspot_copy.set_part_y( 3, fixspotY); #set the Y position of the fixspot on the experimenter's monitor
		fixspot_copy.set_part_x( 2, fixspotX); #set the X position of the black box on the experimenter's monitor
		fixspot_copy.set_part_y( 2, fixspotY); #set the Y position of the black box on the experimenter's monitor
		fixspot_copy.set_part_x( 1, fixspotX); #set the X position of the red box on the experimenter's monitor
		fixspot_copy.set_part_y( 1, fixspotY); #set the Y position of the red box on the experimenter's monitor
		fixspot_real.set_part_x( 1, fixspotX); #set the X position of the fixspot on the monkey's monitor
		fixspot_real.set_part_y( 1, fixspotY); #set the Y position of the fixspot on the monkey's monitor
		fixspot_copy.present(); #present the fixspot copy on the users screen
		fixspot_real.present(); #present the fixspot on the monkeys screen
	end;
	
	if input == "2" then;
		trialInfo = "Fixspot: ";
		trialInfo.append(input);
		text1.set_caption(trialInfo);
		text1.redraw();
		fixspotX=fixspotXs[2];
		fixspotY=fixspotYs[2];
		fixspot_copy.set_part_x( 3, fixspotX); #set the X position of the fixspot on the experimenter's monitor
		fixspot_copy.set_part_y( 3, fixspotY); #set the Y position of the fixspot on the experimenter's monitor
		fixspot_copy.set_part_x( 2, fixspotX); #set the X position of the black box on the experimenter's monitor
		fixspot_copy.set_part_y( 2, fixspotY); #set the Y position of the black box on the experimenter's monitor
		fixspot_copy.set_part_x( 1, fixspotX); #set the X position of the red box on the experimenter's monitor
		fixspot_copy.set_part_y( 1, fixspotY); #set the Y position of the red box on the experimenter's monitor
		fixspot_real.set_part_x( 1, fixspotX); #set the X position of the fixspot on the monkey's monitor
		fixspot_real.set_part_y( 1, fixspotY); #set the Y position of the fixspot on the monkey's monitor
		fixspot_copy.present(); #present the fixspot copy on the users screen
		fixspot_real.present(); #present the fixspot on the monkeys screen
	end;
	
	if input == "3" then;
		trialInfo = "Fixspot: ";
		trialInfo.append(input);
		text1.set_caption(trialInfo);
		text1.redraw();
		fixspotX=fixspotXs[3];
		fixspotY=fixspotYs[3];
		fixspot_copy.set_part_x( 3, fixspotX); #set the X position of the fixspot on the experimenter's monitor
		fixspot_copy.set_part_y( 3, fixspotY); #set the Y position of the fixspot on the experimenter's monitor
		fixspot_copy.set_part_x( 2, fixspotX); #set the X position of the black box on the experimenter's monitor
		fixspot_copy.set_part_y( 2, fixspotY); #set the Y position of the black box on the experimenter's monitor
		fixspot_copy.set_part_x( 1, fixspotX); #set the X position of the red box on the experimenter's monitor
		fixspot_copy.set_part_y( 1, fixspotY); #set the Y position of the red box on the experimenter's monitor
		fixspot_real.set_part_x( 1, fixspotX); #set the X position of the fixspot on the monkey's monitor
		fixspot_real.set_part_y( 1, fixspotY); #set the Y position of the fixspot on the monkey's monitor
		fixspot_copy.present(); #present the fixspot copy on the users screen
		fixspot_real.present(); #present the fixspot on the monkeys screen
	end;
	
	if input == "4" then;
		trialInfo = "Fixspot: ";
		trialInfo.append(input);
		text1.set_caption(trialInfo);
		text1.redraw();
		fixspotX=fixspotXs[4];
		fixspotY=fixspotYs[4];
		fixspot_copy.set_part_x( 3, fixspotX); #set the X position of the fixspot on the experimenter's monitor
		fixspot_copy.set_part_y( 3, fixspotY); #set the Y position of the fixspot on the experimenter's monitor
		fixspot_copy.set_part_x( 2, fixspotX); #set the X position of the black box on the experimenter's monitor
		fixspot_copy.set_part_y( 2, fixspotY); #set the Y position of the black box on the experimenter's monitor
		fixspot_copy.set_part_x( 1, fixspotX); #set the X position of the red box on the experimenter's monitor
		fixspot_copy.set_part_y( 1, fixspotY); #set the Y position of the red box on the experimenter's monitor
		fixspot_real.set_part_x( 1, fixspotX); #set the X position of the fixspot on the monkey's monitor
		fixspot_real.set_part_y( 1, fixspotY); #set the Y position of the fixspot on the monkey's monitor
		fixspot_copy.present(); #present the fixspot copy on the users screen
		fixspot_real.present(); #present the fixspot on the monkeys screen
	end;
	
	if input == "5" then;
		trialInfo = "Fixspot: ";
		trialInfo.append(input);
		text1.set_caption(trialInfo);
		text1.redraw();
		fixspotX=fixspotXs[5];
		fixspotY=fixspotYs[5];
		fixspot_copy.set_part_x( 3, fixspotX); #set the X position of the fixspot on the experimenter's monitor
		fixspot_copy.set_part_y( 3, fixspotY); #set the Y position of the fixspot on the experimenter's monitor
		fixspot_copy.set_part_x( 2, fixspotX); #set the X position of the black box on the experimenter's monitor
		fixspot_copy.set_part_y( 2, fixspotY); #set the Y position of the black box on the experimenter's monitor
		fixspot_copy.set_part_x( 1, fixspotX); #set the X position of the red box on the experimenter's monitor
		fixspot_copy.set_part_y( 1, fixspotY); #set the Y position of the red box on the experimenter's monitor
		fixspot_real.set_part_x( 1, fixspotX); #set the X position of the fixspot on the monkey's monitor
		fixspot_real.set_part_y( 1, fixspotY); #set the Y position of the fixspot on the monkey's monitor
		fixspot_copy.present(); #present the fixspot copy on the users screen
		fixspot_real.present(); #present the fixspot on the monkeys screen
	end;
	
	if input == "6" then;
		trialInfo = "Fixspot: ";
		trialInfo.append(input);
		text1.set_caption(trialInfo);
		text1.redraw();
		fixspotX=fixspotXs[6];
		fixspotY=fixspotYs[6];
		fixspot_copy.set_part_x( 3, fixspotX); #set the X position of the fixspot on the experimenter's monitor
		fixspot_copy.set_part_y( 3, fixspotY); #set the Y position of the fixspot on the experimenter's monitor
		fixspot_copy.set_part_x( 2, fixspotX); #set the X position of the black box on the experimenter's monitor
		fixspot_copy.set_part_y( 2, fixspotY); #set the Y position of the black box on the experimenter's monitor
		fixspot_copy.set_part_x( 1, fixspotX); #set the X position of the red box on the experimenter's monitor
		fixspot_copy.set_part_y( 1, fixspotY); #set the Y position of the red box on the experimenter's monitor
		fixspot_real.set_part_x( 1, fixspotX); #set the X position of the fixspot on the monkey's monitor
		fixspot_real.set_part_y( 1, fixspotY); #set the Y position of the fixspot on the monkey's monitor
		fixspot_copy.present(); #present the fixspot copy on the users screen
		fixspot_real.present(); #present the fixspot on the monkeys screen
	end;
	
	if input == "7" then;
		trialInfo = "Fixspot: ";
		trialInfo.append(input);
		text1.set_caption(trialInfo);
		text1.redraw();
		fixspotX=fixspotXs[7];
		fixspotY=fixspotYs[7];
		fixspot_copy.set_part_x( 3, fixspotX); #set the X position of the fixspot on the experimenter's monitor
		fixspot_copy.set_part_y( 3, fixspotY); #set the Y position of the fixspot on the experimenter's monitor
		fixspot_copy.set_part_x( 2, fixspotX); #set the X position of the black box on the experimenter's monitor
		fixspot_copy.set_part_y( 2, fixspotY); #set the Y position of the black box on the experimenter's monitor
		fixspot_copy.set_part_x( 1, fixspotX); #set the X position of the red box on the experimenter's monitor
		fixspot_copy.set_part_y( 1, fixspotY); #set the Y position of the red box on the experimenter's monitor
		fixspot_real.set_part_x( 1, fixspotX); #set the X position of the fixspot on the monkey's monitor
		fixspot_real.set_part_y( 1, fixspotY); #set the Y position of the fixspot on the monkey's monitor
		fixspot_copy.present(); #present the fixspot copy on the users screen
		fixspot_real.present(); #present the fixspot on the monkeys screen
	end;
	
	if input == "8" then;
		trialInfo = "Fixspot: ";
		trialInfo.append(input);
		text1.set_caption(trialInfo);
		text1.redraw();
		fixspotX=fixspotXs[8];
		fixspotY=fixspotYs[8];
		fixspot_copy.set_part_x( 3, fixspotX); #set the X position of the fixspot on the experimenter's monitor
		fixspot_copy.set_part_y( 3, fixspotY); #set the Y position of the fixspot on the experimenter's monitor
		fixspot_copy.set_part_x( 2, fixspotX); #set the X position of the black box on the experimenter's monitor
		fixspot_copy.set_part_y( 2, fixspotY); #set the Y position of the black box on the experimenter's monitor
		fixspot_copy.set_part_x( 1, fixspotX); #set the X position of the red box on the experimenter's monitor
		fixspot_copy.set_part_y( 1, fixspotY); #set the Y position of the red box on the experimenter's monitor
		fixspot_real.set_part_x( 1, fixspotX); #set the X position of the fixspot on the monkey's monitor
		fixspot_real.set_part_y( 1, fixspotY); #set the Y position of the fixspot on the monkey's monitor
		fixspot_copy.present(); #present the fixspot copy on the users screen
		fixspot_real.present(); #present the fixspot on the monkeys screen
	end;
	
	if input == "9" then;
		trialInfo = "Fixspot: ";
		trialInfo.append(input);
		text1.set_caption(trialInfo);
		text1.redraw();
		fixspotX=fixspotXs[9];
		fixspotY=fixspotYs[9];
		fixspot_copy.set_part_x( 3, fixspotX); #set the X position of the fixspot on the experimenter's monitor
		fixspot_copy.set_part_y( 3, fixspotY); #set the Y position of the fixspot on the experimenter's monitor
		fixspot_copy.set_part_x( 2, fixspotX); #set the X position of the black box on the experimenter's monitor
		fixspot_copy.set_part_y( 2, fixspotY); #set the Y position of the black box on the experimenter's monitor
		fixspot_copy.set_part_x( 1, fixspotX); #set the X position of the red box on the experimenter's monitor
		fixspot_copy.set_part_y( 1, fixspotY); #set the Y position of the red box on the experimenter's monitor
		fixspot_real.set_part_x( 1, fixspotX); #set the X position of the fixspot on the monkey's monitor
		fixspot_real.set_part_y( 1, fixspotY); #set the Y position of the fixspot on the monkey's monitor
		fixspot_copy.present(); #present the fixspot copy on the users screen
		fixspot_real.present(); #present the fixspot on the monkeys screen
	end;
	
	

	

end;


# the experiment is done, release the DIO device that was tracking the eye position
iscan.release_analog_input(idX); # release the X eye postion
iscan.release_analog_input(idY); # release the Y eye position
