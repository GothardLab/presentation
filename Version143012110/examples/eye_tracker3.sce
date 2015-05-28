no_logfile = true;
begin;
begin_pcl;

eye_tracker tracker = new eye_tracker( "your_tracker" );
tracker.start_data( dt_position, true );
int buffer_size = 1000;
tracker.set_max_buffer_size( dt_position, buffer_size );
tracker.start_tracking();
loop
   int position = 0;
until
   false # some condition here
begin
   loop until
      position == tracker.buffer_position( dt_position )
   begin
      position = position + 1;
      if (position > buffer_size) then
         position = 1
      end;
      eye_position_data data = tracker.get_position_data( position );
      # process this sample
   end;
   # perform other tasks
end;