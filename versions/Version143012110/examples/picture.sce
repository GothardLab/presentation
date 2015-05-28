scenario = "PCL picture type example";
no_logfile = true;
begin;

picture {} default;

box { color = 255,0,0; height = 100; width = 100; } box1;    
box { color = 0,255,0; height = 100; width = 100; } box2;
box { color = 0,0,255; height = 100; width = 100; } box3;
box { color = 0,128,128; height = 100; width = 100; } box4; 
box { color = 128,128,0; height = 200; width = 200; } box5;

box { color = 128,128,128; height = 1; width = 1; } dummy;          

trial {
   trial_duration = 1500;
   
   picture {
      text { caption = "text"; font_size = 36; } text1;
      x = 0; y = -200;
   } pic1;
} trial1;

begin_pcl;

sub
   display( string caption )
begin
   text1.set_caption( caption );
   text1.redraw();
   trial1.present()
end;

pic1.add_part( box1, -100, 100 ); 
display( "add_part" );

pic1.add_part( box2, 100, 100 ); 
display( "add_part" );

pic1.add_part( box3, -100, -100 );
display( "add_part" );

pic1.add_part( box4, 100, -100 ); 
display( "add_part" ); 
            
pic1.set_part( 2, box2 ); 
display( "set_part" );

pic1.set_part( 3, box1 );
display( "set_part" ); 

pic1.remove_part( 4 );
display( "remove_part" );
                  
pic1.set_background_color( 128, 128, 128 );
display( "set_background_color" );

pic1.set_background_color( 0, 0, 0 );   
display( "set_background_color" );

pic1.insert_part( 3, box5, 0, 0 );
display( "insert_part" );

pic1.swap_parts( 3, 4 );
display( "swap_parts" );

pic1.swap_parts( 4, 5 );
display( "swap_parts" ); 

pic1.swap_parts( 5, 2 ); 
text1.set_caption( "set_part_x, set_part_y, present" );
text1.redraw();
loop
   int x = -100;
   int y = 100
until
   x > 100
begin
   pic1.set_part_x( 5, x );
   pic1.set_part_y( 5, y );
   pic1.present();
   x = x + 1;
   y = y - 1
end;

pic1.clear();
pic1.add_part( text1, 0, 0 );
display( "clear (then add text) " );