scenario = "Touch Input Example";
active_buttons = 2;
default_font = "Courier New";
default_font_size = 20;

begin;

picture {
	text { caption = " "; } resp_text;
	x = 0; y = 300;
} pic;

begin_pcl;

int interact_display_count = 8;

touch_device tdevice = touch_device( response_manager.get_mouse( 0 ) );
if (is_null( tdevice )) then
	exit( "touch_device required for this scenario" )
end;
tdevice.set_max_buffer_count( 100 );

sub draw_response( response_data d, text t ) begin
	touch_response tr = touch_response( d );
	if (!is_null( tr )) then
		string state = "Down";
		if (tr.button() == 2) then state = "Up  " end;
		t.set_caption( "time: " + printf( tr.time_double(), "%9.2f" ) + " " + state + " " +
			"     x: " + printf( tr.x(), "%8.2f" ) +
			"     y: " + printf( tr.y(), "%8.2f" ),
			true )
	end
end;

sub draw_interaction_info( touch_interaction ti, text t ) begin
	if (ti.active()) then
		t.set_font_color( 255, 0, 0 )
	else
		t.set_font_color( 0, 0, 255 )
	end;
	t.set_caption( "id: " + printf( ti.id(), "%4i" ) +
		"    samples: " + printf( ti.sample_count(), "%4i" ) +
		"     x: " + printf( ti.x(), "%8.2f" ) +
		"     y: " + printf( ti.y(), "%8.2f" ),
		true )
end;

array<text> interact_desc[0];
loop int i = 1 until i > interact_display_count begin
	text t = new text;
	t.set_caption( " ", true );
	interact_desc.add( t );
	pic.add_part( t, 0, (interact_display_count / 2 - i) * 50 );
	i = i + 1
end;

int min_active_index = 1;
int response_count = 0;
loop until false begin
	if (response_manager.response_data_count() > response_count) then
		response_count = response_manager.response_data_count();
		draw_response( response_manager.last_response_data(), resp_text )
	end;

	int current = tdevice.current_index();
	loop int i = min_active_index until i > current begin
		touch_interaction ti = tdevice.get_interaction( i );
		if (is_null( ti )) then
			min_active_index = i + 1
		else
			draw_interaction_info( ti, interact_desc[ i % interact_display_count + 1 ] );
			if (!ti.active()) then
				if (i == min_active_index) then
					min_active_index = i + 1
				end
			end
		end;
		i = i + 1
	end;
	pic.present()
end