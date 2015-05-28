no_logfile = true;

begin;

trial {
	trial_duration = 2000;
	picture { }pic;
}main;

begin_pcl;

line_graphic line = new line_graphic;
line.set_next_line_color( 0, 0, 255, 255 );
line.set_next_line_width( 10.0 );
line.add_line( -100.0, -100.0, -50.0, 100.0 );
line.set_next_join_type( join_flat );
line.line_to( 50.0, 50.0 );
line.line_to( 100.0, - 50.0 );
line.set_next_join_type( join_point );
line.set_next_fill_color( 0, 255, 255, 255 );
line.close( true );
line.redraw();
pic.add_part( line, 0, 0 );
main.present();