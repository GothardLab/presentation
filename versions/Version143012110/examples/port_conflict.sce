# This scenario requires that you have defined a parallel 
# output port in the experiment settings    

scenario = "parallel port conflict example";
no_logfile = true;
write_codes = true;
pulse_width = 100;   

begin;

trial {
   nothing {};  
   code = "stim 1";
   time = 0;         
   port_code = 255;
   
   nothing {}; 
   port_code = 255;  
   code = "stim 2";
   time = 80;              
   
   stimulus_event {
      nothing {}; 
      port_code = 255; 
      time = 200;
   }; 
};