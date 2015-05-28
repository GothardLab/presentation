scenario = "Trials and Templates 1";

default_font_size = 48;

begin;

trial {
	trial_duration = 3000;
	
	picture {
		text { caption = "red"; font_color = 255,0,0; };
		x = 0; y = 0;
	};
	time = 0;
	
	picture {
		text { caption = "flower"; };
		x = 0; y = 0;
	};
	time = 1000;
	duration = 1000;
};