no_logfile = true;

begin;

line_graphic {
	coordinates = -100, 0, 100, 0;
	line_width = 20;
}line;

trial {
	trial_duration = 2000;
	picture { line_graphic line; x = 0; y = 0; };
};