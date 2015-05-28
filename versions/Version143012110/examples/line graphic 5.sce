no_logfile = true;

begin;

line_graphic {
	coordinates = 100, 100, -100, -100;
	line_width = 15;
}line1;

trial {
	trial_duration = 2000;
	picture { line_graphic line1; x = 0; y = 0; };
}main;

begin_pcl;

line1.set_next_line_color( 255, 0, 0, 255 );
line1.add_line( -100.0, 100.0, 100.0, -100.0 );
line1.redraw();
main.present();