# This scenario requires a non-palettized display mode
# - more than 8 bit color
scenario = "PCL text example";
no_logfile = true;
begin;

picture {} default; 

text {
   caption = "original text"; 
   font_size = 24;
   preload = false;
} text1;

trial {      
   trial_duration = 2500;
   
   picture {
      text text1;
      x = 0; y = 0;
   };
} trial1;

begin_pcl;

sub
   present( string caption )
begin
   text1.set_caption( caption );
   text1.redraw();  
   trial1.present()
end;
   
text1.load();
trial1.present();

present( "text::set_caption" ); 
                                
text1.set_font_color( 255, 0, 0 );
present( "text::set_font_color" );  
text1.set_font_color( 255, 255, 255 );

text1.set_background_color( 0, 0, 255 );
present( "text::set_background_color" );

text1.set_width( 300 );   
text1.set_height( 300 );
present( "text::set_width\ntext::set_height" );

text1.set_height( 0 );  
text1.set_width( 0 );
text1.set_font_size( 48 );
present( "text::set_font_size" );

text1.set_font_size( 24 );
text1.set_align( align_left );
present( "text::set_text_align\nline 2\nline 3" );

text1.set_align( align_right );
present( "text::set_text_align\nline 2\nline 3" ); 

text1.set_font( "Courier New" );
present( "text::set_font" );

text1.unload();
# ...