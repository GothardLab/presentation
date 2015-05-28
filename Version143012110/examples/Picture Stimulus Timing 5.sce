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
	duration = 50;

LOOP $i 20;
	picture pic;
	duration = 50;
	delta_time = 100;
ENDLOOP;

};
