scenario = "Picture part example 1";
no_logfile = true;    
default_font_size = 24;  
default_delta_time = 3000;  
default_picture_duration = 3000;  
default_background_color = 0, 100, 100;

begin;       

picture {} default; 

text { caption = "Some text"; } text1; 

trial {
   picture { 
      text { caption = "Using default background color"; };
      x = 0; y = 0;
   };
   time = 0;
   
   picture {  
      text text1;
      left_x = 0;
      y = 100;
      text { caption = "More and longer test"; };
      left_x = 0;
      y = -100;
   };              
   
   picture {  
      background_color = 0,0,255;
   };                  
                        
   picture {
      background_color = 0,0,255;
      
      box { height = 200; width = 200; color = 0,255,0; };
      x = 0; y = 0;
      
      text { caption = "Hello"; background_color = 0,255,0; };
      x = 0; y = 0;
   };
};