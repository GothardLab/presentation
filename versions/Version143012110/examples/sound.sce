scenario = "PCL sound example";
no_logfile = true;
begin;
   
wavefile { filename = "ding.wav"; } ding;

trial {
   sound { wavefile ding; } sound1;
} trial1;   

begin_pcl;

sub
   play( string message )
begin
   display_window.erase();
   display_window.draw_text( message );
   trial1.present()
end;

play( "sound1" ); 

loop
   double attenuation = 0.0
until
   attenuation > 0.6
begin
   sound1.set_attenuation( attenuation );
   play( "attenuation = " + string( attenuation ) );
   attenuation = attenuation + 0.1
end;
sound1.set_attenuation( 0.0 );

loop
   double pan = -1.0
until
   pan > 1.0
begin
   sound1.set_pan( pan );
   play( "pan = " + string( pan ) );
   pan = pan + 0.2
end;