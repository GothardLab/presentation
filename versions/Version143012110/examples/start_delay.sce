scenario = "start_delay example";
default_font_size = 48;
begin; 

picture {} default;

trial {     
   trial_duration = 1000;
   
   picture { text { caption = "Trial 1"; }; x = 0; y = 0; };
   time = 0;
};                 

trial {     
   trial_duration = 1000; 
   start_delay = 500;
   
   picture { text { caption = "Trial 2"; }; x = 0; y = 0; };
   time = 0;
};

trial {     
   trial_duration = 1000;
   start_delay = 500;
   
   picture { text { caption = "Trial 3"; }; x = 0; y = 0; };
   time = 0;
};          

trial {     
   trial_duration = 1500;
   start_delay = 0;
   
   picture { text { caption = "+"; }; x = 0; y = 0; };
   time = 0;
   
   picture { text { caption = "Trial 4"; }; x = 0; y = 0; };
   time = 500;
};