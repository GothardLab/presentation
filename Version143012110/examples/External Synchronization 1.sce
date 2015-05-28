response_matching = simple_matching;
default_font_size = 48;
scenario_type = fMRI_emulation;
scan_period = 2000;

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

loop int pulse = 2 until pulse > 18 begin
	letters.shuffle();
	loop until pulse_manager.main_pulse_count() >= pulse begin end;
	loop int i = 1 until i > letters.count() begin
		pic.set_part( 1, letters[i] );
		event1.set_event_code( letters[i].description() );
		main_trial.present();
		i = i + 1
	end;
	pulse = pulse + 8
end