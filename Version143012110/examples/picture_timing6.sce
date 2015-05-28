scenario = "picture timing example 6";  
no_logfile = true;
begin;

picture {} default;
picture { background_color = 255,0,0; default_code = "pic"; } pic;  

trial {        
   picture pic;
   duration = 5; 
   time = 0;
   
   picture pic;  # default shows in between
   deltat = 10; 
   duration = 5;
   
   picture pic;
   deltat = 10;
};