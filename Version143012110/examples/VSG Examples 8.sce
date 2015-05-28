no_logfile = true;

begin;

trial {
	trial_duration = 50;
	
	picture { 
		bitmap { preload = false; }dummy;
		x = 0; y = 0;
	}pic1;
	code = "pic";
}trial1;

begin_pcl;

vsg::gaussian_generator gaussian = new vsg::gaussian_generator ( 0.0, 100.0 );
array<graphic_surface>surfaces[25];
vsg::graphic_generator graph_gen = new vsg::graphic_generator( 800.0, 600.0 );
graph_gen.add_transformation( gaussian, vsg::combine_none );
graph_gen.add_parameter_increment( gaussian, vsg::mu, 10.0 );
graph_gen.draw( surfaces, 25 );
loop int i = 1 until i > surfaces.count()
begin
   pic1.set_part( 1, surfaces[i] );
   trial1.present();
   i = i + 1;
end;