no_logfile = true;

begin;

picture {} pic1;

begin_pcl;

vsg::gradient_generator gradient = new vsg::gradient_generator( 45.0, 10.0, 0.0, false );
vsg::gaussian_generator gaussian = new vsg::gaussian_generator( 0.0, 50.0 );

vsg::graphic_generator graph_gen = new vsg::graphic_generator( 800.0, 600.0 );
graph_gen.add_transformation( gaussian.generate( 800.0, 600.0 ), vsg::combine_none );
graph_gen.add_parameter_increment( gradient, vsg::phase, 10.0 );
graph_gen.add_transformation( gradient, vsg::combine_mask2 );
graph_gen.set_colors( 127.0, 127.0, 127.0, 127.0, 127.0, 127.0 );

graphic_surface graphic = new graphic_surface( 800.0, 600.0 );
pic1.add_part( graphic, 0, 0 );

loop int i = 1 until i > 2000 
begin
	graph_gen.draw( graphic );
	pic1.present();
	i = i + 1;
end;