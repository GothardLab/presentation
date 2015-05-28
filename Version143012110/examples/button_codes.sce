# This scenario requires that you add at least one
# output port to the experiment settings 
# and that there are two active response buttons
# selected

scenario = "button_codes example";   
no_logfile = true;
active_buttons = 2;
button_codes = 1, 2;
target_button_codes = 11, 12;

write_codes = true;
pulse_width = 20; # if port is parallel 

default_font_size = 24;     
default_trial_type = first_response;
default_trial_duration = forever;

begin;

picture {} default;
picture {
   text { caption = "Target button is 1"; };
   x = 0; y = 0;
} target1;           
picture {
   text { caption = "Target button is 2"; };
   x = 0; y = 0;
} target2;        

LOOP $i 5;
trial {
   picture target1;
   target_button = 1;
};                   

trial {
   picture target2;
   target_button = 2;
};  
ENDLOOP;