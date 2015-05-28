scenario = "start_time example";
default_font_size = 48;
begin; 

picture {} default;

trial {     
   picture { text { caption = "Trial 1"; }; x = 0; y = 0; };
   time = 0;
   duration = 1000;
};                 

trial {     
   start_time = 1500;
   
   picture { text { caption = "Trial 2"; }; x = 0; y = 0; };
   time = 0; 
   duration = 1000;
};

trial {     
   start_time = 3000;
   
   picture { text { caption = "Trial 3"; }; x = 0; y = 0; };
   time = 0; 
   duration = 1000;
};   