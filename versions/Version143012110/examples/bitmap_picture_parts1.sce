# This scenario assumes there are file "graphic1.jpg", 
# "graphic2.jpg", "graphic3.jpg" in the default
# stimuli directory
scenario = "bitmap picture part example 1"; 
no_logfile = true;
default_delta_time = 1000;   
default_picture_duration = 1000;

begin;

picture {} default;

bitmap { filename = "graphic1.jpg"; } graphic1;
bitmap { filename = "graphic2.jpg"; } graphic2;
bitmap { filename = "graphic3.jpg"; } graphic3;

trial {
   picture {
      bitmap graphic1;
      x = 0; y = 0;
   };
   time = 0;
   
   picture { 
      bitmap graphic1;
      x = 100; y = 0;
      bitmap graphic2;
      x = -100; y = 0;
   };    
   
   picture { 
      bitmap graphic3;
      x = 0; y = 0;
   };  
};