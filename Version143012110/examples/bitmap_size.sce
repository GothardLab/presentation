# This scenario assumes there is a file "graphic4.bmp", 
# in the default stimuli directory
scenario = "bitmap size example"; 
no_logfile = true;
default_delta_time = 2000;   
default_picture_duration = 2000; 
default_font_size = 24;
begin;

picture {} default;

trial {
   picture {
      bitmap { filename = "graphic4.bmp"; };
      x = 0; y = 0;                         
      text { caption = "original size"; };
      x = 0; y = -200;
   };
   time = 0;    
   
   picture {
      bitmap { filename = "graphic4.bmp"; width = 350; };
      x = 0; y = 0;                         
      text { caption = "width = 350"; };
      x = 0; y = -200;
   };              
   
   picture {
      bitmap { filename = "graphic4.bmp"; height = 350; };
      x = 0; y = 0;                         
      text { caption = "height = 350"; };
      x = 0; y = -200;
   };                     
   
   picture {
      bitmap { filename = "graphic4.bmp"; height = 350; width = 350; };
      x = 0; y = 0;                         
      text { caption = "height = 350, width = 350"; };
      x = 0; y = -200;
   };
};