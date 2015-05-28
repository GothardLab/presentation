scenario = "PCL picture example 3"; 
no_logfile = true;
begin;

picture {} default;

picture {
   box { height = 5; width = 5; color = 255,255,255; };
   x = 0; y = 0;
} pic1;

begin_pcl;

double radius = 100.0;
loop
   double angle = 0.0
until false begin
   pic1.set_part_x( 1, int( radius * cos( angle ) ) );
   pic1.set_part_y( 1, int( radius * sin( angle ) ) );
   pic1.present();
   angle = angle + 0.05;
end;