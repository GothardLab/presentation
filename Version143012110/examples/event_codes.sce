scenario = "event codes example";
no_logfile = true;
begin;

nothing { default_code = "default code"; } stim;

trial {
   nothing stim;
   time = 0;
   
   nothing stim;
   code = "code 1";
   time = 10;
   
   nothing stim;
   code = "code 2";
   time = 20;   
   
   nothing {};
   # no code - not in logfile
   time = 30;  
   
   nothing stim;
   code = ""; # same as no code
   time = 40;
   
   stimulus_event {
      nothing stim;
      code = "code 3";
      time = 50;
   };
};