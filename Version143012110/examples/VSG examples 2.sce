no_logfile = true;

begin;

picture {
   bitmap { preload = false; }dummy;
   x = 0; y = 0;
} pic;

begin_pcl;

vsg::checker_circle_generator check = new vsg::checker_circle_generator( 0.0, 50.0, 250.0, 6, 8 );
array<graphic_surface>surfaces[50];
vsg::graphic_generator graph_gen = new vsg::graphic_generator( 800.0, 600.0 );
graph_gen.add_transformation( check, vsg::combine_none );
graph_gen.add_parameter_increment( check, vsg::phase, 10.0 );
graph_gen.draw( surfaces, 50 );
loop int i = 1 until i > surfaces.count()
begin
   pic.set_part( 1, surfaces[i] );
   pic.present();
   wait_interval(20);
   i = i + 1;
end;