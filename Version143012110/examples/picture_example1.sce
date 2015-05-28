scenario = "PCL picture example 1";
no_logfile= true;
begin;

picture {} default;

array {
   box { height = 50; width = 50; color = 255,0,0; } box1;   
   box { height = 50; width = 50; color = 0,255,0; };
   box { height = 50; width = 50; color = 0,0,255; };
   box { height = 50; width = 50; color = 128,128,0; };
   box { height = 50; width = 50; color = 128,0,128; };
   box { height = 50; width = 50; color = 0,128,128; };
   box { height = 50; width = 50; color = 100,100,100; }; 
} boxes;     

box { height = 1; width = 30; color = 255,255,255; } horz;
box { height = 30; width = 1; color = 255,255,255; } vert;

trial {
   trial_duration = 500;
   
   picture {
      box box1;
      x = -100; y = 100;
      box box1;
      x = 100; y = 100;
      box box1;
      x = 100; y = -100;
      box box1; 
      x = -100; y = -100; 
      box horz;
      x = 0; y = 0;
      box vert;
      x = 0; y = 0;
   } pic1;
} main_trial;

begin_pcl;

loop
   int i = 1
until
   i > 20
begin
   boxes.shuffle();
   pic1.set_part( 1, boxes[1] );      
   pic1.set_part( 2, boxes[2] );
   pic1.set_part( 3, boxes[3] );
   pic1.set_part( 4, boxes[4] );
   
   main_trial.present();
   
   i = i + 1
end