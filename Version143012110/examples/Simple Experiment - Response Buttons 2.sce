response_matching = simple_matching;
default_font_size = 48;
active_buttons = 2;
button_codes = 1,2;

begin;

array {
   text { caption = "A"; description = "A"; } A;
   text { caption = "B"; description = "B"; };
   text { caption = "C"; description = "C"; };
   text { caption = "D"; description = "D"; };
   text { caption = "E"; description = "E"; };
} letters;

trial {
   trial_duration = 4000;
   trial_type = first_response;
   all_responses = false;

   picture {
      text { caption = "+"; font_size = 12; }; x = 0; y = 0;
   };
   time = 0;

   stimulus_event {
      picture {
         text A;
         x = 0; y = 0;
      } pic;
      time = 1000;
      duration = 1000;
      response_active = true;
   } event1;
} main_trial;

begin_pcl;

loop int i = 1 until i > letters.count() begin
   pic.set_part( 1, letters[i] );
   event1.set_event_code( letters[i].description() );
   main_trial.present();
   i = i + 1
end
