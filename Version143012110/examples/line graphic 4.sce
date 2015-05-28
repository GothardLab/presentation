no_logfile = true;

begin;

line_graphic {
	polygon_coordinates = 100, -100, 100, 100, -100, -100;
	fill_color = 255, 255, 255;
}line;

trial {
	trial_duration = 2000;
	picture { line_graphic line; x = 0; y = 0; };
};