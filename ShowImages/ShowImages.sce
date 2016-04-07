#############################################################################################
# Scenario for showing single images in a manner similiar to CORTEX (Clayton Mosher, Katalin Gothard Lab 2012).
#
# For this scenario to run it reads three text files:
#		an item file (e.g. train8B_itm.txt)
#		a condition file (e.g. train8_cnd.txt)
#		an experimental parameters file (Train8_experimental_parameters.txt);
# The conditions that will be shown and the order they will be shown in is all specified in the
# expermental parameters file.  Bu udating and saving this file, you can change the images the monkey
# sees from one block to the next.
#
# This is a work in progress.  If you notice errors in coding or timing, please let me know.
# If you imrpove the code, let us know and we can update our version as well.
#
# Thanks for your help, Have fun and good luck,
# Clayton Mosher
# Graduate Interdisciplinary Program in Neuroscience, The University of Arizona
# Laboratory of Dr. Katalin Gothard
# (cmosher@email.arizona.edu)
# phone: (520) 626-1450
#############################################################################################


##############################################################################################
begin;	#begin SDL (defining the experiment images / trial types)
##############################################################################################

#~~~~~~~~~~~~ fixspot pictures ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# this is the picture that the experimenter sees on the monitor during the fixspot presentation
# the picture consists of a white fixspot and a red boundary demarcating a window around the fixspot
# if the monkey maintains fixation within this window then he will initate the image trial
# in addition the the fixspot the experimenter will see the monkey's eye position (green dot)
# and basic information about the experiment (e.g. % corect trials)
picture{
	display_index=2;  #display this picutre on the experimenter's monitor (monitor 2)
	#draw a red box, this is the fixspot boundary, height/width are temporary and are updated later
	
	box {color = 255,0,0;height=10;width=10;display_index=2;}fixspotBoundary;
	x=0; y=0;  #the position of the fixspot boundary, this can be edited in the PCL code

	#draw a black box, this is still part of the fixspot boundary, height/width are temporary and are updated later
	box {color = 0,0,0; height=9;width=9; display_index=2;}fixspotBoundaryBlack;
	x=0; y=0; #the position of the fixspot boundary, this can be edited in the PCL code
	on_top=true; #draw the black box ontop of the red box: this makes a red boundary
	
	#draw a white box, this is the fixspot, height/width are temporary and are updated later
	box {color = 255,255,255;height=10;width=10;display_index=2;}fixspot;
	x=0; y=0; #the position of the fixspot, this can be edited in the PCL code
	on_top=true; #draw the fixspot on top layer of the picture
	
	#draw a green box, this is the eyeposition, height/width are 3 pixels
	box {color=0,255,0;height=3;width=3;display_index=2;};
	x=0; y=0; #the eye position is updated throughout the fixspot presentation
	on_top=true; # plot the eye positon on the top layer of the picture
	
	#make an area on the monitor to display text about the progress of the experiment
	text {
    caption = "Hello there!";
    font_size = 10;
    width = 250;
    height = 100;
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
	x=0; y=0; #the position of the fixspot, this can be edited in the PCL code
}fixspot_real; #the name of this picture is "fixspot_real"


#~~~~~~~~~~~~ static image pictures ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# this is the picture that the experimenter sees on the monitor during the image presentation
# the picture consists of an image and a red boundary demarcating a window around the image
# if the monkey maintains fixation within this window then the trial will end and he will be rewarded
# in addition the the image the experimenter will see the monkey's eye position (green dot)
# and basic information about the experiment (e.g. % corect trials)
picture{
	display_index=2;  #display this picutre on the experimenter's monitor (monitor 2)
	#draw a red box, this is the image boundary, height/width are temporary and are updated later
	
	box {color = 255,0,0;height=10;width=10;display_index=2;}imageBoundary;
	x=0; y=0;  #the position of the image boundary, this is updated according to the condition

	#draw a black box, this is still part of the fixspot boundary, height/width are temporary and are updated later
	box {color = 0,0,0; height=9;width=9; display_index=2;}imageBoundaryBlack;
	x=0; y=0; #the position of the fixspot boundary, this is updated according to the condition
	on_top=true; #draw the black box ontop of the red box: this makes a red boundary
	
	#draw the static image 
	bitmap {display_index=2;filename="placeholder.bmp"; #the image will be presented
		width=300;
		height=300;}image_bmp;
		x=0; y=0;	#position of the  image on screen

	on_top=true; 
	
	#draw a green box, this is the eyeposition, height/width are 3 pixels
	box {color=0,255,0;height=10;width=10;display_index=2;};
	x=0; y=0; #the eye position is updated throughout the fixspot presentation
	on_top=true; # plot the eye positon on the top layer of the picture
	
	#make an area on the monitor to display text about the progress of the experiment
	text {
    caption = "Hello there!";
    font_size = 10;
    width = 250;
    height = 100;
    font = "Arial Black";
    font_color = 255,255,255;
	text_align=align_left;
    background_color = 0,0,0;
	 display_index=2;
	}text2;
	x=-240; y=250;
	on_top=true; 
}image_copy; #the name of this picture is "image_copy"

# this is the picture that the monkey sees on the monitor during the image presentation
picture{
	display_index=1; #display this picture on the monkey's monitor (monitor 1)
	
	#draw a white box, this is the fixspot, height/width are temporary and are updated later
	 bitmap {display_index=1;filename="placeholder.bmp"; #the image will be presented
	width=300;
		height=300;}image_bmp2;		
x=0; y=0;	#position of the  image on screen
}image_real; #the name of this picture is "image_real"



#~~~~~~~~~~~~~~~ iti pictures ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# this is the picture that the experimenter sees on the monitor during the ITI presentation
# the picture is just a blank screen with the monkey's eye position and some basic
# information about the progress of the experiment
picture {
	display_index=2; #display this picutre on the experimenter's monitor (monitor 2)
	
	#draw a green box, this is the eyeposition, height/width are 3 pixels		
	box {color=0,255,0;height=3;width=3;display_index=2;};
	x=0; y=0; #the eye position is updated throughout the ITI
	
	#make an area on the monitor to display text about the progress of the experiment
	text {
    caption = "Hello there!";
    font_size = 10;
    width = 250;
    height = 100;
    font = "Arial Black";
    font_color = 255,255,255;
text_align=align_left;
    background_color = 0,0,0;
	 display_index=2;
	}text3;
	x=-240; y=250;
}iti_copy; #the name of this picture is "iti_copy"

# this is the picture that the monkey sees on the monitor during the ITI presentation
picture {
	display_index=1; #display a blank screen on the monkey's monitor (monitor 1)
	}iti_real; #the name of this picture is "iti_real"





##############################################################################################
begin_pcl; #begin PCL (the timing file)
##############################################################################################

# ~~~~~~~~~~~~~~~~~~ INITIALIZATION VARIABLES AND SET THEIR VALUES ~~~~~~~~~~~~~~~~~~~~~
double monitorX=800.0; #monitor width (pixels)
double monitorY=600.0; #monitor height (pixels)
double ratioX=(monitorX/2.0)/4.0; #ratio to multiply ISCAN eyeX voltage by to convert volts into pixels (want 5Volts to be at least 1/2 the width of the monitor)
double ratioY=(monitorY/2.0)/4.0; #ratio to multiply ISCAN eyeY voltage by to convert volts into pixels (want 5Volts to be at least 1/2 the height of the monitor)
int fixspotsize=10;  # size of fixspot (pixels)
int fixwin=20; #this is the extra room that the monkey has around the edge of the fixspot (pixels)
					# so, if fixwin is 10, then there is a leniency of 10 pixels on all sides of the fixspot
int fixspotX=0; # x-position of the fixspot (pixels)
int fixspotY=0; # y-postition of the fixspot (pixels)
int fixspotTime=2000; # time that monkey is allowed to get to fixspot (ms)
int fixationDuration=125; # time required for the monkey to maintain fixation on the fixspot (ms)
int imageDuration=3000; # time required for the monkey to look at the image (ms)
int imagewin=40; #this is the extra room that the monkey has around the edge of the image (pixels)
					# so, if image win is 40, then there is a leniency of 10 pixels on all sides of the fixspot
int imagewidth=300; #the width that all images should be standardized to (pixels)
int imageheight=300; #the height that all images should be standardized to (pixels)
int itiDuration=3000; #duration of the inter-trial-interval (ms)
int numberOfJuiceDrops=5;	# the duration of the TTL pulse that will trigger the juice pump
int clockticker=0; # just an integer counter to hold the clock time
array<int>trialCounter[99]; #just an integer counter to count the number of times each condition has been shown
trialCounter.fill(1,99,0,0); # a counter to keep track of the number of trials that have been completed
double fail2look=0.0; # a counter to keep track of the number of times the monkey failed to look at the fixspot
double fail2hold=0.0; # a counter to keep track of the number of times the monkey failed to hold his gaze on the fixspot
double totalFixspots=0.0; # a counter to keep track of the number of times a fixspot was presented
string trialInfo;


#~~~~~~~~~~~~~~~~ OPEN PORTS FOR SENDING/RECEIVING DATA ~~~~~~~~~~~~~~
output_port oportData=output_port_manager.get_port(1); # open the port to send encodes to the Spike 2 Power 1401
output_port oportPulse=output_port_manager.get_port(2); # the Spike Power 1401 has to see a TTL pulse before it can receive an encode, open the port that the pulse will be sent on
output_port oportJuice=output_port_manager.get_port(2); # open the port that will send the juice TTL pulse
dio_device iscan = new dio_device(ni_dio_device, 1, 0); # initialize the analog portion of the NI DIO card in the presentaiton computer so that we can collect eye data
int idX = iscan.acquire_analog_input("ISCANTask,x");  # set up retrieval of the x coordinate of eye tracker from Measurement and Automation software
int idY = iscan.acquire_analog_input("ISCANTask,y");  # set up retrieval of the y coordinate of eye tracker from Measurement and Automation software
double iscan_x; # initialize variable for eye tracker x postion
double iscan_y; # initialize variable for eye tracker y postion



#********************************************************************************************
#***********************sub routines for eye tracking and encodes****************************
#********************************************************************************************

#~~~~~~get the experimental parameters~~~~~
string exp_par="ShowImages_experimental_parameters.txt"; #the name of the parameter file that contains information about itm files, cnd files
input_file exp_info = new input_file;	#create an input file
exp_info.open( exp_par );	#load the experimental parameters into the input file
string temp_name;	#create a string variable for temporary use
temp_name=exp_info.get_line();	#get the first line of the experimental file (item file)
string item_file=temp_name.substring(12,temp_name.count()-11);	#filename of the item file
temp_name=exp_info.get_line();	#get the second line of the experimental file (condition file)
string cnd_file=temp_name.substring(17,temp_name.count()-16);	#filename of the condition file
temp_name=exp_info.get_line();  	#get the next line (just dashes) and ignore
temp_name=exp_info.get_line();	#get the 4th line (number of trials)
int num_trials=int(double(temp_name.substring(temp_name.count()-1,2)));	#write down the number of trials to be shown

#~~~~~~~~~~~load the items~~~~~~~~~~~~
int i;	#create a counter variable														
string current_filename;	#create a string variable for the item names
input_file fil = new input_file;   #create an input file
fil.open( item_file );	#load the item file data into the input file
current_filename=fil.get_line();	#get the first line of the item file (column headers)
int name_index=current_filename.find("filename");
int num_items=int(double(current_filename.substring(current_filename.find("totalitems=")+11,3))); #assign how many items there are to a avariable
array<string>items[num_items];	#create an array which will contain the filenames of the items	
loop i=1 until i>(num_items) begin  #loop through each line in the item file
   current_filename=fil.get_line();	#get the list of characters that compose the current line in the itm file
	items[i]=current_filename.substring(name_index,current_filename.find(".bmp")-name_index);
	items[i].append(".bmp");  	
	i=i+1;	#increment the counter                 
end;                                

#~~~~~~~~~~~load the conditions~~~~~~~~						
string current_filename2;  #create a string variable for the condition names	
input_file fil2 = new input_file;   #create an input file
fil2.open(cnd_file);	#load the item file data into the input file
current_filename2=fil2.get_line();	#get the first line of the condition file (column headers)
int num_cnds=int(double(current_filename2.substring(current_filename2.find("totalconditions=")+16,3)));#assign how many cnds there are to a variable
int test_index=current_filename2.find("test0");
array<string>cnd[num_cnds];       #create an array which will contain the item numbers for each condition  			
loop i=1 until i>num_cnds begin	#loop through each line in the cnd file
	current_filename2=fil2.get_line();	#get the list of characters that compose the current line in the cnd file  
cnd[i]=current_filename2.substring(test_index,3);	#get just the item numbers (not the condition number) from that line		
   i=i+1;  #increment the counter                           
end;                               

#~~~~~~~~~~figure out which conditions to show~~~~~~~
array<int>cnds_to_show[0];	#create an array that we'll fill with the conditions we want to show
temp_name=exp_info.get_line();	#get the 5th line of the experimental parameters file (conditions to show)
if (temp_name.find("all")!=0) then	#if the word "all" is typed in the condition line then...
	array<int>cnds_temp[num_cnds];	#create an array the length of all cnds
	cnds_temp.fill(1, num_cnds, 1, 1);	#fill the array with all cnds in order
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

# At this point we have imported all the information from the user about what items/conditiosn to show,
# what order to show them in, etc.

#~~~~~~~~~~~~~~~~~~~~~~~ PCL SUBROUTINES (FUNCTIONS) ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~~~~~~~~~~~~~~~~~~ encode function ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sub array<int,1> encode(int C) begin #make a function called "encode" that takes an integer that should be encoded
array<int> encodes[2]; #initialze a variable that will hold the high and low bite of the encode
encodes[1]=mod(C,256); #determine the low bite of the encode
encodes[2]=(C-encodes[1])/256; #determine the high bite of the encode
oportData.send_code(encodes[1],2);#send the low bite through the encode cable coming from Presentation
oportPulse.send_code(128,1); #send the TTL pulse that the 1401 needs before it can see the low bite encode
wait_interval(5); # wait 5 ms, I've tried to make this shorter, but if it gets too shor then we get missed encodes in Spike
oportData.send_code(encodes[2],2);#send the hihg bite through the encode cable coming from Presentation
oportPulse.send_code(128,1); #send the TTL pulse that the 1401 needs before it can see the high bite encode
wait_interval(5); # wait 5 ms
return encodes; # have the function also output the high and low bites so we can use them in the code if we need to
end;

#~~~~~~~~~~~~~~~~~~~ iti function ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sub itipres begin #the name of this function is "itipres"
	clockticker=clock.time(); #get the time
	loop until (clock.time()-clockticker)>(itiDuration-500) #continue to plot the eye on the experiment monitor until the iti time runs out
	begin #note the itiDuration is 500ms less then specified because this 500 ms is made up elsewehre in th code (during the keyboard line immediately following the initaiotn of the condition loop)
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

#~~~~~~~~~~~~~~~~~~~~~ SET THE IMAGE SIZE ~~~~~~~~~~~~~~~~~~
image_bmp.set_load_size(double(imageheight),double(imagewidth),0.0);
image_bmp2.set_load_size(double(imageheight),double(imagewidth),0.0);



##############################################################################################
#~~~~~~~~loop through the conditions~~~~~
##############################################################################################
int current_trial;	#create an integer counter for the trial number (# times each condition should be seen correctly)
int current_cnd;	#create an integer counter for the current condition being shown
array<int>cnds_to_show2[0];	#create an integer array in which we will store the randomized condition numbers

array<int>cnd_correct[cnd.count()];	#create an array which will count the number of times has been correctly performed
cnd_correct.fill(1,cnd.count(),0,0);	#initialize to zero the number of times each cnd has been correctly performed
array<int>cnd_times_shown[cnd.count()];	#create an array which will count the number of times each cnd has been shown  
cnd_times_shown.fill(1,cnd.count(),0,0);	#initialize to zero the number of times each cnd has been shown
int times_fix_shown=0;	#create an integer that will count the number of times a cue has been shown, initialize to zero
int times_fix_achieved=0;	#create an integer that will count the number of times a cue has been achieved, initialize to zero
double overall_cnd_correct=0.0;	#create an integer for the number of correctly performed cnds overall; initialize to zero
double overall_cnd_shown=0.0;	#create an integer for the number of cnds shown overall; initialize to zero
double fixGood; #create a counter to count the number of successful fixations
encode(0); #encode 00 00 for start of new experiment

#loop through the experiment for the total number of trials specified (as written in paramters txt file)
#usually this is just 1 (so every condition is seen once, the experimental block ends and we start a new block)
#alternatively this could be set to a different number, e.g. 3, and then each condition will be seen multiple times,
#much like showing three blocks of images without the interblock interval
loop current_trial=1 until current_trial>num_trials begin 

	#~~~~arrange the conditions for random or incremental presentation
	if order=="random" then	#if the specification of cnd order is random then...
		cnds_to_show2.append(cnds_to_show);
		cnds_to_show2.shuffle();	#...randomly shuffle the conditions
	else
		cnds_to_show2.append(cnds_to_show); #otherwise default to incremental ordering
	end;
		
	#loop through the conditions
	loop current_cnd=1 until current_cnd>cnds_to_show2.count() begin	#loop so long as there is 1 condition to show
		int determine_correct2=0;		
		#set up the keyboard so that if any key is repetetively pressed the experiment will be stopped
		#this is important to do, if the experimenter just presses "escape" then the experiment will stop,
		#before the eye data acquisition port is closed.  If this port is not closed, then we seem to accumulate
		#errors in the eye data as the experiment progresses
		system_keyboard.set_max_length( 1 );
		system_keyboard.set_time_out( 500 );#note this adds an extra 500 ms to the iti that must be subtracted elsewhere
		string input3 = system_keyboard.get_input();
		if (system_keyboard.last_input_type() != keyboard_time_out) then;
			break;
		end;	
		
		trialCounter[cnds_to_show2[current_cnd]]=trialCounter[cnds_to_show2[current_cnd]]+1;
		image_bmp.set_filename(items[int(double(cnd[cnds_to_show2[1]].substring(1,2)))]); #get the sample item filename and set it to the experimenters monitor
		image_bmp.load();	#load the sample item filename for display on the experimenters monitor
		image_bmp2.set_filename(items[int(double(cnd[cnds_to_show2[1]].substring(1,2)))]); #get the sample item filename and set it to the monkeys monitor
		image_bmp2.load();	#load the sample item filename for display on the monkeys monitor

		double w=image_bmp.width(); double h=image_bmp.width();
		imageBoundary.set_height(int(h)+2*imagewin); # set the height boundary of the fixspot (the extra space the monkey is allowed)
		imageBoundary.set_width(int(w)+2*imagewin); # set the width boundary of the fixspot (the extra space the monkey is allowed)
		imageBoundaryBlack.set_height(int(h)+2*imagewin-2); # the above two lines will set the red box height, this is setting the black box height(see picture code for details)
		imageBoundaryBlack.set_width(int(w)+2*imagewin-2); # the above two lines will st the red box width, this is setting the black box width(see picture code for details)


		#these lines will make compile the text that will be displayed throughout the experiment on the experimenter's monitor
		trialInfo="Condition#: ";
		trialInfo.append(string(cnds_to_show2[current_cnd]));
		trialInfo.append("\,     failures= ");
		trialInfo.append(string(cnd_times_shown[cnds_to_show2[1]]));
		if totalFixspots==0.0 then;
			trialInfo.append("\nImage success:          \nFixspot success:          ");
		elseif overall_cnd_shown==0.0 then;
			trialInfo.append("\nImage success:       ");
			trialInfo.append(")\nFixspot success: ");
			trialInfo.append(string(fixGood));
			trialInfo.append("\/");
			trialInfo.append(string(totalFixspots));
			trialInfo.append(" (");
			trialInfo.append(string(round(((fixGood/(totalFixspots)*100.0)),1)));
			trialInfo.append("%)");
		else;
			trialInfo.append("\nImage success: ");
			trialInfo.append(string(overall_cnd_correct));
			trialInfo.append("\/");
			trialInfo.append(string(overall_cnd_shown));
			trialInfo.append(" (");
			trialInfo.append(string(round((((overall_cnd_correct/overall_cnd_shown)*100.0)),1)));
			trialInfo.append("%)");
			trialInfo.append("\nFixspot success: ");
			trialInfo.append(string(fixGood));
			trialInfo.append("\/");
			trialInfo.append(string(totalFixspots));
			trialInfo.append(" (");
			trialInfo.append(string(round(((fixGood/(totalFixspots)*100.0)),1)));
			trialInfo.append("%)");
		end;

		text1.set_caption(trialInfo);
		text2.set_caption(trialInfo);
		text3.set_caption(trialInfo);
		text1.redraw();
		text2.redraw();
		text3.redraw();
term.print(trialInfo);
term.print("\n\n");
		#~~~~~~~~~~~~~~~~ PRESENT THE FIXSPOT ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		totalFixspots=totalFixspots+1.0;
		fixspot_copy.present(); #present the fixspot copy on the users screen
		fixspot_real.present(); #present the fixspot on the monkeys screen
		encode(19); #encode fixspot on (because of the encode time delay, the encode should be sent after the fixspot is presented

		#~~~~~~~~ WAIT FOR THE MONKEY TO LOOK AT THE FIXSPOT ~~~~~~~~~~~~~~~~~~l
		iscan_x =iscan.read_analog(idX)*ratioX; # get the X eye position
		iscan_y =iscan.read_analog(idY)*ratioY; # get the Y eye position
		clockticker=clock.time(); #get the time
		#as long as the monkey isn't looking at the fixspot AND he hasn't ran out of time yet, keep checking the eye
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
			iti_copy.present(); #present the iti to the experimenter
			iti_real.present(); #present the iti to the monkey
			encode(20); #encode fixspot off (the iti is like a black picture that covers the fixspot, so the fixspot turns off when the iti begins);
			encode(05);	
			fail2look=fail2look+1.0;
			itipres(); #monitor the eye during the iti using the subroutine function at the beginning of the PCL code

		#~~~~~~ IF THE MONKEY DID LOOK AT THE FIXSPOT THEN MAKE SURE HE MAINTAINS HIS FIXATION ~~~~~~~~~~~~~~~`
		else	
			clockticker=clock.time(); # get the time
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
				iti_copy.present(); #present the iti to the experimenter
				iti_real.present(); #present the iti to the monkey
				encode(20); #encode fixspot off;
				encode(04);
				fail2hold=fail2hold+1.0;
				iti_copy.set_part_x( 1, iscan_x ); # set the X eye position to eyeposition of the picture
				iti_copy.set_part_y( 1, iscan_y ); # set the Y eye position to eyeposition of the picture
				itipres(); #monitor the eye during the iti using the subroutine function at the beginning of the PCL code

			#~~~~~~~~~~~~~~~~ IF THE MONKEY MAINTAINED HIS FIXATION FOR THE REQUIRED AMOUNT OF TIME THEN GIVE JUICE AND BEGIN THE ITI ~~~~~~~~
			else
				cnd_times_shown[cnds_to_show2[1]]=cnd_times_shown[cnds_to_show2[1]]+1;
				overall_cnd_shown=overall_cnd_shown+1.0;
				#present the image
				fixGood=fixGood+1.0;
				image_copy.present();
				image_real.present();
				encode(17);
				encode(1000+int(double(cnd[cnds_to_show2[1]].substring(1,2))));
				clockticker=clock.time(); # get the time
				# contine to monitor the eye until it leaves the image or the timer runs out
				loop until iscan_x>double(int(w/2.0)+imagewin) || iscan_x<double(-int(w/2.0)-imagewin) ||
					iscan_y>double(int(h/2.0)+imagewin) || iscan_y<double(-int(h/2.0)-imagewin) ||
					(clock.time()-clockticker)>imageDuration
				begin
					iscan_x =iscan.read_analog(idX)*ratioX; # get the X eye position
					iscan_y =iscan.read_analog(idY)*ratioY; # get the Y eye position
					image_copy.set_part_x( 4, iscan_x ); # set the X eye position to eyeposition of the picture
					image_copy.set_part_y( 4, iscan_y ); # set the Y eye position to eyeposition of the picture
					image_copy.present(); # show the eye position on the monitor
				end;
				if iscan_x>double(int(w/2.0)+imagewin) || iscan_x<double(-int(w/2.0)-imagewin) ||
					iscan_y>double(int(h/2.0)+imagewin) || iscan_y<double(-int(h/2.0)-imagewin)
				then
					encode(18); #encode image off;
					iti_real.present(); #present the iti to the monkey
					encode(04);
					iti_copy.present(); #present the iti to the experimenter
					iti_copy.set_part_x( 1, iscan_x ); # set the X eye position to eyeposition of the picture
					iti_copy.set_part_y( 1, iscan_y ); # set the Y eye position to eyeposition of the picture
					itipres(); #monitor the eye during the iti using the subroutine function at the beginning of the PCL code
				else
					encode(18); #encode image off;
					iti_real.present(); #present the iti to the monkey
					encode (03); #encode juice reward
					int nojo=1;
					loop until nojo>numberOfJuiceDrops begin;
						oportJuice.send_code(1,1);#give juice to the monkey
						wait_interval(110);
						nojo=nojo+1;
					end;
					iti_copy.present(); #present the iti to the experimenter
					iti_copy.set_part_x( 1, iscan_x ); # set the X eye position to eyeposition of the picture
					iti_copy.set_part_y( 1, iscan_y ); # set the Y eye position to eyeposition of the picture
					itipres();
					determine_correct2=1;
					overall_cnd_correct=overall_cnd_correct+1.0;
				end;
			end;
		end;

	
		if (determine_correct2==1) then
			array<int>temp_cnd_shower[cnds_to_show2.count()-1];	#create a temporary array
			int k;	#create an integer counter
			loop k=1 until k>cnds_to_show2.count()-1 begin	#loop through each condition
				temp_cnd_shower[k]=cnds_to_show2[k+1];	#rewrite all conditions but the one just completed to the array
				k=k+1;	#increment the counter
			end;
			cnds_to_show2.resize(cnds_to_show2.count()-1);	#resize the array
			cnds_to_show2=temp_cnd_shower;	#assign the temporary array to the global cnd_to_show array
		
		#if the monkey performed the trial incorrectly, then...
		elseif (determine_correct2==0) then 
			int tempcnd=cnds_to_show2[1];	#assign the current cnd number to this temporary variable
			if (tnext=="delayed") then	#if the error trial should be presented with a delay then...
				cnds_to_show2.shuffle();	#just reshuffle the cnd to show list
			elseif (tnext=="immediate") then	#if the error trial should be presented immediatelty...
				#don't do anything, just leave teh conditions to show list as is.
			elseif (tnext=="ignore") then #if you want to ignore error trials then... delete this trial from the conditions to show list
				array<int>temp_cnd_shower[cnds_to_show2.count()-1];	#create a temporary array
				int k;	#create an integer counter
				loop k=1 until k>cnds_to_show2.count()-1 begin	#loop through each condition
					temp_cnd_shower[k]=cnds_to_show2[k+1];	#rewrite all conditions but the one just completed to the array
					k=k+1;	#increment the counter
				end;
				cnds_to_show2.resize(cnds_to_show2.count()-1);	#resize the array
				cnds_to_show2=temp_cnd_shower;	#assign the temporary array to the global cnd_to_show array	
			end;
		end;
	end;
current_trial=current_trial+1;	#increment the trial counter
end;

		trialInfo=("\nImage success: ");
			trialInfo.append(string(overall_cnd_correct));
			trialInfo.append("\/");
			trialInfo.append(string(overall_cnd_shown));
			trialInfo.append(" (");
			trialInfo.append(string(round((((overall_cnd_correct/overall_cnd_shown)*100.0)),1)));
			trialInfo.append("%)");
			trialInfo.append("\nFixspot success: ");
			trialInfo.append(string(fixGood));
			trialInfo.append("\/");
			trialInfo.append(string(totalFixspots));
			trialInfo.append(" (");
			trialInfo.append(string(round(((fixGood/(totalFixspots)*100.0)),1)));
			trialInfo.append("%)");

term.print(trialInfo);