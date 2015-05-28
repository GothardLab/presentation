write_codes = true;
active_buttons=2;

begin;

box { color=255,255,255; height=10; width=10; }fixspot;

bitmap { filename="26fgee02.bmp"; }target_bmp;
picture { }target_pic;
picture {} default;

trial {
	picture default;
	duration=500;
}isi;

trial {
	picture default;
	duration=5000;
}timeout;

begin_pcl;

int i; #the loop variable

#set the item file
string item_file="repsup1.itm";

#define output port for marker codes, juice, 1401 trigger
output_port marker;
marker = output_port_manager.get_port( 1 );

#define input port for eye data from ISCAN
input_port iscan;
iscan = input_port_manager.get_port( 1 );

output_file ofile = new output_file;
ofile.open("dms_test.txt");

## -- load in trial information -- ##
int num_items=7;							#
array<string>items[num_items];      #
input_file fil = new input_file;    #
fil.open( item_file );         		#
loop i=1 until i>num_items begin    #
   items[i]=fil.get_string();			#
   i=i+1;                           #
end;                                #
### ----------------------------- ###  

/*
sub synchronize begin
   # ignore everything until -35
	iscan.clear();
   loop
      i = 0;
		until false begin
      if (iscan.total_count() > i) then
         i = i + 1;
         if (iscan.codes( i ) == 13) then #looks for the stereotyped entry near the beginning of each XY data block
            iscan.clear( 1, i );
            break
         end
      end
   end
end;

sub int decipher_codes(int codes1, int codes2, int codes3) begin
if (codes1<0) then codes1=0; end;
if (codes2<0) then codes2=0; end;
if (codes3<0) then codes3=0; end;
int val = (codes1)*100+(codes2)*10+(codes3);
return val
end;

sub array<int,1> get_XY_codes begin
	array<int> eye[2];
	loop until (iscan.total_count()>=7) begin end;
	eye[1]=decipher_codes(iscan.codes(3)-48,iscan.codes(4)-48,iscan.codes(5)-48);
	iscan.clear(1,7);
	loop until (iscan.total_count()>=7) begin end;
	eye[2]=decipher_codes(iscan.codes(3)-48,iscan.codes(4)-48,iscan.codes(5)-48);
	return eye
end;

sub bool check_eye(int xyrange, int dur) begin
return true;
end;

array<int> eyeval[2];

synchronize();
eyeval=get_XY_codes();
*/

int num_res;
bool res_toggle;
bool abort;
bool used;
bool time_up;
int max_cue_dur=2000;
int max_stim_dur=2000;
array<int> remaining_items[num_items];
remaining_items.fill(1,num_items,1,1);
array<int> randomized_items[num_items] = remaining_items;
array<int> used_items[1] = {0};
array<int> distractor_items[1];
int target_stim_idx;
int trial_onset;
int image_onset;
int num_distractors;
int d; #loop counter for distractor presentation


#ofile.print(string()+"\n");

loop int triali=1 until triali>num_items begin
	
	num_distractors=random(1,3);
	ofile.print(string(num_distractors)+"\n");
	
	#choose target from set of images not yet used successfully as targets
	loop until true begin;
	randomized_items.shuffle();
		loop until i==used_items.count() begin;
			if randomized_items[1]==used_items[i] then
				used=true;
			end;
			if used==false then
				break 
			end;
		end;
	end;
	
	#load and display target image
	target_bmp.unload();
	target_bmp.set_filename(items[randomized_items[1]]);
	target_bmp.load();
	target_pic.add_part(target_bmp,0,0);
	target_pic.present();
	trial_onset=clock.time();
	
	# reinitialize
	abort=false; time_up=false; res_toggle=false;
	
	num_res=response_manager.response_count();
   loop until time_up begin # ----------------------- #
      # check to see if a response was made...           #
      if response_manager.response_count()>num_res then   #
         res_toggle=true;                              #
      end;
      if response_manager.response_count()>num_res+1 then
			res_toggle=false;
			break
		end;
      if clock.time()-trial_onset > max_cue_dur then   #
         time_up=true;				                         #
      end;                                                #
   end; # end within-trial loop ------------------------ #  
	
	# get rid of cue picture
	default.present();

	# something to define picture order and correct picture
	loop d=1 until d>num_distractors begin;
		
		#if there was no response, don't even show distractors
		if res_toggle==false then
			abort=true; 
			break
		end;
		
		# reinitialize
		abort=false; time_up=false;
		
		#show isi
		isi.present();
		
		# choose and load the distractor image
		target_bmp.unload();
		target_bmp.set_filename(items[randomized_items[2]]);
		target_bmp.load();
		target_pic.add_part(target_bmp,0,0);
		target_pic.present();
		image_onset=clock.time();
		
		num_res=response_manager.response_count();
		loop until time_up begin # ---------------------------#
			# check to see if a response was made...           	#
			if response_manager.response_count()>num_res then 
				abort=true;														#
				break;															#
			end;
			# no response made; keep stim onscreen             	#
			if clock.time()-image_onset>max_stim_dur then
				time_up=true;
			end;
      end; # end if-res loop
      if abort then break end;
      d=d+1;
   end; # end within-trial loop ------------------------ #   
   
	# check to see if monkey made the right choice, and respond accordingly
	if abort then
		#error
		timeout.present();
	else
		# give juice
		triali=triali+1;
		used_items.add(randomized_items[1]);
	end;
end;
