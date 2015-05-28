# This scenario requires 2 active buttons

scenario = "PCL response_manager example";  

default_font_size = 18;

active_buttons = 2;
button_codes = 1, 2;   
response_matching = simple_matching;

begin;    

picture {} default; 

trial {
   trial_duration = forever;
   trial_type = first_response;
   
   stimulus_event {
      picture {
         text { caption = "temp"; } text1;
         x = 0; y = 0;
      };
   } event1;
} main_trial;

trial {   
   trial_duration = forever;
   trial_type = first_response;
   
   picture {
      text { caption = " "; } text2;
      x = -150; y = 0;
      text { caption = " "; } text3;
      x = 150; y = 0;   
      text { caption = "Press to Continue"; };
      x = 0; y = -200;
   };
} info_trial;

begin_pcl;

# put some response_manager info into a string
sub
   string get_total_info
begin
   string rval = "total_response_count: " + 
                 string( response_manager.total_response_count() ) +
                 "\ntotal_response_count(1): " +
                 string( response_manager.total_response_count( 1 ) ) +
                 "\ntotal_response_count(2): " +
                 string( response_manager.total_response_count( 2 ) ) +
                 "\ntotal_hits: " +
                 string( response_manager.total_hits() ) +
                 "\ntotal_incorrects: " +
                 string( response_manager.total_incorrects() ) +
                 "\ntotal_false_alarms: " +
                 string( response_manager.total_false_alarms() ) +
                 "\ntotal_misses: " +
                 string( response_manager.total_misses() ); 
   return rval
end;

# put some more response_manager info into a string
sub
   string get_trial_info
begin
   string rval = "response_count: " + 
                 string( response_manager.response_count() ) +
                 "\nresponse_count(1): " +
                 string( response_manager.response_count( 1 ) ) +
                 "\nresponse_count(2): " +
                 string( response_manager.response_count( 2 ) ) +
                 "\nhits: " +
                 string( response_manager.hits() ) +
                 "\nincorrects: " +
                 string( response_manager.incorrects() ) +
                 "\nfalse_alarms: " +
                 string( response_manager.false_alarms() ) +
                 "\nmisses: " +
                 string( response_manager.misses() ) +
                 "\nlast_response: " +
                 string( response_manager.last_response() ); 
   return rval
end;  

# show response_manager info
sub
   show_info
begin
   text2.set_caption( get_total_info() );
   text2.redraw();
   text3.set_caption( get_trial_info() );
   text3.redraw();
   info_trial.present()
end;  

# run the main trial with a new caption
sub
   show_trial( string caption )
begin
   text1.set_caption( caption );
   text1.redraw();
   main_trial.present()
end;  

# main program
show_trial( "stimulus not response active" );
show_info();
            
event1.set_response_active( true );
show_trial( "stimulus response active" );
show_info();                       

event1.set_target_button( 1 );
show_trial( "target button 1" );
show_info();

event1.set_target_button( 1 );
show_trial( "target button 1" );
show_info();

event1.set_target_button( 2 );
show_trial( "target button 2" );
show_info();

event1.set_target_button( 2 );
show_trial( "target button 2" );
show_info();