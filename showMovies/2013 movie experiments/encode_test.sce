

write_codes =false;  # write encodes in Presentation logfile(false=don't write encodes)


##############################################################################################
begin;	#begin SDL (defining the experiment images / trial types)
##############################################################################################

##############################################################################################
begin_pcl; #begin PCL (the timing file)
##############################################################################################
output_port oportData=output_port_manager.get_port(1);
output_port oportPulse=output_port_manager.get_port(2);
#output_port oportJuice=output_port_manager.get_port(2); # open the port that will send the juice TTL pulse


#determine the high and low byte and send these codes.
sub array<int,1> encode(int C) begin
array<int> encodes[2];
encodes[1]=mod(C,256);
encodes[2]=(C-encodes[1])/256;
oportData.send_code(encodes[1],2);#low
oportPulse.send_code(128,1);
wait_interval(5);
oportData.send_code(encodes[2],2);#high
oportPulse.send_code(128,1);
wait_interval(5);
return encodes;
end;

int encodeval;
loop encodeval=0 until encodeval>255 begin;
			encode(encodeval);
			wait_interval(100);
			encodeval=encodeval+1;
end;
		