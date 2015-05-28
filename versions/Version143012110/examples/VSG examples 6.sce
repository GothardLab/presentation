no_logfile = true;

begin;

trial {
	trial_duration = 200;
	
	picture { 
	}pic1;
	code = "pic";
}trial1;

begin_pcl;

vsg::checker_circle_generator checker = new vsg::checker_circle_generator ( 0.0, 0.0, 300.0, 10, 8 );
vsg::graphic_generator graph_gen = new vsg::graphic_generator( 800.0, 600.0 );
graph_gen.add_transformation( checker, vsg::combine_none );
graph_gen.add_parameter_increment( checker, vsg::phase, 180.0 );
graphic_surface new_graphic = graph_gen.create();
pic1.add_part( new_graphic, 0, 0 );
trial1.present();
loop until checker.inner_radius() >= checker.outer_radius()
begin
	loop int i = 1 until i > 10 
	begin
		graph_gen.draw( new_graphic );
		trial1.present();
		i = i + 1;
	end;
	checker.set_inner_radius( checker.inner_radius() + 30.0 );
	if checker.rings() > 1 then
		checker.set_rings( checker.rings() - 1 );
		graph_gen.increment(1);
	end;
end;
