scenario = "box picture parts example";  
no_logfile = true;
default_font_size = 24;
begin;

picture {} default; 

box { height = 1; width = 600; color = 255,255,255; } horiz;
box { height = 400; width = 1; color = 255,255,255; } vert;

trial {
   trial_duration = 4000;
   
   picture {                                            
      box horiz;
      x = 0; y = 200;
      box horiz;
      x = 0; y = -200;
      box vert;
      x = 300; y = 0;
      box vert;
      x = -300; y = 0;
      box { height = 100; width = 100; color = 0,0,255; };
      x = 0; y = 0;
   };
};