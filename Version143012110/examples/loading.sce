scenario = "loading example 1";
no_logfile = true;
default_font_size = 48;
begin;

picture {} default;

array {
   text { caption = "one"; preload = false; } t1;    
   text { caption = "two"; preload = false; };
   text { caption = "three"; preload = false; };
   text { caption = "four"; preload = false; };
   text { caption = "five"; preload = false; };
   text { caption = "six"; preload = false; };
   text { caption = "seven"; preload = false; };
   text { caption = "eight"; preload = false; };
   text { caption = "nine"; preload = false; };
   text { caption = "ten"; preload = false; };
   text { caption = "eleven"; preload = false; };
   text { caption = "twelve"; preload = false; };   
   text { caption = "thirteen"; preload = false; };  
   text { caption = "fourteen"; preload = false; };  
   text { caption = "fifteen"; preload = false; };  
} words;

trial {     
   trial_duration = 1000;
   
   picture {
      text t1;
      x = 0; y = 0;
   } pic;
} main_trial;

picture {
   text { caption = "Resting"; font_color = 0,0,255; };
   x = 0; y = 0;
} resting;

begin_pcl;

# presents an array of text parts
sub
   present_bunch( array<text,1>& bunch_words )
begin
   loop
      int i = 1
   until
      i > bunch_words.count()
   begin
      pic.set_part( 1, bunch_words[i] );
      main_trial.present();
      i = i + 1
   end;
end; 

# main program ------------------------------------------------
words.shuffle();   

# put in 2-d array for easy handling
array<text> word_lists[3][5]; 
loop
   int i = 1
until
   i > words.count()
begin
   word_lists[(i-1) / 5 + 1][i % 5 + 1 ] = words[i];
   i = i + 1
end; 

int start_time = 0;

loop
  int i = 1
until
   i > word_lists.count()
begin  
   # load next five
   loop
      int j = 1
   until
      j > word_lists[i].count()
   begin
      word_lists[i][j].load();
      j = j + 1
   end;  
   
   loop until clock.time() >= start_time begin end;
   
   present_bunch( word_lists[i] );
   
   if (i < word_lists.count()) then
      resting.present();
      start_time = clock.time() + 4000
   end;
      
   # unload previous five
   loop
      int j = 1
   until                 
      j > word_lists[i].count()
   begin
      word_lists[i][j].unload();
      j = j + 1
   end; 
   
   i = i + 1
end