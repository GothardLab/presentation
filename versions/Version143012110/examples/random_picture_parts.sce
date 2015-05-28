# This scenario demonstrates how to use PCL to 
# randomly select multiple elements in a visual stimulus.

# In each trial, one digit from 1 to 9 is selected.
# The selected digit is displayed for 300ms.   
# Then a 5x5 grid of 25 digits is displayed.
# Each position in the grid contain a randomly
# chosen digit from 1 to 9 excluding the selected digit.
# Half of the time, the selected digit is not displayed
# in the grid.
# Half the time, the selected digit appears once in the
# grid at a random location.
# If the selected digit appears in the grid, the subject
# should press button 1.
# If the selected digit does not appear, the subject should
# press button 2.
# The scenario will run forever - you need to press quit
# (default is 'q') to end it.

# Note: This scenario is just a demonstration and is
# not meant to be scientifically meaningful.


scenario = "random picture part selection";
response_matching = simple_matching;
no_logfile = true;
default_font_size = 24;  

active_buttons = 2;
button_codes = 1, 2; 
target_button_codes = 11, 12;

$spacing = 50; # number of pixels between the centers of digits

# ------------- end header ---------------------
begin;  

# picture to show when nothing else is
picture {} default;
      
# the digit picture parts in an array
array {
   text { caption = "1"; } one;    
   text { caption = "2"; };
   text { caption = "3"; };
   text { caption = "4"; };
   text { caption = "5"; };
   text { caption = "6"; };
   text { caption = "7"; };
   text { caption = "8"; };
   text { caption = "9"; }; 
} digits;
      
# the main trial
trial {                      
   # don't end until a response
   trial_duration = forever;
   trial_type = first_response;  
   
   # show the selected digit for 300 ms
   picture {
      text one; # placeholder, set by PCL
      x = 0; y = 0;
   } selected_pic;
   time = 0;
   duration = next_picture;
   
   # show the digit grid
   stimulus_event {
      picture {    
         # save some typing with scenario file loops! 
         LOOP $i 5;
            LOOP $j 5; # 5x5 grid
               text one; # placeholder, set by PCL
               x = '$spacing * ($i - 2)';
               y = '$spacing * ($j - 2)';
            ENDLOOP;
         ENDLOOP; 
      } pic; 
      time = 300;
      duration = next_picture;
   } stim;  
} trial1;

begin_pcl;

# number of digits in the grid
# this must match the number of picture parts in picture "pic"
int num_digits_in_pic = 25;  
# get the number of available digits from the array of 
# digit picture parts
int number_of_digits = digits.count();

# loop forever for demonstration purposes
loop until false begin                   
   
   # in a real experiment, what the selection is will depend
   # on the experiment    
   # for demonstration, just pick a random digit
   int selected_digit = random( 1, number_of_digits );  
   selected_pic.set_part( 1, digits[selected_digit] );
   # for demonstration, just randomly show the selected digit half the time
   bool show_selection = bool( random( 0, 1 ) );
   
   # pick random digits excluding selection for all positions in pic 
   # insert them into the picture "pic"
   loop
      int i = 1
   until
      i > num_digits_in_pic
   begin              
      # be careful! For proper random distribution, must choose
      # from "number_of_digits - 1" possibilities
      int digit = random( 1, number_of_digits - 1 ); 
      if (digit >= selected_digit) then
         digit = digit + 1
      end;
      pic.set_part( i, digits[digit] );
      i = i + 1
   end;  
   if (show_selection) then         
      # if showing selected digit, pick random place for it
      pic.set_part( random( 1, num_digits_in_pic ), digits[selected_digit] );    
      # show some info in the logfile for this stimulus
      stim.set_event_code( "selection " + string( selected_digit ) + " present" ); 
      # subject should press button 1
      stim.set_target_button( 1 );
   else                     
      # show some info in the logfile for this stimulus
      stim.set_event_code( "selection " + string( selected_digit ) + " absent" ); 
      # subject should press button 2
      stim.set_target_button( 2 );
   end;
   
   # run the trial
   trial1.present();  
   
end;
