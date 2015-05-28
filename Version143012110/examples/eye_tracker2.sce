no_logfile = true;
begin;

picture {
   box { height = 2; width = 2; color = 255,255,255; };
   x = 0; y = 0;
} pic;

begin_pcl;

eye_tracker tracker = new eye_tracker( "your_tracker" );
tracker.start_data( dt_position, false );
tracker.start_tracking();
loop
   int end_time = clock.time() + 5000
until
   clock.time() >= end_time
begin
   if (tracker.new_position_data() > 0) then
      eye_position_data data = tracker.last_position_data();
      pic.set_part_x( 1, data.x() );
      pic.set_part_y( 1, data.y() );
      pic.present()
   end
end;
tracker.stop_tracking();