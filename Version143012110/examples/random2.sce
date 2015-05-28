scenario = "random2";
no_logfile = true;   
default_font_size = 36;   
default_trial_duration = 1000;

begin;

picture {} default;

trial {
   trial_duration = 3000;
   
   picture {
      text { caption = "Instruction trials"; };
      x = 0; y = 0;
   };
} instruction_trial;         

trial {
   trial_duration = 3000;
   
   picture {
      text { caption = "Resting trial"; };
      x = 0; y = 0;
   };
} resting_trial;    
 
# put trials in array for PCL
array {
   LOOP $i 15;
   $k = '$i + 1';
   trial {
      picture {
         text { caption = "Pic $k"; };
         x = 0; y = 0;
      };
      code = "Pic $k";
   };
   ENDLOOP;
} main_trials;

begin_pcl;
 
# show a subset of the main trials
sub
   show_batch( int start, int finish )
begin
   loop until 
      start > finish
   begin
      main_trials[start].present();
      start = start + 1
   end
end;

# randomly shuffle the main trials
main_trials.shuffle();
 
# show instructions
instruction_trial.present();

show_batch( 1, 5 );  
resting_trial.present();
show_batch( 6, 10 );  
resting_trial.present();
show_batch( 11, 15 );