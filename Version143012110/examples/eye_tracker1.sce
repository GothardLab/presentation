begin;
begin_pcl;

eye_tracker tracker = new eye_tracker( "my_tracker_name" );
tracker.start_data( dt_position, false );
tracker.start_data( dt_fixation, true );
tracker.start_tracking();
# monitor data here
tracker.stop_tracking()