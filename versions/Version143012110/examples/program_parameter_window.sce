# program_parameter_window example  
no_logfile = true;
begin;

begin_pcl;

sub
   wait( int interval )
begin
   int end_time = clock.time() + interval;
   loop until clock.time() > end_time begin end
end;

int parm1 = parameter_window.add_parameter( "new parameter 1" );  
display_window.draw_text( "add_parameter" );
wait( 1500 );    

parameter_window.set_name_width( 20 );

int parm2 = parameter_window.add_parameter( "another long named parameter" );
display_window.erase();
display_window.draw_text( "add_parameter" ); 
wait( 1500 );

parameter_window.set_parameter( parm1, "value 1" ); 
display_window.erase();  
display_window.draw_text( "set_parameter" );
wait( 1500 );

parameter_window.set_name_width( text_column_width );  
display_window.erase();
display_window.draw_text( "set_name_width" );
wait( 1500 );

