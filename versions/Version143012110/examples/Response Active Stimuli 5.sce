response_matching = simple_matching;
active_buttons = 1;
button_codes = 1;
default_font_size = 24;
no_logfile = true;
begin;

trial {
	trial_duration = 3000;
	trial_type = first_response;
	all_responses = false;

	stimulus_event {
		picture {
			text { caption = "Don't press the button"; };
			x = 0; y = 0;
		};
		response_active = true;
	} event1;
	
} trial1;

begin_pcl;

trial1.present();
stimulus_data last = stimulus_manager.last_stimulus_data();

if last.type() == stimulus_false_alarm then
	term.print("Type: stimulus_false_alarm");
elseif last.type() == stimulus_other then
	term.print("Type: stimulus_other");
end;
