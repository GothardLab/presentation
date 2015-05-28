

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
}fixspot;

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
output_port oportData=output_port_manager.get_port(1);
output_port oportPulse=output_port_manager.get_port(2);
#output_port oportJuice=output_port_manager.get_port(2); # open the port that will send the juice TTL pulse


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
#term.print(endframe[i]);	
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
int numberOfJuiceDrops;
int itiDur;
int itiDurRan;
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
		int clockticker=clock.time(); #get the time
			iti_correct.present();
		#show a blank ITI screen while we load the images for the first movie
		int movie_count=current_cnd+(current_trial-1)*cnds_to_show2.count();
		int total_movies=num_trials*cnds_to_show2.count();
		
		string moviedir=movies[cnds_to_show2[current_cnd]];
		moviedir.append("\\");
		term.print("loading...");
		term.print(movies[cnds_to_show2[current_cnd]]);
		term.print(", movie ");
		term.print(string(movie_count));
		term.print("/");
		term.print(string(total_movies));

		loop frame_val=startframe[cnds_to_show2[current_cnd]] until frame_val==endframe[cnds_to_show2[current_cnd]] begin;
			frame_bmp[frame_val].unload();
			framename=moviedir;
			framename.append(string(frame_val));
			framename.append(".bmp");
			frame_bmp[frame_val].set_filename(framename);
			frame_bmp[frame_val].load();
			frame_val=frame_val+1;
		end;

itiDur=random(1000,2000);		
#itiDurRan=random(500,2000);
#		loop until (clock.time()-clockticker)>itiDurRan #continue to plot the eye on the experiment monitor until the iti time runs out
#	begin
#	end;
#	numberOfJuiceDrops=random(1,3);
#	int nojo=1;
#	encode(03);
#	loop until nojo>numberOfJuiceDrops begin;
#						oportJuice.send_code(1,1);#give juice to the monkey
#						wait_interval(110);
#						nojo=nojo+1;
#	end;
	loop until (clock.time()-clockticker)>itiDur #continue to plot the eye on the experiment monitor until the iti time runs out
	begin
	end;
		int determine_correct=1;
	#	int indexthing=0;
		fixspot.present();	#present the fixspot
		encode(35);	#encode fixspot on
		wait_interval(random(350,500));
		fixshown=fixshown+1.0;
	
	iti_correct.set_duration(random(350,500));
		encode(36);
		iti_correct.present();
		
		if determine_correct==1 then;
		fixachieved=fixachieved+1.0;
		int movie_encode=cnds_to_show2[current_cnd];
			oportData.send_code(movie_encode,2);
			oportPulse.send_code(128,1);
			wait_interval(5);
			oportData.send_code(255,2);
			oportPulse.send_code(128,1);
			wait_interval(5);
			pic1.set_part( 1, frame_bmp[startframe[current_cnd]] ); 
		
		loop frame_val=startframe[cnds_to_show2[current_cnd]] until frame_val==endframe[cnds_to_show2[current_cnd]] begin;
			frame_pres.present();	#begin the sample image period
			encode(frame_val+1000);
			frame_bmp[frame_val].unload();
			frame_val=frame_val+1;
			encode1=mod(1000+frame_val,256);
			encode2=1+(1000+frame_val-encode1)/256;
			pic1.set_part( 1, frame_bmp[frame_val] ); 
		end;
		
		current_cnd=current_cnd+1;
		
		end;
		fixper=100.0*fixachieved/fixshown;
		term.print("               fixation percent: " + string(int(fixper)) + "% (of "+ string(fixshown) +")");
				term.print("\n");
	end;
	current_trial=current_trial+1;
end;
	