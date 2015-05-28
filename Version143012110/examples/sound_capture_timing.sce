pcl_file = "sound_capture_timing.pcl"; 

active_buttons = 1;
button_codes = 1;

begin;

trial {
   trial_duration = 100;
   
   sound {
      wavefile { preload = false; } wave1;
   };
   code = "snd";   
   time = 50;
} trial1;