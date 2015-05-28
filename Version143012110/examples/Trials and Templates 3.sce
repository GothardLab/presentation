scenario = "Trials and Templates 3";

default_font_size = 48;

begin;

text { caption = "red"; font_color = 255,0,0; } red;
text { caption = "flower"; } flower;

trial {
	trial_duration = 3000;
	
	picture {
		text red;
		x = 0; y = 0;
	};
	time = 0;
	code = "red";
	
	picture {
		text flower;
		x = 0; y = 0;
	};
	time = 1000;
	duration = 1000;
	code = "flower";
};