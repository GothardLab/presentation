scenario = "PCL keyboard example";
no_logfile = true;
default_font_size = 24;
begin;    

picture {} default;

trial {
   trial_duration = 1000;
   
   picture {
      text { caption = " "; } text1;
      x = 0; y = 0;
   } pic1;
} trial1;

picture {
   text { caption = "Type something followed by return:";  };
   x = 0; y = 100;
   text { caption = " "; } text2;
   x = 0; y = 0;
} pic2;


begin_pcl;

#Use get input and show what was typed after pressing enter
text1.set_caption( "Type something followed by return" );
text1.redraw();
pic1.present();

string input = system_keyboard.get_input();
text1.set_caption( "You typed:\n" + input );
text1.redraw();
trial1.present();

#Changing the delimiter
system_keyboard.set_delimiter( 'a' );
text1.set_caption( "Type something followed by 'a'" );
text1.redraw();
pic1.present();

input = system_keyboard.get_input();
text1.set_caption( "You typed:\n" + input );
text1.redraw();
trial1.present();

#Use time out and check what ended the call to keyboard::get_input()
system_keyboard.set_time_out( 5000 );
system_keyboard.set_max_length( 10 );
text1.set_caption( "Type 10 characters\nexcluding 'a'\nin under 5 seconds" );
text1.redraw();
pic1.present();

input = system_keyboard.get_input();
string message;
if (system_keyboard.last_input_type() == keyboard_max_length) then
   message = "Good job"
elseif (system_keyboard.last_input_type() == keyboard_time_out) then
   message = "Too slow!"
elseif (system_keyboard.last_input_type() == keyboard_delimiter) then
   message = "You typed an 'a'!"   
else
   message = "Should never happen";
end;
text1.set_caption( message );
text1.redraw();
trial1.present();

#Example of using the methods for obtaining keypress information
system_keyboard.set_delimiter('\n');
int count = system_keyboard.keypress_count();
system_keyboard.set_log_keypresses(true);
system_keyboard.get_input( pic2, text2 );
if system_keyboard.keypress_count() > count then
	double time = system_keyboard.get_keypress_time( count + 1);
	int char_code = system_keyboard.get_keypress_code( count + 1);
	string character = " ";
	character.set_char( 1, char_code );
	message = "You pressed the '" + character + "' button at time: " + string(time);
else
	message = "You didn't press any keys!"
end;
text1.set_caption( message );
text1.redraw();
trial1.present();
	