#active_buttons=1;
#~~~~~~~~~~~~ SET UP PICTURES FOR THE EXPERIMENT (SDL) ~~~~~~~~~~~~~~~~~
begin;

#~~~~~~~~~~~~ fixspot pictures ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# this is the picture that the experimenter sees on the monitor during the fixspot presentation
picture{
	display_index=2;  #display this picture on the experimenter's monitor (monitor 2)
	
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
    caption = "Hello there!";
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
    caption = "Hello there!";
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
int fixspotTime=2000; #1500 # Clayton had 100 #time that monkey is allowed to get to fixspot (ms)
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
end;#loop i=1 until i>(num_items) begin  #loop through each line in the item file
   #current_filename=fil.get_line();	#get the list of characters that compose the current line in the itm file
 	#fixspotXs[i]=int(double(current_filename.substring(fixspotX_index,4))); #get just the item filename from that line
   #fixspotYs[i]=int(double(current_filename.substring(fixspotY_index,4))); #get just the item filename from that line
	#i=i+1;	#increment the counter                 
#end;

#~~~~~~~~~~ DETERMINE WHAT CONDITIONS ARE TO BE SHOWN (BASED ON EXP. PARAMETERS FILE) ~~~~~~~
array<int>cnds_to_show[0];	#create an array that we'll fill with the conditions we want to show
temp_name=exp_info.get_line();	#get the 5th line of the experimental parameters file (conditions to show)
if (temp_name.find("all")!=0) then	#if the word "all" is typed in the condition line then...
	array<int>cnds_temp[num_items];	#create an array the length of all cnds
	cnds_temp.fill(1, num_items, 1, 1);	#fill the array with all cnds in order
	cnds_to_show.append(cnds_temp);	#append the cnd array to the global cnd array
elseif (temp_name.find("-->")!=0) then	#if an arrow --> is typed in the condition line then...
	int start_cnd = int(double(temp_name.substring(temp_name.find("-->")-2,2)));	#get the number before the arrow
	int end_cnd = int(double(temp_name.substring(temp_name.find("-->")+3,2)));	#get the number after the arrow
	array<int>cnds_temp[end_cnd-start_cnd+1];#create an array the length of the number of cnds in the range
	cnds_temp.fill(1, end_cnd-start_cnd+1, start_cnd, 1);	#fill the array with cnds in the specified range
	cnds_to_show.append(cnds_temp);	#append the cnd array to the global cnd array
else	#otherwise the cnds must be specified as a list
	int start_int=temp_name.find("[");	#get the start of the list (noted by a bracket [)
	int end_int=temp_name.find("]");	#get the end of the list (noted by a bracket ])
	array<int>cnds_temp[int(round((1.0/3.0)*(double(end_int-start_int)-1.0)+(1.0/3.0),0))]; #create an array the length of the number of cnds specified
	int j;	#create an integer counter
	loop j=1 until j>(int(round((1.0/3.0)*(double(end_int-start_int)-1.0)+(1.0/3.0),0))) begin	#loop through the cnd array
		cnds_temp[j]=int(double(temp_name.substring(start_int+3*j-2,2)));	#fill the array with the specified cnd
		j=j+1;	#increment the integer counter
	end;
	cnds_to_show.append(cnds_temp);	#append the cnd array to the global cnd array
end;

#~~~~~~~~determine the order of the conditions to be shown~~~~
string order;
temp_name=exp_info.get_line();	#get the 6th line of the experimental parameters file (condition order)
if (temp_name.find("random")!=0) then	#if the specified order is "random"
	order="random";	#then store this "random" information as a string
else
	order="incremental";	#otherwise default to "incremental" order
end;

#~~~~~~~~determine what to do with error trials~~~~
string tnext;
temp_name=exp_info.get_line();#get the 7th line of the experimental parameters file (trial order)
if (temp_name.find("delayed")!=0) then	#if the trial order is "delayed"
	tnext="delayed";	#then store this "delayed" information as a string
elseif (temp_name.find("immediate")!=0) then #if the trial order is "immediate"
	tnext="immediate";	#then store this "incremental" information as a string
else;
	tnext="ignore";	#otherwise default to "ignore" trial
end;

#~~~~~~~~~~~~~~~~~~~~~~~ PCL SUBROUTINES (FUNCTIONS) ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~ encode function ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sub array<int,1> encode(int C) begin #make a function called "encode" that takes an integer that should be encoded
array<int> encodes[2]; #initialze a variable that will hold the high and low bite of the encode
encodes[1]=mod(C,256); #determine the low bite of the encode
encodes[2]=(C-encodes[1])/256; #determine the high bite of the encode
oportData.send_code(encodes[1],2);#send the low bite through the encode cable coming from Presentation
oportPulse.send_code(128,1); #send the TTL pulse that the 1401 needs before it can see the low bite encode
wait_interval(5); # wait 5 ms, I've tried to make this shorter, but if it gets too short then we get missed encodes in Spike
oportData.send_code(encodes[2],2);#send the hihg bite through the encode cable coming from Presentation
oportPulse.send_code(128,1); #send the TTL pulse that the 1401 needs before it can see the high bite encode
wait_interval(5); # wait 5 ms
return encodes; # have the function also output the high and low bites so we can use them in the code if we need to
end;


#~~~~~~~~~~~~~~~~~~~ iti function ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sub itipres begin #the name of this function is "itipres"
	clockticker=clock.time(); #get the time
	loop until (clock.time()-clockticker)>itiDuration #continue to plot the eye on the experiment monitor until the iti time runs out
	begin
		iscan_x =iscan.read_analog(idX)*ratioX; # get the X eye position
		iscan_y =iscan.read_analog(idY)*ratioY; # get the Y eye position
		iti_copy.set_part_x( 1, iscan_x ); # set the X eye position to eyeposition of the picture
		iti_copy.set_part_y( 1, iscan_y ); # set the Y eye position to eyeposition of the picture
		iti_copy.present(); # show the eye postion on the monitor
	end;
end;


#~~~~~~~~~~~~~~~~~~~~~ SET THE FIXSPOT SIZE ~~~~~~~~~~~~~~~~~~
fixspot.set_height(fixspotsize); # set the height of the experimenter's fixspot
fixspot.set_width(fixspotsize); # set the width of the experimenter's fixspot
fixspot2.set_height(fixspotsize); # set the height of the monkey's fixspot
fixspot2.set_width(fixspotsize); # set the width of the monkey's fixspot
fixspotBoundary.set_height(fixspotsize+2*fixwin); # set the height boundary of the fixspot (the extra space the monkey is allowed)
fixspotBoundary.set_width(fixspotsize+2*fixwin); # set the width boundary of the fixspot (the extra space the monkey is allowed)
fixspotBoundaryBlack.set_height(fixspotsize+2*fixwin-2); # the above two lines will set the red box height, this is setting the black box height(see picture code for details)
fixspotBoundaryBlack.set_width(fixspotsize+2*fixwin-2); # the above two lines will st the red box width, this is setting the black box width(see picture code for details)

#~~~~~~~~~~~~~~~~~~~~~~ LOOP THROUGH AND SHOW EACH CONDITION ~~~~~~~~~~~~~~
int current_trial;	#create an integer counter for the trial number (# times each condition should be seen correctly)
int current_cnd;	#create an integer counter for the current condition being shown
array<int>cnds_to_show2[0];	#create an integer array in which we will store the randomized condition numbers
wait_interval(3000);
#loop through the experiment for the number of trials specified for each condition
loop current_trial=1 until current_trial>num_trials begin 

	#arrange the conditions for random or incremental presentation
	if order=="random" then	#if the specification of cnd order is random then...
			cnds_to_show2.resize(0);
			cnds_to_show2.append(cnds_to_show);
			cnds_to_show2.shuffle();	#...randomly shuffle the conditions
	else
			cnds_to_show2.append(cnds_to_show); #otherwise default to incremental ordering
	end;	
		
#loop through the conditions
loop current_cnd=1 until current_cnd>cnds_to_show2.count() begin	#loop so long as there is 1 condition to show

system_keyboard.set_max_length( 1 );
system_keyboard.set_time_out( 500 );
string input = system_keyboard.get_input();

		if (system_keyboard.last_input_type() != keyboard_time_out) then
			break;
		end;	
		
fixspotX=fixspotXs[cnds_to_show2[current_cnd]];
fixspotY=fixspotYs[cnds_to_show2[current_cnd]];

fixspot_copy.set_part_x( 3, fixspotX); #set the X position of the fixspot on the experimenter's monitor
fixspot_copy.set_part_y( 3, fixspotY); #set the Y position of the fixspot on the experimenter's monitor
fixspot_copy.set_part_x( 2, fixspotX); #set the X position of the black box on the experimenter's monitor
fixspot_copy.set_part_y( 2, fixspotY); #set the Y position of the black box on the experimenter's monitor
fixspot_copy.set_part_x( 1, fixspotX); #set the X position of the red box on the experimenter's monitor
fixspot_copy.set_part_y( 1, fixspotY); #set the Y position of the red box on the experimenter's monitor
fixspot_real.set_part_x( 1, fixspotX); #set the X position of the fixspot on the monkey's monitor
fixspot_real.set_part_y( 1, fixspotY); #set the Y position of the fixspot on the monkey's monitor

trialCounter[cnds_to_show2[current_cnd]]=trialCounter[cnds_to_show2[current_cnd]]+1;

trialInfo="Condition: ";
trialInfo.append(string(cnds_to_show2[current_cnd]));
trialInfo.append("\nTrial#: ");
trialInfo.append(string(trialCounter[cnds_to_show2[current_cnd]]));

if totalFixspots==0.0 then;
trialInfo.append("\nLooked at fixspot:          \nMaintained fixation on fixspot:          ");
else;
trialInfo.append("\nLooked at fixspot: ");
trialInfo.append(string(round((100.0-(fail2look/totalFixspots*100.0)),1)));
trialInfo.append("% (");
trialInfo.append(string(totalFixspots));
trialInfo.append(")\nMaintained fixation on fixspot: ");
if (totalFixspots-fail2look)==0.0 then;
trialInfo.append("NaN%");
else;
trialInfo.append(string(round((100.0-(fail2hold/(totalFixspots-fail2look)*100.0)),1)));
trialInfo.append("% (");
trialInfo.append(string(totalFixspots-fail2look));
trialInfo.append(")");
end;
end;
text1.set_caption(trialInfo);
text2.set_caption(trialInfo);
text1.redraw();
text2.redraw();


#~~~~~~~~~~~~~~~~ PRESENT THE FIXSPOT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fixspot_copy.present(); #present the fixspot copy on the users screen
fixspot_real.present(); #present the fixspot on the monkeys screen
encode(35); #encode fixspot on (because of the encode time delay, the encode should be sent after the fixspot is presented
encode(1000+int(double(cnds_to_show2[current_cnd])));


#~~~~~~~~ WAIT FOR THE MONKEY TO LOOK AT THE FIXSPOT ~~~~~~~~~~~~~~~~~~l
iscan_x =iscan.read_analog(idX)*ratioX; # get the X eye position
iscan_y =iscan.read_analog(idY)*ratioY; # get the Y eye position
clockticker=clock.time(); #get the time
#as long as the monkey isn't looking at the fixspot AND he hasn't run out of time yet, keep checking the eye
loop until iscan_x<double(fixspotX+fixspotsize/2+fixwin) && iscan_x>double(fixspotX-fixspotsize/2-fixwin) &&
iscan_y<double(fixspotY+fixspotsize/2+fixwin) && iscan_y>double(fixspotY-fixspotsize/2-fixwin) ||
(clock.time()-clockticker)>fixspotTime #conditional statement about eye postion and time
begin
	iscan_x =iscan.read_analog(idX)*ratioX; # get the X eye position
	iscan_y =iscan.read_analog(idY)*ratioY; # get the Y eye position
	fixspot_copy.set_part_x( 4, iscan_x );  # set the X eye position to eyeposition of the picture
	fixspot_copy.set_part_y( 4, iscan_y );  # set the Y eye position to eyeposition of the picture
	fixspot_copy.present();  # show the eye position on the monitor
end;

#~~~~~~ IF THE MONKEY DIDN'T LOOK AT THE FIXSPOT BEGIN THE ITIS ~~~~~~~~~~~~~~~`
# if the monkeys eye is not on the fixspot then...
if iscan_x>double(fixspotX+fixspotsize/2+fixwin) || iscan_x<double(fixspotX-fixspotsize/2-fixwin) ||
iscan_y>double(fixspotY+fixspotsize/2+fixwin) || iscan_y<double(fixspotY-fixspotsize/2-fixwin)
then
	encode(13);
	iti_real.present(); #present the iti to the monkey
	encode(36); #encode fixspot off (the iti is like a black picture that covers the fixspot, so the fixspot turns off when the iti begins);
   iti_copy.present(); #present the iti to the experimenter
   encode(06); #encode fail to fix
   fail2look=fail2look+1.0;
	itipres(); #monitor the eye during the iti using the subroutine function at the beginning of the PCL code
if tnext=="ignore" then current_cnd=current_cnd+1; end;


#~~~~~~ IF THE MONKEY DID LOOK AT THE FIXSPOT THEN MAKE SURE HE MAINTAINS HIS FIXATION ~~~~~~~~~~~~~~~`
else
	clockticker=clock.time(); # get the time
	encode(14);
	# contine to monitor the eye until it leaves the fixspot or the timer runs out
	loop until iscan_x>double(fixspotX+fixspotsize/2+fixwin) || iscan_x<double(fixspotX-fixspotsize/2-fixwin) ||
	iscan_y>double(fixspotY+fixspotsize/2+fixwin) || iscan_y<double(fixspotY-fixspotsize/2-fixwin) ||
	(clock.time()-clockticker)>fixationDuration
	begin
		iscan_x =iscan.read_analog(idX)*ratioX; # get the X eye position
		iscan_y =iscan.read_analog(idY)*ratioY; # get the Y eye position
		fixspot_copy.set_part_x( 4, iscan_x ); # set the X eye position to eyeposition of the picture
		fixspot_copy.set_part_y( 4, iscan_y ); # set the Y eye position to eyeposition of the picture
		fixspot_copy.present(); # show the eye position on the monitor
	end;
	
	
	
#~~~~~~~~~~~~~~~~ IF THE MONKEY LOOKED AWAY FROM THE FIXSPOT BEFORE TIME WAS UP, BEGIN THE ITI ~~~~~~
# if the monkey's eye is outside the fixspot then...	
if iscan_x>double(fixspotX+fixspotsize/2+fixwin) || iscan_x<double(fixspotX-fixspotsize/2-fixwin) ||
	iscan_y>double(fixspotY+fixspotsize/2+fixwin) || iscan_y<double(fixspotY-fixspotsize/2-fixwin)
	then
		iti_real.present(); #present the iti to the monkey
		encode(36); #encode fixspot off;
		iti_copy.present(); #present the iti to the experimenter
		encode(05); #encode fail to hold
		fail2hold=fail2hold+1.0;
		iti_copy.set_part_x( 1, iscan_x ); # set the X eye position to eyeposition of the picture
		iti_copy.set_part_y( 1, iscan_y ); # set the Y eye position to eyeposition of the picture
		itipres(); #monitor the eye during the iti using the subroutine function at the beginning of the PCL code
		if tnext=="ignore" then current_cnd=current_cnd+1; end;


#~~~~~~~~~~~~~~~~ IF THE MONKEY MAINTAINED HIS FIXATION FOR THE REQUIRED AMOUNT OF TIME THEN GIVE JUICE AND BEGIN THE ITI ~~~~~~~~
	else
		iti_real.present(); #present the iti to the monkey
		encode(36); #encode fixspot off;
		iti_copy.present(); #present the iti to the experimenter
		encode(03); #encode juice reward
		int nojo=1;
		loop until nojo>numberOfJuiceDrops begin;
		oportJuice.send_code(1,1);#give juice to the monkey
		wait_interval(110);
		nojo=nojo+1;
		end;
		iti_copy.set_part_x( 1, iscan_x ); # set the X eye position to eyeposition of the picture
		iti_copy.set_part_y( 1, iscan_y ); # set the Y eye position to eyeposition of the picture
	   itipres(); #monitor the eye during the iti etc.
		current_cnd=current_cnd+1;
	end;
	if (system_keyboard.last_input_type() != keyboard_time_out) then
			break;
		end;	
end;
totalFixspots=totalFixspots+1.0;
end;
current_trial=current_trial+1;
end;
# the experiment is done, release the DIO device that was tracking the eye position
iscan.release_analog_input(idX); # release the X eye postion
iscan.release_analog_input(idY); # release the Y eye position
