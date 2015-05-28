# This scenario assumes there are jpg files named
# "graphics1.jpg", "graphics2.jpg", and "graphics3.jpg"
# in the default stimulus directory
scenario = "bitmap PCL example";
no_logfile = true;
begin;

picture {} default;

array {
   bitmap { filename = "graphic1.jpg"; preload = false; };
   bitmap { filename = "graphic2.jpg"; preload = false; };
   bitmap { filename = "graphic3.jpg"; preload = false; };
} graphics;

trial {    
   trial_duration = 2000;
   
   picture {  
      # placeholder - set by PCL
      box { height = 1; width = 1; color = 0,0,0; };
      x = 0; y = 0;
   } pic1;
   time = 0;
} trial1;

begin_pcl;

loop
   int i = 1
until
   i > graphics.count()
begin
   graphics[i].load();          
   # if display mode is palettized (8-bit color), and the graphic contains
   # a color not previously used, we must call set_palette to change the 
   # palette to include the new color
#   display_device.set_palette();   
   
   pic1.set_part( 1, graphics[i] ); 
   trial1.present();   
   
   graphics[i].unload(); 
   
   i = i + 1
end