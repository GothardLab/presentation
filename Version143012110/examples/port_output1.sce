# This scenario requires that you add at least one
# output port to the experiment settings    

scenario = "port output example";
no_logfile = true;
write_codes = true;
pulse_width = 20; # if parallel port

begin;

nothing { default_port_code = 1; } stim;

trial {
   nothing stim;  
   code = "stim 1";
   time = 0;
   # uses default port code
   
   nothing stim; 
   port_code = 2;
   code = "stim 2";
   time = 1000;              
   
   stimulus_event {
      nothing stim; 
      port_code = 3;
      time = 2000;
   };
};