# This scenario requires that you add a parallel 
# output port to the experiment settings    

scenario = "parallel port output example";
no_logfile = true;
write_codes = true;
pulse_width = 20;   

begin;

trial {
   nothing {};  
   code = "stim 1";
   time = 0;         
   port_code = 255;
   
   nothing {}; 
   port_code = 255;  
   code_width = 50;
   code = "stim 2";
   time = 1000;              
   
   stimulus_event {
      nothing {}; 
      port_code = 255; 
      code_width = 100;
      time = 2000;
   }; 
};