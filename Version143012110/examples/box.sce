scenario = "box PCL example"; 
no_logfile = true;
begin;

picture {} default;

picture {
   box { height = 1; width = 1; color = 0,0,0; } box1;
   x = 0; y = 0;
} pic1;

begin_pcl;

loop
   int i = 10;
until
   i > 255
begin
   box1.set_height( i );
   box1.set_width( i );
   box1.set_color( 0, i, 255-i );
   
   pic1.present();
   
   i = i + 1
end