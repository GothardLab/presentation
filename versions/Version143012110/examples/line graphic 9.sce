no_logfile = true;

begin;

trial {
	trial_duration = 2000;
	picture { }pic;
}main;

begin_pcl;

line_graphic line = new line_graphic;
line.set_line_color( 0, 255, 0, 255 );
line.add_polygon( { { -100.0, -100.0 }, { -50.0, 100.0 }, { 100.0, 0.0 } }, false, 1.0, 0.0 );
line.redraw();
pic.add_part( line, 0, 0 );
main.present();