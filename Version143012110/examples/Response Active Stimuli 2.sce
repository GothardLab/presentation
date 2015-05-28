response_matching = simple_matching;
active_buttons = 1;
button_codes = 1;
default_font_size = 24;
no_logfile = true;
begin;

trial{
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

trial{
	trial_duration = 2000;
	
	picture {
		text { caption = "  "; } feedback_text; #set caption in pcl
		x = 0; y = 0;
	};

} feedback_trial;

begin_pcl;

loop int i = 1 until i > 5
begin
	trial1.present();
	stimulus_data last = stimulus_manager.last_stimulus_data();
	if last.reaction_time() <= 1000 then
		feedback_text.set_caption("Reaction time = " + string(last.reaction_time()) + " ms\nGood!" );
	else
		feedback_text.set_caption("Reaction time = " + string(last.reaction_time()) + " ms\nPlease respond faster." );
	end;
	feedback_text.redraw();
	feedback_trial.present();
	i = i + 1;
end;
