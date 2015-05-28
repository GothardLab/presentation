# randomize stimuli with a restriction that 3 in a row is not allowed
scenario = "in-a-row example";   
no_logfile = true;
active_buttons = 2;
button_codes = 1, 2;

begin;

picture {} default;

trial {       
   trial_duration = forever;
   trial_type = first_response; 
   
   picture default;
   time = 0;
            
   stimulus_event {
      picture {
         box { height = 100; width = 100; color = 255,255,255; } box1;
         x = 0; y = 0;
      } pic1;
      time = 1000; 
   } event1;
} main_trial;

begin_pcl;

loop       
   int last_side = 0;
   int in_a_row = 0;
   int i = 1
until
   i > 10
begin                                
   # randomly pick 1 or -1 
   int side = random( 0, 1 ) * 2 - 1;    
   # enforce restriction
   if (side == last_side) then
      in_a_row = in_a_row + 1;
      if (in_a_row == 3) then   
         # switch sides
         if (side == 1) then side = -1
         else side = 1 end;
         in_a_row = 1
      end;
   else
      in_a_row = 1
   end;    
   last_side = side;
   
   # set part location, event code, and target button
   # based on side
   pic1.set_part_x( 1, side * 100 );
   if (side == -1) then
      event1.set_event_code( "left" );
      event1.set_target_button( 1 )
   else
      event1.set_event_code( "right" );
      event1.set_target_button( 2 )
   end;
   
   main_trial.present();
   
   i = i + 1
end