no_logfile = true;

begin;

picture {
	annulus_graphic{
		inner_width = 250;
		inner_height = 150;
		outer_width = 350;
		outer_height = 250;
		color = 255, 255, 0;
	}annulus1;
	x = 0; y = 0;
} pic1;

begin_pcl;

annulus_graphic annulus2 = new annulus_graphic;
pic1.add_part( annulus2, 0, 0 );
annulus2.set_dimensions( 100.0, 400.0, 200.0, 500.0 );
annulus2.set_color( 255, 0, 127, 255 );
annulus2.redraw();
loop double rotation = 0.0; int x = -180; until rotation > 180.0
begin
	annulus1.set_rotation( -rotation );
	pic1.set_part_x( 2, x );
	annulus1.redraw();
	pic1.present();
	rotation = rotation + 1.0;
	x = x + 2;
end;
