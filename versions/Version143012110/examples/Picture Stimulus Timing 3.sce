no_logfile = true;
begin;

picture {} default;

box { height = 100; width = 100; color = 255,0,0; } box1;

trial {

LOOP $i 40;
	picture {
		box box1;
		x = $i; y = 0;
	};
	deltat = 1;
	duration = 1;
	code = "pic";
ENDLOOP;

};
