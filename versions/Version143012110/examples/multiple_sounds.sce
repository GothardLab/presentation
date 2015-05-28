 # This scenario assumes there exist files named
 # sound3.wav, sound1.wav, sound2.wav in the 
 # default stimulus directory  
 # and that the sound card format is set to 
 # 16 bit mono
 
scenario = "multiple sounds example"; 
no_logfile = true;
begin;

sound { wavefile { filename = "sound1.wav"; }; default_code = "sound1"; } sound1;    
sound { wavefile { filename = "sound2.wav"; }; default_code = "sound2"; } sound2;
sound { wavefile { filename = "sound3.wav"; }; default_code = "sound3"; } sound3;

trial {                               
   sound sound2;
   time = 0;
   sound sound3;
   deltat = 1;  
                                 
   sound sound2;
   time = 500;
   sound sound3;
   time = 600;      
                                 
   sound sound2;
   time = 1000;
   sound sound3;
   time = 1200;         
                                 
   sound sound2;
   time = 1500;
   sound sound3;
   time = 1800;            
                                 
   sound sound2;
   time = 2000;
   sound sound3;
   time = 2400;
   
   sound sound1;
   time = 3000;
};