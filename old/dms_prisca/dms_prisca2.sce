write_codes = true;  # write encodes (false=don't write encodes)
active_buttons=2;		# there are two response possibilities (lever up or down)



##############################################################################################
begin;	#begin SDL (defining the experiment images / trial types)
##############################################################################################

picture {} default; #create a "blank screen" to show during inter-trial-intervals
wavefile { filename="jad0022a.wav";}correct_sound; #load the correct response sound
wavefile { filename="jad0024a.wav";}incorrect_sound;  #load the incorrect response sound


#~~~~~~correct ITI~~~~~~~~
trial {
	trial_duration=3000; #length of correct ITI
	picture default;	#a blank screen will be displayed
	sound{wavefile correct_sound;}good_sound;	#the good sound will be played for correct trials
}iti_correct;


#~~~~~~incorrect ITI~~~~~~~~
trial {
	trial_duration=5000; #length of incorrect ITI
	picture default;	#a blank screen will be displayed
	sound{wavefile incorrect_sound;}bad_sound; #the bad sound will be played for incorrect trials
}iti_incorrect;

#~~~~cue image parameters~~~
trial {
	trial_duration=5000; #the maximum length of time the cue will be presented for
	trial_type=correct_response;		#a correct response will cause the trial to end
	picture {bitmap {filename="cue.bmp";};  #the cue image will be presented
		x=0; y=0;};	#the position of the cue image on the screen
	target_button=1;	#the correct response is to press the lever
}cue;


#~~~sample image parameters~~
trial{
	trial_duration=2500; #duration of cue presentation
	trial_type=fixed;		#the duration of the trial is fixed, but a response will be recorded if the monkey lets go of the lever
	picture { bitmap {filename="placeholder.bmp";}sample_bmp; #the sample image will be presented
		x=-200; y=0;};	#position of the sample image on screen (x=-200 --> lefthand side of screen)
	target_button=2;	#the only possible action is letting go of the lever (incorrect response)
}sample;

#~~~~~~inter image delay~~~~~~~~
trial {
	trial_duration=500; #duration of cue presentation
	trial_type=fixed;		#the duration of the trial is fixed, but a response will be recorded if the monkey lets go of the lever
	picture { bitmap sample_bmp; #the sample image will be presented
		x=-200; y=0;};	#position of the sample image on screen (x=-200 --> lefthand side of screen)
	target_button=2;	#the only possible action is letting go of the lever (incorrect response)
}inter_image_delay;

#~~~~~~distractor image parameters~
trial {
	trial_duration=2500;	#duration of distractor presentations
	trial_type=fixed;	#the duration of the trial is fixed, but a response will be recorded if the monkey lets go of the lever
	picture { bitmap sample_bmp;  #the sample image will be presented
		x=-200; y=0; #position of the sample image on screen (x=-200 --> lefthand side of screen)
		bitmap {filename="placeholder.bmp";}distractor_bmp; #the distractor image will be presented
		x=200; y=0;}; #position of the distractor image on screen (x=200 --> righthand side of screen)
	target_button=2; #the only possible action is letting go of the lever (incorrect response)
}distractor;


#~~~~~~match image parameters~~~~~~~~
trial{
	trial_duration=2500; #duration of match presentation
	trial_type=fixed;		#the duration of the trial is fixed, but a response will be recorded if the monkey lets go of the lever
	picture { bitmap sample_bmp;  #the sample image will be presented
		x=-200; y=0; #position of the sample image on screen (x=-200 --> lefthand side of screen)
		bitmap { filename="placeholder.bmp"; }match_bmp; #the match image will be presented
		x=200; y=0;};#position of the match image on screen (x=200 --> rightland side of screen)
	target_button=2;	#the only possible action is letting go of the lever (correct response)
}match;




##############################################################################################
begin_pcl; #begin PCL (the timing file)
##############################################################################################

#define output port for marker codes, juice, 1401 trigger
output_port marker;
marker = output_port_manager.get_port( 1 );
marker.send_code(32,1);

#debug file (use this to write information to a text file when debugging the program)
output_file debug_file = new output_file;
debug_file.open("dms_debug.txt");

#~~~~~~get the experimental parameters~~~~~
#~~~~~~get the experimental parameters~~~~~
string exp_par="repsup1_experimental_parameters.txt"; #the name of the item file with the experiment information
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
int num_items=int(double(current_filename.substring(current_filename.count()-1,2))); #assign how many items there are to a avariable
array<string>items[num_items];	#create an array which will contain the filenames of the items	
loop i=1 until i>(num_items) begin  #loop through each line in the item file
   current_filename=fil.get_line();	#get the list of characters that compose the current line in the itm file
	items[i]=current_filename.substring(4,current_filename.count()-3); #get just the item filename from that line
   i=i+1;	#increment the counter                 
end;                                


#~~~~~~~~~~~load the conditions~~~~~~~~						
string current_filename2;  #create a string variable for the condition names	
input_file fil2 = new input_file;   #create an input file
fil2.open(cnd_file);	#load the item file data into the input file
current_filename2=fil2.get_line();	#get the first line of the condition file (column headers)
int num_cnds=int(double(current_filename2.substring(current_filename2.count()-1,2))); #assign how many cnds there are to a variable
array<string>cnd[num_cnds];       #create an array which will contain the item numbers for each condition  			
loop i=1 until i>num_cnds begin	#loop through each line in the cnd file
	current_filename2=fil2.get_line();	#get the list of characters that compose the current line in the cnd file 
   cnd[i]=current_filename2.substring(4,current_filename2.count()-3);	#get just the item numbers (not the condition number) from that line		
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

#determine the condition trial types
array<int>cnd_type_int[cnd.count()];	#create an array in which we will store the type of each condition
int kk;	#create an integer counter
loop kk=1 until kk>cnd.count() begin	#loop through each condition
	int cnd_num_images=(cnd[kk].count()+1)/3; #get the number of items in the current condition
	if (cnd_num_images==2) then	#if the condition has 2 items
		cnd_type_int[kk]=1;	#then assign type 1 for sample-match
	elseif (cnd_num_images==3) then	#otherwise, if the condtion has 3 items
		cnd_type_int[kk]=2;	#then assign type 2 for sample-distractor-match
	elseif (cnd_num_images==4 && cnd[kk].substring(cnd[kk].count()-1,2)!="-1") then #if the condition has 4 items and the last is not -1
		cnd_type_int[kk]=3;	#then assign type 3 for sample-distractor-distractor-match
	elseif (cnd_num_images==4 && cnd[kk].substring(cnd[kk].count()-1,2)=="-1") then	#if the condition has 4 items and the last is -1
		cnd_type_int[kk]=4;	#then assign type 4 for sample-distractor-distractor
	end;
	kk=kk+1;	#increment the counter
end;

array<string>cnd_type[4];	#create an array that we will put the name of the cnd type into		
cnd_type[1]="sample-match";	#if cnd type is 1, then the name is "sample-match"
cnd_type[2]="sample-distractor-match";	#if cnd type is 2, then the name is "sample-distractor-match"
cnd_type[3]="sample-distractor-distractor-match";	#if cnd type is 3, then the name is "sample-distractor-distractor-match"
cnd_type[4]="sample-distractor-distractor";	#if cnd type is 4, then the name is "sample-distractor-distractor"

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

array<int>cnd_correct[cnd.count()];	#create an array which will count the number of times has been correctly performed
cnd_correct.fill(1,cnd.count(),0,0);	#initialize to zero the number of times each cnd has been correctly performed
array<int>cnd_times_shown[cnd.count()];	#create an array which will count the number of times each cnd has been shown  
cnd_times_shown.fill(1,cnd.count(),0,0);	#initialize to zero the number of times each cnd has been shown
int times_cue_shown=0;	#create an integer that will count the number of times a cue has been shown, initialize to zero
int times_cue_achieved=0;	#create an integer that will count the number of times a cue has been achieved, initialize to zero
array<int>type_correct[cnd.count()];	#create an integer that will count the number of times each type of cnd has been correctly performed
type_correct.fill(1,cnd.count(),0,0);	#initialize to zero the number of times each type of cnd has been correctly performed
array<int>type_times_shown[cnd.count()];	#create an integer that will count the number of times each type of cnd has been shown
type_times_shown.fill(1,cnd.count(),0,0);		#initialize to zero the number of times each type of cnd has been shown
int overall_cnd_correct=0;	#create an integer for the number of correctly performed cnds overall; initialize to zero
int overall_cnd_shown=0;	#create an integer for the number of cnds shown overall; initialize to zero

string cur_cnd_per="NaN";	#create a string that will hold the %accuracy of the current cnd being shown
string init_trial_per="NaN";	#create a string that will hold the % of times a trial is initiated when a cue is shown
string overall_cnd_per="NaN";	#create a string that will hold the overall % accuracy when images are shown
array<string>type_per[4];	#create a string that will hold the %accuracy of each trial type
int tt;	#create an integer counter
loop tt=1 until tt>4 begin	#loop through each condition type
	type_per[tt]="NaN";#and initialize the cnd type to "not yet shown"
	tt=tt+1;#increment the counter
end;

#create some titles that we will use when presenting information during the experiment
string current_cnd_title="\ncnd: ";
string current_attempt_num="\  | trial: ";
string current_cnd_percent="\  | cnd%accuracy: ";
string percent_intiate_trial="\ncue%: ";
string percent_correct_cnds="\  |  all cnd%accuracy: ";
string percent_correct_SM="\nSM: ";
string percent_correct_SDM="\  |  SDM: ";
string percent_correct_SDDM="\  |  SDDM: ";
string percent_correct_SDD="\  |  SDD: ";

#loop through the experiment for the number of trials specified for each condition
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
	
		if (cnd_times_shown[cnds_to_show2[1]]>0) then	#if the condition has been shown at least once, then calculate that condition's percentage
			cur_cnd_per=string(int(100.0*double(cnd_correct[cnds_to_show2[1]])/double(cnd_times_shown[cnds_to_show2[1]])));
		end;
		
		#display information about the current condition
		term.print(current_cnd_title + string(cnds_to_show2[1]) + ", "+cnd_type[cnd_type_int[cnds_to_show2[1]]] +current_attempt_num
		+ string(cnd_times_shown[cnds_to_show2[1]]+1)
		 + current_cnd_percent + cur_cnd_per +"\n");
		int num_images=(cnd[cnds_to_show2[1]].count()+1)/3; #get the number of items in the current condition
		
		#~~~~~~~~~~~present the cue image~~~~~~~~	
		#create and initiate a boolean which says if the monkey is performing the trial correctly so far
		bool trial_is_correct=true;	#a boolean for the overall correctness of the trial
		bool cue_achieved=true;	#a boolean for the cue correctness
		
		cue.present(); #begin the cue image period
		times_cue_shown=times_cue_shown+1;	#increment the number of times the cue has been shown
		
		#check to see whether the lever was pressed during the cue
		stimulus_data last = stimulus_manager.last_stimulus_data();
		
		#if the lever was pressed in response to the cue then....
		if (last.type() == stimulus_hit) then
			times_cue_achieved=times_cue_achieved+1;
			cue_achieved=true;
			#~~~~~~~present the sample image ~~~~~~
			sample_bmp.unload();	#unload the placeholder filename for the sample
			sample_bmp.set_filename(items[int(double(cnd[cnds_to_show2[1]].substring(1,2)))]); #get the sample item filename
			sample_bmp.load();	#load the sample item filename
			sample.present();	#begin the sample image period

			#check to see whether the lever was released during the sample image
			stimulus_data last4 = stimulus_manager.last_stimulus_data();
	
			#if the lever was released during the sample image then....
			if (last4.type() == stimulus_hit) then
				trial_is_correct=false;	#...the monkey has performed the trial incorrectly
			end;

			#if the lever was not released during the sample image then...
			if (trial_is_correct) then
				#loop through and present all distractor images
				loop i=2 until i==num_images begin #distractors will be the 2nd,3rd,4th,etc. item, but not the last item
				
					#~~~~~~~present the distractor image ~~~~~~
					inter_image_delay.present();	#display a blank screen before the next image is shown
					distractor_bmp.unload(); #unload the placeholder filename for the distractor
					distractor_bmp.set_filename(items[int(double(cnd[cnds_to_show2[1]].substring(1+3*(i-1),2)))]); #get the distractor item filename
					distractor_bmp.load();	#load the distractor item filename
					distractor.present();	#begin the distractor image period
			
					#check to see whether the lever was released during the distractor image
					stimulus_data last3 = stimulus_manager.last_stimulus_data();
			
					#if the lever was released during the sample image then....
					if (last3.type() == stimulus_hit) then 
						trial_is_correct=false; #...the monkey has performed the trial incorrectly
						break;	#the trial was incorrect, so don't show subsequent distractors
					end;
					i=i+1;	#increment counter for distractor image loop
				end;
			end;
	
			#if the lever was not released during the sample or distractor images then...
			if (trial_is_correct) then
	
				#if the last item in the condition is an actual item number (i.e. not "-1") then	
				if (int(cnd[cnds_to_show2[1]].substring(cnd[cnds_to_show2[1]].count()-1,2))!=-1) then			
				
					#~~~~~~~present the match image ~~~~~~
					inter_image_delay.present();	#display a blank screen before the next image is shown
					match_bmp.unload();	#unload the placeholder filename for the match
					match_bmp.set_filename(items[int(double(cnd[cnds_to_show2[1]].substring(cnd[cnds_to_show2[1]].count()-1,2)))]);#get the match item filename
					match_bmp.load();	#load the match image
					match.present();	#begin the match image period
			
					#check to see whether the lever was released during the distractor image
					stimulus_data last2 = stimulus_manager.last_stimulus_data();
		
					#if the lever was  held through the match image then...
					if (last2.type() != stimulus_hit) then
						trial_is_correct=false; #...the monkey has performed the trial incorrectly
					end;	
				end;
			end;
			
			cnd_times_shown[cnds_to_show2[1]]=cnd_times_shown[cnds_to_show2[1]]+1;	#increment the number of times the current condition has been shown
			overall_cnd_shown=overall_cnd_shown+1;	#increment the total number of times that cnds have been shown
			type_times_shown[cnd_type_int[cnds_to_show2[1]]]=type_times_shown[cnd_type_int[cnds_to_show2[1]]]+1;	#increment the number of times this type of cnd has been shown
		
		else #if the monkey let go during the cue
			cue_achieved=false; #...the monkey has performed the trial incorrectly
		end;
		
		int tempcnd;	#create a variable in wich to store the current cnd number for later use
		
		#if the monkey did not press for the cue, then...
		if (cue_achieved==false) then 
			iti_incorrect.present();	#begin the incorrect ITI period
			
		#if the trial was correct then... 
		elseif (trial_is_correct==true && cue_achieved==true) then
			tempcnd=cnds_to_show2[1];	#assign the current cnd number to this temporary variable
			cnd_correct[cnds_to_show2[1]]=cnd_correct[cnds_to_show2[1]]+1;	#increment the number of times this cnd has been correctly performed
			overall_cnd_correct=overall_cnd_correct+1;	#increment the number of times that all cnds have been performed correctly
			type_correct[cnd_type_int[cnds_to_show2[1]]]=type_correct[cnd_type_int[cnds_to_show2[1]]]+1;	#increment the number of times that cnds of this type have been correctly performed
			marker.send_code(64,500);  #...deliver a juice reward
			iti_correct.present();		#begin the correct ITI period
		
			array<int>temp_cnd_shower[cnds_to_show2.count()-1];	#create a temporary array
			int k;	#create an integer counter
			loop k=1 until k>cnds_to_show2.count()-1 begin	#loop through each condition
				temp_cnd_shower[k]=cnds_to_show2[k+1];	#rewrite all conditions but the one just completed to the array
				k=k+1;	#increment the counter
			end;
			cnds_to_show2.resize(cnds_to_show2.count()-1);	#resize the array
			cnds_to_show2=temp_cnd_shower;	#assign the temporary array to the global cnd_to_show array
		#if the monkey performed the trial incorrectly, then...
		elseif (trial_is_correct==false) then 
				tempcnd=cnds_to_show2[1];	#assign the current cnd number to this temporary variable
				iti_incorrect.present();	#begin the incorrect ITI period
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
	
		overall_cnd_per=string(int(100.0*double(overall_cnd_correct)/double(overall_cnd_shown)));	#calculate the %accuracy of all cnds
		type_per[cnd_type_int[tempcnd]]=string(int(100.0*double(type_correct[cnd_type_int[tempcnd]])/double(type_times_shown[cnd_type_int[tempcnd]])));	#calculate the %accuracy of thi type of cnd
		init_trial_per=string(int(100.0*double(times_cue_achieved)/double(times_cue_shown)));	#calculate the % of time a cue is inititated
		
		#print out the percent results
		term.print(percent_intiate_trial+ init_trial_per+ "% (of " + string(times_cue_shown)+ ")"
		+ percent_correct_cnds+overall_cnd_per+ "% (of " + string(overall_cnd_shown)+ ")"
		+ percent_correct_SM + type_per[1] + "% (of "+ string(type_times_shown[1]) +")"
		+ percent_correct_SDM + type_per[2]+ "% (of "+ string(type_times_shown[2]) +")"
		+ percent_correct_SDDM + type_per[3]+ "% (of "+ string(type_times_shown[3]) +")"
		+ percent_correct_SDD + type_per[4]+ "% (of "+ string(type_times_shown[4]) +")");
	end;
	
	current_trial=current_trial+1;	#increment the trial counter
end;

