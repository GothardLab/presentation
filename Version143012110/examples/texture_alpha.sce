# demonstrates transparent_color in textures

scenario = "Texture Alpha Sample";     
no_logfile = true; 

active_buttons = 2;
button_codes = 1, 2;
default_all_responses = false;
response_logging = log_active;     
begin;                           
#--------------------------------------------------------------------------------

picture {} default;

texture { filename = "graphic4.bmp"; } txr1;

plane {
   height = 400.0; width = 400.0;
   emissive = 1.0, 1.0, 1.0; #this fully lights the plane without the need for light objects
   mesh_texture = txr1;
} plane1;
        
# intro trial
trial {       
   trial_type = first_response;
   trial_duration = forever;  
   all_responses = true;
   
	picture {
		text {
			system_memory = true; 
			font_size=15; 
	caption="You can make a texture semi-transparent in four ways.
1) set a transparent_color
2) set the alpha to a number between 0 and 255
3) set the alpha to an image                             
4) load a .dds file

.dds files can be created in certain graphics applications
including Photoshop (with a plugin from developer.nvidia.com).

This example will show you a plane with a texture mapped
onto it drawn over some sample text.  Each time you click
the mouse, the alpha method used will change, starting
with no alpha (an alpha of 1.0) and then moving through
the 4 modes listed above.

Please click mouse to continue...";
      }; 
		x=0; y=0;
	};
	time = 0;
} introtx;
 
# main picture stimulus
trial {       
   trial_type = first_response;
   trial_duration = forever;  
   all_responses = true;

   picture {
      background_color = 0, 64, 0;
             
   	plane plane1;
   	x = 0.0; y = 0.0; z = 0.0;
   
   	text {
         system_memory = true;
         background_color = 0, 64, 0;
   		font_size=20; 
   	   caption="Sample Text   Sample Text   Sample Text
Sample Text   Sample Text   Sample Text
Sample Text   Sample Text   Sample Text
Sample Text   Sample Text   Sample Text
Sample Text   Sample Text   Sample Text
Sample Text   Sample Text   Sample Text
Sample Text   Sample Text   Sample Text
Sample Text   Sample Text   Sample Text
Sample Text   Sample Text   Sample Text
Sample Text   Sample Text   Sample Text
Sample Text   Sample Text   Sample Text
Sample Text   Sample Text   Sample Text
Sample Text   Sample Text   Sample Text
Sample Text   Sample Text   Sample Text
Sample Text   Sample Text   Sample Text
Sample Text   Sample Text   Sample Text";
      }; 
   	x=0; y=0;
   } pic1;  
} trial1;

begin_pcl;

# show intro trial
introtx.present();

trial1.present();          
                   
txr1.set_transparent_color( 255, 255, 255 ); #convert white pixels to transparent

trial1.present();          

txr1.set_alpha( 128 ); #50% transparency

trial1.present();         

txr1.set_alpha_file( "transparent.bmp" ); #load an image into the alpha channel

trial1.present(); 

plane1.load_texture( "circle.dds" ); #load a .dds file         

trial1.present(); 