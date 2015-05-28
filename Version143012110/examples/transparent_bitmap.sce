# This scenario assumes there are file "transparent.bmp", 
# in the default stimuli directory
scenario = "transparent bitmap example"; 
no_logfile = true;
default_delta_time = 3000;   
default_picture_duration = 3000; 
default_font_size = 24;
begin;  

bitmap { filename = "transparent.bmp"; } original;
bitmap { filename = "transparent.bmp"; transparent_color = 255,255,255; } trans;
text { caption = "Hello!"; font_size = 48; } hello;

picture {} default;

trial {
   picture {                                 
      bitmap original;
      x = 0; y = 0;                         
      text { caption = "original graphic"; };
      x = 0; y = -200;
   };
   time = 0;    
   
   picture {                                              
      text hello;
      x = 0; y = 0;                         
      text { caption = "picture part 1"; };
      x = 0; y = -200;
   };              
   
   picture {                                               
      text hello;
      x = 0; y = 0; 
      bitmap trans;
      x = 0; y = 0;                        
      text { caption = "transparent_color = 255,255,255"; };
      x = 0; y = -200;
   };    
};