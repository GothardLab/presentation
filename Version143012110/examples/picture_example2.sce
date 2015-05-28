scenario = "PCL picture example 2";
no_logfile= true;
begin;

picture {} default; 

box { height = 2; width = 2; color = 255,0,0; } dot;

box { height = 1; width = 30; color = 255,255,255; } horz;
box { height = 30; width = 1; color = 255,255,255; } vert;

trial {
   trial_duration = 500;
   
   picture {
   } pic1;
} main_trial;

begin_pcl;

loop
   int i = 1
until
   i > 20
begin   
   pic1.clear();            
   int num_dots = random( 1, 40 );
   loop
      int j = 1
   until
      j > num_dots
   begin
      pic1.add_part( dot, random( -200, 200 ), random( -200, 200 ) );
      j = j + 1
   end;
   pic1.add_part( horz, 0, 0 ); 
   pic1.add_part( vert, 0, 0 ); 
   
   main_trial.present();
   
   i = i + 1
end