no_logfile = true;

begin;

array {
	ellipse_graphic {
		ellipse_width = 250;
		ellipse_height = 150;
		color = 255, 0, 0;
		rotation = 30;
	}ellipse1;
	ellipse_graphic {
		ellipse_width = 400;
		ellipse_height = 300;
		color = 255, 127, 0;
		background_color = 127,127,127;
	};
	ellipse_graphic {
		ellipse_width = 300;
		ellipse_height = 300;
		height = 600;
		width = 600;
		color = 255, 127, 127;
		background_color = 255,255,255;
	};
}graphics;

trial {
	trial_duration = 1000;
	
	picture {
		ellipse_graphic ellipse1;
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