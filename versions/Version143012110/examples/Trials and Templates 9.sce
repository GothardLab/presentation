scenario = "Trials and Templates 9";

default_font_size = 48;
response_matching = simple_matching;
active_buttons = 1;
button_codes = 1;

begin;

array {
	text { caption = "red"; font_color = 255,0,0; };
	text { caption = "green"; font_color = 0,255,0; };
	text { caption = "blue"; font_color = 0,0,255; };
} color_words;
array {
	text { caption = "flower"; };
	text { caption = "car"; };
	text { caption = "house"; };
} object_words;
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

color_words.shuffle();
object_words.shuffle();
loop int i = 1 until i > color_words.count() begin
	pic1.set_part( 1, color_words[i] );
	event1.set_event_code( color_words[i].caption() );
	pic2.set_part( 1, object_words[i] );
	event2.set_event_code( object_words[i].caption() );
	main_trial.present();

	i = i + 1
end