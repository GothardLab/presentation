scenario = "PCL picture example 4"; 
no_logfile = true;
begin;

picture {} default;

trial {      
   stimulus_event {
      picture {
         box { height = 5; width = 5; color = 255,255,255; };
         x = 0; y = 0;
         box { height = 5; width = 5; color = 255,255,255; };
         x = 0; y = 0;
      } pic1;
   } event1;
} trial1;

begin_pcl;

double radius = 100.0; 
event1.set_time( 20 );
loop
   double angle = 0.0;
   double angle2 = 3.14159 / 2.0;
until false begin
   pic1.set_part_x( 1, int( radius * cos( angle ) ) );
   pic1.set_part_y( 1, int( radius * sin( angle ) ) );     
   pic1.set_part_x( 2, int( radius * cos( angle2 ) ) );
   pic1.set_part_y( 2, int( radius * sin( angle2 ) ) );
   trial1.present();
   angle = angle + 0.05;   
   angle2 = angle2 - 0.05;
end;