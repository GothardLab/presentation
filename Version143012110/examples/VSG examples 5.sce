no_logfile = true;

begin;

trial {
	trial_duration = 1000;
	
	picture { 
	}pic1;
	code = "pic";
}trial1;

begin_pcl;

vsg::annulus_generator annulus = new vsg::annulus_generator ( 200.0, 100.0, 500.0, 300.0, 30.0 );
vsg::normalized_graphic norm_graph = annulus.generate( 800.0, 600.0 );
graphic_surface surface = norm_graph.create_graphic( 127.5, 127.5, 127.5, 127.5, 127.5, 127.5 );
pic1.add_part( surface, 0, 0 );
trial1.present();
