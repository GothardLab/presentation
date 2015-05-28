scenario = "hello";

active_buttons = 1;
button_codes = 1;

begin;

picture {} default;

picture {
   text {
      caption = "Welcome\nto\nPresentation";
      font_size = 36;
      font_color = 100,200,200;
   };
   x = 0; y =0;
   text {
      caption = "(Press response button to continue)";
   };
   x = 0; y = -200;
} pic1;

trial {
   trial_type = first_response;
   trial_duration = forever;
   
   picture pic1;
   code = "pic1";
};