	set echo	off;

--	==============================================================================================
--	specify tables and users for security generator
--	==============================================================================================

	truncate table	garland.gis_objects	reuse storage;


--	specify Tables to be secured

	insert into	garland.gis_objects (item01, item02, item03) 
	select	'TRIGGER', 'TABLE', table_name
	from		user_tables

--	where		table_name 	like 'UT%'			-- specify filter

	where		table_name 	= 'UTWATPIP'		-- specify filter
	or		table_name 	= 'UTSANPIP'		-- specify filter
	;


--	specify Users to be permitted update capability

	insert into garland.gis_objects (item01, item02, item03) values ('TRIGGER', 'USER', 'ddarby');
	insert into	garland.gis_objects (item01, item02, item03) values ('TRIGGER', 'USER', 'sguyen');


	commit;

	select rpad(item01,20) " ", rpad(item02,20) " ", rpad(item03,20) " "
	from	garland.gis_objects;

	set echo	on;
