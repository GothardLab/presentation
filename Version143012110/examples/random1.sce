scenario = "random1";
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
   LOOP $i 10;
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

int first_bunch = 5;

# randomly shuffle the main trials
main_trials.shuffle();
 
# show instructions
instruction_trial.present();

# show first batch
int i = 1;
loop until
   i > first_bunch
begin
   main_trials[i].present();
   i = i + 1
end;

# show resting trial
resting_trial.present();
  
# show remainder
loop until
   i > main_trials.count()
begin
   main_trials[i].present();
   i = i + 1
end;