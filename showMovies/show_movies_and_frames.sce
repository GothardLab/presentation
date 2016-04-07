

write_codes =false;  # write encodes in Presentation logfile(false=don't write encodes)


##############################################################################################
begin;	#begin SDL (defining the experiment images / trial types)
##############################################################################################

picture {} default; #create a "blank screen" to show during inter-trial-intervals

#~~~~~~ITI~~~~~~~~
trial {
	trial_duration=1000; #length of correct ITI
	picture default;	#a blank screen will be displayed
}iti_correct;

#fixspot parameters
picture{
bitmap {filename = "projector.bmp";};
x=0;y=0;
}projector;

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
	box {color = 0,255,0;height=10;width=10;display_index=1;}fixspot2;
	x=0; y=0; #the position of the fixspot, this is updated according to the condition
}fixspot_real; #the na

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
	
#~~~~movie frame parameters~~~
array{
 LOOP $i 300;
   $k = '$i + 1';
   bitmap { filename = "placeholder.bmp";preload=false;};
   ENDLOOP;
} frame_bmp;

trial {    
trial_duration=17;
   picture {  
      # placeholder - set by PCL
      box { height = 1; width = 1; color = 0,0,0; };
      x = 0; y = 0;
   } pic1;
   
} frame_pres;



##############################################################################################
begin_pcl; #begin PCL (the timing file)
##############################################################################################
double monitorX=800.0; #monitor width (pixels)
double monitorY=600.0; #monitor height (pixels)
double ratioX=((monitorX/2.0)/4.0); #ratio to multiply X voltage by (want 5Volts to be at least 1/2 the width of the monitor)
double ratioY=((monitorY/2.0)/4.0); #ratio to multiply X voltage by (want 5Volts to be at least 1/2 the height of the monitor)
int fixspotsize=7;  # size of fixspot (pixels)
int fixwin=25; #this is the extra room that the monkey has around the edge of the fixspot (pixels)
					# so, if fixwin is 10, then there is a leniency of 10 pixels on all sides of the fixspot
int fixspotX=0; # x-position of the fixspot (pixels)
int fixspotY=0; # y-postition of the fixspot (pixels)
int fixspotTime=2000; # time that monkey is allowed to get to fixspot (ms)
int fixationDuration=50; # time required for the monkey to maintain fixation on the fixspot (ms)
int itiDuration=1000; #duration of the inter-trial-interval (ms)
int numberOfJuiceDrops=10;	# the duration of the juice TTL pulse
int clockticker=0; # just an integer counter to hold the clock time
int numberofSpots=1; # just an integer counter to hold the clock time
#int stimlength=299;

int movieLength = 299;
int imageLength = 90;

int thisTrialMaxFrame;

array<int>trialCounter[99]; #just an integer counter to count the number of times each condition has been shown
trialCounter.fill(1,99,0,0);
double fail2look=0.0; # a counter to keep track of the number of times the monkey failed to look at the fixspot
double fail2hold=0.0; # a counter to keep track of the number of times the monkey failed to hold his gaze on the fixspot
double totalFixspots=0.0; # a counter to keep track of the number of times a fixspot was presented
string trialInfo;
#array<int>fixpos[9][2]={ {0,0},{-100,0},{100,0},{0,100},{0,0},{50,50},{-50,-0},{-50,50},{50,0}};
#array<int>fixlist[9]={ 1,2,3,4,5,6,7,8,9 };
array<int>fixpos[1][2]={ {0,0}};#,{-100,0},{100,0},{0,100},{0,0},{50,50},{-50,-0},{-50,50},{50,0}};
array<int>fixlist[1]={ 1};#,2,3,4,5,6,7,8,9 };

int skipFixSpot = 1;

output_port oportData=output_port_manager.get_port(1);
output_port oportPulse=output_port_manager.get_port(2);
output_port oportJuice=output_port_manager.get_port(2); # open the port that will send the juice TTL pulse
dio_device iscan = new dio_device(ni_dio_device, 1, 0); # initialize the analog portion of the NI DIO card in the presentaiton computer
int idX = iscan.acquire_analog_input("ISCANTask,x");  # set up retrieval of the x coordinate of eye tracker
int idY = iscan.acquire_analog_input("ISCANTask,y");  # set up retrieval of the y coordinate of eye tracker
double iscan_x; # initialize variable for eye tracker x postion
double iscan_y; # initialize variable for eye tracker y postion


parameter_window.remove_all();

#determine the high and low byte and send these codes.
sub array<int,1> encode(int C) begin
array<int> encodes[2];
encodes[1]=mod(C,256);
encodes[2]=(C-encodes[1])/256;
oportData.send_code(encodes[1],2);#low
oportPulse.send_code(128,1);
wait_interval(5);
oportData.send_code(encodes[2],2);#high
oportPulse.send_code(128,1);
wait_interval(5);
return encodes;
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

#~~~~~~get the experimental parameters~~~~~
string exp_par="movie_parameters.txt"; #the name of the item file with the experiment information
input_file exp_info = new input_file;	#create an input file
exp_info.open( exp_par );	#load the experimental parameters into the input file
string temp_name;	#create a string variable for temporary use
temp_name=exp_info.get_line();	#get the first line of the experimental file (item file)
string item_file=temp_name.substring(12,temp_name.count()-11);	#filename of the item file
temp_name=exp_info.get_line();  	#get the next line (just dashes) and ignore
temp_name=exp_info.get_line();	#get the 4th line (number of trials)
int num_trials=int(double(temp_name.substring(temp_name.count()-1,2)));	#write down the number of trials to be shown

#~~~~~~~~~~~load the items~~~~~~~~~~~~
int i; int name_index; int start_frame_index; int end_frame_index; #create a counter variable														
string current_filename;	#create a string variable for the item names
input_file fil = new input_file;   #create an input file
fil.open( item_file );	#load the item file data into the input file
current_filename=fil.get_line();	#get the first line of the item file (column headers)
name_index=current_filename.find("moviename");
start_frame_index=current_filename.find("startframe");
end_frame_index=current_filename.find("endframe");

int num_items=int(double(current_filename.substring(current_filename.find("totalitems=")+11,2))); #assign how many items there are to a avariable
array<string>movies[num_items];	#create an array which will contain the filenames of the items
array<int>startframe[num_items];	#create an array which will contain the start frame of each movie
array<int>endframe[num_items];	#create an array which will contain the end frame of each movie
loop i=1 until i>(num_items) begin  #loop through each line in the item file
   current_filename=fil.get_line();	#get the list of characters that compose the current line in the itm file
 	movies[i]=current_filename.substring(name_index,current_filename.find(".avi")-name_index); #get just the item filename from that line
   startframe[i]=int(double(current_filename.substring(start_frame_index,3))); #get just the item filename from that line
   endframe[i]=int(double(current_filename.substring(end_frame_index,3))); #get just the item filename from that line
	i=i+1;	#increment the counter                 
end;

#~~~~~~~~~~figure out which conditions to show~~~~~~~
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

##############################################################################################
#~~~~~~~~loop through the conditions~~~~~
##############################################################################################
int current_trial;	#create an integer counter for the trial number (# times each condition should be seen correctly)
int current_cnd;	#create an integer counter for the current condition being shown
int itiDur;
int itiDurRan;
array<int>cnds_to_show2[0];	#create an integer array in which we will store the randomized condition numbers
int frame_val; int encode1; int encode2;
string framename;
double fixshown; double fixachieved; double fixper;

loop current_trial=1 until current_trial>num_trials begin 
	
	#~~~~arrange the conditions for random or incremental presentation
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
		system_keyboard.set_time_out( 500 );#note this adds an extra 500 ms to the iti that must be subtracted elsewhere
		string input3 = system_keyboard.get_input();
		if (system_keyboard.last_input_type() != keyboard_time_out) then;
			break;
		end;	



clockticker=clock.time(); #get the time
			iti_correct.present();
		#show a blank ITI screen while we load the images for the first movie
		int movie_count=current_cnd+(current_trial-1)*cnds_to_show2.count();
		int total_movies=num_trials*cnds_to_show2.count();
		
		string moviedir=movies[cnds_to_show2[current_cnd]];
		
		term.print("\n\n");
		trialInfo=movies[cnds_to_show2[current_cnd]];
		trialInfo.append(", movie ");
		trialInfo.append(string(movie_count));
		trialInfo.append("/");
		trialInfo.append(string(total_movies));
		term.print(trialInfo);
		text1.set_caption(trialInfo);
		text2.set_caption(trialInfo);
		text1.redraw();
		text2.redraw();
		if endframe[cnds_to_show2[current_cnd]]>1
		then
		loop frame_val=startframe[cnds_to_show2[current_cnd]] until frame_val==(movieLength+startframe[cnds_to_show2[current_cnd]]) begin;
			#term.print("\n Movie Trial!");\
			#term.print("\n movie frame_val:");
			#term.print(frame_val);
			frame_bmp[frame_val-startframe[cnds_to_show2[current_cnd]]+1].unload();
			framename=moviedir;
			framename.append("\\");
			framename.append(string(frame_val));
			framename.append(".bmp");
			frame_bmp[frame_val-startframe[cnds_to_show2[current_cnd]]+1].set_filename(framename);
			frame_bmp[frame_val-startframe[cnds_to_show2[current_cnd]]+1].load();
			frame_val=frame_val+1;
		end;
		
		
		else
		loop frame_val=startframe[cnds_to_show2[current_cnd]] until frame_val==imageLength+1 begin;#endframe[cnds_to_show2[current_cnd]] begin;
			#term.print("\n Image Trial!");
			#term.print("\n  image frame_val:");
			#term.print(frame_val);
			frame_bmp[frame_val].unload();
			framename="00 single movie frames\\";
			framename.append(moviedir);
			#term.print(moviedir);
			framename.append(".bmp");
			frame_bmp[frame_val].set_filename(framename);
			frame_bmp[frame_val].load();
			frame_val=frame_val+1;
		end;
		
		
end;

#encode(51);	#movie/image loaded

thisTrialMaxFrame = frame_val-1;
term.print(thisTrialMaxFrame);

projector.present();	#present the fixspot
		encode(35);	#encode fixspot on
		wait_interval(random(350,500));

#itiDur=random(50,100);		
#	loop until (clock.time()-clockticker)>itiDur #continue to plot the eye on the experiment monitor until the iti time runs out
	#begin
	#end;
		int determine_correct=1;
	#	int indexthing=0;
		fixshown=fixshown+1.0;
	
	#iti_correct.set_duration(random(100,150));
		encode(36);
		#iti_correct.present();
		
		if determine_correct==1 then;
		fixachieved=fixachieved+1.0;
		
##ofile1.print("\n");
##ofile1.print(cnds_to_show2[current_cnd]);
##ofile1.print("|*|");

		int movie_encode=cnds_to_show2[current_cnd];
			oportData.send_code(movie_encode,2);
			oportPulse.send_code(128,1);
			wait_interval(5);
			oportData.send_code(255,2);
			oportPulse.send_code(128,1);
			wait_interval(5);
			pic1.set_part( 1, frame_bmp[1] ); 
		loop frame_val=startframe[cnds_to_show2[current_cnd]] until frame_val==(thisTrialMaxFrame+startframe[cnds_to_show2[current_cnd]]) begin;
			
			term.print("\n");
			term.print(frame_val);
			term.print("/");
			term.print(thisTrialMaxFrame);
			

	frame_pres.present();	#begin the sample image period
			encode(frame_val+1000);
			frame_bmp[frame_val-startframe[cnds_to_show2[current_cnd]]+1].unload();
			frame_val=frame_val+1;
			encode1=mod(1000+frame_val,256);
			encode2=1+(1000+frame_val-encode1)/256;
		
			pic1.set_part( 1, frame_bmp[frame_val-startframe[cnds_to_show2[current_cnd]]+1] );
		end;
			iti_correct.present();
			encode(00);

		current_cnd=current_cnd+1;
		
		end;
	end;
	current_trial=current_trial+1;
end;

# the experiment is done, release the DIO device that was tracking the eye position
iscan.release_analog_input(idX); # release the X eye postion
iscan.release_analog_input(idY); # release the Y eye position
	