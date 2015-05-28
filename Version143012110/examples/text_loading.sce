scenario = "text loading example"; 
no_logfile = true;
default_font_size = 48;
begin;  

picture {} default;

array {
   text { caption = "These"; preload = false; } text1;   
   text { caption = "Are"; preload = false; };
   text { caption = "The"; preload = false; };
   text { caption = "Words"; preload = false; };
   text { caption = "To"; preload = false; };
   text { caption = "Be"; preload = false; };
   text { caption = "Presented"; preload = false; };  
} words;  

text { caption = "temp"; } for_palettized;

trial {
   trial_duration = 1000;
   
   picture {
      text text1;
      x = 0; y = 0;
   } pic1;
} main_trial;

begin_pcl;

# This is just an example of loading and unloading - 
# in this situation, it would be just as good to
# use text::set_caption and text::redraw

words.shuffle();

loop
   int i = 1
until
   i > words.count()
begin       
   words[i].load();
   pic1.set_part( 1, words[i] );   
   main_trial.present();
   words[i].unload();
   i = i + 1
end;