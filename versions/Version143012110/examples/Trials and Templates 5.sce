scenario = "Trials and Templates 5";

default_font_size = 48;
response_matching = simple_matching;
active_buttons = 1;
button_codes = 1;

begin;

text { caption = "red"; font_color = 255,0,0; } red;
text { caption = "flower"; } flower;

trial {
	trial_duration = 5000;
	trial_type = first_response;
	all_responses = false;
	
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
	response_active = true;
	code = "flower";
};