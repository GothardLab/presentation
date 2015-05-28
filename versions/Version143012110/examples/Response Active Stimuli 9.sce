active_buttons = 1;
button_codes = 1;
no_logfile = true;
response_matching = simple_matching;
default_font_size = 48;

begin;

picture{}default;

trial {
	trial_duration = 2000;
		
	stimulus_event {
		picture {
			text { caption = "Press the button"; };
			x = 0; y = 0;
		};
		target_button = 1;
		stimulus_time_in = 200;
		stimulus_time_out = 1200;
		code = "instruct";		
	}event1;	
	
	picture default;
	time = 1000;
	
} main_trial;

text { caption = "Correct!"; } correct; 
text { caption = "Miss!"; } miss; 

trial{
	trial_duration = 2000;
	
	picture {
		text miss; #set in pcl
		x = 0; y = 0;
	} feedback_pic;

} feedback_trial;

begin_pcl;

loop int i = 1 until i > 5
begin
	main_trial.present();
		stimulus_data last = stimulus_manager.last_stimulus_data();
	if last.type() == stimulus_hit then
		feedback_pic.set_part( 1, correct )
	elseif last.type() == stimulus_miss then
		feedback_pic.set_part( 1, miss )
	end;
	feedback_trial.present();
	i = i + 1;
end;

