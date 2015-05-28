no_logfile = true;
begin;

picture {} default;

picture {
	default_code = "pic";
	box { height = 100; width = 100; color = 255,0,0; };
	x = 0; y = 0;
} pic;

trial {
	picture pic;
	time = 0;
	duration = 1;

	picture pic;
	time = 90;
	duration = 1;
};
