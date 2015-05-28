scenario = "Picture part coordinate example";
no_logfile = true;      
default_font_size = 24;  
default_delta_time = 3000;  
default_picture_duration = 3000;
begin;       

picture {} default;  

trial {
   picture {
      text { 
            caption = "x = 0\ntext_align = align_center";
      };
      x = 0; y = 0;
   };
   time = 0;
   
   picture {
      text {
         caption = "left_x = 0\ntext_align = align_left";
         text_align = align_left;
      };
      left_x = 0; y = 0;
   };              
   
   picture {
      text {
         caption = "right_x = 0\ntext_align = align_right";
         text_align = align_right;
      };
      right_x = 0; y = 0;
   };                  
   
   picture {
      text {
         caption = "y = 0\nline 2\nline 3"; 
         background_color = 0,0,255;
      };
      x = 0; y = 0;
   };                      
   
   picture {
      text {
         caption = "top_y = 0\nline 2\nline 3"; 
         background_color = 0,0,255;
      };
      x = 0; top_y = 0;
   };                            
   
   picture {
      text {
         caption = "bottom_y = 0\nline 2\nline 3"; 
         background_color = 0,0,255;
      };
      x = 0; bottom_y = 0;
   };       
};