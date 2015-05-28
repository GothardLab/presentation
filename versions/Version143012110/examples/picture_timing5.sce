scenario = "picture timing example 5";  
no_logfile = true;
begin;

picture {} default;
picture { default_code = "pic"; } pic;  

trial {        
   LOOP $i 100;
   picture pic;
   duration = 20;
   deltat = 20;
   ENDLOOP;
};