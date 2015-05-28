scenario = "PCL stimulus_data example";
no_logfile = true;
default_font_size = 18;  
default_text_align = align_left;

active_buttons = 2;
button_codes = 1, 2;
response_matching = simple_matching;

begin;

picture {} default;  

trial {
   trial_type = first_response;
   trial_duration = forever;
   
   stimulus_event {
      picture {
         text { caption = "temp caption"; } text1;
         x = 0; y = 0;
      };
   } event1;
} main_trial;

trial {     
   trial_type = first_response;
   trial_duration = forever;
   
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


# puts the last stimulus info into a string
sub
   string get_stim_info
begin              
   string cap;
   if (bool( stimulus_manager.stimulus_count() )) then
      stimulus_data last = stimulus_manager.last_stimulus_data();
       cap = "stimuli: " + string( stimulus_manager.stimulus_count() ) + 
             "\nbutton: " + string( last.button() ) + 
             "\nevent_code: " + last.event_code() + 
             "\nreaction_time: " + string( last.reaction_time() ) + 
             "\ntime: " + string( last.time() ) +
             "\ntype: ";
      if (last.type() == stimulus_hit) then
         cap = cap + "stimulus_hit"
      elseif (last.type() == stimulus_incorrect) then
         cap = cap + "stimulus_incorrect"
      elseif (last.type() == stimulus_miss) then
         cap = cap + "stimulus_miss"
      elseif (last.type() == stimulus_false_alarm) then
         cap = cap + "stimulus_false_alarm" 
      elseif (last.type() == stimulus_other) then
         cap = cap + "stimulus_other"
      else
         cap = cap + "Bug!"
      end;
      cap = cap + "\nunc_dms: " + string( last.unc_dms() );  
   else
      cap = "stimuli: 0";
   end;            
   return cap
end;  
 
# puts the last response info into a string       
sub
   string get_response_info
begin              
   string cap;
   if (bool( response_manager.response_count() )) then
      response_data last = response_manager.last_response_data();
      cap = "responses: " + string( response_manager.response_count() ) + 
            "\nbutton: " + string( last.button() ) +
            "\ntype: ";  
      if (last.type() == stimulus_hit) then
         cap = cap + "response_hit"
      elseif (last.type() == response_incorrect) then
         cap = cap + "response_incorrect"
      elseif (last.type() == response_false_alarm) then
         cap = cap + "response_false_alarm" 
      elseif (last.type() == response_other) then
         cap = cap + "response_other"
      else
         cap = cap + "Bug!"
      end;
      cap = cap + "\ncode: " + string( last.code() ) +
                  "\ntime: " + string( last.time() ) +
                  "\nunc_dms: " + string( last.unc_dms() ); 
   else
      cap = "No new responses";
   end;            
   return cap
end;

# show the stimulus/response info
sub 
   display_info
begin
   text2.set_caption( get_stim_info() );
   text2.redraw();
   text3.set_caption( get_response_info() );
   text3.redraw();
   info_trial.present()
end;

# show the main trial
sub
   present( string caption )
begin
   text1.set_caption( caption );
   text1.redraw();
   main_trial.present()
end;

# main program
present( "no event code\nnot response active" );
display_info();

event1.set_event_code( "stim 1" );
present( "event code\nnot response active" );
display_info();
                                             
event1.set_event_code( "stim 2" );                                            
present( "event code\nnot response active" ); 
display_info();     

event1.set_event_code( "stim 3" ); 
event1.set_response_active( true );
present( "event code\nresponse active" ); 
display_info();            

event1.set_event_code( "" ); 
present( "no event code\nresponse active" ); 
display_info();                   

event1.set_event_code( "stim 5" );
event1.set_target_button( 1 );
present( "event code\ntarget button 1" );  
display_info();

event1.set_event_code( "" );
event1.set_target_button( 1 );
present( "no event code\ntarget button 1" ); 
display_info();                        

event1.set_event_code( "stim 7" );
event1.set_target_button( 2 );
present( "event code\ntarget button 2" );  
display_info();

event1.set_event_code( "" );
event1.set_target_button( 2 );
present( "no event code\ntarget button 2" ); 
display_info();           

event1.set_target_button( 0 );
event1.set_response_active( true );
main_trial.set_duration( 3000 );
present( "response_active\n(do not respond)" );   
display_info();

event1.set_target_button( 1 );
present( "target button 1\n(do not respond)" );
display_info();