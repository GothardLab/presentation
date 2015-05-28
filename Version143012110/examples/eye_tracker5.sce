begin;
begin_pcl;

eye_tracker tracker = new eye_tracker( "my_tracker_name" );
tracker.start_data( et_right, dt_position, false );
tracker.start_data( et_left, dt_position, false );
tracker.start_tracking();
# use methods with "eye" argument included
tracker.stop_tracking()