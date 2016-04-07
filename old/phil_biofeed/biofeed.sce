#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Define Objects in SDL
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

begin;																							# begin SDL sequence of code

#monitorMonkeyResp																				# the monkey's respiration, displayed on the monitoring screen
picture{
	display_index = 2;

	box { color = 0,255,0; height=1; width=10; display_index = 2;}mRespLevel;
	x=0; y = 0;
	on_top = true;


}monitorMonkeyResp;

#presentMonkeyResp																				# the monkey's respiration, displayed on the presentation screen
picture{
	display_index = 1;

	box { color = 0,255,0; height=1; width=10; display_index = 1;}pRespLevel;
	x=0; y = 0;
	on_top = true;


}presentMonkeyResp;
 
##monitorDebugText																				# the debugging text on the monitor screen
#text{
#	display_index = 2;
#
#
#
#}monitorDebugText;


#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Start PCL and define experimental parameters
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

begin_pcl;																						# begin PCL sequence of code

double monitorX=800.0; 																			# monitor width (pixels)
double monitorY=600.0; 																			# monitor height (pixels)
double ratioX=(monitorX/2.0)/4.0; 																# ratio to multiply X voltage by (want 5Volts to be at least 1/2 the width of the monitor)
double ratioY=(monitorY/2.0)/4.0; 																# ratio to multiply X voltage by (want 5Volts to be at least 1/2 the height of the monitor)
int startTime=0;																				# just an integer counter to hold the clock time
int calTime = 10000;																			# calibration time in miliseconds
int trialTime = 30000;																			# trial time in miliseconds
double oldMax;																					# max value during calibration period
double oldMin;																					# min value during calibration period
double newMax = 1.0;																			# should be 0
double newMin = 0.0;																			# should be
double newValue;																				# new value calculated from calibration
double oldValue;																				# raw analog input
double oldRange;
double newRange;
double calPixels = 300.0;																			# number to take value of 1 to max pixels
double resPixels;
int saturateFlag = 0;
double tempA;
double tempB;


#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Open ports for sending/receiving data
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

output_port oportData=output_port_manager.get_port(1);											# open the port to send encodes on
output_port oportPulse=output_port_manager.get_port(2); 										# the 1401 has to see a TTL pulse before it can receive an encode, open the port that the pulse will be sent on
output_port oportJuice=output_port_manager.get_port(2); 										# open the port that will send the juice TTL pulse
dio_device iscan = new dio_device(ni_dio_device, 1, 0); 										# initialize the analog portion of the NI DIO card in the presentaiton computer
int idX = iscan.acquire_analog_input("ISCANTask,x");  											# set up retrieval of the x coordinate of eye tracker
int idY = iscan.acquire_analog_input("ISCANTask,y");  											# set up retrieval of the y coordinate of eye tracker
double iscan_x; 																				# initialize variable for eye tracker x postion
double iscan_y; 																				# initialize variable for eye tracker y postion



#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Zero the respiratory input based on calibration period
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

tempA = iscan.read_analog(idX);																	# take in temporary values to set for min and max
tempB = iscan.read_analog(idX);

if tempA > tempB then																			# make the lesser of the two values the min, and the other the max
	oldMax = tempA;
	oldMin = tempB;
else
	oldMax = tempB;
	oldMin = tempA;
end;


loop
	startTime = clock.time();																	# get the current time and save it for later reference
until
	(clock.time()-startTime) > calTime
begin


		iscan_x =iscan.read_analog(idX);														# get analog input
		
		
		if iscan_x > oldMax then																# set a new max
			oldMax = iscan_x;
		end;
		
		if iscan_x < oldMin then																# set a new min
			oldMin = iscan_x;
		end;
		
		oldRange = (oldMax - oldMin);  
		newRange = (newMax - newMin);
		oldValue = iscan.read_analog(idX);
		newValue = (((oldValue - oldMin) * newRange) / oldRange) + newMin;
		
		resPixels =  calPixels * newValue;
		mRespLevel.set_height(resPixels);
		monitorMonkeyResp.present();

end;

oldRange = (oldMax - oldMin);  
newRange = (newMax - newMin);



#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Display the input for 30 seconds
#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

loop
	startTime = clock.time();																	# get the current time and save it for later reference
until
	(clock.time()-startTime) > trialTime
begin

	oldValue = iscan.read_analog(idX);
	newValue = (((oldValue - oldMin) * newRange) / oldRange) + newMin;
	
	if newValue <= 0.0 then
		newValue = 0.0;
		saturateFlag = 1;
	end;
	
	if newValue >= 1.0 then
		newValue = 1.0;
		saturateFlag = 1;
	end;
	
	resPixels =  calPixels * newValue;
	
	pRespLevel.set_height(resPixels);
	mRespLevel.set_height(resPixels);
	presentMonkeyResp.present();
	monitorMonkeyResp.present();
	

end;