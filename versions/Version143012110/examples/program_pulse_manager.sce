scenario = "PCL program_pulse_manager example";
scenario_type = fMRI_emulation;
scan_period = 1000;

default_font_size = 24;

begin;

picture {} default;

picture {
   text { caption = "Pulse: 0"; } text1;
   x = 0; y = 0; 
} pic1;

begin_pcl;

pic1.present();

int pulses = 0;
loop until false begin
   if (pulse_manager.main_pulse_count() > pulses) then
      pulses = pulse_manager.main_pulse_count();   
      int time = pulse_manager.main_pulse_time( pulses );
      text1.set_caption( "Pulse: " + string( pulses ) +
                         "\nTime: " + string( time ) );
      text1.redraw();
      pic1.present()
   end
end