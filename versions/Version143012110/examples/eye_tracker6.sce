begin;

picture {
   background_color = 0,0,255;
   box { height = 10; width = 1; color = 255,0,0; };
   x = 0; y = 0;
   box { height = 1; width = 10; color = 255,0,0; };
   x = 0; y = 0;
} et_calibration;

begin_pcl;

eye_tracker tracker = new eye_tracker( "my_tracker_name" );
tracker.calibrate( et_calibrate_default, 0.0, 0.0, 0.0 );