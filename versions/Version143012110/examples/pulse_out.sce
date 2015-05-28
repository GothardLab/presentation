# This scenario requires that you add at least one
# output port to the experiment settings

scenario = "pulse_out example";  
no_logfile =true;
pulse_out = true;
pulse_value = 5;
pulse_width = 20; # if using parallel port

begin;     

trial {
   nothing {};
   time = 0;
   code = "stim 1";
   
   nothing {};
   time = 1000;
   code = "stim 2";
   
   nothing {};
   time = 2000;
   
   nothing {};
   time = 3000;
   code = "stim 4";   
};