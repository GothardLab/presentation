# One input port must be selected for this scenario
# put port in logging mode to test total_count()
# and codes(int)

scenario = "PCL input_port example"; 
no_logfile = true;
default_font_size = 24;
begin;   

picture {} default;    

picture {
   text { caption = "current_value():"; };
   x = -50; y = 200;
   text { caption = " "; } current_value_text;
   x = 100; y = 200;       
   text { caption = "last_code():"; };
   x = -50; y = 150;
   text { caption = " "; } last_code_text; 
   x = 100; y = 150;
   text { caption = "total_count():"; };
   x = -50; y = 100;
   text { caption = " "; } total_count_text;
   x = 100; y = 100;
   text { caption = "codes:"; };
   x = 0; y = 50;
   text { caption = " "; } codes_text;
   x = 0; y = 0;
} pic1;

begin_pcl;

input_port port;

# subroutine to draw information from the input port
sub
   draw_values
begin     
   last_code_text.set_caption( string( port.last_code() ) );
   last_code_text.redraw();
   total_count_text.set_caption( string( port.total_count() ) );
   total_count_text.redraw();  
   string codes_string;
   loop
      int i = 1
   until
      i > port.total_count()
   begin
      if (i > 1) then
         codes_string = codes_string + ", "
      end;
      codes_string = codes_string + string( port.codes( i ) ); 
      if (codes_string.count() > 30) then
         codes_string = codes_string + "\n";
      end;
      i = i + 1
   end;
   codes_text.set_caption( codes_string );
   codes_text.redraw();
end;

if (input_port_manager.port_count() == 0) then
   codes_text.set_caption( "No input ports selected!" );  
   codes_text.set_font_color( 255, 0, 0 ); 
   codes_text.redraw(); 
   pic1.present();
   loop until false begin end
else
   port = input_port_manager.get_port( 1 );
   loop until false begin
      if (bool( port.new_code_count() )) then   
         draw_values()
      end;
      current_value_text.set_caption( string( port.current_value() ) );
      current_value_text.redraw();
      pic1.present()
   end
end 