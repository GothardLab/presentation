no_logfile = true;

begin;

picture {
	arrow_graphic {
		coordinates = -100, -50, 100, 50;
		line_width = 15;
		color = 255, 255, 0;
		head_width = 50;
		head_length = 50;
	}arrow1;
	x = 0; y = 0;
} pic1;

trial {
	trial_duration = 1000;
	picture pic1;
}trial1;

begin_pcl;

trial1.present();
#Changing properties of an SDL created arrow in PCL
arrow1.set_head_type( head_swift );
arrow1.redraw();
trial1.present();

#Create an arrow in PCL with default properties and then set properties and redraw
arrow_graphic arrow2 = new arrow_graphic;
arrow2.set_coordinates( 200.0, 100.0, 200.0, -100.0 );
arrow2.set_line_width( 10.0 );
arrow2.set_color( 255, 0, 255, 255 );
arrow2.set_head_width( 40.0 );
arrow2.set_head_length( 40.0 );
arrow2.redraw();
pic1.set_part( 1, arrow2 );
trial1.present();

#Create an arrow in PCL with all properties set
arrow_graphic arrow3 = new arrow_graphic( 150.0, 20.0, -200.0, 0.0, 5.0, 15.0, 10.0, head_flat );
pic1.set_part( 1, arrow3 );
trial1.present();  
