active_buttons = 1;
button_codes = 1;
stimulus_properties = stim, string, x_pos, number, y_pos, number,
	x_sel, number, y_sel, number;
event_code_delimiter = ",";

begin;

picture {
	text { caption = "+"; font_size = 12; };
	x = 0; y = 0;
} pic;

begin_pcl;

mouse mse = response_manager.get_mouse( 1 );
int max_x = display_device.width() / 2;
int min_x = -max_x;
int max_y = display_device.height() / 2;
int min_y = -max_y;
mse.set_min_max( 1, min_x, max_x );
mse.set_min_max( 2, min_y, max_y );
mse.set_restricted( 1, true );
mse.set_restricted( 2, true );
	
sub get_location begin
	mse.poll();
	mse.set_xy( 0, 0 );
	loop
		int count = response_manager.total_response_count( 1 )
	until
		response_manager.total_response_count( 1 ) > count
	begin
		mse.poll();
		pic.set_part_x( 1, mse.x() );
		pic.set_part_y( 1, mse.y() );
		pic.present()
	end
end;

loop until false begin
	get_location()
end