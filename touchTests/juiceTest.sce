begin;

begin_pcl;

output_port juicePulse = output_port_manager.get_port(1);

int nojo=1;							# Counter for number of juice drops given already
loop until 
		nojo > 5 
begin
		juicePulse.send_code(10,150);	# Give juice to the monkey
		wait_interval(150);
		juicePulse.send_code(0,150);	# Give juice to the monkey
		wait_interval(150);
		nojo=nojo+1;
end;