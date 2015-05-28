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

trial {
	trial_duration = 1000;
} wait_trial;

begin_pcl;

wait_trial.present();
main_trial.present();