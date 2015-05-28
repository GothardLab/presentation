# This scenario assumes there are file "transparent.bmp", 
# in the default stimuli directory

scenario = "transparent text example"; 

default_delta_time = 3000;   
default_picture_duration = 3000; 
default_font_size = 24;

begin;  

text { caption = "Hello"; font = "system"; font_color = 0,255,0; font_size = 48; } original;
text { caption = "Hello"; font = "system"; font_color = 0,255,0; font_size = 48; transparent_color = 0,0,0; } trans; 
bitmap { filename = "transparent.bmp"; } map;

picture {} default;

trial {
   picture {                                 
      text original;
      x = 0; y = 0;                         
      text { caption = "original text"; };
      x = 0; y = -200;
   };
   time = 0;    
   
   picture {                                              
      bitmap map;
      x = 0; y = 0;                         
      text { caption = "picture part 1"; };
      x = 0; y = -200;
   };              
   
   picture {                                               
      bitmap map;
      x = 0; y = 0; 
      text trans;
      x = 0; y = 0;                        
      text { caption = "transparent_color = 0,0,0"; };
      x = 0; y = -200;
   };    
};