# The WRONG way to present a sequence of small duration pictures
scenario = "picture timing example 4";  
no_logfile = true;
begin;

picture {} default;
picture { default_code = "pic"; } pic;  

trial {        
   LOOP $i 100;
   picture pic;
   duration = 20;
   delta_time = 20;
   ENDLOOP;
};