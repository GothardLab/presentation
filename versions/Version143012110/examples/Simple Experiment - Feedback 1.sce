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
      duration = 1000;
   } event1;
} main_trial;

begin_pcl;

text target = A;
letters.shuffle();
loop int i = 1 until i > letters.count() begin
   pic.set_part( 1, letters[i] );
   event1.set_event_code( letters[i].description() );
   if (letters[i] == target) then
      event1.set_target_button( 1 )
   else
      event1.set_target_button( 0 );
      event1.set_response_active( true )
   end;
   main_trial.present();
   i = i + 1
end
