# This scenario requires that you add at least two
# output ports to the experiment settings    

scenario = "port output example";
no_logfile = true;
write_codes = true;
pulse_width = 20; # if parallel port   

default_output_port = 2;

begin;

trial {
   nothing {};  
   code = "stim 1";
   time = 0; 
   port_code = 1;
   # uses default output port
   
   nothing {}; 
   port_code = 1;
   port = 1;
   code = "stim 2";
   time = 1000;              
   
   stimulus_event {
      nothing {}; 
      port_code = 2;  
      port = 2;
      time = 2000;
   };  
   
   nothing {};
   time = 3000;
   port_code = 2;
   port = 1;
};