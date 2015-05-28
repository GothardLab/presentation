response_matching = simple_matching;
default_font_size = 48;
active_buttons = 1;
button_codes = 1;

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
	all_responses = false;
	
	stimulus_event {
		picture {
			text A;
			x = 0; y = 0;
		} pic;
		time = 0;
		duration = 500;
	} event1;
} main_trial;

begin_pcl;

sub
	int random_exclude( int first, int last, int exclude )
begin
	int rval = random( first, last - 1 );
	if (rval >= exclude) then
		rval = rval + 1
	end;
	return rval
end;

int stimulus_count = 100;

loop
   int i = 1;
	int last = 0;
	int two_back = 0;
until
   i > stimulus_count
begin
   int index;
	if (two_back == 0) then
		index = random( 1, letters.count() )
	elseif (random( 1, 4 ) == 1) then
		index = two_back
	else
		index = random_exclude( 1, letters.count(), two_back )
	end;
   pic.set_part( 1, letters[index] );
   event1.set_event_code( letters[index].description() );
   main_trial.present();
   two_back = last;
	last = index;
   i = i + 1
end