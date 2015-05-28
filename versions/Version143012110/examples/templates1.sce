scenario = "Template Example";  

default_font_size = 48;

begin;

picture {} default;
  
# define some text objects
LOOP $i 10;
text { caption = "Pic $i"; } "text$i";
ENDLOOP;

TEMPLATE "templates1.tem" {
   cap         ecode       ;
   text4       "t4"        ;   
   text1       "t1"        ;
   text9       "t9"        ;
   text7       "t7"        ;
   text0       "t0"        ;
   text6       "t6"        ;
   text3       "t3"        ;
   text2       "t2"        ;
   text8       "t8"        ;
   text5       "t5"        ;       
};