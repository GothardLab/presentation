scenario = "PCL memory_device example";

begin;    

picture {} default;

trial {
   trial_duration = 2000;
   
   picture {
      text { caption = " "; font_size = 24; } text1;
      x = 0; y = 0;
   } pic1;
} trial1;

begin_pcl;

memory_device parallel = new memory_device( 888, 3 ); 

sub
   write( int i )
begin
   text1.set_caption( "Data lines set to " + string( i ) );
   text1.redraw();
   parallel.write_byte( i, 1 );
   trial1.present()
end;

int status = parallel.read_byte( 2 );
text1.set_caption( "Status register: " + string( status ) );
text1.redraw();
trial1.present();

parallel.write_byte( 37, 1 );
if (parallel.read_byte( 1 ) != 37) then
   text1.set_caption( "Port may be in bidirectional mode!" );
   text1.redraw();
   trial1.present()
else                  
   write( 37 );
   write( 20 );
   write( 255 );  
end