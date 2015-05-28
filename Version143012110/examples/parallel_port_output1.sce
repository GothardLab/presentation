#This scenario requires one parallel output port in the experiment
#settings

write_codes = true;
pulse_width = 10;
no_logfile = true;
begin;

trial {
   LOOP $i 100;
   $k = '$i + 1';
   nothing {};
   delta_time = 1000;
   port_code = $k;
   ENDLOOP;
};