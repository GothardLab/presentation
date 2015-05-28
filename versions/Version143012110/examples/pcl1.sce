scenario = "PCL Example";   

active_buttons = 1;
button_codes = 1; 
default_font_size = 48;

begin;

picture {} default;

trial {                    
   trial_type = first_response;
   trial_duration = forever;
   
   picture {
      text {
         caption = "Instruction Trial\nPress to Continue";
      };
      x = 0; y = 0;
   };
   time = 0;
} instruction_trial;     

trial {                    
   trial_type = first_response;
   trial_duration = forever;
   
   picture {
      text {
         caption = "Resting Trial\nPress to Continue";
      };
      x = 0; y = 0;
   };
   time = 0;
} resting_trial;   

array {
   LOOP $i 20;
   trial {
      trial_duration = 1000;
      
      picture {
         text { caption = "pic $i"; };
         x = 0; y = 0;
      };
      time = 0;
   };
   ENDLOOP;
} main_trials;

begin_pcl;

main_trials.shuffle();
int half = main_trials.count() / 2; 

instruction_trial.present();
                            
int i = 1;
loop until
   i > half
begin
   main_trials[i].present();
   i = i + 1
end;

resting_trial.present();
        
loop until
   i > main_trials.count()
begin
   main_trials[i].present();
   i = i + 1
end;

