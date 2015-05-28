# This example demonstrates how to use the wavefile::load
# and wavefile::unload methods to load and unload sounds
# during a scenario

# This scenario assumes there are wav files named
# "sound1.wav", "sound2.wav", and "sound3.wav"
# in the default stimulus directory    

# The sound format setting on the "Hardware Settings" tab must
# match the sound format of the wave files
scenario = "wavefile PCL example";
no_logfile = true;
begin;

array { 
   sound { wavefile { filename = "sound1.wav"; preload = false; }; } sound1;   
   sound { wavefile { filename = "sound2.wav"; preload = false; }; };
   sound { wavefile { filename = "sound3.wav"; preload = false; }; };
} sounds;

trial {    
   trial_duration = 2000;
   
   stimulus_event {
      sound sound1;
   } event1;
} trial1;

begin_pcl;

loop
   int i = 1
until
   i > sounds.count()
begin      
   sounds[i].get_wavefile().load();           
   event1.set_stimulus( sounds[i] );
   trial1.present();   
   sounds[i].get_wavefile().unload(); 
   i = i + 1
end