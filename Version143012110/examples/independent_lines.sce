# This scenario requires that you have defined a parallel 
# output port in the experiment settings     
# in independent lines mode

scenario = "parallel port independent lines example";
no_logfile = true;
write_codes = true;
pulse_width = 100;   

begin;

trial {
   nothing {};  
   time = 0;         
   port_code = 1;
   
   nothing {}; 
   port_code = 2; 
   time = 10;  
   
   nothing {};
   port_code = 4;
   time = 20;     
   
   nothing {};
   port_code = 24;
   time = 30;
};