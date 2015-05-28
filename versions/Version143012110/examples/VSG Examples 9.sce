no_logfile = true;

begin;

trial {
   trial_duration = 1000;
   picture { }pic1;
}trial1;

begin_pcl;

vsg::gradient_generator gradient = new vsg::gradient_generator( 0.0, 90.0, 0.0, true );
vsg::gradient_generator gradient2 = new vsg::gradient_generator( 90.0, 90.0, 0.0, true  );
vsg::normalized_graphic graph = gradient.generate( 800.0, 600.0 );
gradient2.generate_and_multiply( graph );
graphic_surface new_graphic = graph.create_graphic( 127.5, 127.5, 127.5, 127.5, 127.5, 127.5 );
pic1.add_part( new_graphic, 0, 0 );
trial1.present();