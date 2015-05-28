 # This scenario assumes there exists a file named
 # sound3.wav in the default stimulus directory  
 # and that the sound card format is set to 
 # 16 bit mono
scenario = "sound pan example"; 
no_logfile = true;
default_delta_time = 500;
begin;

wavefile { filename = "sound3.wav"; } s3; 

trial {         
   sound { wavefile s3; pan = -1; };      
   sound { wavefile s3; pan = -.2; };   
   sound { wavefile s3; pan = -.15; };   
   sound { wavefile s3; pan = -.1; };   
   sound { wavefile s3; pan = 0; };   
   sound { wavefile s3; pan = .1; };   
   sound { wavefile s3; pan = .15; };   
   sound { wavefile s3; pan = .2; };   
   sound { wavefile s3; pan = 1; };   
};