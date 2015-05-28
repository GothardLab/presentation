 # This scenario assumes there exist files named
 # sound3.wav, sound1.wav, sound2.wav in the 
 # default stimulus directory  
 # and that the sound card format is set to 
 # 16 bit mono
 
scenario = "simultaneous sound picture example";  
no_logfile = true;
default_font_size = 48;
default_picture_duration = 2000;

begin; 

picture {} default;

sound { wavefile { filename = "sound1.wav"; }; default_code = "sound1"; } sound1;    
sound { wavefile { filename = "sound2.wav"; }; default_code = "sound2"; } sound2;
sound { wavefile { filename = "sound3.wav"; }; default_code = "sound3"; } sound3;

trial {     
   picture {
      text { caption = "Sound 1"; };
      x = 0; y = 0;
   };
   time = 0;
   code = "pic1";
   
   sound sound1;
   deltat = 0;
           
   picture {
      text { caption = "Sound 2"; };
      x = 0; y = 0;
   };
   time = 2000;
   code = "pic2";
   
   sound sound2;
   deltat = 0;     
           
   picture {
      text { caption = "Sound 3"; };
      x = 0; y = 0;
   };
   time = 4000;
   code = "pic3";
   
   sound sound3;
   deltat = 0;   
};