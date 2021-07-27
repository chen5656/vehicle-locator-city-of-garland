	set echo off;
--	======================================================================
--	make backup (jdeacutis) of current version (garland) of CCS_ADDRESS 
--	======================================================================

--	truncate table jdeacutis.CCS_ADDRESS	reuse storage;
--	insert --+ append	
--	into	jdeacutis.ccs_address
--	select * from garland.ccs_address;
--	commit;

--	======================================================================

	drop table	jdeacutis.CCS_ADDRESS;

	create table jdeacutis.CCS_ADDRESS 
	tablespace gis_data
	nologging
	as select * from garland.CCS_ADDRESS;

--	======================================================================

	select count(*) garland 	from garland.ccs_address;
	select count(*) jdeacutis	from jdeacutis.ccs_address;

	select owner,object_name, last_ddl_time garland 
	from all_objects 
	where object_name = 'CCS_ADDRESS';

--	======================================================================
