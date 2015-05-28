scenario = "randomize trials"; 
no_logfile = true;
randomize_trials = true; 
default_font_size = 48;

begin; 

picture {} default; 

LOOP $i 5;
$k = '$i + 1';
picture {
   text { caption = "Pic $k"; };
   x = 0; y = 0;
} "pic$k";   
ENDLOOP;

# randomize with pic n shown n times           
TEMPLATE "template_randomize.tem" randomize {
   pic   ecode;
   pic1  "pic1";   
   pic2  "pic2";
   pic2  "pic2";
   pic3  "pic3";
   pic3  "pic3";
   pic3  "pic3";
   pic4  "pic4";
   pic4  "pic4";
   pic4  "pic4";
   pic4  "pic4";  
   pic5  "pic5"; 
   pic5  "pic5"; 
   pic5  "pic5"; 
   pic5  "pic5"; 
   pic5  "pic5"; 
};