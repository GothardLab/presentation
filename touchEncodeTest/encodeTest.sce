#	Philip Putnam, 2016, University of Arizona


# Scenario file parameters
scenario = "Encode Test";
active_buttons = 2;
default_font = "Courier New";
default_font_size = 15;

# ---------------------------------------------------------------------------
#										Begin SDL code
# ---------------------------------------------------------------------------
begin;

#Blank default screen
picture {} default;

picture {

	display_index=2;
	text { caption = "X"; display_index=2;} numberText;
	x = 0; y = 0; # String to display touch position
	
}numberScreen;



# ---------------------------------------------------------------------------
#										Begin PCL code
# ---------------------------------------------------------------------------
begin_pcl;

# ------------------ Access national instruments card ------------------
dio_device card = new dio_device( ni_dio_device, 1, 0 );

# ------------------ Setup output ports  ------------------
output_port juicePulse = output_port_manager.get_port(1);
output_port openData = output_port_manager.get_port(2);
output_port openPulse = output_port_manager.get_port(3);

# ------------------ Send Encode Subroutine ------------------
sub
	encode ( int codeValue )
begin
	openData.send_code(codeValue, 2);
	openPulse.send_code(255,1)
end;


int i = 0;

loop # Loop through the number of specified blocks
		i = 1 
until 
		i > 1500 
begin 
			numberText.set_caption( "i:" + printf( i, "%6d" ), true );
			encode(i);
			wait_interval(33);
			i = i+1;
			
			numberScreen.present();
end; 



