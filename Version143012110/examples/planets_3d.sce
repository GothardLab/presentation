# simulates the gravitational effect of a large mass on small masses
# the large mass position can be changed using the mouse

scenario = "Planets";    
no_logfile = true; 
active_buttons = 2;
button_codes = 1, 2;
default_all_responses = false;
response_logging = log_active;     

#--------------------------------------------------------------------------------
begin;                           
#--------------------------------------------------------------------------------

picture {} default;

#for lighting the planets as if from sun
light {              
   light_type = light_point;
   diffuse = 1.0, 1.0, 1.0;
   ambient = 0.0, 0.0, 0.0;
   specular = 0.0, 0.0, 0.0;
   attenuation = 0.6, 0.004, 0.000006; 
} light1;

#for lighting the sun
light {              
   light_type = light_directional;
   direction = 1, -1, 3;
   diffuse = 0.001, 0.001, 0.001;
   ambient = 0.0, 0.0, 0.0;
   specular = 0.0, 0.0, 0.0;
} light2;

#setting the sun's alpha to 0.8 allows you to see the planets when they go behind it
sphere { radius = 10; slices = 16; stacks = 16; diffuse = 900.0, 900.0, 0.0; alpha = 0.8; } sun;
sphere { radius = 5; slices = 16; stacks = 16; diffuse = 0.0, 0.8, 0.4;  emissive = 0.0, 0.1, 0.05; specular = 0.0, 0.0, 0.0, 0.0;} planet;
        
# intro trial
trial {       
   trial_type = first_response;
   trial_duration = forever;  
   all_responses = true;
   
	picture {
		text {
			system_memory = true; 
			font_size=15; 
	caption="You can simulate smooth motion in presentation by transforming
the x, y, z coordinates of the objects by small amounts and rapidly
presenting the same picture stimulus.

This demonstration emulates gravity between the sun and several
surrounding planets.  You can move the sun around with your
mouse, and can reset the planets to their initial position by
clicking the mouse button.  Right-click to change the magnification.
You may wish to make some adjustments
to the pcl code to tune this experiment to your system's speed.
When you are finished, press the Esc key to end
the scenario.

Please click mouse to continue....";
      }; 
		x=0; y=0;
	};
	time = 0;
} introtx;
 
# picture stimulus used for the text input
picture {
	text {
	font_size = 15;
	caption = "Enter number of planets (1-20): ";};
	x = 0; y = 25;
   text {
	   system_memory = true;
	   font_size=15;
	   caption=" ";
	} input_text;
	x=0; y=0;
} input_pict;
                                          
# main picture stimulus used to draw sun and planets
#planets will be added in the pcl code
picture {       
   camera_position = 0, 0, -600;
   light light1;
   light light2;
	sphere sun;
	x = 0; y = 0; z = -30;
} one_pict;

begin_pcl;

# subroutine to get number of planets from user
sub int num_planets begin
   int rval;
   loop until (rval >= 1) && (rval <= 20) begin
      rval = int( system_keyboard.get_input( input_pict, input_text ));
   end;
   return rval
end;    

# main program ----------------------------------------------

# show intro trial
introtx.present(); 
                                                  
# prompt user for number of planets
int pmax = num_planets(); 

# coordinates of planets
array<double> x[pmax];
array<double> y[pmax];  
# velocities of planets
array<double> vx[pmax];
array<double> vy[pmax]; 
# coordinates of sun
double sunx = 0.0;
double suny = 0.0;  
# size of boxes
int max_sun_size = 5;
int max_planet_size = 2; 
# magnification factor 
double mag = 1.0;
double mag2 = 1.0;
 
# factor that incorporates strength of gravity and time step
# change this to make motion faster or slower
double delta = 0.2; 
# number of calculation time steps per frame
# change this depending on machine speed
# use a lower value for slower machines
int iterations = int(320.0/double(pmax));  

# get a reference to the mouse object
mouse mos = response_manager.get_mouse(1);
                                 
# subroutine to reset to initial positions and velocities 
sub reset_planets begin  
   sunx = 0.0;
   suny = 0.0; 
   mos.set_xy( 0, 0 );
	loop int i = 1 until i > pmax begin
		x[i] = 0.0;             
		# slightly different initial y for each planet
		y[i] = double(i) * 1.5 + 80.0; 
		# slightly different initial vx for each planet
		vx[i] = 0.02 + double(i)/350.0;
		vy[i] = 0.0;
		i = i + 1;
	end;
end;            

# reset planets to start
reset_planets();   

# Load our picture up with the specified number of planets  
loop int i = 1 until i > pmax begin
   #use insert_3dpart rather than add_3dpart so that the sun is drawn last
   #in order to see the planets behind the sun, it must be drawn last           
	one_pict.insert_3dpart( 1, planet, x[i], y[i], 0.0 ); 
   i = i + 1;   
end;         

# counter to detect control mouse clicks
int last_left_count = response_manager.total_response_count( 1 ); 
int last_right_count = response_manager.total_response_count( 2 );
    
# the main loop
loop int i = 0 until i > 100000 begin 
   i = i + 1;             
   
   # change sun position in the picture stimulus                  
	one_pict.set_3dpart_xyz( pmax + 1, sunx, suny, -30.0 );
	light1.set_position( sunx, suny, -30.0 );
	# calculate new planet positions and change in the picture stimulus
	loop int j = 1 until j > pmax begin
		loop int k = 0 until k > iterations begin 
		   k = k + 1;
			double dist_sqrd = pow(x[j] - sunx, 2.0) + pow(y[j] - suny, 2.0); 
			# smooth out gravity inside the sun 
			# (Keeps planets from shooting off into space (sometimes))
			if (dist_sqrd < 2.0) then dist_sqrd = 2.0; end;
			#calculate new velocity
			vx[j] = vx[j] - delta * (x[j] - sunx) / pow(dist_sqrd, 1.5);
			vy[j] = vy[j] - delta * (y[j] - suny) / pow(dist_sqrd, 1.5);
         #apply velocity to position
			x[j] = x[j] + vx[j];
			y[j] = y[j] + vy[j];
		end;      
		
		one_pict.set_3dpart_xyz(j, x[j], y[j], 0.0 );
		j = j + 1;
	end;     
	                 
	# show the picture
	one_pict.present();          
                   
   # get new mouse coordinates
	mos.poll(); 
	sunx = double(mos.x()); 
	suny = double(mos.y());
                    
   # find out if user reset planets
	if (response_manager.total_response_count( 1 ) > last_left_count) then
		last_left_count = response_manager.total_response_count( 1 );
		reset_planets();
	end;       
	# find out if magnification has changed
	if (response_manager.total_response_count( 2 ) > last_right_count) then
	   last_right_count = response_manager.total_response_count( 2 );   
	   mag = mag + 1.0;
	   if (mag > 4.0) then mag = 1.0 end;
	end;                                            
	# smoothly transition to new magnification level if different than current level
	if (mag < mag2 - 0.01 || mag > mag2 + 0.01) then
   	if (mag < mag2) then
	      mag2 = mag2 - 0.1;
	   else
	      mag2 = mag2 + 0.05;
	   end;
      one_pict.set_camera_xyz( 0.0, 0.0, -mag2 * 600.0 );
	end;               
end;