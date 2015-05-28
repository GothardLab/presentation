begin;

picture {
   box { height = 10; width = 10; color = 255,0,0; } box1;
   x = 0; y = 0;
} calibration_pic;

begin_pcl;

eye_tracker tracker = new eye_tracker( "my_tracker_name" );
array<double> temp[0][2];
tracker.start_calibration( temp, et_default, "" );
loop
   int point = -1;
   int change_time = clock.time() + 100;
   int box_size = 10;
until
   point == 0
begin
   double x;
   double y;
   int cpoint;
   tracker.get_calibration_point( cpoint, x, y );
   if (point != cpoint) then
      point = cpoint;
      if (point != 0) then
         calibration_pic.set_part_x( 1, x );
         calibration_pic.set_part_y( 1, y );
         calibration_pic.present()
      end
   end;
   if (clock.time() >= change_time) then
      change_time = change_time + 100;
      if (box_size == 10) then box_size = 30 else box_size = 10 end;
      box1.set_height( box_size );
      box1.set_width( box_size );
      calibration_pic.present()
   end
end;
tracker.stop_calibration();