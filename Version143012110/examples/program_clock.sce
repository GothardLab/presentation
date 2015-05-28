scenario = "PCL program_clock example";
no_logfile = true;
begin;

picture {} default;

picture {
   text { caption = "12:00"; font_size = 48; font = "Courier New"; } text1;
   x = 0; y = 0;
} pic1;

begin_pcl;

sub
   string convert_time( int hundredths )
begin                
   int minutes = (hundredths / 6000) % 60;
   string time;
   if (minutes < 10) then time = time + "0" end;
   time = time + string( minutes ) + ":";
   int seconds = (hundredths / 100) % 60;
   if (seconds < 10) then time = time + "0" end;
   time = time + string( seconds ) + ":"; 
   hundredths = hundredths % 100;
   if (hundredths < 10) then time = time + "0" end;
   time = time + string( hundredths );
   return time
end;

loop until clock.time() >= 0 begin end;
loop
   int time_hundredths = -1
until false begin                          
   int new_time = clock.time() / 10;
   if (new_time > time_hundredths) then
      time_hundredths = new_time;
      text1.set_caption( convert_time( time_hundredths ) );
      text1.redraw();
      pic1.present()
   end
end