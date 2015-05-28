scenario = "Trials and Templates 4";

begin;

bitmap { filename = "red.jpg"; } red;
bitmap { filename = "flower.jpg"; } flower;

trial {
	trial_duration = 3000;
	
	picture {
		bitmap red;
		x = 0; y = 0;
	};
	time = 0;
	code = "red";
	
	picture {
		bitmap flower;
		x = 0; y = 0;
	};
	time = 1000;
	duration = 1000;
	code = "flower";
};