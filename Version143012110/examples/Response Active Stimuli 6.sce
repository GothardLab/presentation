active_buttons = 1;
button_codes = 1;
no_logfile = true;
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
	trial_type = first_response;
	
	stimulus_event {		
		picture {
			text A;
			x = 0; y = 0;
		} pic1;
		time = 0;
		code = "A";
	} event1;	
	
} main_trial;

text { caption = "Hit"; } hit; 
text { caption = "Incorrect"; } incorrect; 
text { caption = "False Alarm"; } fa; 
text { caption = "Miss"; } miss; 
text { caption = "Other"; } other; 

trial {
	trial_duration = 2000;
	
	picture {
		text hit; #set in pcl
		x = 0; y = 0;
	} feedback_pic;
	code = "feedback";

} feedback_trial;

begin_pcl;

text target = A;
letters.shuffle();

loop int i = 1 until i > letters.count()
begin
	pic1.set_part( 1, letters[i]);
	event1.set_event_code( letters[i].description() );
	if letters[i] == target then
		event1.set_target_button( 1 )
	else
		event1.set_target_button( 0 );
		event1.set_response_active( true );
	end;
	main_trial.present();
	stimulus_data last = stimulus_manager.last_stimulus_data();
	if last.type() == stimulus_hit then
		feedback_pic.set_part( 1, hit )
	elseif last.type() == stimulus_incorrect then 
		#this won't happen unless you have another active button
		feedback_pic.set_part( 1, incorrect )
	elseif last.type() == stimulus_false_alarm then
		feedback_pic.set_part( 1, fa )
	elseif last.type() == stimulus_miss then
		feedback_pic.set_part( 1, miss )
	elseif last.type() == stimulus_other then
		feedback_pic.set_part( 1, other )
	end;
	feedback_trial.present();
	i = i + 1;
end;


