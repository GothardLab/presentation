scenario = "PCL stimulus_event example";
no_logfile = true;

default_font_size = 24;  

active_buttons = 2;
button_codes = 1, 2;

begin;

picture {} default;

array {
   TEMPLATE "picture.tem" {
      cap   ;
      "targeta 1"  ;    
      "targeta 2"  ;
      "targeta 3"  ;
      "targeta 4"  ;
      "targeta 5"  ;
      "targeta 6"  ;
      "targeta 7"  ;
      "targeta 8"  ;
      "targeta 9"  ;
      "targeta 10" ;
   };
} targetas;            

array {
   TEMPLATE "picture.tem" {
      cap   ;
      "targetb 1"  ;    
      "targetb 2"  ;
      "targetb 3"  ;
      "targetb 4"  ;
      "targetb 5"  ;
      "targetb 6"  ;
      "targetb 7"  ;
      "targetb 8"  ;
      "targetb 9"  ;
      "targetb 10" ;
   };
} targetbs;     

trial {
   trial_duration = 3000;
   
   stimulus_event {
      nothing {};
   } event1;
} main_trial;

begin_pcl;

loop
   int i = 1
until
   i > 20
begin
   bool a = bool( random( 0, 1 ) );
   if a then
      int pic = random( 1, targetas.count() );
      event1.set_stimulus( targetas[pic] );
      event1.set_target_button( 1 );
      event1.set_event_code( "targeta " + string( pic ) );
   else                  
      int pic = random( 1, targetbs.count() );
      event1.set_stimulus( targetbs[pic] );
      event1.set_target_button( 2 );
      event1.set_event_code( "targetb " + string( pic ) );  
   end;
   event1.set_time( random( 0, 1000 ) );
   event1.set_duration( random( 200, 1000 ) );
   
   main_trial.present();
   
   i = i + 1
end