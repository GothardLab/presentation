scenario = "Trials and Templates 7";

default_font_size = 48;
response_matching = simple_matching;
active_buttons = 1;
button_codes = 1;

begin;

text { caption = "red"; font_color = 255,0,0; } red;
text { caption = "green"; font_color = 0,255,0; } green;
text { caption = "blue"; font_color = 0,0,255; } blue;
text { caption = "flower"; } flower;
text { caption = "car"; } car;
text { caption = "house"; } house;

TEMPLATE "Trials and Templates 7.tem" {
	part1		code1		part2		code2		dur	;
	red		"red"		car		"car"		1000	;
	blue		"blue"	house		"house"	500	;
	green		"green"	flower	"flower"	1500	;
};