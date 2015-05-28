no_logfile = true;

begin;

picture {
	polygon_graphic {
		sides = 3;
		radius = 150;
		line_color = 255, 0, 0;
		fill_color = 255, 0, 0;
		join_type = join_circle;
	}polygon1;
	x = 0; y = 0;
} pic1;

trial {
	trial_duration = 1000;
	picture pic1;
}trial1;

begin_pcl;

#Changing properties of an SDL created polygon in PCL
loop double radius = 150.0;  until radius > 300.0
begin
	polygon1.set_radius( radius );
	polygon1.redraw();
	pic1.present();
	radius = radius + 3.0;
end;

#Create a polygon in PCL with default properties and then set properties and redraw
polygon_graphic polygon2 = new polygon_graphic;
pic1.set_part( 1, polygon2 );
polygon2.set_sides( 4 );
polygon2.set_radius( 200.0 );
polygon2.set_line_color( 0, 0, 255, 255 );
polygon2.set_fill( true );
polygon2.set_fill_color( 0, 0, 255, 255 );
polygon2.redraw();
trial1.present();

#Create a polygon in PCL with all properties set
polygon_graphic polygon3 = new polygon_graphic( 100.0, 6, 15.0, join_point, 0.0 );
pic1.set_part( 1, polygon3 );
trial1.present();  