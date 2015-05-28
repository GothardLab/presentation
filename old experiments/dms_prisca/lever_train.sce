write_codes=true;
active_buttons=2;
pulse_width=1;
button_codes=41,42;

begin;

picture {}default;

sound { wavefile { filename="jad0022a.wav"; }; }correct_sound;
wavefile { filename="jad0024a.wav"; }wrong_sound;

box { width=10; height=1; color=255,255,255; }fixspot;

trial {
	trial_duration=1000;
	picture default;
}pause;

trial {
	trial_duration=2000;
	sound { wavefile wrong_sound; };
	picture default;
	port_code=34;	
}timeout;

trial {
	trial_duration=2;
	picture default;
	port_code=33;
}reward;

trial {
	trial_duration=500;
	picture {text {caption="iti";}; x=0; y=0;};
	port_code=34;
}iti;

trial {
	trial_duration=3000;
	trial_type=specific_response;
	terminator_button=2;
	max_responses=2;
	correct_feedback=reward;
	incorrect_feedback=timeout;
	no_response_feedback=timeout;
	picture { bitmap { filename="26fgee02.bmp"; }bmp;
	x=0; y=0; };
	target_button=1;
	port_code=32;
}pic;

begin_pcl;

#set the item file
string item_file="repsup1.itm";

#define output port for marker codes, juice, 1401 trigger
output_port marker;
marker = output_port_manager.get_port( 1 );

/*text file for debugging
output_file ofile = new output_file;
ofile.open("debug.txt");*/

int i; #the loop variable
int last_hit_count=0;
int DAL=32;

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

sub
   play( string message )
begin
   display_window.erase();
   display_window.draw_text( message );
end;

items.shuffle();

#trigger 1401 recording
marker.send_code(DAL+64);

#trial loop, presents randomized images until all have been presented
loop i=1 until i>items.count() begin;

	#set the image to a random one
	bmp.unload();
	bmp.set_filename(items[i]);
	bmp.load();

	#waits until the button is not pressed
	default.present();
	loop until (response_manager.last_response()==2) || (response_manager.last_response()==0) begin end;
	last_hit_count=response_manager.total_response_count();	
	pause.present();
	pic.present();
	if response_manager.total_response_count()==last_hit_count+1 then
		marker.send_code(128,1000);
		correct_sound.present();
		i=i+1;
	end;
	
	
end ;
