no_logfile = true;

begin;

array {
	annulus_graphic {
		inner_width = 250;
		inner_height = 150;
		outer_width = 350;
		outer_height = 250;
		color = 255, 255, 255;
		rotation = 45;
	}annulus1;
	annulus_graphic {
		inner_width = 300;
		inner_height = 150;
		outer_width = 150;
		outer_height = 200;
		color = 255, 127, 0;
		background_color = 127,127,127;
	};
	annulus_graphic {
		inner_width = 200;
		inner_height = 200;
		outer_width = 250;
		outer_height = 400;
		height = 600;
		width = 600;
		color = 255, 127, 127;
		background_color = 255,255,255;
	};
}graphics;

trial {
	trial_duration = 1000;
	
	picture {
		annulus_graphic annulus1;
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