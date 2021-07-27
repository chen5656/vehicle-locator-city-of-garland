	set echo 	off;
	set timing	on;

	select 'UMS KEYS EXTRACT start  ' || to_char(sysdate, 'mon dd,yyyy hh24:mi') " " from dual;

--	===================================================================
--	Specify Service Type 

	variable	 serv_type		varchar2(5);
	execute	:serv_type	:=	'EL';					--	<<<<<<<=======	SPECIFY

--	service types	
--		'EL'		electric	
--		'WTR'		water
--		'SWR'		sewer
--		'STM'		storm water
--		'SWRSD'	sanitation


	@c:\deacutis\scripts\departments\ums\11B_Extract_Keys.sql;	--	<<<<<=========	EXECUTE

--	===================================================================
	select 'UMS KEYS EXTRACT stop  ' || to_char(sysdate, 'mon dd,yyyy hh24:mi') " " from dual;

