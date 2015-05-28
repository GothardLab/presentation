no_logfile = true;

begin;

array {
	arrow_graphic {
		coordinates = -100, 0, 100, 0;
		line_width = 20;
		head_width = 100;
		head_length = 50;
	}arrow1;
	arrow_graphic {
		coordinates = -200, 200, 250, 200;
		line_width = 15;
		head_width = 100;
		head_length = 80;
		head_type = head_swift;
		color = 255, 0, 0;
		background_color = 127,127,127;
	};
	arrow_graphic {
		coordinates = 300, -200, -100, -200;
		line_width = 20;
		head_width = 40;
		head_length = 50;
		height = 600;
		width = 600;
		color = 0, 0, 255;
		background_color = 255,255,255;
	};
}graphics;

trial {
	trial_duration = 1000;
	
	picture {
		arrow_graphic arrow1;
		x = 0; y = 0;
	}pic;
}main;

begin_pcl;

loop int i = 1 until i > graphics.count()
begin
	pic.set_part( 1, graphics[i] );
	main.present();
	i = i + 1;
end;