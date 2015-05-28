response_matching = simple_matching;
active_buttons = 2;
button_codes = 1,2;
default_font_size = 24;
no_logfile = true;
begin;

picture {} default;

trial {
	trial_duration = forever;
	trial_type = first_response;
	all_responses = false;
	
	picture default;
	
	stimulus_event {
		picture {
			text { caption = "Press the button"; };
			x = 0; y = 0;
		};
		time = 1000;
		response_active = true;
	};
} trial1;

begin_pcl;

loop int i = 1 until i > 5
begin
	trial1.present();
	i = i + 1
end;