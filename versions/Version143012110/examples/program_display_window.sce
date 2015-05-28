# PCL program_display_window example 
no_logfile = true;
begin;

begin_pcl;  

sub
   wait( int interval )
begin
   int end_time = clock.time() + interval;
   loop until clock.time() > end_time begin end
end;
 
sub
   display( string message )
begin
   display_window.erase();
   display_window.draw_text( message ); 
   wait( 1500 );
end; 

display( "draw_text" ); 

display_window.erase();
display_window.draw_text_left( "draw_text_left", 0, 0 );
wait( 1500 );
                   
display_window.set_background_color( 128, 128, 255 );  
display( "set_background_color" );

display_window.set_text_color( 255, 255, 0 ); 
display( "set_text_color" );

display_window.set_text_size( 36 );
display( "set_text_size" );
                
display_window.set_font_style( display_style_bold );
display( "set_font_style" );

display_window.add_font_style( display_style_italic );
display( "add_font_style" );

display_window.set_font_style( display_style_none );
display_window.set_font( "Courier New" );
display( "set_font" );  