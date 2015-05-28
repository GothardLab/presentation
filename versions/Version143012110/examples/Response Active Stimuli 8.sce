active_buttons = 1;
button_codes = 1;
no_logfile = true;
response_matching = simple_matching;
default_font_size = 48;

begin;


picture{} default;

trial {
	trial_duration = forever;
	trial_type = first_response;
	all_responses = false;	
	
	picture default;
	time = 0;
	
	stimulus_event {
		picture {
			text { caption = "Press the button"; };
			x = 0; y = 0;
		};
		time = 1000;
		stimulus_time_in = 200;
		response_active = true;
		code = "A";
	} event1;	
	
} main_trial;

begin_pcl;


loop int i = 1 until i > 5
begin
	main_trial.present();
	i = i + 1;
end;