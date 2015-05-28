no_logfile = true;

begin;

line_graphic {
	coordinates = 100, -100, 100, 100, -100, -100 ;
	line_width = 10;
}line;

trial {
	trial_duration = 2000;
	picture { line_graphic line; x = 0; y = 0; };
};