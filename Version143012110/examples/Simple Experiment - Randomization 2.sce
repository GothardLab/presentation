response_matching = simple_matching;
default_font_size = 48;

begin;

text { caption = "A"; description = "A"; } A;
text { caption = "B"; description = "B"; } B;
text { caption = "C"; description = "C"; } C;
text { caption = "D"; description = "D"; } D;
text { caption = "E"; description = "E"; } E;

array {
   LOOP $i 3;
   text A; text B; text C; text D; text E;
   ENDLOOP;
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

letters.shuffle();
wait_trial.present();
loop int i = 1 until i > letters.count() begin
   pic.set_part( 1, letters[i] );
   event1.set_event_code( letters[i].description() );
   main_trial.present();
   i = i + 1
end
