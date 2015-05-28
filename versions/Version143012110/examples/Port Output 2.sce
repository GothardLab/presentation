response_matching = simple_matching;
default_font_size = 48;
active_buttons = 2;
button_codes = 1,2;
write_codes = true;
pulse_width = 10;

begin;

array {
	text { caption = "A"; description = "A,10"; } A;
	text { caption = "B"; description = "B,11"; };
	text { caption = "C"; description = "C,12"; };
	text { caption = "D"; description = "D,13"; };
	text { caption = "E"; description = "E,14"; };
} letters;

trial {
	trial_duration = 4000;
	trial_type = first_response;
	all_responses = false;
	
	picture {
		text { caption = "+"; font_size = 12; }; x = 0; y = 0;
	};
	time = 0;
	
	stimulus_event {
		picture {
			text A;
			x = 0; y = 0;
		} pic;
		time = 1000;
		duration = 1000;
		response_active = true;
	} event1;
} main_trial;

begin_pcl;

loop int i = 1 until i > letters.count() begin
	pic.set_part( 1, letters[i] );
	string code = letters[i].description();
	int pos = code.find( "," );
	int port_code = int( code.substring( pos + 1, code.count() - pos ) );
	event1.set_event_code( code );
	event1.set_port_code( port_code );
	main_trial.present();
	i = i + 1
end