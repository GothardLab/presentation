begin;
begin_pcl;

eye_tracker tracker = new eye_tracker( "my_tracker_name" );
tracker.start_data( et_right, dt_position, false );
tracker.set_default_data_set( et_right );
tracker.start_tracking();
# use methods without optional "eye" argument
tracker.stop_tracking()