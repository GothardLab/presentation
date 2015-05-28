response_matching = simple_matching;
active_buttons = 1;
button_codes = 1;
default_font_size = 24;
no_logfile = true;
begin;

trial {
	trial_duration = forever;
	trial_type = first_response;
	
	stimulus_event {
		picture {
			text { caption = "Press the button"; };
			x = 0; y = 0;
		};
		response_active = true;
		code = "stim";
	};
} trial1;

begin_pcl;

trial1.present();
stimulus_data last = stimulus_manager.last_stimulus_data();
term.print( "Reaction time: " + string(last.reaction_time()) );
