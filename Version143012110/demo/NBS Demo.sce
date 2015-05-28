scenario = "New demo";
# pretend we're getting input pulses from a scanner
scenario_type = fMRI_emulation;
# 3 s per fictitious scan
scan_period = 3000;
response_matching = simple_matching;
no_logfile = true;
active_buttons = 12;
button_codes = 1,2,3,4,5,6,7,8,9,10,11,12;
default_font_size = 24;
default_font = "Arial";
default_background_color = 0,0,0;
begin;

###---Begin commonly used SDL parts

$top_color = "33,67,105";
$bottom_color = "122,150,180";
$bottom_continue_y = -364;
$bottom_line_y= -344;
$top_main_text_y = 250;
$mid_line_y = 100;
$top_halfway_y = 300;
$bottom_halfway_y = -150;
box{color = $top_color; height = 400; width = 1024;}top_box;
box{color = $bottom_color; height = 500; width = 1024;}bottom_box;
box{color = $top_color; height = 40; width = 1024;}continue_box;
box{color = 0,0,0; height = 2; width = 1024;}line;
text{caption = " ";}dummy;
text{caption = " "; background_color = $bottom_color;}bottomdummy;
text{caption = "Click a mouse button to continue. Press escape to quit or 'm' to return to the menu."; font_size = 14; background_color = $top_color;}continue1;


trial{
	trial_type = specific_response;
	terminator_button = 1,2,6;
   trial_duration = forever;
   stimulus_event{
		picture{
			box top_box;
			x = 0; y = $top_halfway_y; 
			box bottom_box;
			x = 0; y = $bottom_halfway_y; 
			box line;
			x = 0; y = $mid_line_y; 
			text dummy; 
			x = 0; y = $top_main_text_y; 
			box continue_box;
			x = 0; y = $bottom_continue_y; on_top = true;
			box line;
			x = 0; y = $bottom_line_y; on_top = true;
			text continue1; 
			x = 0; y = $bottom_continue_y; on_top = true;
			text dummy; 
			x = 0; y = -130;
		}basic_pic;
	}basic_event;
}basic_trial;

trial{
	trial_type = specific_response;
	terminator_button = 1,2,6;
   trial_duration = forever;
   picture{
		background_color = $top_color;
		text dummy;
		x = 0; y = 0;
		box line;
		x = 0; y = $bottom_line_y;
		text continue1; 
		x = 0; y = $bottom_continue_y;
	}fullscreen_pic;
}fullscreen_trial;

# ---------------------------------------------------------
# 3d slide objects

cuboid{
   width = 100; height = 100; depth = 100;
   color = 1.0, 0.0, 0.0, 1;
   color = 0.0, 1.0, 0.0, 2;
   color = 0.0, 0.0, 1.0, 3;
   color = 1.0, 1.0, 0.0, 4;
   color = 0.0, 1.0, 1.0, 5;
   color = 1.0, 0.0, 1.0, 6;                   
} cube1; 

cuboid{
   width = 150; height = 150; depth = 150;
   color = 1.0, 0.0, 0.0, 1;
   color = 0.0, 1.0, 0.0, 2;
   color = 0.0, 0.0, 1.0, 3;
   color = 1.0, 1.0, 0.0, 4;
   color = 0.0, 1.0, 1.0, 5;
   color = 1.0, 0.0, 1.0, 6;                   
} cube2; 

sphere{
   radius = 50; slices = 16; stacks = 16;
   color = 1.0, 0.9, 0.1, 1;
} sphere1;

sphere{
   radius = 10; slices = 16; stacks = 16; alpha = 0.7;
   color = 1.0, 0.9, 0.1, 1;
} sphere2;

cylinder{
   radius = 75, 75; height = 90; slices = 32;
   color = 0.2, 0.6, 1.0, 1;
   color = 0.8, 0.1, 0.1, 2;
   color = 0.4, 0.9, 0.4, 3;
} cylinder1;

cone{
   radius = 100; height = 100; slices = 32;
   color = 1.0, 1.0, 0.0, 1;
   color = 0.0, 0.0, 1.0, 2;
} cone1; 

sound {wavefile {filename = "ding.wav";}ding;}boing;

bitmap {filename = "squirrel.jpg";}squirrel;
bitmap {filename = "flower.jpg";}flower;
bitmap {filename = "mountain.jpg";}mountain;

###---End commonly used SDL parts

###---------------begin menu SDL---

sound {wavefile {filename = "menu.wav";};}menu_sound;

box {height = 10 ; width = 10;}border_box;

array {
	LOOP $i 20; 
	text {caption = " "; background_color = 44, 91, 143 ;};
	ENDLOOP;
}menu_text;

text{caption = "+"; font_size = 24; trans_src_color = 0,0,0; font = "Courier";}cursor;
text{caption = " "; font_size = 36; background_color = $bottom_color;}titletext;

trial{
	picture{
	background_color = 122,150,180;
	}pic;
}menu_screen;

###---------------end menu SDL---

######FEATURES

#####Stimuli

###---------------begin 2d visual stimuli SDL---

#Photo display SDL
text {caption = "Presentation can display images that are in .bmp, .pcx or .jpg format."; background_color = $top_color;}phototext;

#Text display SDL
text {caption = "Presentation can display text. You can specify\nthe font, the color, a background color, and more.\nBelow are some possibilities."; background_color = $top_color;}displaytext;
text {caption = "Color"; background_color = $bottom_color; font_color = 255,255,0;}text1;
text {caption = "Font"; background_color = $bottom_color; font = "Georgia";}text2;
text {caption = "Background\ncolor"; background_color = 128, 0, 64;}text3;
text {caption = "Size"; background_color = $bottom_color; font_size = 48;}text4;

#Vertical refresh SDL
text {caption = 
"Presentation coordinates the display of all visual stimuli
with the monitor vertical refresh. You can change the display
as often as every refresh. This screen counts up one
frame for every monitor refresh."; 
background_color = $top_color;}refreshtext;
text {caption = " "; background_color = $bottom_color;}frameratetext;

trial{
	stimulus_event{
		picture{
			box top_box;
			x = 0; y = $top_halfway_y; 
			box bottom_box;
			x = 0; y = $bottom_halfway_y; 
			box line;
			x = 0; y = $mid_line_y; 
			text refreshtext; 
			x = 0; y = $top_main_text_y; 
			box continue_box;
			x = 0; y = $bottom_continue_y; 
			box line;
			x = 0; y = $bottom_line_y; 
			text continue1; 
			x = 0; y = $bottom_continue_y; 
			text frameratetext; 
			x = 0; y = -130;		
		}framerate_pic;
		code = "code";
	}frame_event;
}frame_trial;

#animate (Planets) SDL
text {caption = "Press the right mouse button to move to the next screen. Press escape to quit or 'm' to return to the menu."; font_size = 14; background_color = $top_color;}planets_continue;
text {caption = "You can make your own animations with Presentation.
Dynamically change or move visual elements programmatically,
including in response to subject responses."; background_color = $top_color;}planets_text; 
text {caption = "Move the sun around with your mouse. 
Reset the planets by clicking the left mouse button."; font_size = 18; background_color = $bottom_color;}planets_instruct;
bitmap {filename = "sun.pcx"; trans_src_color = 255,255,255;}sun;
bitmap {filename = "planet.pcx"; trans_src_color = 255,255,255; }planet;

picture{
	box bottom_box;
	x = 0; y = $bottom_halfway_y;
	text planets_instruct;
	x = 0; y = 30;
	bitmap sun; 
	x = 0; y = $bottom_halfway_y;	
	box top_box;
	x = 0; y = $top_halfway_y;
	box line;
	x = 0; y = $mid_line_y;	
	text planets_text; 
	x = 0; y = $top_main_text_y;
	box continue_box;
	x = 0; y = $bottom_continue_y;
	box line;
	x = 0; y = $bottom_line_y;
	text planets_continue;
	x = 0; y = $bottom_continue_y;	
}planet_pic;

#multimodal SDL
array{
	sound { wavefile { preload = false; } wave1; };
	sound { wavefile { preload = false; } wave2; };
	sound { wavefile { preload = false; } wave3; };
	sound { wavefile { preload = false; } wave4; };
	sound { wavefile { preload = false; } wave5; };
}sounds;

text { caption = 
"You can simultaneously present multiple sounds, videos,
and changing visual stimuli.
In this example, Presentation is randomly presenting one of 5 tones
every 200ms, and presents pictures from a list every 600 ms."; background_color = $top_color;}multimodaltext;
array{
	bitmap mountain;
	bitmap squirrel;
	bitmap flower;
}pics;

#icm SDL----
bitmap {filename = "icm_profile.pcx";}icm;
text {caption = "Press space to change the icm profile. "; font_size = 18; background_color = $bottom_color;}icmcontinue;
text{caption = 
"You can adjust the color calibration of your video card before
or during an experiment. In this case, the ICM profile 
changes every time you press the space bar. NBS provides a utility
to help you create ICM profiles on the NBS web site. The Presentation 
ICM properties window is also shown below."; background_color = $top_color;}icmtext;
text{caption = " "; background_color = $bottom_color; }icmtext2;

picture{
	box top_box;
	x = 0; y = $top_halfway_y;
	box bottom_box;
	x = 0; y = $bottom_halfway_y;
	box line;
	x = 0; y = $mid_line_y;
	text icmtext; 
	x = 0; y = $top_main_text_y;
	box continue_box;
	x = 0; y = $bottom_continue_y;
	box line;
	x = 0; y = $bottom_line_y;
	text continue1; 
	x = 0; y = $bottom_continue_y;
	bitmap icm;
	x = 0; y = -130;
	text icmtext2; 
	x = 0; y = 30;
	text icmcontinue;
	x = 0; y = -280;
}icm_pic;

#multiple monitor SDL
text {caption = 
"Presentation can display stimuli on multiple monitors
simultaneously. You can use as many displays as Windows
allows. Each visual stimulus is targeted at a particular
display."; background_color = $top_color;}multi_monitortext;
bitmap {filename = "multiple_display.pcx";}multi_monitor;

###---------------end 2d visual stimuli SDL---

###---------------begin video stimuli SDL---

#video1 SDL
text {caption = "Presentation allows you to present videos, which
may be mixed with other visual or auditory stimuli.
You can even present multiple videos simultaneously.
Videos can be in any non-proprietary, non-interlaced
format. You can download a separate video features
demo from the web site by searching for \"new video demo\"
in the experiment archive."; background_color = $top_color;}video1text;

#video2 SDL
text {caption = "The timing accuracy for video is the same as the
timing accuracy for static visual stimuli. You can create a
detailed log of every single frame presented that 
includes the frame number, time, and uncertainty.
You can control other timing features of video as
well. For instance, you can manually control the 
frame presentation (without audio), and play a video at
a different speed (without audio)."; background_color = $top_color;}video2text;

#video3 SDL
text {caption = "Other features of video playback in Presentation
include the ability to play an arbitrary section
of a video fle, playing a video wrapped on a 3d
object, and displaying partially transparent videos."; background_color = $top_color;}video3text;


###---------------end video stimuli SDL---

###---------------begin 3d visual stimuli SDL---
#Warning
text { caption = "Some video cards may not display Presentation 3d
as intended. Remember that if your video card does not
seem to be displaying the 3d images described in the
screens ahead, you can go back to the menu by pressing
'm' at any time."; background_color = $top_color;}warning;


#Transparency
text { caption = "You can make parts of pictures transparent. Here we have
a picture with varying levels of transparency
on a 3d plane and we are moving that plane
over another graphical element."; background_color = $top_color;}alphatext;

texture { filename = "flower.jpg"; } txr1;

plane {
   height = 148.0; width = 200.0;
   emissive = 1.0, 1.0, 1.0; #this fully lights the plane without the need for light objects
   mesh_texture = txr1;
} plane1;

trial {       
	trial_type = specific_response;
	terminator_button = 5;
   trial_duration = forever;
   picture {
      background_color = 0, 64, 0;
             
   	plane plane1;
   	x = 0.0; y = 0.0; z = 0.0;
		box top_box;
		x = 0; y = $top_halfway_y;
		box bottom_box;
		x = 0; y = $bottom_halfway_y;
		box line;
		x = 0; y = $mid_line_y;
		text alphatext; 
		x = 0; y = $top_main_text_y;
		box continue_box;
		x = 0; y = $bottom_continue_y;
		box line;
		x = 0; y = $bottom_line_y;
		text continue1; 
		x = 0; y = $bottom_continue_y;
   	text {
         system_memory = true;
         background_color = $bottom_color;
   		font_size=14; 
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
   	x=0; y=-140;
   } alpha_pic;  
} alpha_trial;

#stereo display SDL
text{caption = "Presentation is capable of stereo display using 3d nVidia drivers
to alternate left and right frames for a 3D scene, or by 
using the multiple monitor capability to send a completely 
different signal to devices that accept two inputs."; background_color = $top_color;}stereo_disp;

picture{
	light {
		light_type = light_point;  position = 0.0, 0.0, -300.0;
		diffuse = 1.0, 1.0, 1.0; ambient = 0.0, 0.0, 0.0;
		attenuation = 0.9, 0.000003, 0.0000003;
	} stereo_light; 
	box top_box;
	x = 0; y = $top_halfway_y;
	box bottom_box;
	x = 0; y = $bottom_halfway_y;
	box line;
	x = 0; y = $mid_line_y;
	text stereo_disp; 
	x = 0; y = $top_main_text_y;
	box continue_box;
	x = 0; y = $bottom_continue_y;
	box line;
	x = 0; y = $bottom_line_y;
	text continue1; 
	x = 0; y = $bottom_continue_y;
	cuboid cube2;
	x = 0.0; y = -160.0; z = 0.0;
}stereo_pic;

#3d primitives SDL

text{caption = "You can create 3d pictures and move around within them.
On the next screen, you will be looking at a field of 3d 
objects. To strafe left, press 's', to move right, press 'f',
to move back, press 'd', or to move forward, press 'e'. 
You can change the camera angle with the mouse.

Press the mouse button to move on and try it out."; background_color = $top_color;}primitivestext; 



picture {
	background_color = $bottom_color;
	camera_position = 0.0, 0.0, 0.0;

	light {
		light_type = light_point;  position = 0.0, 0.0, -100.0;
		diffuse = 1.0, 1.0, 1.0; ambient = 0.0, 0.0, 0.0;
		attenuation = 0.9, 0.000003, 0.0000003;
	} look_light; 
	box continue_box;
	x = 0; y = $bottom_continue_y; on_top = true;
	box line; 
	x = 0; y = $bottom_line_y; on_top = true;
	text continue1; 
	x = 0; y = $bottom_continue_y; on_top = true;
} look_pic;

#3d model SDL
mesh {
   scale_factor = 20.0, 20.0, 20.0;
   filename = "bigship1.x";
} mesh_ship;

text{caption = "You can import 3d models into Presentation
for use in your experiments. Here we have a 3d model of a 
spaceship that is being rotated."; background_color = $top_color;}model_3dtext;

#3d camera
text{caption = "You can control where the camera in a 3d
picture is looking. On the next screen, objects
will be placed in the picture and the camera
will turn randomly.

Press a mouse key to move on and watch the 3d scene."; background_color = $top_color;}cameratext; 


#light control SDL 
text{caption = "You can control the position of lights in a 3d scene.
Below is a rotating cube being lit by two point lights that are represented
by the small yellow spheres."; background_color = $top_color;}light_control;

picture{
	light {
		light_type = light_point;  position = 0.0, 0.0, -300.0;
		diffuse = 1.0, 1.0, 1.0; ambient = 0.0, 0.0, 0.0;
		attenuation = 0.9, 0.000003, 0.0000003;
	} light1; 
	light {
		light_type = light_point;  position = 0.0, 0.0, 300.0;
		diffuse = 1.0, 1.0, 1.0; ambient = 0.0, 0.0, 0.0;
		attenuation = 0.9, 0.000003, 0.0000003;
	} light2; 
	box top_box;
	x = 0; y = $top_halfway_y;
	box bottom_box;
	x = 0; y = $bottom_halfway_y;
	box line;
	x = 0; y = $mid_line_y;
	text light_control; 
	x = 0; y = $top_main_text_y;
	box continue_box;
	x = 0; y = $bottom_continue_y;
	box line;
	x = 0; y = $bottom_line_y;
	text continue1; 
	x = 0; y = $bottom_continue_y;
	cuboid cube2;
	x = 0.0; y = -180.0; z = 0.0;
	sphere sphere2;
	x = 0.0; y = 0.0; z = -300.0;
	sphere sphere2;
	x = 0.0; y = 0.0; z = 300.0; 
}light_pic;

###---------------end 3d visual stimuli SDL---

###---------------begin auditory stimuli SDL---
#wavefiles SDL
array{
	sound {wavefile {filename = "bQ0.wav";};};
	sound {wavefile {filename = "dQ0.wav";};};
	sound {wavefile {filename = "gQ0.wav";};};
}wavesounds;

text{caption = "Presentation can play multiple simultaneous
sounds as part of your experiment. You can use sounds stored
as wavefiles, or generate simple tones with Presentation."; background_color = $top_color;}wavestext;
text{caption = "Press the space bar to hear a sound."; background_color = $bottom_color; font_size = 18; }wavestext2;

#attenuation SDL
array{
	LOOP $i 6;
	$k = '$i * .1';
	sound { wavefile ding; attenuation = '$k'; description = "$k";};
	ENDLOOP;
}atten_sounds;
text{caption = "You can attenuate sounds in Presentation. Here we start with an 
attenuation of zero, and increase attenuation over time. 
The sound is attenuated by the value of the attenuation 
parameter * 100 db."; background_color = $top_color; }attentext;
text{caption = " "; background_color = $bottom_color; }attentext2;

#multichannel SDL
sound { wavefile { preload = false; } multichan; } multisnd;
text{caption = 
"You can independently control up to 8 speakers, and 
specify the speaker and attenuation for each channel
of a multiple channel sound."; background_color = $top_color; }multi_chantext;
text{caption = " "; background_color = $bottom_color; }multi_chantext2;


#windows sound control SDL
text{caption = "You can control the master volume on your computer before or 
during an experiment. To control beforehand, set the volume 
settings in the master volume settings box (shown below)."; background_color = $top_color;}windowssoundtext;
bitmap {filename = "windowssound.pcx";}windowssound;

#latency SDL
text { caption = "Presentation can present sounds with very low latency,
depending on your sound card. Multiple mixing modes 
are provided to achieve the best possible results on
the widest array of standard hardware. See the NBS web
site for detailed sound card latency test results."; background_color = $top_color; }latencytext; 
bitmap {filename = "SCLA_Screenshot.pcx"; }latency;

###---------------end auditory stimuli SDL---

#####End Stimuli

#####Responses

###---------------begin button response SDL---

#reused button response SDL
bitmap {filename = "circle.pcx"; trans_src_color = 33,67,105;}circle;
bitmap {filename = "ring.pcx"; trans_src_color = 255,255,255; }ring;
text {caption = " "; background_color = $bottom_color; }timetext;
text {caption = " "; background_color = $bottom_color; }speedtext;
text {caption = " "; background_color = $bottom_color; }pressed;
text {caption = "Press the space bar to continue. Press escape to quit or 'm' to return to the menu."; font_size = 14; background_color = $top_color;}buttonpress_continue;

#keyboard button response SDL
text {caption = 
"Presentation monitors button press responses at all times.
The keyboard can be used as a giant response pad. Just select
which keys are to be used as response buttons. Response data
is recorded and available in real time, allowing response
dependent experiment behavior."; background_color = $top_color; }fstext;
text {caption = "Press 'f' to make the circle accelerate counter-clockwise\nPress 's' to make it accelerate in the clockwise direction."; background_color = $bottom_color; font_size = 18; }fsinstruct;

#mouse button response SDL
text {caption = "The mouse can also be used for button response. This works
in exactly the same way as keyboard button presses."; background_color = $top_color; }mouse_buttontext;
text {caption = "Press the left mouse button to accelerate counter-clockwise.\nPress the right button to accelerate in the clockwise direction."; background_color = $bottom_color; font_size = 18; }mouse_buttoninstruct;

#keyboard input SDL
text {caption = 
"You can also accept typed responses and display
the text. Text entry can be terminated by a 
specific character, length, or time limit.";background_color = $top_color; }keytext;
text {caption = "Please type 'continue'."; background_color = $bottom_color; font_size = 18; }directtext;
text {caption = " "; background_color = $bottom_color; text_align = align_left; }inputtext;
text {caption = " "; background_color = $bottom_color; font_size = 18; font_color = 145, 200, 145;}wrongtext;
text {caption = "Type 'continue' and press return to continue. Press escape to quit."; font_size = 14; background_color = $top_color;}keyboard_continue;

#game devices SDL
bitmap {filename = "game_dev1.jpg";}game_dev1;
bitmap {filename = "game_dev2.jpg";}game_dev2;
bitmap {filename = "game_dev3.jpg";}game_dev3;
text {caption = "Presentation can also accept button press and
release responses from any other DirectX compatible device.
A few such devices are shown below."; background_color = $top_color; }game_devtext;

#serial response SDL
text { caption = 
"Presentation can use any serial reponse box that
sends one byte for each event. You may also use
custom response devices that use the parallel port
or digital I/O cards."; 
background_color = $top_color; }serialresponsetext; 

bitmap {filename = "port_devices.pcx";}idsettings; 
bitmap {filename = "port_device_props.pcx";}idparams;


#sound response buttons SDL
text {caption = 
"Presentation can use sound card inputs to
detect voice responses. You set the threshold
parameters, and the responses can be recorded
to disk."; background_color = $top_color;}sound_resptext;
bitmap {filename = "soundtest.jpg";}soundtest;

#button device pictures
picture{
	box top_box;
	x = 0; y = $top_halfway_y;
	box bottom_box;
	x = 0; y = $bottom_halfway_y;
	box line;
	x = 0; y = $mid_line_y;
	text fstext;
	x = 0; y = $top_main_text_y;
	box continue_box;
	x = 0; y = $bottom_continue_y;
	box line;
	x = 0; y = $bottom_line_y;
	text buttonpress_continue; 
	x = 0; y = $bottom_continue_y;
	bitmap ring;
	x = -2; y = -138;
	bitmap circle;
	x = 0; y = -90;
	text timetext;
	x = 330; y = -90;
	text speedtext;
	x = 330; y = -140;
	text pressed;
	x = 330; y = -200;
	text fsinstruct;
	x = 0; y = 40;
}button_pic;

picture{
	box top_box;
	x = 0; y = $top_halfway_y;
	box bottom_box;
	x = 0; y = $bottom_halfway_y;
	box line;
	x = 0; y = $mid_line_y;
	text keytext;
	x = 0; y = $top_main_text_y;
	box continue_box;
	x = 0; y = $bottom_continue_y;
	box line;
	x = 0; y = $bottom_line_y;
	text keyboard_continue; 
	x = 0; y = $bottom_continue_y;
	text directtext;
	x = 0; y = 0;
	text inputtext;
	left_x = $bottom_halfway_y; y = -120;
	text wrongtext;
	x = 0; y = -160;
}keyboard_input_pic;


###---------------end button response SDL---

###---------------begin axis positions SDL---

#mouse as axis device
text {caption = 
"Presentation can monitor mouse movements.
Those coordinates can be used to display a cursor
or to make any other display change you require."; background_color = $top_color; }mousetext;
text {caption = " "; background_color = $bottom_color; text_align = align_left; }coordtextx;
text {caption = " "; background_color = $bottom_color; text_align = align_left; }coordtexty;
text {caption = "Move the mouse around and see the coordinates."; background_color = $bottom_color; font_size = 18;}mouseinstruct;
picture{
	box top_box;
	x = 0; y = $top_halfway_y;
	box bottom_box;
	x = 0; y = $bottom_halfway_y;
	box line;
	x = 0; y = $mid_line_y;
	text mousetext; 
	x = 0; y = $top_main_text_y;
	box continue_box;
	x = 0; y = $bottom_continue_y;
	box line;
	x = 0; y = $bottom_line_y;
	text continue1; 
	x = 0; y = $bottom_continue_y;
	text coordtextx;
	left_x = -120; y = 50;
	text coordtexty;
	left_x = 10; y = 50;
	text mouseinstruct;
	x = 0; y = -180;
	text cursor; 
	x = 0; y = $bottom_halfway_y;
}mouse_pic;

#other axis devices SDL 
bitmap {filename = "axis_dev1.jpg";}axis_dev1;
bitmap {filename = "axis_dev2.jpg";}axis_dev2;
bitmap {filename = "axis_dev3.jpg";}axis_dev3;
text {caption = "Presentation can also get coordinates of other
axis devices like joysticks and wheels
that are DirectX compatible."; background_color = $top_color;}axistext;

#touchscreen SDL
bitmap {filename = "touchscreen.jpg";}touchscreen;
text {caption = "Presentation can also get coordinates from
touchscreen devices. Any of these devices can be
tested in Presentation in the Settings tab."; background_color = $top_color;}touchscreentext;

#force feedback SDL
text {caption = "You can use DirectX compatible force feedback devices in
Presentation to present tactile stimuli. Below is the testing
window used to test a device's force effects."; background_color = $top_color; } forcefeedbacktext;
bitmap {filename = "feedback.pcx";}forcefeedback;

###---------------end axis positions SDL---

#####End Responses

###---------------begin hardware interfacing SDL---

#port input SDL
text { caption = "Presentation lets you receive and log codes and pulses
sent from external devices during the experiment using
standard serial or parallel ports as well as digital I/O cards. 
You may use multiple ports in the same experiment."; background_color = $top_color; }portinputtext; 
bitmap {filename = "portinput.pcx"; }portinput;

#port output SDL
text { caption = "Presentation can produce output from standard serial or parallel
ports and digital I/O cards in conjunction with 
stimulus or response events.
You can even use several ports simultaneously."; background_color = $top_color; }portoutputtext; 
bitmap {filename = "portoutput.pcx"; }portoutput;

#fMRI mode SDL
$npics = 10; # declare and name all bitmaps bwlow- uses variable in strings
array{
	LOOP $i $npics;
	$k = '$i + 1';
	bitmap { filename = "disk$k.pcx"; trans_src_color = 127, 127, 127;}  "wedge$k";
	ENDLOOP;
}fmrionpics;

array{
	LOOP $i $npics;
	$k = '$i + 1';
	bitmap { filename = "disk_off$k.pcx"; trans_src_color = 127, 127, 127;}  "wedgeo$k";
	ENDLOOP;
}fmrioffpics;

text {caption = "Presentation stimulus delivery can be synchronized to external pulses
marking events such as transcranial magnetic stimulation or 
MR data acquisition. Scenarios like this one can be tested 
using fMRI emulation mode, which simulates such pulses.
In this case, the pulses occur every 3 seconds."; background_color = $top_color;}fmritext;
text {caption = "Please wait for next\nsimulated pulse."; background_color = $bottom_color;}fmri_wait;
text {caption = " "; background_color = $bottom_color;}pulsetext;

###---------------end hardware interfacing SDL---

###---------------begin programmability SDL---

#programmability SDL
text { caption = "Using the Presentation control language, you can program
a huge variety of experiments and have complete control
over stimulus delivery."; background_color = $top_color; }programmabilitytext; 
bitmap {filename = "programmability.pcx"; }programmability;

#randomization SDL
text { caption = "You can randomize your stimuli and randomly 
construct stimuli as the experiment is running. 
Here, the stimuli are generated during the scenario
to simulate a visual search task."; background_color = $top_color;}randomtext;

box { height = 18; width = 6; color = 255,0,0; } target;  

array {                                                
   LOOP $i 20;
   box { height = 1; width = 1; color = 18,208,9; };
   ENDLOOP;
} boxes;

picture {
	box top_box;
	x = 0; y = $top_halfway_y;
	box bottom_box;
	x = 0; y = $bottom_halfway_y;
	box line;
	x = 0; y = $mid_line_y;
	text randomtext; 
	x = 0; y = $top_main_text_y;
	box continue_box;
	x = 0; y = $bottom_continue_y;
	box line;
	x = 0; y = $bottom_line_y;
	text continue1; 
	x = 0; y = $bottom_continue_y;
}random_pic ;

#feedback SDL
text{caption = "Presentation can automatically categorize stimulus-response
pairs for feedback. Presentation will display feedback 
based on your choice."; background_color = $top_color; }catstim_resptext;
array {
	text { caption = "A"; description = "A"; font_size = 36; background_color = $bottom_color; } A;
	text { caption = "B"; description = "B"; font_size = 36; background_color = $bottom_color; };
	text { caption = "C"; description = "C"; font_size = 36; background_color = $bottom_color; };
	text { caption = "D"; description = "D"; font_size = 36; background_color = $bottom_color; };
	text { caption = "E"; description = "E"; font_size = 36; background_color = $bottom_color; };
} letters;

text {caption = "Press S if the letters are the same, D if they are different."; font_size = 18; background_color = $bottom_color;}instructfeedback;


	
trial{
	trial_duration = 800;
	stimulus_event{
		picture{
			box top_box;
			x = 0; y = $top_halfway_y;
			box bottom_box;
			x = 0; y = $bottom_halfway_y;
			box line;
			x = 0; y = $mid_line_y;
			text catstim_resptext; 
			x = 0; y = $top_main_text_y;
			box continue_box;
			x = 0; y = $bottom_continue_y;
			box line;
			x = 0; y = $bottom_line_y;
			text continue1; 
			x = 0; y = $bottom_continue_y;
			text A; 
			x = -100; y = -60;
			text A; 
			x = 100; y = -60;	
			text instructfeedback;
			x = 0; y = -300;
		}stim_res_pic;
		response_active = true;
	}stim_res_event;
}stim_res_trial;

text { caption = "Good!"; background_color = $bottom_color; } good;
text { caption = "Incorrect!"; background_color = $bottom_color; } incorrect;
text { caption = "Too slow!"; background_color = $bottom_color; } tooslow;

trial{
	trial_type = specific_response;
	terminator_button = 6;
   trial_duration = 1000;
   stimulus_event{
		picture{
			box top_box;
			x = 0; y = $top_halfway_y;
			box bottom_box;
			x = 0; y = $bottom_halfway_y;
			box line;
			x = 0; y = $mid_line_y;
			text catstim_resptext; 
			x = 0; y = $top_main_text_y;
			box continue_box;
			x = 0; y = $bottom_continue_y;
			box line;
			x = 0; y = $bottom_line_y;
			text continue1; 
			x = 0; y = $bottom_continue_y;
			text good; 
			x = 0; y = -170;
			text instructfeedback;
			x = 0; y = -300;
		}feedback_pic;
	}feedback_event;
}feedback_trial;



#Adaptive SDL
box { height = 200; width = 200; color = 128,128,128; } surround_left;
box { height = $mid_line_y; width = $mid_line_y; color = 128,128,128; } center_left;
box { height = 200; width = 200; color = 128,128,128; } surround_right;
box { height = $mid_line_y; width = $mid_line_y; color = 128,128,128; } center_right; 
                                                            
text { caption = "Presentation's control language allows you to program adaptive
procedures like this double staircase procedure in which 2 correct
answers increase the difficulty and one decreases it. One staircase 
approaches the outer gray from the dark side, and one from the light."; background_color = $top_color; }adaptivetext;

text {caption = "Press space to move on, escape to quit or 'm' to return to the menu."; font_size = 14; background_color = $top_color;}adaptivecontinue;
text {caption = "Click the left or right mouse button to signify which side has a square 
with a square of another color inside it."; font_size = 18; background_color = $bottom_color;}adaptiveinstruct;
                                                         
picture {
	box top_box;
	x = 0; y = $top_halfway_y;
	box bottom_box;
	x = 0; y = $bottom_halfway_y;
	box line;
	x = 0; y = $mid_line_y;
	text adaptivetext; 
	x = 0; y = $top_main_text_y;
	box continue_box;
	x = 0; y = $bottom_continue_y;
	box line;
	x = 0; y = $bottom_line_y;
	text adaptivecontinue; 
	x = 0; y = $bottom_continue_y;
   box surround_left;   # defined earlier
   x = $bottom_halfway_y;          # x coordinate of center
   y = -130;          # y coordinate of center
   box center_left;     # defined earlier
   x = $bottom_halfway_y;          # x coordinate of center
   y = -130;          # y coordinate of center 
   box surround_right;   # defined earlier
   x = 150;          # x coordinate of center
   y = -130;          # y coordinate of center
   box center_right;     # defined earlier
   x = 150;          # x coordinate of center
   y = -130;          # y coordinate of center 
	text adaptiveinstruct;
	x = 0; y = -300;
} center_surround_stimulus;

trial {  
   trial_duration = 1500;
   picture {
		box top_box;
		x = 0; y = $top_halfway_y;
		box bottom_box;
		x = 0; y = $bottom_halfway_y;
		box line;
		x = 0; y = $mid_line_y;
		text adaptivetext; 
		x = 0; y = $top_main_text_y;
		box continue_box;
		x = 0; y = $bottom_continue_y;
		box line;
		x = 0; y = $bottom_line_y;
		text adaptivecontinue; 
		x = 0; y = $bottom_continue_y;
      text { caption = "Correct"; font_size = 36; background_color = $bottom_color; };
      x = 0; y = -130;
   };  
} correct;                 

trial {  
   trial_duration = 1500;
   picture {
		box top_box;
		x = 0; y = $top_halfway_y;
		box bottom_box;
		x = 0; y = $bottom_halfway_y;
		box line;
		x = 0; y = $mid_line_y;
		text adaptivetext; 
		x = 0; y = $top_main_text_y;
		box continue_box;
		x = 0; y = $bottom_continue_y;
		box line;
		x = 0; y = $bottom_line_y;
		text adaptivecontinue; 
		x = 0; y = $bottom_continue_y;
      text { caption = "Incorrect"; font_size = 36; background_color = $bottom_color; };
      x = 0; y = -130;
   };  
} wrong;

trial {  
   trial_duration = forever;
   trial_type = first_response; 
   
   stimulus_event{   
      picture center_surround_stimulus;  
      stimulus_time_in = 200;     
   } center_surround_event;
} trial1;  

#Analyzer SDL
text { caption = 
"After you run the experiment, you can use Presentation's analyzer
for quick performance statistics and to format the data for
easy importation into your statistics or analysis package."; background_color = $top_color; }analyzertext; 
bitmap {filename ="analyzer.pcx"; }analyzer;

#Matlab SDL
text { caption = 
"Presentation can communicate with 3rd party software using
Presentation \"extensions\". This includes commercial eye
tracking systems. You can even write your own extensions.
One extension provided by NBS allows control of Matlab.";  background_color = $top_color; }matlabtext;
text { caption = "MATLAB"; font = "Times"; font_size = 64; background_color = $bottom_color;}matlab_logo;
bitmap {filename = "matlablogo.jpg"; trans_src_color = 0,0,0;}matlab;

###---------------end programmability SDL---

###---------------begin timing SDL---

#logfiles SDL
text { caption = 
"Presentation will create logfiles with stimulus and response data 
that record everything of interest that happens during the experiment,
including complete timing information. Logfiles and data files created
by the Presentation analyzer are simple and portable text files."; background_color = $top_color; }logfilestext; 
bitmap {filename ="logfile.pcx"; }logfiles;

#uncertainty SDL
text {caption = 
"Presentation reports timing uncertainties that
control for operating system interruptions. The event time and
uncertainty give you a time interval within which the event 
detection definitely occurred. Combined with knowledge of your
hardware, you can verify the timing of every event."; background_color = $top_color; } uncertaintytext;
bitmap {filename = "uncertainty.pcx"; }uncertainty;

###---------------end timing SDL---

######END FEATURES

######DEMOS

###---------------begin Stroop SDL

array{
	text { caption = " "; font_color = 255, 0, 0; description = "red"; background_color = 255,255,255;}red;
	text { caption = " "; font_color = 255, 128, 64; description = "orange"; background_color = 255,255,255;};
	text { caption = " "; font_color = 255, 255, 0; description = "yellow"; background_color = 255,255,255;};
	text { caption = " "; font_color = 0, 255, 0; description = "green"; background_color = 255,255,255;};
	text { caption = " "; font_color = 0, 0, 255; description = "blue"; background_color = 255,255,255;};
	text { caption = " "; font_color = 141, 83, 172; description = "purple"; background_color = 255,255,255;};
}colors;

array{
	box { height = 20; width = 50; color = 255, 0, 0; }red_box;
	box { height = 20; width = 50; color = 255, 128, 64; }orange_box;
	box { height = 20; width = 50; color = 255, 255, 0; }yellow_box;
	box { height = 20; width = 50; color = 0, 255, 0; }green_box;
	box { height = 20; width = 50; color = 0, 0, 255; }blue_box;
	box { height = 20; width = 50; color = 141, 83, 172; }purple_box;
}stroop_boxes;

array{
	text {caption = "In the following block, press the
left mouse button if the text of the word on the left side
matches the text of the word in the center and
press the right mouse button if the text of the
word on the right side matches the text of the
word in the center."; font_color = 0,0,0; background_color = 255,255,255; }stroop_dummy;
	text {caption = "In the following block, press the
left mouse button if the text of the word on the left side
matches the color of the box in the center and
press the right mouse button if the text of the
word on the right side matches the color of the
box in the center."; font_color = 0,0,0; background_color = 255,255,255; };
	text {caption = "In the following block, press the
left mouse button if the text and color of the word on the left side
matches the text and color of the word in the center and
press the right mouse button if the text and color of the
word on the right side matches the text and color of the
word in the center."; font_color = 0,0,0; background_color = 255,255,255; };
	text {caption = "In the following block, press the
left mouse button if the color of the word on the left side
matches the color of the word in the center and
press the right mouse button if the color of the
word on the right side matches the color of the
word in the center."; font_color = 0,0,0; background_color = 255,255,255; };
}introtext;

text {caption = "The following is an example of a Stroop task experiment.
There are four different blocks. Please choose a number of trials
per block between 1 and 20 or type m for menu and press enter."; font_color = 0,0,0; background_color = 255,255,255; }choose;
text {caption = " "; font_color = 0,0,0; background_color = 255,255,255; }stroop_input;

text {caption = " "; font_color = 0,0,0; background_color = 255,255,255; }no_color;

text {caption = " "; font_color = 0,0,0; background_color = 255,255,255; }left_choice;
text {caption = " "; font_color = 0,0,0; background_color = 255,255,255; }right_choice;

text {caption = " "; font_color = 0,0,0; background_color = 255,255,255; }instruct;

text {caption = "Press m to return to the menu or escape to quit at any time."; font_size = 14; font_color = 0,0,0; background_color = 255,255,255; }continue2;
text {caption = "Press the left mouse button to continue."; font_size = 14; font_color = 0,0,0; background_color = 255,255,255; }continue3;

text {caption = " "; font_color = 0,0,0; background_color = 255,255,255; }results;

picture{
	background_color = 255,255,255;
	text choose;
	x = 0; y = 0;
	text stroop_input;
	x = 0; y = $bottom_halfway_y;
}stroop_input_pic;

trial{
	trial_duration = forever;
   trial_type = first_response;
	picture{
		background_color = 255,255,255;
		text stroop_dummy;
		x = 0; y = 0;
		text continue2;
		x = 0; y = $bottom_continue_y;
		text continue3;
		x = 0; y = -329;
	}stroop_intro_pic;
}stroop_intro_trial;

trial{
	trial_duration = forever;
   trial_type = first_response;
	picture{
		background_color = 255,255,255;
		text results;
		x = 0; y = 0;
		text continue2;
		x = 0; y = $bottom_continue_y;
		text continue3;
		x = 0; y = -329;
	}stroop_results_pic;
}stroop_results_trial;

picture{
	background_color = 255,255,255;
	text red;
	x = 0; y = 0;
	text left_choice;
	x = -200; y = -100;
	text right_choice;
	x = 200; y = -100;
	text instruct;
	x = 0; y = 200;
	text continue2;
	x = 0; y = $bottom_continue_y;
}stroop_main_pic;


trial {  
   trial_duration = forever;
   trial_type = first_response; 
   
   stimulus_event{   
      picture stroop_main_pic;  
      stimulus_time_in = 80; 
		code = "code";
		response_active = true;
   } stroop_main_event;	
} stroop_main_trial; 
###---------------end Stroop SDL

###---------------begin visual search SDL

text {caption = "Press m to return to the menu or escape to quit at any time."; font_size = 14; }n_back_continue;

array {                                                
   LOOP $i 20;
   box { height = 1; width = 1; color = 0,255,0; };
   ENDLOOP;
} vis_search_boxes;
box { height = 2; width = 20; color = 255,255,255; } vis_fix_hor;
box { height = 20; width = 2; color = 255,255,255; } vis_fix_ver;  

picture {
   box vis_fix_hor; x = 0; y = 0;
   box vis_fix_ver; x = 0; y = 0;
	text n_back_continue;
   x = 0; y = $bottom_continue_y;
} vis_search_default;

trial {
   trial_duration = forever;
	trial_type = specific_response;
	terminator_button = 1,2,6;  
   
   picture vis_search_default;
   time = 0;
   
   stimulus_event {
      picture {	
			text n_back_continue;
			x = 0; y = $bottom_continue_y;
		} vis_search_pic1; 
      stimulus_time_in = 200;
      time = 1000;
   } vis_search_event1;
} vis_search_trial1;

text {
         caption = 
"You can randomize your stimuli and
randomly construct stimuli as the
experiment is running. Here, the stimuli
are generated during the scenario for
a typical visual search task.
 
If a red square is present, click the 
left mouse button. Otherwise, click the
right mouse button.";
      } vis_search_text;

trial {      
   trial_duration = forever;
   trial_type = first_response;
   
   picture {
      text {
         caption = " ";
      } vis_search_results_text;
      x = 0; y = 0;
      text {
         caption = "Click the mouse to continue...";
         font_size = 14;
      };
      x = 0; y = -200;
      text n_back_continue;
		x = 0; y = $bottom_continue_y;
   }vis_search_message_pic;
} vis_search_message_trial;

###---------------end visual search SDL

###---------------begin N-Back SDL
array {
   text { caption = "A"; description = "A";  font_size = 36; } letterA;
   text { caption = "B"; description = "B";  font_size = 36; };
   text { caption = "C"; description = "C";  font_size = 36; };
   text { caption = "D"; description = "D";  font_size = 36; };
   text { caption = "E"; description = "E";  font_size = 36; };
} n_back_letters;


text { caption = " ";  }n_back_input;
text { caption = "The following demo is an example of an 
N-back task. You will choose your N to be 1, 2, or 3. 
Whatever your N is, this denotes which letter will be 
the target. For instance, if you choose a 2-Back task,
then you will be continuously watching for the letter
to be the same letter as it was 2 letters ago.

You will press the mouse button when the current letter
matches the letter that was presented n letters ago.

Please type in 1, 2, or 3 to denote your N
or 'm' to return to the menu and press Enter:";  }intro_text;
text { caption = " "; }confirm;


picture{
	text intro_text;
	x = 0; y = 0;
	text n_back_input;
	x = 0; y = -250;
	text n_back_continue;
   x = 0; y = $bottom_continue_y;
}intro_pic;


trial{
   trial_duration = forever;
   trial_type = first_response; 
		picture{
		text confirm;
		x = 0; y = 0;
	}confirm_pic;
}confirm_trial;

picture { text n_back_continue; x = 0; y = $bottom_continue_y; }n_back_default;
trial {
	trial_type = specific_response;
	terminator_button = 6;
   trial_duration = 2000;
   stimulus_event {
      picture {
         text letterA;
         x = 0; y = 0;
         text n_back_continue;
         x = 0; y = $bottom_continue_y;
      } n_back_pic;
      time = 0;
      duration = 500;
      code = "n-back";
   } n_back_event1;
   picture n_back_default;
   time = 500;
} n_back_main_trial;
###---------------end N-Back SDL

###---------------begin backward masking SDL

text {caption = "XXX";}mask;

text {caption = " ";}display;

array{
	text {caption = "ONE"; description = "ONE"; }stim;
	text {caption = "MOO"; description = "MOO"; };
	text {caption = "ANY"; description = "ANY"; };
	text {caption = "SEE"; description = "SEE"; };
	text {caption = "TWO"; description = "TWO"; };
	text {caption = "LIE"; description = "LIE"; };
	text {caption = "TAG"; description = "TAG"; };
	text {caption = "DUE"; description = "DUE"; };
	text {caption = "LOW"; description = "LOW"; };
	text {caption = "FEW"; description = "FEW"; };
}words;

trial{
   trial_duration = forever;
   trial_type = first_response; 
		picture{
		text display;
		x = 0; y = 0;
		text n_back_continue;
		x = 0; y = $bottom_continue_y;
	}masking_display_pic;
}masking_display_trial;

trial{
	trial_type = specific_response;
	terminator_button = 6;
   trial_duration = 2000;
	stimulus_event{
		picture{
			text stim;
			x = 0; y = 0;
			text n_back_continue;
			x = 0; y = $bottom_continue_y;
		}stim_pic;
		time = 0;
		code = "targ";
		}target_event;
		picture{
			text mask;
			x = 0; y = 0;
			text n_back_continue;
			x = 0; y = $bottom_continue_y;
		}mask_pic;
		deltat = 26;
	picture{
		text n_back_continue;
		x = 0; y = $bottom_continue_y;
	} mask_default;
	time = 500;
}mask_trial;

trial{
	trial_type = specific_response;
	terminator_button = 6;
   trial_duration = 2000;
	stimulus_event{
		picture stim_pic;
		time = 0;
		code = "targ";
	}no_mask_target_event;
	picture mask_default;
}no_mask_trial;

###---------------end backward masking SDL


###---------------begin auditory threshold SDL
picture {
	text { caption = "Press the left mouse button when you hear a tone.
Press 'm' to return to the menu or Escape to quit."; font_size = 18;};
	x = 0; y = 0;
} aud_default;
sound { wavefile { filename = "t0250hz.wav";} t250; }s250;
sound { wavefile { filename = "t0500hz.wav";} t500; }s500;
sound { wavefile { filename = "t1000hz.wav";} t1000; }s1000;
sound { wavefile { filename = "t2000hz.wav";} t2000; }s2000;
sound { wavefile { filename = "t4000hz.wav";} t4000; }s4000;

text {caption = "Press a mouse button to continue
Press m to go to the menu or Escape to quit at any time"; font_size = 18;}aud_continue;
text {caption = " ";}aud_results_text;

trial {
	picture {
		text { caption = "This is an example of determining the auditory
threshold for the pure tones.

Once you begin, press the left mouse button whenever you hear a tone.

Now, press the left mouse button to begin.";
			system_memory = true; };
		x = 0; y = 0;
	};
	time = 0;
	duration = response;

} aud_intro;

trial {
	trial_duration = 2000;
	trial_type = first_response;
	picture aud_default;
	stimulus_event {
		sound s250;
		code = "";
		time = 1000;
	} stim1;
} aud_trial;

trial{
	trial_duration = forever;
   trial_type = first_response;
   terminator_button = 1, 2, 6;
	picture{
		text aud_results_text;
		x = 0; y = 0;
		text aud_continue;
		x = 0; y = $bottom_continue_y;
	}aud_results_pic;
}aud_results_trial;


###---------------end auditory threshold SDL

######END DEMOS

######SUPPORT
array{
	text {caption = 
"Presentation comes with complete,
hyper-linked, indexed, searchable
documentation -- your first stop 
for Presentation information."; background_color = $top_color;};
	text {caption = 
"The documentation includes many 
examples and tutorials to get
you started quickly."; background_color = $top_color;};
	text {caption = 
"The NBS web site contains tutorial
videos that cover the basics of 
using Presentation.";background_color = $top_color; };
	text {caption = 
"The NBS web site experiment archive
contains examples and complete 
experiments uploaded by NBS and
Presentation users that you can
download."; background_color = $top_color;};
	text {caption = 
"You can post questions to the NBS 
Forums message boards to be answered
by other users and NBS staff.";background_color = $top_color; };
	text {caption = 
"We can even program your experiments
for you through NBS consulting services.
As your time is valuable, this can be
a very cost-effective way to get started.";background_color = $top_color; };
} supporttext;

array{
	bitmap {filename = "help_file.pcx";}screen1;
	bitmap {filename = "doc_tutorial.pcx";};
	bitmap {filename = "web_tutorial.pcx";};
	bitmap {filename = "exp_archive.pcx";};
	bitmap {filename = "forums.pcx";};
	bitmap {filename = "consultation.pcx";};
} supportscreens;

######END SUPPORT

begin_pcl;

###-------begin pcl globals---


int max_x = display_device.width() / 2;
int min_x = -max_x;
int max_y = display_device.height() / 2;
int min_y = -max_y;
int bottom_max_y = 100; #for restricting mouse to bottom half
int bottom_min_y = min_y + 40; #for restricting mouse to bottom half
mouse mse = response_manager.get_mouse(1);

###-------end pcl globals---

###-------re-used subroutines
sub wait (int wait_time)
begin
	loop int time = clock.time()
	until clock.time() > time + wait_time
	begin
	end;
end;

sub bool resp (int button, int current_count)
begin
	if response_manager.total_response_count(button) > current_count then
		return true
	end;
	return false;
end;

###-------end re-used subroutines

###-------begin menu pcl---
sub int current_button(array<int,2>& locations, int x, int y)
begin
	loop
		int i = 1
	until
		i > locations.count()
	begin
		if ( (x >= locations[i][1]) && (x <= locations[i][2]) &&
			  (y <= locations[i][3]) && (y >= locations[i][4]) ) then
			return i
		end;
		i = i + 1
	end;
	return 0
end;


sub int menu (array<string,1>& options, string title)
begin
	mse.set_min_max( 1, min_x, max_x );
	mse.set_min_max( 2, min_y, max_y );
	mse.set_restricted( 1, true );
	mse.set_restricted( 2, true );
	###adjustable parameters for menu
	int border_width = 5;
	int box_dist = 20;
	##
	array<int> locations[options.count()][4];
	int number = options.count();
	int max_width = 0;
	###set the text captions into the text array and find the max_width
	loop int i = 1 until i > number begin
		menu_text[i].set_height(0);
		menu_text[i].set_width(0);
		menu_text[i].set_caption(options[i]);
		menu_text[i].redraw();
		if int(menu_text[i].width()) > max_width then
			max_width = int(menu_text[i].width());
		end;
		i = i + 1;
	end;
	###make the proper number of button boxes and border boxes with the right dimensions and colors
	int text_height = int(menu_text[number].height()) + 30;
	int box_height = text_height + border_width * 2;
	int text_width = max_width + 30;
	int box_width = text_width + border_width * 2;
	border_box.set_width( box_width);
	border_box.set_height( box_height );
	border_box.set_color( 0, 0, 0);
	loop int i = 1 until i > number 
	begin
		menu_text[i].set_width( text_width );
		menu_text[i].set_height( text_height );
		menu_text[i].set_background_color( 44, 91, 143 );
		menu_text[i].redraw();
		i = i + 1;
	end;
	###make array of locations
	int in_col = 0;
	int last_left_edge = -box_width/2;
	int last_right_edge = box_width/2;
	int last_top_edge = box_height/2;
	int last_bottom_edge = -box_height/2;
	###special case of only one choice
	if number == 1 then 
		locations[number][1] = last_left_edge; 
		locations[number][2] = last_right_edge;
		locations[number][3] = last_top_edge;
		locations[number][4] = last_bottom_edge;
		else
		###decide how many buttons per column
		if mod(number, 2) == 1 then
			in_col = number - 1;
			else 
			in_col = number;
		end;
		###how many rows
		int rows = in_col / 2;
		###put all edge locations in location array
		loop int i = 1;
			int left_edge = -(box_width + box_dist);
			until i > 2 
			begin
				int top_edge = (box_height + box_dist)*rows/2;
				loop int j = 1 until j > rows 
				begin
					int index = ((i-1) * rows) + j;
					int right_edge = (left_edge + box_width);
					int bottom_edge = top_edge - box_height;
					locations[index][1] = left_edge;
					locations[index][2] = right_edge;
					locations[index][3] = top_edge;
					locations[index][4] = bottom_edge;
					top_edge = top_edge - (box_height + box_dist);
					j = j + 1;
				end;
			left_edge = (left_edge + box_width + 2*box_dist);
			i = i + 1;
		end;
		if mod (number,2) == 1 then
			last_top_edge = (locations[number - 1][4] - box_dist);
			last_bottom_edge = last_top_edge - box_height;
			locations[number][1] = last_left_edge; 
			locations[number][2] = last_right_edge;
			locations[number][3] = last_top_edge;
			locations[number][4] = last_bottom_edge;
		end;
	end;
	###add buttons to picture pic
	loop int i = 1 until i > options.count()
	begin
		pic.add_part(border_box, locations[i][1] + box_width/2, locations[i][3] - box_height/2);
		pic.add_part(menu_text[i], locations[i][1] + box_width/2, locations[i][3] - box_height/2);
		i = i + 1;
	end;
	###add title to picture pic
	titletext.set_caption(title);
	titletext.redraw();
	pic.add_part(titletext, 0, 300);
	###add cursor to picture pic
	pic.add_part(cursor, 0, 0);
	int cursor_index = pic.part_count();
	mse.set_xy( 0, 0 );
	
	int last_location = 1;
	loop  
		int responses = response_manager.total_response_count(1);
	until false
	begin
		pic.present();
		mse.poll();
		int x = mse.x();
		int y = mse.y();	
		###display cursor at coordinates
		pic.set_part_x( cursor_index, x );
		pic.set_part_y( cursor_index, y ); 
		###change colors if necessary
		int location = current_button(locations, x, y);
		if location != last_location then
			if (location > 0) then
				menu_text[location].set_background_color(145, 200, 145 );
				menu_text[location].redraw();
				menu_sound.present();
			end;
			if (last_location > 0) then
				menu_text[last_location].set_background_color(44, 91, 143 );
				menu_text[last_location].redraw();
			end;
			last_location = location;
		end;
		if (resp(1, responses)) then
			if (location > 0) then 
			#	menu_text[last_location].set_background_color(44, 91, 143 );
			#	menu_text[last_location].redraw();				
				pic.clear();
				return location 
			end;
			responses = response_manager.total_response_count(1)
		end;
	end;
	return 0;
end;
###-------end menu pcl---

########Features PCL

#####Stimuli

###2d Stimuli

##animate planets pcl set up
# set number of planets
int pmax = 5; 
# factor that incorporates strength of gravity and time step
# change this to make motion faster of slower
double delta = 0.1; 
# number of calculation time steps per frame
# change this depending on machine speed
int iterations = int(420.0/double(pmax));
# coordinates of planets
array<double> x[pmax];
array<double> y[pmax];  
# velocities of planets
array<double> vx[pmax];
array<double> vy[pmax]; 
# coordinates of sun
double sunx = 0.0;
double suny = -130.0; 

# subroutine to reset to initial positions and velocities 
sub 
   reset_planets 
begin 
	mse.set_min_max( 1, min_x, max_x );
	mse.set_min_max( 2, bottom_min_y, bottom_max_y ); 
	mse.set_restricted( 1, true );
	mse.set_restricted( 2, true );
   sunx = 0.0;
   suny = -130.0; 
   mse.set_xy( 0, -130 );
	loop 
	   int i = 1 
	until 
	   i > pmax 
	begin
		x[i] = 0.0;             
		# slightly different initial y for each planet
		y[i] = double(i) * 1.5 - 100.0; 
		# slightly different initial vx for each planet
		vx[i] = 0.03 + double(i)/350.0;
		vy[i] = 0.0;
		i = i + 1;
	end;
end;                      

sub bool animate_planets
begin
	int m_responses = response_manager.total_response_count(6);
	# reset planets to start
	reset_planets();   
	# Load our picture up with the specified number of planets  
	loop 
		int i = 1 
	until 
		i > pmax 
	begin               
		planet_pic.insert_part( 4, planet, int( x[i] ), int( y[i] ) ); 
		i = i + 1;   
	end;
	loop 
		mse.set_min_max( 1, min_x, max_x );
		mse.set_min_max( 2, bottom_min_y, bottom_max_y ); 
		mse.set_restricted( 1, true );
		mse.set_restricted( 2, true );
		int i = 0;
		int reset_button_count = response_manager.total_response_count( 1 );
		int end_responses = response_manager.total_response_count(2);
	until 
		resp(2, end_responses) || resp(6, m_responses) 
	begin
		i = i + 1;                
		# change sun position in the picture stimulus                  
		planet_pic.set_part_x(3, int( sunx ) );
		planet_pic.set_part_y(3, int( suny ) );   
		# calculate new planet positions and change in the picture stimulus
		loop 
			int j = 1 
		until 
			j > pmax 
		begin
			loop 
				int k = 0 
			until 
				k > iterations 
			begin 
				k = k + 1;
				double dist_sqrd = pow(x[j] - sunx, 2.0) + pow(y[j] - suny, 2.0); 
				# smooth out gravity inside the sun 
				# (Keeps planets from shooting off into space (sometimes))
				if (dist_sqrd < 2.0) then dist_sqrd = 2.0; end;     
				vx[j] = vx[j] - delta * (x[j] - sunx) / pow(dist_sqrd, 1.5);
				vy[j] = vy[j] - delta * (y[j] - suny) / pow(dist_sqrd, 1.5);
	
				x[j] = x[j] + vx[j];
				y[j] = y[j] + vy[j];
			end;      		
			planet_pic.set_part_x(j + 3, int( x[j] ) );
			planet_pic.set_part_y(j + 3, int( y[j] ) );
			j = j + 1;
		end;                     
		# show the picture
		planet_pic.present();                            
		# get new mouse coordinates
		mse.poll(); 
		sunx = double(mse.x()); 
		suny = double(mse.y());
		if (resp(1, reset_button_count)) then
			reset_button_count = response_manager.total_response_count( 1 );
			reset_planets();
		end;                      
	end;
	loop 
		int i = 1 
	until 
		i > pmax 
	begin               
		planet_pic.remove_part( 4 ); 
		i = i + 1;   
	end;
	if resp(6, m_responses) then 
		return true
	end;
	return false;
end;


sub bool photos 
begin
	int m_responses = response_manager.total_response_count(6);
	basic_pic.set_part(4, phototext);
	basic_pic.set_part(8, squirrel);
	basic_pic.add_part(mountain, -250, -130);
	basic_pic.add_part(flower, 250, -130);
	basic_trial.present();
	basic_pic.remove_part(basic_pic.part_count());
	basic_pic.remove_part(basic_pic.part_count());
	if resp(6, m_responses) then 
		return true
	end;
	return false;
end;	
	
sub bool text_display 
begin
	int m_responses = response_manager.total_response_count(6);
	basic_pic.set_part(4, displaytext);
	basic_pic.set_part(8, text1);
	basic_pic.add_part(text2, -250, -130);
	basic_pic.add_part(text3, 250, -130);
	basic_pic.add_part(text4, 0, 0);
	basic_trial.present();
	loop int i = 1 until i > 3
	begin
		basic_pic.remove_part(basic_pic.part_count());
		i = i + 1
	end;
	if resp(6, m_responses) then 
		return true
	end;
	return false;
end;

sub bool frame_rate
begin
	int m_responses = response_manager.total_response_count(6);
	int responses1 = response_manager.total_response_count(1);
	int responses2 = response_manager.total_response_count(2);
	loop 
		int i = 1;
	until resp(6, m_responses) || resp(1, responses1) || resp(2, responses2)
	begin
		frameratetext.set_caption("Frame = " + string(i));
		frameratetext.redraw();
		frame_trial.present();
		i = i + 1;
	end;
	if resp(6, m_responses) then 
		return true
	end;
	return false;
end;


sub bool icm
begin
	int m_responses = response_manager.total_response_count(6);
	array<string>profiles[3] = {"default", "red", "blue"};
	array<double>default_table[3][256];
	display_device.get_color_table(default_table);
	icm_pic.present();
	int responses1 = response_manager.total_response_count(1);
	int responses2 = response_manager.total_response_count(2);
	loop int i = 1;
		int space_responses = response_manager.total_response_count(5)
	until resp(6, m_responses) || resp(1, responses1) || resp(2, responses2)
	begin 
		if resp(5, space_responses) then
			space_responses = response_manager.total_response_count(5);
			int index = mod(i, profiles.count()) + 1;
			icmtext2.set_caption(profiles[index]);
			icmtext2.redraw();
			icm_pic.present();
			if profiles[index] == "default" then
				display_device.set_color_table(default_table);
			else
				display_device.load_icm(profiles[index] + ".icm");
			end;
			display_device.apply_color_table();
			i = i + 1;
		end;
	end;
	display_device.set_color_table(default_table);
	display_device.apply_color_table();
	if resp(6, m_responses) then 
		return true
	end;
	return false;
end;

sub bool multi_monitor 
begin
	int m_responses = response_manager.total_response_count(6);
	basic_pic.set_part(4, multi_monitortext);
	basic_pic.set_part(8, multi_monitor);
	basic_trial.present();
	if resp(6, m_responses) then 
		return true
	end;
	return false;
end;

sub bool multimodal
begin
	int m_responses = response_manager.total_response_count(6);
	loop int i = 1 until i > 5
	begin
		audio_space.run( "channel1 = 0.5 * sin( " + string(i*500) + ", 0, 100, 0 )" );
		audio_space.run( "channel1 *= line(0, 1, 50, 0) + line(1, 0, 50, 50)");
		audio_space.run( "wave" + string(i) + " = (channel1, channel1)" );
		audio_space.get_wave_data( "wave" + string(i), sounds[i].get_wavefile() );
		i = i + 1;
	end;
	basic_pic.set_part(4, multimodaltext);
	basic_pic.set_part(8, mountain);
	basic_pic.present();
	loop
		int responses1 = response_manager.total_response_count(1);
		int responses2 = response_manager.total_response_count(2);
		int i = 1;
		int j = 1;
	until resp(6, m_responses) || resp(1, responses1) || resp(2, responses2)
	begin
		wait(200);
		int index = random(1, 5);
		sounds[index].present();
		if mod(i,3) == 0 then #change picture every 3 tones
			index = mod(j,3) + 1;
			basic_pic.set_part(8, pics[index]);
			basic_pic.present();	
			j = j + 1;
		end;
		i = i + 1;
	end;
	if resp(6, m_responses) then 
		return true
	end;
	return false;
end;

sub bool visual_stims2d
	begin
	if photos() then return true end;
	if text_display() then return true end;
	if frame_rate() then return true end;
	if animate_planets() then return true end;
	if icm() then return true end;
	if multi_monitor() then return true end;
	if multimodal() then return true end;
	return false;
end;

###video stimuli

sub bool video1 
begin
	int m_responses = response_manager.total_response_count(6);
	fullscreen_pic.set_part(1, video1text);;
	fullscreen_trial.present();
	if resp(6, m_responses) then 
		return true
	end;
	return false;
end;

sub bool video2 
begin
	int m_responses = response_manager.total_response_count(6);
	fullscreen_pic.set_part(1, video2text);;
	fullscreen_trial.present();
	if resp(6, m_responses) then 
		return true
	end;
	return false;
end;

sub bool video3 
begin
	int m_responses = response_manager.total_response_count(6);
	fullscreen_pic.set_part(1, video3text);;
	fullscreen_trial.present();
	if resp(6, m_responses) then 
		return true
	end;
	return false;
end;

sub bool video_stims
begin
	if video1() then return true end;
	if video2() then return true end;
	if video3() then return true end;
	return false;
end;


###3d Stimuli
#begin lookaround set up pcl
bool camera_control_has_been_run = false;
sub camera_control (bool control) begin
	mse.set_min_max( 1, min_x, max_x );
	mse.set_min_max( 2, bottom_min_y, bottom_max_y ); 
	mse.set_restricted( 1, true );
	mse.set_restricted( 2, true );
	int m_responses = response_manager.total_response_count(6);
	int responses1 = response_manager.total_response_count(1);
	int responses2 = response_manager.total_response_count(2);
	int responses7 = response_manager.total_response_count(7);
	int responses8 = response_manager.total_response_count(8);
	int responses4 = response_manager.total_response_count(4);
	int responses3 = response_manager.total_response_count(3);
	int responses11 = response_manager.total_response_count(11);
	int responses12 = response_manager.total_response_count(12);
	int responses10 = response_manager.total_response_count(10);
	int responses9 = response_manager.total_response_count(9);
   display_device.set_field_of_view( 60.0 );
   #put the objects into an array so we can loop through them
   array<d3d_picture_part> objs[4];
   objs[1] = cone1;
   objs[2] = cube1;
   objs[3] = cylinder1;
   objs[4] = sphere1;
   int field_size = 1000;
   if !camera_control_has_been_run then
      #add a bunch of objects to random locations with random rotations
      loop int oi = 1 until oi > objs.count() begin
         loop int i = 1 until i > 30 begin
            look_pic.add_3dpart( objs[oi], double(random( -field_size, field_size )), double(random( -field_size, field_size )), double(random( -field_size, field_size )) 
            , random() * 360.0, random() * 360.0, random() * 360.0 );
            i = i + 1;
         end; 
         oi = oi + 1;
      end;
   end;
   camera_control_has_been_run = true;
   #use speed to adjust the speed of movement through the 3D environment
   double speed = 16.0; 
   
   #camera position
   double cx = 0.0;
   double cy = 0.0;
   double cz = 0.0; 
   
   #angles used for looking around
   double ax = 0.0;
   double ay = 0.0;
   
   #this is a vector defining which direction the camera is looking
   double lookx = 0.0;
   double looky = 0.0;
   double lookz = 1.0;
    		
	#used for strafing from left to right with the a and d keys
   double panx = -1.0;
   double panz = 0.0;
   
	#set the camera position
	loop double j = 1.0;
		double old_x = 0.0;
		double old_y = 0.0;
		double new_x = 0.0;
		double new_y = 0.0;
	until resp(6, m_responses) || resp(1, responses1) || resp(2, responses2)
	begin 
      if control then  
      # get new mouse coordinates
   	mse.poll(); 
   	new_x = double(mse.x()); 
   	new_y = double(mse.y());
   	else
	   new_x = sin(j*0.01)*360.0; 
   	new_y = cos(j*0.01)*360.0;
   	end;
   	   ###this part is new
   	   if control then 
				if new_x != old_x || new_y != old_y then
				#apply the motion of the mouse directly to the angles
				#used in defining the trajectory (or look) vector
				ax = ax + (new_x - old_x) * 0.005;
				ay = ay + (new_y - old_y) * 0.005; 
				end;
			else
				#apply the new values directly to the angles
				#used in defining the trajectory (or look) vector
				ax = ax + (new_x - old_x) * 0.005;
				ay = ay + (new_y - old_y) * 0.005;               
         end;
         #keep the user from looking up too high or down too low
         if ay > 1.5 then ay = 1.5; end;
         if ay < -1.5 then ay = -1.5; end;
   
         #we use each these values a couple times, so we store
         #them here for future use to reduce calls to sin() and cos()
         double sinax = sin(ax);
         double cosax = cos(ax);
         double sinay = sin(ay);
         double abssinay = abs(sinay);
         
         if control then
            #detect a press of the e key

				if resp(7, responses7) && !resp(11, responses11) then
					cx = cx + lookx * speed;
					cy = cy + looky * speed;
					cz = cz + lookz * speed;
				elseif resp(7, responses7) && resp(11, responses11) then
					responses7 = response_manager.total_response_count(7);
					responses11 = response_manager.total_response_count(11);
				end;
				#detect a press of the d key
				if resp(8, responses8) && !resp(12, responses12) then
					cx = cx - lookx * speed;
					cy = cy - looky * speed;
					cz = cz - lookz * speed;
				elseif resp(8, responses8) && resp(12, responses12) then
					responses8 = response_manager.total_response_count(8);
					responses12 = response_manager.total_response_count(12);
				end;                      
				#detect a press of the s key
				if resp(4, responses4) && !resp(10, responses10) then
					cx = cx + panx * speed;
					cz = cz + panz * speed;
				elseif resp(4, responses4) && resp(10, responses10) then
					responses4 = response_manager.total_response_count(4);
					responses10 = response_manager.total_response_count(10);
				end;
				#detect a press of the f key
				if resp(3, responses3) && !resp(9, responses9) then	cx = cx - panx * speed;
					cz = cz - panz * speed;
				elseif resp(3, responses3) && resp(9, responses9) then
					responses3 = response_manager.total_response_count(3);
					responses9 = response_manager.total_response_count(9);
				end;  
				#detect a press of the m key
				if resp(6, m_responses) then
					break;
				end; 
			end;
         #calculate the new look and pan values
         lookx = sinax - sinax * abssinay;
         looky = -sinay;
         lookz = cosax - cosax * abssinay;
         panx = -cosax;
         panz = sinax;        
         if new_x > double(max_x) || new_x < double(min_x) || new_y > double(max_y) || new_y < double(min_y) then
				if new_x > double(max_x) then new_x = double(min_x); end;
				if new_x < double(min_x) then new_x = double(max_x); end;
				if new_y > double(bottom_max_y) then new_y = double(min_y); end;
				if new_y < double(min_y) then new_y = double(bottom_max_y); end; 
				mse.set_xy( int(new_x), int(new_y) );
			end;
         old_x = new_x;
			old_y = new_y;
		#set the camera to look at a spot right in front of the camera position
      look_pic.set_camera_lookat( lookx + cx, looky + cy, lookz + cz );
      #set the camera position
      look_pic.set_camera_xyz( cx, cy, cz );
      #set the light position
      look_light.set_position( cx, cy, cz );
		look_pic.present();
		j = j + 1.0;
	end;
end;   
#end lookaround pcl setup

sub bool warning
begin
	int m_responses = response_manager.total_response_count(6);
	fullscreen_pic.set_part(1, warning);
	fullscreen_trial.present();
	if resp(6, m_responses)
		then return true;
	end;
	return false;
end;

sub bool transparent
begin 
	int m_responses = response_manager.total_response_count(6);
	loop int responses1 = response_manager.total_response_count(1);
		int responses2 = response_manager.total_response_count(2);
		double i = 1.0;
		double speed = 0.05; 
		double new_x = 0.0; 
		double new_y = 0.0;
		double index = 0.0; 
		alpha_pic.set_camera_lookat( 0.0, 0.0, 0.0 ); 
		alpha_pic.set_camera_xyz( 0.0, 0.0, -900.0 );
		txr1.set_alpha_file( "trans_circle.bmp" ); #load an image into the alpha channel
	until resp(6, m_responses) || resp(1, responses1) || resp(2, responses2)
	begin
		new_x = new_x + (i/10.0);
		alpha_pic.set_3dpart_xyz(1, new_x, new_y, 0.0);
		alpha_pic.present(); 
		index = index + speed;
		new_x = (sin(index))*80.0;
		new_y = -130.0 - (cos(index))*80.0;		
	end;
	if resp(6, m_responses)
		then return true;
	end;
	return false;
end;

sub bool stereo_disp
begin
	int m_responses = response_manager.total_response_count(6);
	stereo_pic.set_camera_lookat( 0.0, 0.0, 0.0 ); 
	stereo_pic.set_camera_xyz( 0.0, 0.0, -900.0 );
	stereo_pic.set_part(4, stereo_disp);
	stereo_pic.set_3dpart(1, cube2);
	loop double xr = 0.0;
		double yr = 45.0;
		double zr = 45.0;
		int responses1 = response_manager.total_response_count(1);
		int responses2 = response_manager.total_response_count(2);
	until resp(6, m_responses) || resp(1, responses1) || resp(2, responses2)
	begin
		stereo_pic.set_3dpart_rot(1, xr, yr, zr);
		stereo_pic.present();
		xr = xr - 0.5;
		yr = yr + 1.0;
		zr = zr + 0.5;
	end;
	if resp(6, m_responses)
		then return true;
	end;
	return false;
end;

sub bool primitives_main
begin
	int m_responses = response_manager.total_response_count(6);
	fullscreen_pic.set_part(1, primitivestext);
	fullscreen_trial.present();
	if resp(6, m_responses)
		then return true;
	end;
	camera_control(true);
	if resp(6, m_responses)
		then return true;
	end;
	return false;
end;

sub bool models
begin
	int m_responses = response_manager.total_response_count(6);
	stereo_pic.set_camera_lookat( 0.0, 0.0, 0.0 ); 
	stereo_pic.set_camera_xyz( 0.0, 0.0, -900.0 );
	stereo_pic.set_part(4, model_3dtext);
	stereo_pic.set_3dpart(1, mesh_ship);
	loop double xr = 0.0;
		double yr = 45.0;
		double zr = 45.0;
		int responses1 = response_manager.total_response_count(1);
		int responses2 = response_manager.total_response_count(2);
	until resp(6, m_responses) || resp(1, responses1) || resp(2, responses2)
	begin
		stereo_pic.set_3dpart_rot(1, xr, yr, zr);
		stereo_pic.present();
		xr = xr - 0.5;
		yr = yr + 1.0;
		zr = zr + 0.5;
	end;
	if resp(6, m_responses)
		then return true;
	end;
	return false;
end;

sub bool control_main
begin
	int m_responses = response_manager.total_response_count(6);
	fullscreen_pic.set_part(1, cameratext);
	fullscreen_trial.present();
	if resp(6, m_responses)
		then return true;
	end;
	camera_control(false);
	if resp(6, m_responses)
		then return true;
	end;
	return false;
end;

sub bool lights
begin
	int m_responses = response_manager.total_response_count(6);
	light_pic.set_camera_lookat( 0.0, 0.0, 0.0 ); 
	light_pic.set_camera_xyz( 0.0, 0.0, -900.0 );
	loop double xp1 = 0.0;
		double yp1 = 0.0;
		double zp1 = -300.0;
		double xp2 = -400.0;
		double yp2 = -400.0;
		double zp2 = 0.0;
		double xr = 0.0;
		double yr = 45.0;
		double zr = 45.0;	
		double j = 1.0;
		int responses1 = response_manager.total_response_count(1);
		int responses2 = response_manager.total_response_count(2);
	until resp(6, m_responses) || resp(1, responses1) || resp(2, responses2)
	begin
		light1.set_position( xp1, yp1, zp1);
		light2.set_position( xp2, yp2, zp2);
		light_pic.set_3dpart_rot(1, xr, yr, zr);
		light_pic.set_3dpart_xyz(2, xp1, yp1, zp1);
		light_pic.set_3dpart_xyz(3, xp2, yp2, zp2);
		light_pic.present();
		xr = xr - 0.1;
		yr = yr + 0.1;
		zr = zr + 0.1;
		xp1 = sin(j*0.01)*200.0;
		#keep the light in one y position -- don't change y
		#yp1 = cos(j*0.01)*100.0 - 150.0;
		zp1 = cos(j*0.01)*100.0;
		xp2 = cos(j*0.01)*200.0; 
		#keep the light in one y position -- don't change y
		#yp2 = sin(j*0.01)*230.0 - 150.0; 
		zp2 = cos(j*0.01)*100.0;
		j = j + 1.0;
	end;
	if resp(6, m_responses)
		then return true;
	end;
	return false;
end;

#main 3d picture parts subroutine
sub bool visual_stims3d
	begin
   display_device.set_field_of_view( 45.0 );	
	if warning() then return true end;
	if transparent() then return true end;
	if stereo_disp() then return true end;
	if primitives_main() then return true end;
	if models() then return true end;
	if control_main() then return true end;
	if lights() then return true end;
	return false;
end;

###Auditory Stimuli

sub bool wavefiles 
begin
	int m_responses = response_manager.total_response_count(6);
	basic_pic.set_part(4, wavestext);
	basic_pic.set_part(8, wavestext2);
	basic_pic.present();
	loop int space_responses = response_manager.total_response_count(5);
		int responses1 = response_manager.total_response_count(1);
		int responses2 = response_manager.total_response_count(2);
		int i = 1
	until resp(6, m_responses) || resp(1, responses1) || resp(2, responses2)
	begin
		if resp(5, space_responses) then
			int index = mod(i, wavesounds.count()) + 1;
			space_responses = response_manager.total_response_count(5);
			wavesounds[index].present();
			i = i + 1
		end;
	end;
	if resp(6, m_responses) then 
		return true
	end;
	return false;
end;

sub bool atten
begin
	int responses1 = response_manager.total_response_count(1);
	int responses2 = response_manager.total_response_count(2);
	int m_responses = response_manager.total_response_count(6);
	basic_pic.set_part(4, attentext);
	basic_pic.set_part(8, attentext2);
	loop int i = 0
	until resp(6, m_responses) || resp(1, responses1) || resp(2, responses2)
	begin
		int index = mod(i,atten_sounds.count()) + 1;
		atten_sounds[index].present();
		attentext2.set_caption("Attenuation parameter = " + atten_sounds[index].description() + "\nAttenuation Value = " + string(double(atten_sounds[index].description()) * 100.0) + "dB") ;
		attentext2.redraw();
		basic_pic.present();
		wait(750);
		i = i + 1;
	end;
	if resp(6, m_responses) then 
		return true
	end;
	return false;
end;

sub bool multichannel
begin
	int responses1 = response_manager.total_response_count(1);
	int responses2 = response_manager.total_response_count(2);
	int m_responses = response_manager.total_response_count(6);
	audio_space.run( "channel1 = 0.5 * sin( 600, 0, 250, 0 )" );
	audio_space.run( "wave1 = (channel1)" );
	audio_space.get_wave_data( "wave1", multichan );
	basic_pic.set_part(4, multi_chantext);
	basic_pic.set_part(8, multi_chantext2);
	loop double i = -1.0
	until resp(6, m_responses) || resp(1, responses1) || resp(2, responses2)
	begin
		if i > -0.1 && i < 0.1 then
			multi_chantext2.set_caption("Both Sides Equal")
		elseif i < -0.1 then 
			multi_chantext2.set_caption("Right speaker attenuated")
		elseif i > 0.1 then
			multi_chantext2.set_caption("Left speaker attenuated")
		end;
		multi_chantext2.redraw();
		multisnd.set_pan(i);
		basic_pic.present();
		multisnd.present();
		wait(400);
		i = i + 0.2;
		if i > 1.0 then
			i = -1.0
		end
	end;
	if resp(6, m_responses) then 
		return true
	end;
	return false;
end;

sub bool windows_sound
begin
	int m_responses = response_manager.total_response_count(6);
	basic_pic.set_part(4, windowssoundtext);
	basic_pic.set_part(8, windowssound);
	basic_trial.present();
	if resp(6, m_responses) then 
		return true
	end;
	return false;
end;

sub bool latency
begin
	int m_responses = response_manager.total_response_count(6);
	basic_pic.set_part(4, latencytext);
	basic_pic.set_part(8, latency);
	basic_trial.present();
	if resp(6, m_responses) then 
		return true
	end;
	return false;
end;

sub bool auditory
begin
	if wavefiles() then return true end;
	if atten() then return true end;
	if multichannel() then return true end;
	if windows_sound() then return true end;
	if latency() then return true end;
	return false;
end;

#####Response devices

###Button devices

#setup interactive button trial slides
sub bool circle_trial (int button1, int button2, int endbutton1, int endbutton2, int menubutton)
begin
	loop int i = 1 until i > 12
	begin
		response_manager.set_button_active(i, false);
		i = i + 1;
	end;
	response_manager.set_button_active(button1, true);
	response_manager.set_button_active(button2, true);
	response_manager.set_button_active(endbutton1, true);
	response_manager.set_button_active(endbutton2, true);
	response_manager.set_button_active(menubutton, true);
	timetext.set_caption(" ");
	timetext.redraw();
	speedtext.set_caption(" ");
	speedtext.redraw();
	pressed.set_caption(" ");
	pressed.redraw();
	loop int i = 1; 
		int responses = response_manager.total_response_count();
		int end_response1 = response_manager.total_response_count( endbutton1 );
		int end_response2 = response_manager.total_response_count( endbutton2 );
		int menu_response = response_manager.total_response_count( menubutton );
		double inc_speed = 0.02; 
		double new_x = 0.0; 
		double new_y = -130.0;
		double index = 0.0; 
		int start_time = clock.time();
	until resp(endbutton1, end_response1) || resp( endbutton2, end_response2)
	begin
		if resp(menubutton, menu_response)
		then 
			loop int j = 1 until j > 12
			begin
				response_manager.set_button_active(j, true);
				j = j + 1;
			end;
			return true;
		end;
		if response_manager.total_response_count() > responses
			then response = response_manager.last_response();
			responses = response_manager.total_response_count();
			string name = response_manager.button_name(response, true, true);
			pressed.set_caption("button = " + name);
			pressed.redraw();
			int current_time = clock.time() - start_time;
			timetext.set_caption("time = " + string(current_time) + " ms");
			timetext.redraw();
			if response == button1 
				then inc_speed = inc_speed + 0.005;
				speedtext.set_caption("accelerate\ncounter-clockwise");
				speedtext.redraw();
			elseif response == button2
				then inc_speed = inc_speed - 0.005;
				speedtext.set_caption("accelerate\nclockwise");
				speedtext.redraw();
			end;
		end;  
		index = index + inc_speed;
		new_x = (sin(index))*140.0;
		new_y = -140.0 - (cos(index))*140.0;
		button_pic.set_part_x(9, new_x);
		button_pic.set_part_y(9, new_y);
		button_pic.present();		
		i = i + 1;
	end;
	loop int i = 1 until i > 12
	begin
		response_manager.set_button_active(i, true);
		i = i + 1;
	end;
	return false;
end;

sub bool button_response
begin 
	int m_responses = response_manager.total_response_count(6);
	button_pic.set_part(4, fstext);
	button_pic.set_part(7, continue1);
	button_pic.set_part(13, fsinstruct);
	circle_trial(3,4,1,2,6);
	if resp(6, m_responses) then 
		return true
	end;
	return false;
end;

sub bool mouse_buttons
begin 
	int m_responses = response_manager.total_response_count(6);
	button_pic.set_part(4,mouse_buttontext);
	button_pic.set_part(7, buttonpress_continue);
	button_pic.set_part(13, mouse_buttoninstruct);
	circle_trial(1,2,5,5,6);
	if resp(6, m_responses) then 
		return true
	end;
	return false;
end;

sub bool key_input
begin
	loop int i = 1; 
		string input = system_keyboard.get_input(keyboard_input_pic, inputtext); 
		string total_in; 
		inputtext.set_caption(" "); 
		inputtext.redraw(); 
		wrongtext.set_caption(" "); 
		wrongtext.redraw();
	until input == "continue"
	begin		
		wrongtext.set_caption("You must type 'continue'.");
		wrongtext.redraw();
		input = system_keyboard.get_input(keyboard_input_pic, inputtext)
	end;
	wrongtext.set_caption(" ");
	wrongtext.redraw();
	return false;
end;

sub bool game_dev
begin 
	int m_responses = response_manager.total_response_count(6);
	basic_pic.set_part(4, game_devtext);
	basic_pic.set_part(8, game_dev1);
	basic_pic.add_part(game_dev2, -200, -130);
	basic_pic.add_part(game_dev3, 200, -130);
	basic_trial.present();
	basic_pic.remove_part(9);
	basic_pic.remove_part(9);
	if resp(6, m_responses) then 
		return true
	end;
	return false;
end;

sub bool serial_response
begin
	int m_responses = response_manager.total_response_count(6);
	basic_pic.set_part(4, serialresponsetext);
	basic_pic.set_part(8, bottomdummy);
	basic_pic.add_part(idsettings, -150, -130);
	basic_pic.add_part(idparams, 200, -130);
	basic_trial.present();
	loop until basic_pic.part_count() == 8
	begin
		basic_pic.remove_part(basic_pic.part_count());
	end;
	if resp(6, m_responses) then 
		return true
	end;
	return false;
end;

sub bool sound_resp
begin
	int m_responses = response_manager.total_response_count(6);
	basic_pic.set_part(4, sound_resptext);
	basic_pic.set_part(8, soundtest);
	basic_trial.present();
	if resp(6, m_responses) then 
		return true
	end;
	return false;
end;

sub bool button_devices 
begin
	if button_response() then return true end;
	if mouse_buttons() then return true end;
	if key_input() then return true end;
	if game_dev() then return true end;
	if serial_response() then return true end;
	if sound_resp() then return true end;
	return false;
end;

###Axis devices

sub bool mouse_coord
begin
	int m_responses = response_manager.total_response_count(6);
	int responses1 = response_manager.total_response_count(1);
	int responses2 = response_manager.total_response_count(2);
	loop
		int x1;
		int y1;
	until resp(6, m_responses) || resp(1, responses1) || resp(2, responses2)
	begin
		if resp(6, m_responses) then 
			return true
		end;
		mse.set_min_max( 1, min_x, max_x );
		mse.set_min_max( 2, bottom_min_y, bottom_max_y ); 
		mse.set_restricted( 1, true );
		mse.set_restricted( 2, true );
		mse.poll();
		x1 = mse.x();	
		y1 = mse.y();
		###display cursor at coordinates
		mouse_pic.set_part_x( 11, x1 );
		mouse_pic.set_part_y( 11, y1 ); 
		coordtextx.set_caption("x = " + string(x1));
		coordtexty.set_caption( "y = " + string(y1));
		coordtextx.redraw();
		coordtexty.redraw();
		mouse_pic.present();
	end;
	if resp(6, m_responses) then 
		return true
	end;
	return false;
end;

sub bool axis_dev
begin
	int m_responses = response_manager.total_response_count(6);
	basic_pic.set_part(4, axistext);
	basic_pic.set_part(8, axis_dev1);
	basic_pic.add_part(axis_dev2, -200, -130);
	basic_pic.add_part(axis_dev3, 200, -130);
	basic_trial.present();
	basic_pic.remove_part(9);
	basic_pic.remove_part(9);
	if resp(6, m_responses) then 
		return true
	end;
	return false;
end;

sub bool touchscreen
begin
	int m_responses = response_manager.total_response_count(6);
	basic_pic.set_part(4, touchscreentext);
	basic_pic.set_part(8, touchscreen);
	basic_trial.present();
	if resp(6, m_responses) then 
		return true
	end;
	return false;
end;

sub bool forcefeedback
begin
	int m_responses = response_manager.total_response_count(6);
	basic_pic.set_part(4, forcefeedbacktext);
	basic_pic.set_part(8, forcefeedback);
	basic_trial.present();
	if resp(6, m_responses) then 
		return true
	end;
	return false;
end;

sub bool axis_devices
begin
	if mouse_coord() then return true end;
	if axis_dev() then return true end;
	if touchscreen() then return true end;
	if forcefeedback() then return true end;
	return false;
end;

#####Hardware interfacing

sub bool port_input
begin
	int m_responses = response_manager.total_response_count(6);
	basic_pic.set_part(4, portinputtext);
	basic_pic.set_part(8, portinput);
	basic_trial.present();
	if resp(6, m_responses) then 
		return true
	end;
	return false;
end;

sub bool port_output
begin
	int m_responses = response_manager.total_response_count(6);
	basic_pic.set_part(4, portoutputtext);
	basic_pic.set_part(8, portoutput);
	basic_trial.present();
	if resp(6, m_responses) then 
		return true
	end;
	return false;
end;

sub bool fmri
begin
	int m_responses = response_manager.total_response_count(6);
	loop
		int responses1 = response_manager.total_response_count(1);
		int responses2 = response_manager.total_response_count(2);
	until resp(6, m_responses) || resp(1, responses1) || resp(2, responses2)
	begin
		#reset caption in case fmri has been run before
		pulsetext.set_caption(" ");
		pulsetext.redraw();
		basic_pic.add_part(pulsetext, 300, -130);
		int start_pulse = pulse_manager.main_pulse_count();
		basic_pic.set_part(4, fmritext);
		basic_pic.set_part(8, fmri_wait);
		basic_pic.present();
		pulsetext.set_caption("Pulse Number 1");
		pulsetext.redraw();
		basic_pic.set_part_x(8, -15);
		loop until pulse_manager.main_pulse_count() > start_pulse || resp(6, m_responses) || resp(1, responses1) || resp(2, responses2)
		begin
		end;
		loop int pulse_count = pulse_manager.main_pulse_count();
			int i = 1;
			int j = 1;
		until resp(6, m_responses) || resp(1, responses1) || resp(2, responses2)
		begin
			if pulse_manager.main_pulse_count() > pulse_count then
				pulse_count = pulse_count + 1;
				i = i + 1;
				pulsetext.set_caption("Pulse Number " + string(i));
				pulsetext.redraw();	
			end;
			wait(100);		
			if mod (j,2) == 0 then 	
				int index = mod(i + 1, fmrionpics.count()) + 1;
				basic_pic.set_part(8, fmrionpics[index]);		
			else
				int index = mod(i + 1, fmrioffpics.count()) + 1;
				basic_pic.set_part(8, fmrioffpics[index]);
			end;
			basic_pic.present();
			j = j + 1;
		end;
	end;
	basic_pic.set_part_x(8, 0);
	basic_pic.remove_part(9);
	if resp(6, m_responses) then 
		return true
	end;
	return false;
end;

sub bool hardware
begin
	if port_input() then return true end;
	if port_output() then return true end;
	if fmri() then return true end;
	return false;
end;

#####Programmability
#begin randomization set up pcl

# randomize stimulus presentation
sub array<int, 2> rand_stim
begin
	int min_items = 5;
	int max_items = 15;
	int repeats = 1; 
	array<int> stimuli[(max_items - min_items + 1) * repeats * 2][2];
	loop
		int i = min_items;
		int j = 1
	until
		j > stimuli.count()
	begin             
		loop
			int k = 1
		until
			k > repeats
		begin
			stimuli[j][1] = i;
			stimuli[j][2] = 0;
			stimuli[j + 1][1] = i;
			stimuli[j + 1][2] = 1;
			j = j + 2;
			k = k + 1
		end;
		i = i + 1
	end;
	stimuli.shuffle();
	return stimuli
end;
# construct the stimulus
sub
   make_stim( int item_count, bool has_target )
begin  
	int buffer_space = 10;
	int item_height = 10;
	int item_width = 10; 
	array<int> grid_squares[20] = 
	 { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20 }; 
	array<int> coordsx[20][2];
	array<int> coordsy[20][2];
	int square_width = display_device.width() / 5;
	int square_height = display_device.height() / 4;
	int base_x1 = -display_device.width() / 2 + buffer_space + item_width / 2;
	int base_x2 = -display_device.width() / 2 + square_width - buffer_space - item_width / 2;
	int base_y1 = -display_device.height() / 2 + buffer_space + item_height / 2 + 50;
	int base_y2 = -display_device.height() / 2 + square_height - buffer_space - item_height / 2 +50;
	# calculate allowable coordinates 
	loop
		int i = 1
	until
		i > coordsx.count()
	begin
		loop
			int j = 1
		until
			j > 5
		begin 
			coordsx[i][1] = base_x1 + (j - 1)  * square_width;
			coordsx[i][2] = base_x2 + (j - 1) * square_width;
			coordsy[i][1] = base_y1 + ((i - 1) / 10) * square_height;
			coordsy[i][2] = base_y2 + ((i - 1) / 10) * square_height;
			j = j + 1;
			i = i + 1
		end
	end;           
   grid_squares.shuffle(); 
   random_pic.clear(); 
   random_pic.add_part( bottom_box, 0, -130 );
   random_pic.add_part( top_box, 0, 300 );   
   random_pic.add_part( line, 0, 100 );
   random_pic.add_part( randomtext, 0, 250 );
   random_pic.add_part( continue_box, 0 , -364);
	random_pic.add_part( line, 0, -344);
   random_pic.add_part( continue1, 0, -364 );
   string code;  
   int i = 1;           
   int square = grid_squares[i];
   if (has_target) then
      random_pic.add_part( target, random( coordsx[square][1], 
                                     coordsx[square][2] ),
                             random( coordsy[square][1], 
                                     coordsy[square][2] ) );   
      i = i + 1;
   else
   end;                 
   loop until i > item_count begin  
      square = grid_squares[i];    
      random_pic.add_part( boxes[i], random( coordsx[square][1], 
                                     coordsx[square][2] ),
                             random( coordsy[square][1], 
                                     coordsy[square][2] ) );
      if (random() < 0.5) then
         boxes[i].set_width( 6 );
         boxes[i].set_height( 18 )
      else
         boxes[i].set_width( 18 );
         boxes[i].set_height( 6 )
      end;
      i = i + 1 
   end;
end;
#end randomization setup pcl

#begin adaptive setup pcl
int up = 1;
int down = -1;
int increment_value =10;
int surround_value = 128;
int center_value1 = random( surround_value + 1, 200);  # default color of center  
int center_value2 = random( 55, surround_value - 1);
bool last_correct1 = false;
bool last_correct2 = false;  
#--------- show1 ---------------
sub 
   show1
begin
	int m_responses = response_manager.total_response_count(6);
	int space_responses = response_manager.total_response_count(5);
   int which_button = random(1,2);  # decide which button
   center_surround_event.set_target_button( which_button );
   if (which_button == 1) then  # left stimulus is target
      center_left.set_color(center_value1, center_value1,center_value1);
      center_right.set_color(surround_value, surround_value, surround_value);                   
   else                         # right stimulus is target
      center_right.set_color(center_value1, center_value1,center_value1);
      center_left.set_color(surround_value, surround_value, surround_value);
   end; # which_button  
   center_surround_event.set_event_code( "show1: " + string(center_value1) );
   trial1.present();  
   last_correct1 = response_manager.hits() == 1;
   if resp(6, m_responses) || resp(5, space_responses) 
	then
	else
		if (last_correct1) then correct.present() 
		else wrong.present() end;
	end;
end;  # show1()

#--------- correct1 ---------------
sub 
   bool correct1 
begin    
   return last_correct1     
end;  # corect1()

#--------- raise1 ---------------
sub 
   raise1
begin
   center_value1 = center_value1 - increment_value;
   if (center_value1 < surround_value) then
      center_value1 = surround_value;
      end;
end;

#--------- lower1 ---------------
sub 
   lower1
begin
   center_value1 = center_value1 + increment_value;
   if (center_value1 > 252) then
      center_value1 = 252;
      end;
end;                                                
#--------- show2 ---------------
sub 
   show2
begin
	int m_responses = response_manager.total_response_count(6);
	int space_responses = response_manager.total_response_count(5);
   int which_button = random(1,2);  # decide which button
   center_surround_event.set_target_button( which_button );
   if (which_button == 1) then  # left stimulus is target
      center_left.set_color(center_value2, center_value2,center_value2);
      center_right.set_color(surround_value, surround_value, surround_value);                   
   else                         # right stimulus is target
      center_right.set_color(center_value2, center_value2,center_value2);
      center_left.set_color(surround_value, surround_value, surround_value);
   end; # which_button  
   center_surround_event.set_event_code( "show2: " + string(center_value2) );
   trial1.present();  
   last_correct2 = response_manager.hits() == 1;
   if resp(6, m_responses) || resp(5, space_responses) 
	then
	else
		if (last_correct2) then correct.present() 
		else wrong.present() end;
	end;
end;  # show1()

#--------- correct2 ---------------
sub 
   bool correct2 
begin    
   return last_correct2     
end;  # correct1()

#--------- raise2 ---------------
sub 
   raise2
begin
   center_value2 = center_value2 + increment_value;
   if (center_value2 > surround_value) then
      center_value2 = surround_value;
      end;
end;

#--------- lower2 ---------------
sub 
   lower2
begin
   center_value2 = center_value2 - increment_value;
   if (center_value2 < 0) then
      center_value2 = 0;
   end;
end;
#--------- double_staircase ---------------
sub
   double_staircase( 
      int lower_count1,
      int raise_count1,
      int reverses1,
      int lower_count2,
      int raise_count2,
      int reverses2
   )
begin
   loop
      bool done1 = false; 
      bool done2 = false;
      int correct_count1 = 0;
      int correct_count2 = 0;
      int incorrect_count1 = 0;
      int incorrect_count2 = 0;
      int direction1 = 0;
      int direction2 = 0;
      int reverse_count1 = 0;
      int reverse_count2 = 0;
      int m_responses = response_manager.total_response_count(6);
		int space_responses = response_manager.total_response_count(5);
   until 
      (done1 && done2) || resp(6, m_responses) || resp(5, space_responses) 
   begin
      if !done1 then
			if resp(6, m_responses) || resp(5, space_responses) then
				break;
			end;
         show1();
         if resp(6, m_responses) || resp(5, space_responses) then
				break;
			end;
         if (correct1()) then 
            correct_count1 = correct_count1 + 1;  
            if (correct_count1 == raise_count1) then  
               raise1();
               correct_count1 = 0;
               incorrect_count1 = 0;
               if (direction1 == down) then  
                  reverse_count1 = reverse_count1 + 1;
                  if (reverse_count1 == reverses1) then
                     done1 = true
                  end
               end;
               direction1 = up;   
            end;
         else
            incorrect_count1 = incorrect_count1 + 1;
            if (incorrect_count1 == lower_count1) then
               lower1();
               incorrect_count1 = 0;
               correct_count1 = 0;
               if (direction1 == up) then
                  reverse_count1 = reverse_count1 + 1;
                  if (reverse_count1 == reverses1) then
                     done1 = true
                  end
               end;
               direction1 = down;
            end
         end
      end;
      if !done2 then
			if resp(6, m_responses) || resp(5, space_responses) then
				break;
			end;
         show2();
         if resp(6, m_responses) || resp(5, space_responses) then
				break;
			end;
         if (correct2()) then 
            correct_count2 = correct_count2 + 1;  
            if (correct_count2 == raise_count2) then  
               raise2();
               correct_count2 = 0;
               incorrect_count2 = 0;
               if (direction2 == down) then  
                  reverse_count2 = reverse_count2 + 1;
                  if (reverse_count2 == reverses2) then
                     done2 = true
                  end
               end;
               direction2 = up;   
            end;
         else
            incorrect_count2 = incorrect_count2 + 1;
            if (incorrect_count2 == lower_count2) then
               lower2();
               incorrect_count2 = 0;
               correct_count2 = 0;
               if (direction2 == up) then
                  reverse_count2 = reverse_count2 + 1;
                  if (reverse_count2 == reverses2) then
                     done2 = true
                  end
               end;
               direction2 = down;
            end
         end
      end
   end 
end;  
#end adaptive setup

sub bool program_slide
begin
	int m_responses = response_manager.total_response_count(6);
	basic_pic.set_part(4, programmabilitytext);
	basic_pic.set_part(8, programmability);
	basic_trial.present();
		if resp(6, m_responses) then 
		return true
	end;
	return false;
end;

sub bool randomization_main
begin
	int m_responses = response_manager.total_response_count(6);
	random_pic.present();
	loop int last_time = clock.time() - 1000;
		int i = 1;
		int responses1 = response_manager.total_response_count(1);
		int responses2 = response_manager.total_response_count(2);
	until resp(6, m_responses) || resp(1, responses1) || resp(2, responses2)
	begin
		if clock.time() > last_time + 1000
		then
			array<int>stimuli[0][2];
			stimuli.resize(rand_stim().count());
			stimuli = rand_stim();
			int index = mod (i,stimuli.count()) + 1;
			make_stim( stimuli[index][1], bool( stimuli[index][2] ) );
			random_pic.present();
			i = i + 1;
			last_time = clock.time();
		end;
	end;
	if resp(6, m_responses) then
		return true
	end;
	return false
end;

sub bool feedback_main
begin
	int m_responses = response_manager.total_response_count(6);
	int responses1 = response_manager.total_response_count(1);
	int responses2 = response_manager.total_response_count(2);
	feedback_pic.set_part(4, catstim_resptext); 
	loop 
	until resp(6, m_responses) || resp(1, responses1) || resp(2, responses2)
	begin
		int left = random (1, letters.count());
		int right;
		bool same = bool(random (0, 1));
		if same then
			right = left;
			stim_res_event.set_target_button( 4 );
			stim_res_event.set_response_active( true )
		else
			right = random (1, letters.count());
			loop until right != left
			begin
				right = random (1, letters.count());
			end;
			stim_res_event.set_target_button( 8 );
			stim_res_event.set_response_active( true )
		end;
		stim_res_event.set_event_code(string(left) + "," + string(right));
		stim_res_pic.set_part(8, letters[left]);
		stim_res_pic.set_part(9, letters[right]);
		stim_res_trial.present();
		if resp(6, m_responses) then
			return true
		end;		
		if resp(1, responses1) || resp(2, responses2) then 
		else
			int type = stimulus_manager.last_stimulus_data().type();
			if (type == stimulus_hit) then
				feedback_pic.set_part( 8, good );
				feedback_trial.present()
			elseif (type == stimulus_miss) then
				feedback_pic.set_part( 8, tooslow );
				feedback_trial.present()
			elseif (type == stimulus_incorrect) then
				feedback_pic.set_part( 8, incorrect );
				feedback_trial.present()
			end;	
		end;
		if resp(6, m_responses) then return true 
		end;
	end;
	if resp(6, m_responses) then
		return true
	end;
	return false
end;

sub bool adaptive_main
begin 
	int m_responses = response_manager.total_response_count(6);
	loop 
		int space_responses = response_manager.total_response_count(5);
	until resp(6, m_responses) || resp(5, space_responses)
	begin
	double_staircase(1,2,2,1,2,2);
	end;
	if resp(6, m_responses) then
		return true
	end;
	return false
end;
	
sub bool analyzer
begin 
	int m_responses = response_manager.total_response_count(6);
	basic_pic.set_part(4, analyzertext);
	basic_pic.set_part(8, analyzer);
	basic_trial.present();
	if resp(6, m_responses) then
		return true
	end;
	return false
end;	

sub bool matlab
begin 
	int m_responses = response_manager.total_response_count(6);
	basic_pic.set_part(4, matlabtext);
	basic_pic.set_part(8, matlab);
	basic_pic.set_part_x(8, -175);
	basic_pic.add_part(matlab_logo, 175, -130);
	basic_trial.present();
	basic_pic.remove_part(basic_pic.part_count());
	basic_pic.set_part_x(8, 0);
	if resp(6, m_responses) then
		return true
	end;
	return false
end;	

sub bool programmability
begin
	if program_slide() then return true end;
	if randomization_main() then return true end;
	if feedback_main() then return true end;
	if adaptive_main() then return true end;
	if analyzer() then return true end;
	if matlab() then return true end;
	return false;
end;
	
#####Timing

sub bool logfiles
begin 
	int m_responses = response_manager.total_response_count(6);
	basic_pic.set_part(4, logfilestext);
	basic_pic.set_part(8, logfiles);
	basic_trial.present();
	if resp(6, m_responses) then
		return true
	end;
	return false
end;	

sub bool uncertainty
begin 
	int m_responses = response_manager.total_response_count(6);
	basic_pic.set_part(4, uncertaintytext);
	basic_pic.set_part(8, uncertainty);
	basic_trial.present();
	if resp(6, m_responses) then
		return true
	end;
	return false
end;	

sub bool timing
begin
	if logfiles() then return true end;
	if uncertainty() then return true end;
	return false
end;

########Demos PCL

#begin Stroop PCL

sub string run_block (int block_type, int num_trials)
	begin
	int m_responses = response_manager.total_response_count(6);
	stroop_intro_pic.set_part(1, introtext[block_type]);
	stroop_intro_trial.present();
	int plain_word = 1;
	int color_box = 2;
	int color_word = 3;
	int stroop_word = 4;
	array<string>color_list[6] = {"red", "orange", "yellow", "green", "blue", "purple"};
	array<stimulus_data>data[num_trials];
	int correct_count = 0;
	int total_rt = 0;
	loop int i = 1; 
	until i > num_trials || resp(6, m_responses) 
	begin
		colors.shuffle();
		bool correct_left = bool(random(0,1));
		if block_type == plain_word then
			instruct.set_caption("Choose which word matches the central word");
			instruct.redraw();
			no_color.set_caption(colors[1].description());
			no_color.redraw();
			stroop_main_pic.set_part(1, no_color);
		elseif block_type == color_box then
			instruct.set_caption("Choose which word matches the color of the box");
			instruct.redraw();
			int index = 0;
			loop int j = 1 until j > color_list.count() || index >= 1
			begin
				if colors[1].description() == color_list[j] then
					index = j
				end;
				j = j + 1;
			end;
			stroop_main_pic.set_part(1, stroop_boxes[index])
		elseif block_type == stroop_word then
			instruct.set_caption("Choose which word matches the color of the word");
			instruct.redraw();
			colors[1].set_caption(colors[2].description());
			colors[1].redraw();
			stroop_main_pic.set_part(1, colors[1]);
		elseif block_type == color_word then
			instruct.set_caption("Choose which word matches the color of the word and the word");
			instruct.redraw();
			colors[1].set_caption(colors[1].description());
			colors[1].redraw();
			stroop_main_pic.set_part(1, colors[1]);
		end;
		if correct_left then
			left_choice.set_caption(colors[1].description());
			right_choice.set_caption(colors[2].description());
			stroop_main_event.set_target_button(1);
		else
			left_choice.set_caption(colors[2].description());
			right_choice.set_caption(colors[1].description());
			stroop_main_event.set_target_button(2);
		end;
		left_choice.redraw();
		right_choice.redraw();	
		stroop_main_trial.present();
		if resp(6, m_responses) then
			break;
		end;	
		stimulus_data last = stimulus_manager.last_stimulus_data();
		if last.type() == stimulus_hit then
			correct_count = correct_count + 1;
		end;
		total_rt = total_rt + last.reaction_time();		
		i = i + 1;
	end;
	string cap;
	if resp(6, m_responses)  then
	else		
		cap = cap + "\naverage reaction_time: " + string( total_rt/num_trials ) + "ms";
		cap = cap + "\ncorrect: " + string(correct_count) + " out of " + string(num_trials) + "\n" ;
		results.set_caption(cap);
		results.redraw();
		stroop_results_trial.present();
	end;
	return cap
end;

sub bool stroop
begin
	int m_responses = response_manager.total_response_count(6);
	int num_trials = 0;
	int num_blocks = 4;
	loop string input_string	
	until num_trials > 0 && num_trials <= 20 || input_string == "m"
	begin
		input_string = system_keyboard.get_input(stroop_input_pic, stroop_input);
		num_trials = int(input_string);
	end;
	if resp(6, m_responses)  then
		return true
	end;
	array<string>caps[num_blocks];
	loop int i = 1 
	until i > num_blocks
	begin
		caps[i] = run_block(i, num_trials);
		i = i + 1;
		if resp(6, m_responses)  then
			return true
		end;
	end;
	string cap = "Plain word results:";
	cap = cap + caps[1];
	results.set_caption(cap);
	results.redraw();
	stroop_results_trial.present();
	cap = "Color box results:";
	cap = cap + caps[2];
	results.set_caption(cap);
	results.redraw();
	stroop_results_trial.present();
	cap = "Color word results:";
	cap = cap + caps[3];
	results.set_caption(cap);
	results.redraw();
	stroop_results_trial.present();
	if resp(6, m_responses)  then
		return true
	end;
	cap = "Stroop word results:";
	cap = cap + caps[4];
	results.set_caption(cap);
	results.redraw();
	stroop_results_trial.present();
	if resp(6, m_responses)  then
		return true
	end;
	return false;
end;
#visual search PCL
sub array<int, 2> vis_rand_stim
begin 
	int vis_min_items = 5;
	int vis_max_items = 15;
	int vis_repeats = 1; 
	# randomize stimulus presentation
	array<int> vis_stimuli[(vis_max_items - vis_min_items + 1) * vis_repeats * 2][2];
	loop
		int i = vis_min_items;
		int j = 1
	until
		j > vis_stimuli.count()
	begin             
		loop
			int k = 1
		until
			k > vis_repeats
		begin
			vis_stimuli[j][1] = i;
			vis_stimuli[j][2] = 0;
			vis_stimuli[j + 1][1] = i;
			vis_stimuli[j + 1][2] = 1;
			j = j + 2;
			k = k + 1
		end;
		i = i + 1
	end;
	vis_stimuli.shuffle();
	return vis_stimuli;
end;

sub
   vis_make_stim( int item_count, bool has_target )
begin   
	int vis_display_width = display_device.width();
	int vis_display_height = display_device.height();
	int vis_buffer_space = 40;
	int vis_item_height = 10;
	int vis_item_width = 10; 	
	array<int> vis_grid_squares[20] = 
	 { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20 };	 
	array<int> vis_coordsx[20][2];	 
	array<int> vis_coordsy[20][2];	
	int vis_square_width = vis_display_width / 5;
	int vis_square_height = vis_display_height / 4;
	int vis_base_x1 = -vis_display_width / 2 + vis_buffer_space + vis_item_width / 2;
	int vis_base_x2 = -vis_display_width / 2 + vis_square_width - vis_buffer_space - vis_item_width / 2;
	int vis_base_y1 = -vis_display_height / 2 + vis_buffer_space + vis_item_height / 2;
	int vis_base_y2 = -vis_display_height / 2 + vis_square_height - vis_buffer_space - vis_item_height / 2;	
	# calculate allowable coordinates 
	loop
		int i = 1
	until
		i > vis_coordsx.count()
	begin
		loop
			int j = 1
		until
			j > 5
		begin 
			vis_coordsx[i][1] = vis_base_x1 + (j - 1) * vis_square_width;
			vis_coordsx[i][2] = vis_base_x2 + (j - 1) * vis_square_width;
			vis_coordsy[i][1] = vis_base_y1 + ((i - 1) / 5) * vis_square_height;
			vis_coordsy[i][2] = vis_base_y2 + ((i - 1) / 5) * vis_square_height;
			j = j + 1;
			i = i + 1
		end
	end;          
   vis_grid_squares.shuffle(); 
   vis_search_pic1.clear(); 
   vis_search_pic1.add_part( vis_fix_ver, 0, 0 );
   vis_search_pic1.add_part( vis_fix_hor, 0, 0 );
   vis_search_pic1.add_part( n_back_continue, 0 , -364);
   string code;  
   int i = 1;           
   int square = vis_grid_squares[i];
   if (has_target) then
      vis_search_event1.set_target_button( 1 ); 
      vis_search_pic1.add_part( target, random( vis_coordsx[square][1], 
                                     vis_coordsx[square][2] ),
                             random( vis_coordsy[square][1], 
                                     vis_coordsy[square][2] ) );   
      i = i + 1;
      code = "target ";
   else
      vis_search_event1.set_target_button( 2 );
      code = "no target ";
   end;                 
   loop until i > item_count begin  
      square = vis_grid_squares[i];    
      vis_search_pic1.add_part( vis_search_boxes[i], random( vis_coordsx[square][1], 
                                     vis_coordsx[square][2] ),
                             random( vis_coordsy[square][1], 
                                     vis_coordsy[square][2] ) );
      if (random() < 0.5) then
         vis_search_boxes[i].set_width( 6 );
         vis_search_boxes[i].set_height( 18 )
      else
         vis_search_boxes[i].set_width( 18 );
         vis_search_boxes[i].set_height( 6 )
      end;
      i = i + 1 
   end;
   code = code + string(item_count);
   vis_search_event1.set_event_code( code );
end;


sub bool vis_search
begin
	int m_responses = response_manager.total_response_count(6);
	vis_search_message_pic.set_part(1, vis_search_text);
	vis_search_message_trial.present();
	int hits = 0;
	if resp(6, m_responses) 
		then return true;
	end;
	array<int>vis_stimuli[0][2];
	vis_stimuli.resize(vis_rand_stim().count());
	vis_stimuli = vis_rand_stim();
	# run trials
	loop
		int i = 1
	until
		i > vis_stimuli.count()
	begin
		vis_make_stim( vis_stimuli[i][1], bool( vis_stimuli[i][2] ) );
		vis_search_trial1.present();
		stimulus_data last = stimulus_manager.last_stimulus_data();
		if last.type() == stimulus_hit then
			hits = hits + 1;
		end;
		if resp(6, m_responses)  
			then return true;
		end;
		i = i + 1   
	end;
	string message = "You got " + string( hits ) +
	 " right out of " + string( vis_stimuli.count() );
	vis_search_message_pic.set_part(1, vis_search_results_text);
	vis_search_results_text.set_caption( message );
	vis_search_results_text.redraw();
	vis_search_message_trial.present();
	if resp(6, m_responses)  
		then return true;
	end;
	return false;
end;
#N-back PCL
sub
   int random_exclude( int first, int last, int exclude )
begin
   int rval = random( first, last - 1 );
   if (rval >= exclude) then
      rval = rval + 1
   end;
   return rval
end;

sub bool n_back
begin
	int m_responses = response_manager.total_response_count(6);
	int n_back = 0;
	string n_back_string;
	loop		
	until n_back > 0 && n_back <= 3 || n_back_string == "m"
	begin
		n_back_string = system_keyboard.get_input(intro_pic, n_back_input);
		n_back = int(n_back_string);
	end;
	if resp(6, m_responses)  then 
		return true
	end;
	confirm.set_caption("You have chosen a " + string(n_back) + "-Back task.\nPress the mouse button to begin,\nand the m button to return to the menu.");
	confirm.redraw();
	confirm_trial.present();
	if resp(6, m_responses)  then 
		return true
	end;
	int stimulus_count = 20;
	array<int> is_target[stimulus_count];
	loop int i = 1 until i > stimulus_count / 4 begin
		is_target[i] = 1;
		i = i + 1
	end;
	is_target.shuffle();
	if n_back == 1 then
		loop until is_target[1] == 0 begin
			is_target.shuffle()
		end;
	elseif n_back == 2 then 
		loop until is_target[1] == 0 && is_target[2] == 0 begin
			is_target.shuffle()
		end;
	elseif n_back == 3 then 
		loop until is_target[1] == 0 && is_target[2] == 0 && is_target[3] == 0 begin
			is_target.shuffle()
		end;
	end;
	array<stimulus_data>n_back_data[0];
	int num_targs = 0;
	int num_non_targs = 0;
	loop
		int i = 1;
		array<int>last_3_stims[3] = {0,0,0};
	until
		i > stimulus_count || resp(6, m_responses) 	
	begin
		int index;
		if (is_target[i] == 1) then
			index = last_3_stims[n_back];
			n_back_event1.set_target_button(1);
			n_back_event1.set_event_code(string(last_3_stims[n_back]) + "," + "target");
			num_targs = num_targs + 1;
		else
			index = random_exclude( 1, n_back_letters.count(), last_3_stims[n_back]);
			n_back_event1.set_target_button(0);
			n_back_event1.set_response_active(true);
			n_back_event1.set_event_code(string(index) + "," + "non-target");
			num_non_targs = num_non_targs + 1;
		end;
		n_back_pic.set_part( 1, n_back_letters[index] );
		if resp(6, m_responses)  then
			return true
		end;
		n_back_main_trial.present();
		n_back_data.add(stimulus_manager.last_stimulus_data());
		last_3_stims[3] = last_3_stims[2];
		last_3_stims[2] = last_3_stims[1];
		last_3_stims[1] = index;
		i = i + 1
	end;
	if resp(6, m_responses)  then
		return true
	end;
	int correct_count = 0;
	int false_alarm_count = 0;
	int miss_count = 0;
	loop int i = 1;
	until i > n_back_data.count()
	begin
		if n_back_data[i].type() == stimulus_hit then
			correct_count = correct_count + 1;
		elseif n_back_data[i].type() == stimulus_miss then
			miss_count = miss_count + 1;
		elseif n_back_data[i].type() == stimulus_false_alarm then
			false_alarm_count = false_alarm_count + 1;		
		end;
		i = i + 1;
	end;
	string cap = "N-Back Results:";
	cap = cap + "\nNumber of Targets: " + string(num_targs); 
	cap = cap + "\nHits: " + string( correct_count );
	cap = cap + "\nMisses: " + string( miss_count) ;
	cap = cap + "\nNumber of Distractors: " + string(num_non_targs);
	cap = cap + "\nCorrect Rejections: " + string( num_non_targs - false_alarm_count );
	cap = cap + "\nFalse Alarms: " + string(false_alarm_count) + "\n" ;
	confirm.set_caption(cap);
	confirm.redraw();
	confirm_trial.present();
	if resp(6, m_responses)  then
		return true
	end;
	return false;
end;

#backward masking PCL
sub bool masking
begin
	int m_responses = response_manager.total_response_count(6);
	display.set_caption("In the following trials, you will\nbe watching for the word \"ONE\".\nWhen you see ONE, press the left\nmouse button\nPress the mouse button to begin.");
	display.redraw();
	masking_display_trial.present();
	if resp(6, m_responses)  
		then return true;
	end;
	default.present();
	wait(500);
	#make 20% target trials
	int num_trials = 10;
	array<int>is_targ[num_trials];
	loop int i = 1 until i > num_trials / 5
	begin
		is_targ[i] = 1;
		i = i + 1;
	end;
	#present no mask trials
	array<stimulus_data>no_mask_data[0];
	loop int i = 1;
		is_targ.shuffle();
	until i > num_trials
	begin
		if is_targ[i] == 1 then 
			no_mask_target_event.set_target_button(1);
			no_mask_target_event.set_event_code(words[1].description());
			stim_pic.set_part(1, words[1]);	
		else
			int index = random (2, words.count());
			no_mask_target_event.set_target_button(0);
			no_mask_target_event.set_response_active(true);
			no_mask_target_event.set_event_code(words[index].description());
			stim_pic.set_part(1, words[index]);
		end;
		no_mask_trial.present();
		if resp(6, m_responses)  
			then return true;
		end;
		no_mask_data.add(stimulus_manager.last_stimulus_data());
		i = i + 1;
	end;
	display.set_caption("In the following trials, you will\nbe watching for the word \"ONE\".\nWhen you see ONE, press the left\nmouse button\nThis time, the word will be presented\nfor the same amount of time as before,\nbut followed by a mask.\nPress the mouse button to begin.");
	display.redraw();
	masking_display_trial.present();
	if resp(6, m_responses)  
		then return true;
	end;
	default.present();
	wait(500);
	array<stimulus_data>mask_data[0];
	#present mask trials
	loop int i = 1;
		is_targ.shuffle();
	until i > num_trials
	begin
		if is_targ[i] == 1 then 
			target_event.set_target_button(1);
			target_event.set_event_code(words[1].description());
			stim_pic.set_part(1, words[1]);
		else
			int index = random (2, words.count());
			target_event.set_target_button(0);
			target_event.set_response_active(true);
			target_event.set_event_code(words[index].description());
			stim_pic.set_part(1, words[index]);
		end;
		mask_trial.present();
		if resp(6, m_responses)  
			then return true;
		end;
		mask_data.add(stimulus_manager.last_stimulus_data());
		i = i + 1;
	end;
	int no_mask_correct_count = 0;
	int no_mask_false_alarm_count = 0;
	int no_mask_miss_count = 0;
	int no_mask_correct_rej = 0;
	loop int i = 1;
	until i > no_mask_data.count()
	begin
		if no_mask_data[i].type() == stimulus_hit then
			no_mask_correct_count = no_mask_correct_count + 1;
		elseif no_mask_data[i].type() == stimulus_miss then
			no_mask_miss_count = no_mask_miss_count + 1;
		elseif no_mask_data[i].type() == stimulus_false_alarm then
			no_mask_false_alarm_count = no_mask_false_alarm_count + 1;	
		else
			no_mask_correct_rej = no_mask_correct_rej + 1;
		end;
		i = i + 1;
	end;
	int mask_correct_count = 0;
	int mask_false_alarm_count = 0;
	int mask_miss_count = 0;
	int mask_correct_rej = 0;
	loop int i = 1;
	until i > mask_data.count()
	begin
		if mask_data[i].type() == stimulus_hit then
			mask_correct_count = mask_correct_count + 1;
		elseif mask_data[i].type() == stimulus_miss then
			mask_miss_count = mask_miss_count + 1;
		elseif mask_data[i].type() == stimulus_false_alarm then
			mask_false_alarm_count = mask_false_alarm_count + 1;	
		else 
			mask_correct_rej = mask_correct_rej + 1;
		end;
		i = i + 1;
	end;
	if resp(6, m_responses)  then
		return true
	end;
	string cap = "No Masking Results:";
	cap = cap + "\nHits: " + string( no_mask_correct_count );
	cap = cap + "\nMisses: " + string( no_mask_miss_count) ;
	cap = cap + "\nCorrect Rejections: " + string(no_mask_correct_rej) ;
	cap = cap + "\nFalse Alarms: " + string(no_mask_false_alarm_count) + "\n" ;
	display.set_caption(cap);
	display.redraw();
	masking_display_trial.present();
	if resp(6, m_responses)  then
		return true
	end;
	cap = "Masking Results:";
	cap = cap + "\nHits: " + string( mask_correct_count );
	cap = cap + "\nMisses: " + string( mask_miss_count) ;
	cap = cap + "\nCorrect Rejections: " + string(mask_correct_rej) ;
	cap = cap + "\nFalse Alarms: " + string(mask_false_alarm_count) + "\n" ;
	display.set_caption(cap);
	display.redraw();
	masking_display_trial.present();
	if resp(6, m_responses)  
		then return true;
	end;
	return false;
end;

#auditory threshold PCL
sub bool threshold
begin
	int m_responses = response_manager.total_response_count(6);
	#  PCL program to demonstrate the determination of auditory
	#	thresholds in the right and left ears at the five
	#	major octave frequencies: 250, 500, 1000, 2000, and
	#	4000 Hz.  Of course, precise calibration would be
	#	needed for accurate auditory-threshold measurements.
	#	Initial version computed the mean for reversal points,
	#	excluding the first two.  Because this procedure really
	#	needs more data than a demonstration version would
	#	normally take, the current demonstration version
	#	merely prints the final value of the volume parameter.
	#	An experimenter might want to modify this to do a
	#	longer set of trials, and shift back to the mean of
	#	the reversal points as the measure.  Adding and array
	#	to hold the sum of squares of the good reversals, would
	#	permit calculation of their standard deviations.
	#  This version of the demonstration program measures the values
	#	for the 10 ear-frequency conditions randomly intermixed.
	#	Arrays are used to hold the parameters for the adaptive
	#	procedures.  The array index number determines which
	#	condition is being measured in each trial.
	#
	#  First define the necessary arrays to represent the
	#	parameters for the ten ear-frequency combinations.
	#
	array<sound> stims[10];		#Defines the stimulus event.
	array<string> evcod[10];	#Defines the stimulus event code.
	array<double> xvol[10];		#The current volume level.
	array<double> ear[10];		#Define the ear (-1.0 = Left).
	array<double> dir[10];		#The current direction of adjustment.
	array<double> dstep[10];	#The current step size (starts larger).
	array<double> num_revs[10];	#The number of direction reversals.
	array<double> sum_revs[10];	#Sum of good reversals, to compute mean.
					#  First two reversals don't count.
	#  Then set the necessary parameters.
	int target_button = 1;	#Listener should press button #1 for tones.
	#
	#  Stimulus events present 250, 500, 1000, 2000, & 4000 Hz Tones.
	#	Note that "ear" parameter (pan value) determines ear tested.
	
	stims[1] = s250;
	stims[2] = s500;
	stims[3] = s1000;
	stims[4] = s2000;
	stims[5] = s4000;
	stims[6] = s250;
	stims[7] = s500;
	stims[8] = s1000;
	stims[9] = s2000;
	stims[10] = s4000;
	#
	#   Event codes indicate frequency and ear tested with number and letter.
	evcod[1] = "250Hz Left";
	evcod[2] = "500Hz Left";
	evcod[3] = "1000Hz Left";
	evcod[4] = "2000Hz Left";
	evcod[5] = "4000Hz Left";
	evcod[6] = "250Hz Right";
	evcod[7] = "500Hz Right";
	evcod[8] = "1000Hz Right";
	evcod[9] = "2000Hz Right";
	evcod[10] = "4000Hz Right";
	#
	#   Starting volume is "90 dB" for all tests.
	#	Note volume parameter varies from 0.0 to 1.0 for 0 to 100 dB, respectively.
	xvol[1] = 0.9;
	xvol[2] = 0.9;
	xvol[3] = 0.9;
	xvol[4] = 0.9;
	xvol[5] = 0.9;
	xvol[6] = 0.9;
	xvol[7] = 0.9;
	xvol[8] = 0.9;
	xvol[9] = 0.9;
	xvol[10] = 0.9;
	#
	#  Ear parameter is 1.0 for right ear and -1.0 for left ear.
	#	Note negative pan parameter attenuates right ear
	#	and positive pan parameter attenuates left ear.
	ear[1] = -1.0;
	ear[2] = -1.0;
	ear[3] = -1.0;
	ear[4] = -1.0;
	ear[5] = -1.0;
	ear[6] = 1.0;
	ear[7] = 1.0;
	ear[8] = 1.0;
	ear[9] = 1.0;
	ear[10] = 1.0;
	#
	#  Initial negative direction reduces volume from starting 90 dB level.
	#	Note that the dir value determines only the direction of adjustment
	#	and the dstep value determines the size of the adjustment.
	dir[1] = -1.0;
	dir[2] = -1.0;
	dir[3] = -1.0;
	dir[4] = -1.0;
	dir[5] = -1.0;
	dir[6] = -1.0;
	dir[7] = -1.0;
	dir[8] = -1.0;
	dir[9] = -1.0;
	dir[10] = -1.0;
	#
	#  Initial step value is large so that we will not have too many high-level
	#	trials that are not of any value in determining the threshold.  The
	#	initial steps are 15 dB at all test points.
	dstep[1] = 0.15;
	dstep[2] = 0.15;
	dstep[3] = 0.15;
	dstep[4] = 0.15;
	dstep[5] = 0.15;
	dstep[6] = 0.15;
	dstep[7] = 0.15;
	dstep[8] = 0.15;
	dstep[9] = 0.15;
	dstep[10] = 0.15;
	#
	#  Initially, of course, we have no reversals of the direction of adjustment.
	num_revs[1] = 0.0;
	num_revs[2] = 0.0;
	num_revs[3] = 0.0;
	num_revs[4] = 0.0;
	num_revs[5] = 0.0;
	num_revs[6] = 0.0;
	num_revs[7] = 0.0;
	num_revs[8] = 0.0;
	num_revs[9] = 0.0;
	num_revs[10] = 0.0;
	#
	#  Initially, the sum of the good reversals (excluding the first two) is zero.
	sum_revs[1] = 0.0;
	sum_revs[2] = 0.0;
	sum_revs[3] = 0.0;
	sum_revs[4] = 0.0;
	sum_revs[5] = 0.0;
	sum_revs[6] = 0.0;
	sum_revs[7] = 0.0;
	sum_revs[8] = 0.0;
	sum_revs[9] = 0.0;
	sum_revs[10] = 0.0;
	
	#debug_out.open("data.out");		# Open file to store results.
	
	loop int i = 1 until i > 12
	begin
		response_manager.set_button_active(i, false);
		i = i + 1
	end;
	response_manager.set_button_active(1, true);
	response_manager.set_button_active(6, true);
	aud_intro.present();			# Present initial instructions.
	#
	#  Loop in j to do 50 randomly selected trials.
	loop
		int j = 0;
	until
		j == 50 || resp(6, m_responses) 
	begin
	#
	#  Set up one trial:
		int i = random ( 1, 10);		#choose ear-frequency at random.
		stim1.set_stimulus(stims[i]);		#set stimulus event to deliver.
		stim1.set_event_code(evcod[i]);		#set corresponding event code.
		stims[i].set_volume(xvol[i]);		#set current volume.
		stims[i].set_pan(ear[i]);		#set ear of delivery.
	#  Deliver this trial.
		aud_trial.present();
	#  Count trial as delivered.
		j = j + 1;
	#  Get response: 1 for button push, 0 for no response.
		int is_correct = response_manager.response_count(1);
	#
	#  Now process the response.  Depends on response and on adjustment direction.
		if (is_correct == 1) then
			if (dir[i] > 0.0) then
	#  Correct and previous direction was up:  REVERSAL, change to going down.
				dir[i] = -1.0;
				num_revs[i] = num_revs[i] + 1.0;
	#  Is it more than 2nd reversal? If so, add to sum.
				if (num_revs[i] > 2.0) then
					sum_revs[i] = sum_revs[i] + xvol[i];
				end;
	#  After first reversal, change to smaller step.
	#	Note that it does no harm to continue resetting dstep[i],
	#	and that it would take longer test it before resetting.
				if (num_revs[i] > 1.0) then
					dstep[i] = 0.08;
				end;
			end;
		end;
	#  Check for incorrect response.
		if (is_correct != 1) then
			if (dir[i] < 0.0) then
	#  Incorrect and previous direction was down:  REVERSAL, change to going up.
				dir[i] = 1.0;
				num_revs[i] = num_revs[i] + 1.0;
	#  Is it more than 2nd reversal? If so, add to sum.
				if (num_revs[i] > 2.0) then
					sum_revs[i] = sum_revs[i] + xvol[i];
				end;
	#  After first reversal, change to smaller step.
				if (num_revs[i] > 1.0) then
					dstep[i] = 0.05;
				end;
			end;
		end;
	#  Finished processing this response.
		xvol[i] = xvol[i] + (dir[i] * dstep[i]);
	#  Check to be sure volume is not too high.
		if (xvol[i] > 1.0) then
			xvol[i] = 1.0;
		end;
	#  Check to be sure volume is not too low.
		if (xvol[i] < 0.0) then
			xvol[i] = 0.0;
		end;
	end;
	if resp(6, m_responses)  then
		loop int i = 1 until i > 12
		begin
			response_manager.set_button_active(i, true);
			i = i + 1
		end;
		return true
	end;
	#  Loop in i to write results 
	loop
		int i = 1
	until
		i == 10
	begin
		string cap = "Auditory Threshold Results:\nDecibel threshold given for each frequency in each ear.\n";
		double thresh = 0.0;		#Used in mean-reversal file printout.
		double num = num_revs[i] - 2.0;	#As in mean-reversal file printout.
	#  Event code and tab are done in mean-reversal and final-level prints.
		cap = cap + (evcod[i]) + " ";
	#  Mean-reversals section checks to be sure there are enough reversals.
	#    Check is needed to prevent division-by-zero errors and nonsense values.
		if (num <= 0.0) then
			thresh = 100.0 * xvol[i];
			cap = cap + string(thresh) + "dB (Questionable, no good reversals)\n";
		else
			thresh = 100.0 * (sum_revs[i] / num);
			cap = cap + string(thresh) + "dB " + string(num) + " reversals\n";
		end;
		aud_results_text.set_caption(cap);
		aud_results_text.redraw();
		aud_results_trial.present();
		if resp(6, m_responses)  then
			break
		end;
		i = i + 1;
	end;
	loop int i = 1 until i > 12
	begin
		response_manager.set_button_active(i, true);
		i = i + 1
	end;
	if resp(6, m_responses)  then
		return true
	end;
	return false
end;

########Support PCL

sub bool support
begin
	loop int i = 1;
	int m_responses = response_manager.total_response_count(6);
	until i > supporttext.count()
	begin
		if resp(6, m_responses)  then
			return true
		end;
		basic_pic.set_part(4, supporttext[i]);
		basic_pic.set_part(8, supportscreens[i]);
		basic_trial.present();
		i = i + 1;
	end;
	return false;
end;

sub int response_menu_loop
begin
	array<string>response_menu_options[5] = {"Button Devices", "Axis Devices", "Return to Features", "Return to Main Menu", "Exit"};
	int response_menu_choice;
	loop response_menu_choice = menu(response_menu_options, "Response Devices")
	until response_menu_choice == 3  || response_menu_choice == 4 || response_menu_choice == 5 
	begin
		if response_menu_choice == 1
		then button_devices();
		elseif response_menu_choice == 2
		then axis_devices();
		end;
		response_menu_choice = menu(response_menu_options, "Response Devices");
	end;
	return response_menu_choice
end;

sub int stimulus_menu_loop
begin
	array<string>stimulus_menu_options[7] = {"2d Visual Stimuli", "Video Stimuli", "3d Visual Stimuli", "Auditory Stimuli", "Return to Features", "Return to Main Menu", "Exit"};
	int stimulus_menu_choice;
	bool goto_main = false;
	loop stimulus_menu_choice = menu(stimulus_menu_options, "Stimuli")
	until stimulus_menu_choice == 5  || stimulus_menu_choice == 6 || stimulus_menu_choice == 7 
	begin
		if stimulus_menu_choice == 1
		then visual_stims2d()
		elseif stimulus_menu_choice == 2
		then video_stims()
		elseif stimulus_menu_choice == 3
		then visual_stims3d()
		elseif stimulus_menu_choice == 4
		then auditory()
		end;
		stimulus_menu_choice = menu(stimulus_menu_options, "Stimuli");
	end;
	return stimulus_menu_choice
end;

sub bool feature_menu_loop
begin
	array<string>feature_menu_options[7] = {"Response Devices", "Stimuli", "Hardware Interfacing", "Programmability", "Timing", "Return to Main Menu", "Exit"};
	int feature_menu_choice;
	loop feature_menu_choice = menu(feature_menu_options, "Features")
	until feature_menu_choice == 6  
	begin
		if feature_menu_choice == 1
			then int next = response_menu_loop();
			if next == 4 then return false
			elseif next == 5 then return true
			end;			
		elseif feature_menu_choice == 2
			then int next = stimulus_menu_loop();	
			if next == 6 then return false
			elseif next == 7 then return true
			end;		
		elseif feature_menu_choice == 3
			then hardware()
		elseif feature_menu_choice == 4 
			then programmability()
		elseif feature_menu_choice == 5
			then timing()
		elseif feature_menu_choice == 7
			then return true
		end;
		feature_menu_choice = menu(feature_menu_options, "Features");
	end;
	return false
end;

sub bool demo_menu_loop
begin
	array<string>demo_menu_options[7] = {"Stroop Effect", "Visual Search", "N-Back Task", "Backward Masking", "Auditory Thresholds", "Return to Main Menu", "Exit"};
	int demo_menu_choice;
	loop demo_menu_choice = menu(demo_menu_options, "Experiment Demonstrations")
	until demo_menu_choice == 6
	begin
		if demo_menu_choice == 1
			then stroop()
		elseif demo_menu_choice == 2
			then vis_search()
		elseif demo_menu_choice == 3
			then n_back()
		elseif demo_menu_choice == 4
			then masking()
		elseif demo_menu_choice == 5
			then threshold()
		elseif demo_menu_choice == 7
			then return true
		end;
		demo_menu_choice = menu(demo_menu_options, "Experiment Demonstrations");
	end;
	return false;
end;
			
sub main_menu_loop
begin
	loop
	bool exit = false; 
	array<string>main_menu_options[4] = {"Feature Summary", "Experiment Demos", "Support Resources", "Exit"};
	int main_menu_choice = menu(main_menu_options, "Main Menu")
	until main_menu_choice == 4 || exit
	begin
		if main_menu_choice == 1 
		then exit = feature_menu_loop();
		elseif main_menu_choice == 2
		then exit = demo_menu_loop();
		elseif main_menu_choice == 3
		then support()
		end;
		if exit then break end;
		main_menu_choice = menu(main_menu_options, "Main Menu");
	end;
end;

main_menu_loop();