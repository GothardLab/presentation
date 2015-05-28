no_logfile = true;
default_font_size = 24;
begin;

picture {} default;

trial {  
   trial_duration = 2500;
   
   picture {
      text { caption = " "; } text1;
      x = 0; y = 0;
   } pic1;
} trial1;      

picture {
   text { caption = "Enter string to send\nfollowed by return,\nor just return to quit"; };
   x = 0; y = 0;
} prompt;

trial {
   trial_duration = 1000;
   
   picture {
      text { caption = "Sending..."; };
      x = 0; y = 0;
   };
} sending;

begin_pcl;

sub
   show_text( string message )
begin
   text1.set_caption( message );
   text1.redraw();
   trial1.present()
end;

if (output_port_manager.port_count() == 0) then      
   show_text( "No output ports selected!" );
else
   output_port port = output_port_manager.get_port( 1 );
   
   port.set_pulse_width( 100 );
   port.send_code( 255 );  
   bool is_parallel = port.pulse_up(); 
   
   if (is_parallel) then     
      show_text( "Port is a parallel port" )
   else                                         
      show_text( "Port is a serial port" )           
   end;            
   
   string message = "About to send code 45";
   if (is_parallel) then
      message = message + "\npulse width 100 ms"
   end;
   show_text( message );
   port.send_code( 45 );
   
   message = "About to send code 255";
   if (is_parallel) then
      message = message + "\npulse width 50 ms"
   end;
   show_text( message );
   port.send_code( 255, 50 ); 
   
   if (!is_parallel) then  
      prompt.present();
      message = system_keyboard.get_input(); 
      loop until 
         message == ""
      begin
         port.send_string( message );
         sending.present();
         prompt.present();
         message = system_keyboard.get_input()
      end
   end
end