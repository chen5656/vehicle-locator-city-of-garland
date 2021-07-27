
	set echo 		off;
	set serveroutput	on;

declare

	cycles	number	:= 111111;

	name		varchar2(20):= 'asdfqwerzxcfv';

	start_hh	number;
	start_mm	number;
	start_ss	number;
	stop_hh	number;
	stop_mm	number;
	stop_ss	number;
	timer		number;

begin

	start_hh	:= to_char ( sysdate, 'hh24');
	start_mm	:= to_char ( sysdate, 'mi');
	start_ss	:= to_char ( sysdate, 'ss');

for x in 1..cycles				loop

	name := adr_name_ending ( name );

end loop;

	stop_hh	:= to_char ( sysdate, 'hh24');
	stop_mm	:= to_char ( sysdate, 'mi');
	stop_ss	:= to_char ( sysdate, 'ss');
	
	if	stop_hh < start_hh		then
		stop_hh := stop_hh + 24;
	end if;
	
	if	stop_mm < start_mm		then
		stop_mm := stop_mm + 60;
		stop_hh := stop_hh - 01;
	end if;
	
	if	stop_ss < start_ss		then
		stop_ss := stop_ss + 60;
		stop_mm := stop_mm - 01;
	end if;

	timer	:=	(stop_hh - start_hh) * 3600	+ 
			(stop_mm - start_mm) * 0060	+
			(stop_ss - start_ss);
		
	dbms_output.put_line ( timer );

end;

