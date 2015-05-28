no_logfile = true;

begin; 
trial {
	trial_duration = 5000;
	picture { 
				
	} pic1; 
}trial1;

begin_pcl; 
  
vsg::polygon_generator pol = new vsg::polygon_generator( 25.0, 3, 5.0, vsg::join_point, 0.0 ); 
vsg::normalized_graphic graph = pol.generate( 800.0, 600.0 ); 
pol.set_draw_background( false ); 
loop int i = 4 until i > 15 begin 
	pol.set_radius( double(i*20) ); 
	pol.set_rotation( double(i) * 5.0 );
	pol.set_sides( i ); 
	pol.generate( graph ); 
	i = i + 1; 
end; 
graphic_surface surface = graph.create_graphic( 127.5, 127.5, 127.5, 127.5, 127.5, 127.5 ); 
pic1.add_part( surface, 0.0, 0.0 ); 
trial1.present();