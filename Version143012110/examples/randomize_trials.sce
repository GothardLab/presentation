scenario = "randomize trials"; 
no_logfile = true;
randomize_trials = true; 
default_font_size = 48;

begin; 

picture {} default;

LOOP $i 10;
$k = '$i + 1';
trial {
   trial_duration = 1000;
   
   picture {
      text { caption = "Pic $k"; };
      x = 0; y = 0;
   };  
   code = "Pic $k";
};
ENDLOOP;