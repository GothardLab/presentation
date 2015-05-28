# This scenario requires 2 active response buttons
scenario = "PCL trial example"; 
no_logfile = true;
active_buttons = 2;
button_codes = 1, 2; 
begin; 

picture {} default;

trial {     
   trial_duration = 2500;
   
   stimulus_event {
      picture {
         text { caption = "original"; font_size = 24; } text1;
         x = 0; y = 0;
      };
   } event1;
} trial1; 

begin_pcl;

sub
   display( string caption )
begin
   text1.set_caption( caption );
   text1.redraw();
   trial1.present()
end;

trial1.set_start_time( 2000 );
display( "set_start_time( 2000 )" );  

trial1.set_start_delay( 1000 );
display( "set_start_delay( 1000 )" );
                 
trial1.set_start_delay( 0 );
trial1.set_duration( 4000 );
display( "set_duration( 4000 )" );  

trial1.set_duration( forever );
trial1.set_type( first_response );
display( "set_duration( forever )\nset_type( first_response )" );

trial1.set_type( nth_response );
trial1.set_max_responses( 3 );
display( "set_type( nth_response )\nset_max_responses( 3 )" );

trial1.set_all_responses( false );
trial1.set_type( first_response );
trial1.set_duration( 7000 );
display( "set_all_responses( false )\nset_type( first_response )\nset_duration( 7000 )\nno target" );

trial1.set_duration( forever );
event1.set_target_button( 1 ); 
display( "set_all_responses( false )\nset_type( first_response )\nset_duration( forever )\ntarget" );