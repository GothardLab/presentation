scenario = "Trials and Templates 8";

default_font_size = 48;
response_matching = simple_matching;
active_buttons = 1;
button_codes = 1;

begin;

text { caption = "red"; font_color = 255,0,0; } red;
text { caption = "flower"; } flower;
box { height = 1; width = 1; color = 0,0,0; } placeholder;

trial {
	trial_duration = 5000;
	trial_type = first_response;
	all_responses = false;
	
	stimulus_event {
		picture {
			box placeholder;
			x = 0; y = 0;
		} pic1;
		time = 0;
	} event1;
	
	stimulus_event {
		picture {
			box placeholder;
			x = 0; y = 0;
		} pic2;
		time = 1000;
		duration = 1000;
		response_active = true;
	} event2;
} main_trial;

begin_pcl;

pic1.set_part( 1, red );
event1.set_event_code( "red" );
pic2.set_part( 1, flower );
event2.set_event_code( "flower" );
main_trial.present();