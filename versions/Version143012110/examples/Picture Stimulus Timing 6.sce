no_logfile = true;
begin;

picture {} default;

picture {
	default_code = "pic1";
	box { height = 100; width = 100; color = 255,0,0; };
	x = 0; y = 0;
} pic1;

picture {
	default_code = "pic2";
	box { height = 100; width = 100; color = 0,0,255; };
	x = 0; y = 0;
} pic2;


trial {

LOOP $i 40;
	picture pic1;
	deltat = 1;
	duration = 1;
	code = "pic";
ENDLOOP;

	picture pic1;
	deltat = 100;
	duration = 500;

	picture pic2;
	delta_time = 500;
	duration = 500;
	};
