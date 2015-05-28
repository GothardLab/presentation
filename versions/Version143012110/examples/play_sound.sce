 # This scenario assumes there exists a file named
 # sound3.wav in the default stimulus directory  
 # and that the sound card format is set to 
 # 16 bit mono
scenario = "play sound";
no_logfile = true;
begin;

wavefile { filename = "sound3.wav"; } s3; 
sound { wavefile s3; } sound3;

trial {  
   sound sound3;
   time = 0;
   
   sound {         
      wavefile s3; 
      attenuation = 0.1; 
   };
   time = 500;
   
   sound { 
      wavefile s3;
      attenuation = 0.2;
   };    
   time = 1000;
};