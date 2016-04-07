

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
bitmap {filename = "98.bmp";};
x=0;y=0;
}fixspot;

#sound parameters
sound {
    wavefile { filename = "silent.wav"; }sound2;
} sound1;


#~~~~movie frame parameters~~~
array{
 LOOP $i 300;
   $k = '$i + 1';
   bitmap { filename = "placeholder.bmp";preload=false;};
   ENDLOOP;
} frame_bmp;

trial {
	monitor_sounds = false;
    sound sound1;
} sound_trial;

trial {
	monitor_sounds = false;    
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
output_port oportData=output_port_manager.get_port(1);
output_port oportPulse=output_port_manager.get_port(2);

output_file debug_file = new output_file;
debug_file.open(("debug_file.txt"));


#input_port iport=input_port_manager.get_port(1);#the serial port (for receiving eye data)
#calibration parameters
#int V=-52; #true horizontal displacement from input value
#int H=-261;  # true verticle displacement from input value
#double RatioX=11.79;
#double RatioY=22.6; #human was 24
#double T=0.03;#clockwise angle to be rotated #might need to add a G for a separate Y rotation.


parameter_window.remove_all();

#********************************************************************************************
#***********************sub routines for eye tracking and encodes****************************
#********************************************************************************************
#convert the digital output of eyescan into X and Y values
#iport.clear();	    
#sub synchronize      begin;      
#	iport.clear();
  # loop
 #     int ii = 0
#		until false begin
#if (iport.total_count() > ii) then
  #       ii = ii + 1;
   #      if (iport.codes( ii ) == 13) then #looks for the stereotyped entry near the beginning of each XY data block
   #         iport.clear( 1, ii );
    #        break
   #      end;
#      end;
#   end;
#end;
#synchronize();
#sub int decipher_codes(int codes1, int codes2, int codes3) begin
#if (codes1<0) then codes1=0; end;
#if (codes2<0) then codes2=0; end;
#if (codes3<0) then codes3=0; end;
#int val = 100*(codes1)+10*(codes2)+(codes3);
#return val
#end;

#subarray which will contain the X and Y positions retrieved from ISCAN
#sub array<int,1> get_XY_codes begin
#	array<int> eye[2];#
#	loop until (iport.total_count()>=7) begin 	end;
#	eye[1]=-1*(decipher_codes(iport.codes(3)-48,iport.codes(4)-48,iport.codes(5)-48));
#	iport.clear(1,7);
#	loop until (iport.total_count()>=7) begin end;
#	eye[2]=-1*(decipher_codes(iport.codes(3)-48,iport.codes(4)-48,iport.codes(5)-48));
#	return eye
#end;
#
#sub array<int,1> get_eyes begin
#	array<int>eyetracker[2];
#	synchronize();
#	array<int> eyeval[2]=get_XY_codes();
#	int IX=0;int IY=0;
#	IX=int(round((RatioX*double(eyeval[1])),0))-int(round((RatioX*double(H)),0));
#	IY=int(round((RatioY*double(eyeval[2])),0))-int(round((RatioY*double(V)),0));
#	eyetracker[1]=IX;
#	eyetracker[2]=IY;
#	return eyetracker;
#end;

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

#~~~~~~get the experimental parameters~~~~~
string exp_par="audiovisual_parameters.txt"; #the name of the item file with the experiment information
input_file exp_info = new input_file;	#create an input file
exp_info.open( exp_par );	#load the experimental parameters into the input file
string temp_name;	#create a string variable for temporary use
temp_name=exp_info.get_line();	#get the first line of the experimental file (item file)
string item_file=temp_name.substring(12,temp_name.count()-11);	#filename of the item file
temp_name=exp_info.get_line();  	#get the next line (just dashes) and ignore
temp_name=exp_info.get_line();	#get the 4th line (number of trials)
int num_trials=int(double(temp_name.substring(temp_name.count()-1,2)));	#write down the number of trials to be shown

#~~~~~~~~~~~load the items~~~~~~~~~~~~
int i; int nameF_index; int nameA_index; int start_frame_index; int end_frame_index; #create a counter variable														
string current_filename;	#create a string variable for the item names
input_file fil = new input_file;   #create an input file
fil.open( item_file );	#load the item file data into the input file
current_filename=fil.get_line();	#get the first line of the item file (column headers)
nameF_index=current_filename.find("framefile");
nameA_index=current_filename.find("audiofile");
start_frame_index=current_filename.find("startframe");
end_frame_index=current_filename.find("endframe");

int num_items=int(double(current_filename.substring(current_filename.find("totalitems=")+11,2))); #assign how many items there are to a avariable
array<string>movies[num_items];	#create an array which will contain the filenames of the items
array<string>audios[num_items];	#create an array which will contain the filenames of the audio items
array<int>startframe[num_items];	#create an array which will contain the start frame of each movie
array<int>endframe[num_items];	#create an array which will contain the end frame of each movie
loop i=1 until i>(num_items) begin  #loop through each line in the item file
   current_filename=fil.get_line();	#get the list of characters that compose the current line in the itm file
 	movies[i]=current_filename.substring(nameF_index,current_filename.find(".avi")-nameF_index); #get just the item filename from that line
   debug_file.print(i);
	audios[i]=current_filename.substring(nameA_index,current_filename.find(".wav")-nameA_index); #get just the item filename from that line
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
array<int>cnds_to_show2[0];	#create an integer array in which we will store the randomized condition numbers
int frame_val; int encode1; int encode2;
string framename;
double fixshown; double fixachieved; double fixper;
#loop through the experiment for the number of trials specified for each condition
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
		
		#show a blank ITI screen while we load the images for the first movie
		int movie_count=current_cnd+(current_trial-1)*cnds_to_show2.count();
		int total_movies=num_trials*cnds_to_show2.count();
		iti_correct.set_duration(3000);
		iti_correct.present();
		string moviedir=movies[cnds_to_show2[current_cnd]];
		string audiodir=audios[cnds_to_show2[current_cnd]];
		moviedir.append("\\");
		audiodir.append(".wav");
				term.print(string(movie_count));
		term.print("/");
		term.print(string(total_movies));
	   term.print(", cnd ");
	   term.print(string(cnds_to_show2[current_cnd]));
		term.print(",  loading...movie [");
		term.print(movies[cnds_to_show2[current_cnd]]);
				term.print("] audio [");
		term.print(audios[cnds_to_show2[current_cnd]]);
		term.print("]");
		

		loop frame_val=startframe[current_cnd] until frame_val>(endframe[current_cnd]) begin;
			frame_bmp[frame_val].unload();
			framename=moviedir;
			framename.append(string(frame_val));
			framename.append(".bmp");
			frame_bmp[frame_val].set_filename(framename);
			frame_bmp[frame_val].load();
			frame_val=frame_val+1;
		end;
		
		int determine_correct=1;
	#	int indexthing=0;
		fixshown=fixshown+1.0;
		#string clktime;
	#	string clktime2;
		#string ct=string(clock.time());
	#	loop until (clock.time()>=int(ct)+2000 ||determine_correct==1) begin;
	#	array<int>eyetracker[2]=get_eyes();
		#double eyeX=double(eyetracker[1]);
		#double eyeY=double(eyetracker[2]);

	#	if eyeX<(0.0+37.0) && eyeX>(0.0-37.0) && eyeY<(0.0+37.0) && eyeY>(0.0-37.0) then indexthing=indexthing+1;
	#		if indexthing==1 then clktime=string(clock.time());end;
	#		if indexthing>1 then clktime2=string(clock.time());end;
		#	if (int(clktime2)>int(clktime)+random(100,150)) then determine_correct=1;break;end;		
		#else#if eye is outside...after being inside...break trial, encode error
	#		if indexthing>=1 then determine_correct=0;;break;end;
		#	end;
	#	end;		
	iti_correct.set_duration(random(10000,20000));
		encode(36);
		iti_correct.present();
		
		if determine_correct==1 then;
		fixachieved=fixachieved+1.0;
					sound2.unload();
			sound2.set_filename(audiodir);
			sound2.load();
			
		int movie_encode=cnds_to_show2[current_cnd];
			oportData.send_code(movie_encode,2);
			oportPulse.send_code(128,1);
			wait_interval(5);
			oportData.send_code(255,2);
			oportPulse.send_code(128,1);
			wait_interval(5);
			pic1.set_part( 1, frame_bmp[startframe[current_cnd]] );
		 
		sound_trial.present();
		encode(771);
		loop frame_val=startframe[current_cnd] until frame_val>endframe[current_cnd] begin;
			frame_pres.present();	#begin the sample image period
			encode(frame_val+1000);
			frame_bmp[frame_val].unload();
			frame_val=frame_val+1;
			#encode1=mod(1000+frame_val,256);
			#encode2=1+(1000+frame_val-encode1)/256;
			pic1.set_part( 1, frame_bmp[frame_val] ); 
		end;
		
		current_cnd=current_cnd+1;
		
		end;
		fixper=100.0*fixachieved/fixshown;
				term.print("\n");
	end;
	current_trial=current_trial+1;
end;
	