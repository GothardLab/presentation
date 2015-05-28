active_buttons=0;

begin;

picture {
box{ height=10; width=10; color=255, 255, 255; };
x=0; y=0;
text { caption="+";};
x=0; y=0;
}fspot;

picture {
text{ caption="hi";}elapsedtimetext; x=0; y=-20;
}elapsedtime;

begin_pcl;

#debug file
output_file ofile = new output_file;
ofile.open("test.txt");

#create the analog input channels
dio_device iscan = new dio_device(ni_dio_device,1,0);
int idX = iscan.acquire_analog_input("eye,Voltage");
int idY = iscan.acquire_analog_input("eye,Voltage_0");

int wait1;
int pause1;
int checkclock;
int time1;
int count;
int count2=1;
array <double> posX[1000];
array <double> posY[1000];

wait1=clock.time();
loop until clock.time()-wait1>500 begin end;

fspot.present();

wait1=clock.time();

#loop until count2>10 begin
count=1;
checkclock=clock.time();

loop until count>300 begin#clock.time()-wait1>3000 begin

pause1=clock.time();
posX[count]=iscan.read_analog(idX); #store x location
loop until clock.time()-pause1>8 begin end; #pause a bit
posY[count]=iscan.read_analog(idY); #store y location

#fspot.set_part_x(2,posX[count]*50.0);
#fspot.set_part_y(2,posY[count]*50.0);
#fspot.present();

count=count+1;
end;
#count2=count+1;
#end
time1=clock.time()-checkclock;
elapsedtimetext.set_caption(string(time1));
elapsedtimetext.redraw();
elapsedtime.present();
pause1=clock.time();
loop until clock.time()-pause1>1000 begin end; #pause a bit

