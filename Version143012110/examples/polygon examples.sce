no_logfile = true;

begin;

array {
	polygon_graphic {
		sides = 5;
		radius = 200;
		line_color = 255,255,255;
		line_width = 20;
		fill_color = 127,127,127;
	}polygon1;
	polygon_graphic {
		sides = 3;
		radius = 150;
		line_color = 255, 0, 0;
		fill_color = 255, 0, 0;
		join_type = join_circle;
	};
	polygon_graphic {
		sides = 8;
		radius = 200;
		line_color = 255, 0, 127;
		line_width = 20;
		join_type = join_flat;
		background_color = 127,127,0;
		rotation = 45;
		height = 500;
		width = 600;
	};
}graphics;

trial {
	trial_duration = 1000;
	
	picture {
		polygon_graphic polygon1;
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