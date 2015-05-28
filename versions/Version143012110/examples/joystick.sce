# This scenario requires one selected joystick

scenario = "PCL joystick example";
no_logfile = true;

begin;

picture {} default;

picture {  
   box { color = 255,0,0; height = 10; width = 10; };
   x = 0; y = 0;
   box { color = 0,0,255; height = 10; width = 10; };
   x = 0; y = 0;
} pic1;   

picture {
   text { caption = " "; font_size = 24; } text1;
   x = 0; y = 0;
} pic2;

begin_pcl;

# make sure a joystick is being used
if (response_manager.joystick_count() == 0) then
   text1.set_caption( "No joystick selected!" );
   text1.redraw();
   pic2.present();
   loop until false begin end 
end;

joystick stick = response_manager.get_joystick( 1 ); 
                                    
# make sure joystick has 2 axes                                   
if (stick.axis_count() < 2) then
   text1.set_caption( "Scenario requires 2 axes!" );
   text1.redraw();
   pic2.present();
   loop until false begin end
end;

# set joystick parameters
stick.set_min_max( 1, -200, 200 ); 
stick.set_min_max( 2, -200, 200 );
stick.set_saturation( 1, 0.9 );
stick.set_saturation( 2, 0.9 );
stick.set_dead_zone( 1, 0.2 ); 
stick.set_dead_zone( 2, 0.2 );

# move boxes according to joystick movement
int location_x = 0;
int location_y = 0;
loop until false begin  
   stick.poll();
   pic1.set_part_x( 1, stick.x() );
   pic1.set_part_y( 1, stick.y() );
      
   if (stick.x() > 0) then
      location_x = location_x + 3
   elseif (stick.x() < 0) then
      location_x = location_x - 3
   end;
   if (location_x > 200) then
      location_x = 200;
   elseif (location_x < -200) then
      location_x = -200;
   end;                            
      
   if (stick.y() > 0) then
      location_y = location_y + 3
   elseif (stick.y() < 0) then
      location_y = location_y - 3
   end;
   if (location_y > 200) then
      location_y = 200;
   elseif (location_y < -200) then
      location_y = -200;
   end;
   
   pic1.set_part_x( 2, location_x );
   pic1.set_part_y( 2, location_y );
   
   pic1.present()
end
      