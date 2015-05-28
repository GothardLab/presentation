response_matching = simple_matching;
default_font_size = 48;

begin;

array {
	text { caption = "A"; description = "A"; } A;
	text { caption = "B"; description = "B"; };
	text { caption = "C"; description = "C"; };
	text { caption = "D"; description = "D"; };
	text { caption = "E"; description = "E"; };
} letters;

trial {
	trial_duration = 2000;
	
	stimulus_event {
		picture {
			text A;
			x = 0; y = 0;
		} pic;
		time = 0;
		duration = 1000;
	} event1;
} main_trial;

begin_pcl;

input_port iport = input_port_manager.get_port( 1 );

loop int k = 1 until k > 3 begin
	letters.shuffle();
	iport.new_code_count();
	loop until iport.new_code_count() != 0 && iport.last_code() == 5 begin end;
	loop int i = 1 until i > letters.count() begin
		pic.set_part( 1, letters[i] );
		event1.set_event_code( letters[i].description() );
		main_trial.present();
		i = i + 1
	end;
	k = k + 1
end