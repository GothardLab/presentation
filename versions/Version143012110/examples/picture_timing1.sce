scenario = "picture timing example 1";
no_logfile = true;
begin;

picture {} default;
picture { default_code = "pic"; } pic;

trial {
   picture pic;
   time = 0;
   picture pic;
   time = 50;
   picture pic;
   time = 100;  
   picture pic;
   time = 150;
   picture pic;
   time = 200;
};