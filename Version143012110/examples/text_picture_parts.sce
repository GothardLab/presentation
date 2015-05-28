scenario = "text picture part example 1"; 
no_logfile = true;
default_font_size = 24;  
default_delta_time = 2000;
default_picture_duration = 2000;
begin;  

picture {} default;
                       
trial {
   picture {
      text { 
         caption = "Default text"; 
      };
      x = 0; y = 0;
   };
   time = 0;
   
   picture {
      text {
         caption = "text_align = align_left\nline2\nline3"; 
         text_align = align_left;
      };
      x = 0; y = 0;
   };            
   
   picture {
      text {
         caption = "text_align = align_right\nline2\nline3"; 
         text_align = align_right;
      };
      x = 0; y = 0;
   };                   
   
   picture {
      text {
         caption = "font_size = 48"; 
         font_size = 48;
      };
      x = 0; y = 0;
   };                          
   
   picture {
      text {
         caption = "width = 400\nheight = 400\nbackground_color = 0,0,255"; 
         width = 400;
         height = 400; 
         background_color = 0,0,255;
      };
      x = 0; y = 0;
   };                                 
   
   picture {
      text {
         caption = "font_color = 0,255,0";  
         font_color = 0,255,0;
      };
      x = 0; y = 0;
   };                                       
   
   picture {
      text {
         caption = "font = \"Courier New\"";  
         font = "Courier New";
      };
      x = 0; y = 0;
   };  
};