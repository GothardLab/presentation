scenario = "picture timing example 2";
no_logfile = true;
default_picture_duration = 1;
begin;

picture {} default;
picture { default_code = "pic"; } pic;

trial {
   picture pic;
   time = 0;
   picture pic;
   time = 1;
   picture pic;
   time = 2;  
   picture pic;
   time = 3;
   picture pic;
   time = 4;
};