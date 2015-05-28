no_logfile = true;

begin;

trial {
	trial_duration = 1000;
	
	picture { 
		bitmap { preload = false; }dummy;
		x = 0; y = 0;
	}pic1;
	code = "pic";
}trial1;

begin_pcl;

vsg::ellipse_generator ellipse = new vsg::ellipse_generator ( 200.0, 100.0, 0.0 );
ellipse.set_offset( 200.0, 100.0 );
vsg::normalized_graphic norm_graph = ellipse.generate( 800.0, 600.0 );
graphic_surface surface = norm_graph.create_graphic( 127.5, 127.5, 127.5, 127.5, 127.5, 127.5 );
pic1.set_part( 1, surface );
trial1.present();

ellipse.set_height( 400.0 );
ellipse.set_background( -0.5 );
ellipse.set_foreground( 0.5 );
ellipse.set_offset( 0.0, 0.0 );
norm_graph = ellipse.generate( 800.0, 600.0 );
norm_graph.draw_graphic( surface, 127.5, 127.5, 127.5, 127.5, 127.5, 127.5 );
trial1.present();