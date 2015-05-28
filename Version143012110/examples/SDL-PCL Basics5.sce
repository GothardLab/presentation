begin;

text { caption = "Hello world!"; font_size = 24; } hello;
box { height = 100; width = 200; color = 255,0,0; } red_box;

picture {
   background_color = 0,0,255;

   text hello;
   x = 0; y = 100;
   box red_box;
   x = 0; y = -100;
} hello_pic;

trial {
   trial_duration = 2000;

   picture hello_pic;
   time = 0;
   duration = 1000;
} hello_trial;

begin_pcl;

loop
   int i = 1
until
   i > 3
begin
   hello.set_caption( "time = " + string( clock.time() ) );
   hello.redraw();
   hello_trial.present();
   i = i + 1
end