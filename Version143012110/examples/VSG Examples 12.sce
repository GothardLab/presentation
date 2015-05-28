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

vsg::shape_generator shape = new vsg::shape_generator();

array<double>shape_coords[5][2];
loop int i = 1 until i > shape_coords.count()
begin
	loop int j = 1 until j > shape_coords[i].count()
	begin
		shape_coords[i][j] = (random() * 600.0) - 300.0;
		j = j + 1;
	end;
	i = i + 1;
end;
shape.set_join_type( vsg::join_flat );
shape.add_polygon( shape_coords, 10.0, 1.0, vsg::fill_value_none, 1.0, 0.0 );
vsg::normalized_graphic norm_graph = shape.generate( 800.0, 600.0 );
graphic_surface surface = norm_graph.create_graphic( 127.5, 127.5, 127.5, 127.5, 127.5, 127.5 );
pic1.set_part( 1, surface );
trial1.present();