scenario = "picture timing example 3";   
no_logfile = true;
default_picture_duration = 10;
begin;

picture {} default;
picture { default_code = "pic"; } pic;      
picture { default_code = "pic1"; } pic1;
picture { default_code = "pic2"; } pic2;

trial {
   picture pic;
   time = 0;
   picture pic;
   deltat = 10;
   picture pic; 
   deltat = 10;
   picture pic; 
   deltat = 10;
   picture pic; 
   deltat = 10;     
   picture pic; 
   deltat = 10;
   picture pic; 
   deltat = 10;
   picture pic; 
   deltat = 10;
   picture pic; 
   deltat = 10;
   picture pic; 
   deltat = 10;
   picture pic1; 
   deltat = 10;
   
   picture pic2;
   time = 200;
};