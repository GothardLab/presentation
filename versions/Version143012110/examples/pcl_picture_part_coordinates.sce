scenario = "PCL picture part coordinates example";

default_font_size = 16;

begin;

picture {} default;

trial {  
   trial_duration = 5000;
   
   picture {
      text { caption = "temp"; background_color = 0,0,255; } text1;
      x = 0; y = 0;   
      box { height = 1; width = 300; color = 255,255,255; };
      x = 0; y = 0;
      box { width = 1; height = 300; color = 255,255,255; };
      x = 0; y = 0;
   } pic1;
} main_trial;

begin_pcl;

sub 
   display( string caption )
begin
   text1.set_caption( caption );
   text1.redraw();
   main_trial.present()
end;

pic1.set_part_x( 1, 0 );
pic1.set_part_y( 1, 0 );
display( "set_part_x( 1, 0 )\nset_part_y( 1, 0 )" );     

pic1.set_part_x( 1, 0, right_coordinate );
pic1.set_part_y( 1, 0, bottom_coordinate );
display( "set_part_x( 1, 0, right_coordinate )\nset_part_y( 1, 0, bottom_coordinate )" );         

pic1.set_part_x( 1, 0, left_coordinate );
pic1.set_part_y( 1, 0, bottom_coordinate );
display( "set_part_x( 1, 0, left_coordinate )\nset_part_y( 1, 0, bottom_coordinate )" );            

pic1.set_part_x( 1, 0, left_coordinate );
pic1.set_part_y( 1, 0, top_coordinate );
display( "set_part_x( 1, 0, left_coordinate )\nset_part_y( 1, 0, top_coordinate )" );                   

pic1.set_part_x( 1, 0, right_coordinate );
pic1.set_part_y( 1, 0, top_coordinate );
display( "set_part_x( 1, 0, right_coordinate )\nset_part_y( 1, 0, top_coordinate )" );