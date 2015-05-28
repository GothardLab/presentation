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
         text A; x = 0; y = 0;
      } pic;
      time = 0;
      duration = 1000;
   } event1;
} main_trial;

trial { trial_duration = 1000; } wait_trial;

begin_pcl;

int repeat_count = 3;
int count = letters.count() * repeat_count;
array<int> sequence[count];
loop int i = 1 until i > count begin
   loop int k = 1 until k > letters.count() begin
      sequence[i] = k;
      k = k + 1;
      i = i + 1
   end
end;

sub
   bool sequence_ok( int limit )
begin
   bool rval = true;
   int last = 0;
   int in_a_row = 0;
   loop int i = 1 until i > sequence.count() begin
      if (sequence[i] == last) then
         in_a_row = in_a_row + 1;
         if (in_a_row > limit) then
            rval = false;
            break
         end
      else
         in_a_row = 1
      end;
      last = sequence[i];
      i = i + 1
   end;
   return rval
end;

sequence.shuffle();
loop until sequence_ok( 2 ) begin
   sequence.shuffle()
end;
wait_trial.present();
loop int i = 1 until i > sequence.count() begin
   int index = sequence[i];
   pic.set_part( 1, letters[index] );
   event1.set_event_code( letters[index].description() );
   main_trial.present();
   i = i + 1
end
