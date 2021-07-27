	set echo 	off;
--	===================================================================

--	===================================================================
--	specify service type 

	variable	serv_type		varchar2(5);
--	variable	from_date		date;
--	variable	to_date		date;

	execute	:serv_type	:= 'SWRSD';
--	execute	:from_date	:= to_date ('JAN 01 2001', 'MON dd,yyyy');
--	execute	:to_date	:= to_date ('DEC 31 2001', 'MON dd,yyyy');

--	service types	
--		'EL'		electric	
--		'WTR'		water
--		'SWR'		sewer
--		'STM'		storm water
--		'SWRSD'	sanitation

--	===================================================================

	@c:\deacutis\scripts\departments\ums\01_Execute_UMS_Keys.sql;

--	===================================================================
	set echo 	on;



