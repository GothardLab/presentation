# This scenario lasts forever - you must press q or escape to quit
scenario = "PCL mouse example";
no_logfile = true;
begin;

picture {} default;

picture {
   box { color = 255,0,0; height = 10; width = 10; };
   x = 0; y = 0;
} pic1;
   
picture {
   text { caption = " "; font_size = 24; } text1;
   x = 0; y = 0;
} pic2;

begin_pcl;

if (response_manager.mouse_count() == 0) then
   text1.set_caption( "no mice selected!" );
   text1.redraw();
   pic2.present();
   loop until false begin end
end;

mouse mouse1 = response_manager.get_mouse( 1 );

if (mouse1.axis_count() < 2) then
   text1.set_caption( "mouse has < 2 axes!" );
   text1.redraw();
   pic2.present();
   loop until false begin end
end;

mouse1.set_min_max( 1, -200, 200 );
mouse1.set_min_max( 2, -200, 200 );
mouse1.set_restricted( 1, true );
mouse1.set_restricted( 2, true );
mouse1.set_xy( 0, 0 );
                          
loop until false begin
   mouse1.poll();
   pic1.set_part_x( 1, mouse1.x() );
   pic1.set_part_y( 1, mouse1.y() );
   pic1.present()
end