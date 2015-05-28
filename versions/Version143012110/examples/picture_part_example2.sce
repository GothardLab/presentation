scenario = "Picture part example 2";
no_logfile = true;   
default_delta_time = 1000;  
default_picture_duration = 1000;  
begin;       

picture {} default;  

box { height = 100; width = 100; color = 255,0,0; } red;
box { height = 100; width = 100; color = 0,255,0; } green;
box { height = 100; width = 100; color = 0,0,255; } blue; 

trial {
   picture {
      box red;
      x = 0; y = 0;
   };
   time = 0;
   
   picture {
      box red;
      x = 0; y = 0;
      box green;
      x = 50; y = 50;
   };            
   
   picture {
      box red;
      x = 0; y = 0;
      box green;
      x = 50; y = 50; 
      box blue; 
      x = 60; y = -20;
   };                    
   
   picture {
      box red;
      x = 0; y = 0;
      box green;
      x = 50; y = 50; 
      box blue; 
      x = 60; y = -20;  
      box red;
      x = 20; y = 10;
   };                             
   
   picture {
      box red;
      x = 0; y = 0;
      box green;
      x = 50; y = 50; 
      box blue; 
      x = 60; y = -20;  
      box red;
      x = 20; y = 10;  
      box green;
      x = -20; y = -10;
   };                                  
   
   picture {
      box red;
      x = 0; y = 0;
      box green;
      x = 50; y = 50; 
      box blue; 
      x = 60; y = -20;  
      box red;
      x = 20; y = 10;  
      box green;
      x = -20; y = -10;  
      box blue;
      x = 0; y = 0;
   };
};