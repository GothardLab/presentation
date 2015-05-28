no_logfile = true;

begin;

trial {
	
	picture { 
	}pic1;
	code = "pic";
}trial1;

begin_pcl;

vsg::circular_generator circular = new vsg::circular_generator ( 50.0, 50.0, false );
vsg::graphic_generator graph_gen = new vsg::graphic_generator( 800.0, 600.0 );
graph_gen.add_transformation( circular, vsg::combine_none );
graph_gen.add_parameter_increment( circular, vsg::phase, 5.0 );
graphic_surface new_graphic = graph_gen.create();
pic1.add_part( new_graphic, 0, 0 );
trial1.present();
loop int i = 1 until i > 500
begin
	graph_gen.draw( new_graphic );
	trial1.present();
	i = i + 1;
end;