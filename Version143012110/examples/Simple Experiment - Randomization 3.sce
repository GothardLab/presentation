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
array<text> sequence[count];
loop int i = 1 until i > count begin
   loop int k = 1 until k > letters.count() begin
      sequence[i] = letters[k];
      k = k + 1;
      i = i + 1
   end
end;

sequence.shuffle();
wait_trial.present();
loop int i = 1 until i > sequence.count() begin
   pic.set_part( 1, sequence[i] );
   event1.set_event_code( sequence[i].description() );
   main_trial.present();
   i = i + 1
end
