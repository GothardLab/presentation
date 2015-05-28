no_logfile = true;

begin;

picture {
	ellipse_graphic{
		ellipse_width = 300;
		ellipse_height = 200;
		color = 255, 127, 0;
	}ellipse1;
	x = 0; y = 0;
} pic1;

begin_pcl;

ellipse_graphic ellipse2 = new ellipse_graphic;
pic1.add_part( ellipse2, 0, 0 );
ellipse2.set_dimensions( 100.0, 400.0 );
ellipse2.set_color( 255, 0, 0, 255 );
loop double rotation = 0.0 until rotation > 180.0
begin
	ellipse1.set_rotation( -rotation );
	ellipse2.set_rotation( rotation );
	ellipse1.redraw();
	ellipse2.redraw();
	pic1.present();
	rotation = rotation + 1.0;
end;
