--	=====================================================================
	select * from viewer.me;
--	BEGIN  TEST TEST TEST TEST TEST  TEST TEST TEST TEST TEST  TEST TEST TEST TEST TEST  END;
set	TIMING		OFF;
set	sqlblanklines	on;
set	serveroutput	on	size 99999;
set	linesize		1000;
set	pagesize		0000;
--	execute jdeacutis.show_table_column	('', '', '');
--	execute jdeacutis.show_source		('test_proc', 'jdeacutis', '');
--	execute jdeacutis.show_error		('test_proc', 'jdeacutis', '');
--	execute jdeacutis.show_view		('', '', '');
--	execute jdeacutis.show_index_column	('', '', '');
--	SELECT  to_char(sysdate,'Mon dd,yyyy hh24:mi')||'  ***  ' " "  from dual;
--	EXECUTE jdeacutis.TEST_PROC;
--	CREATE or replace procedure jdeacutis.TEST_PROC  as
--	DECLARE
--	=====================================================================	
--	Create Common_CUS copy of Common_UMS
--	It will be used as work table
--	=====================================================================	

	drop table	garland.CCS_ADDRESS_ODT;

	create table	garland.CCS_ADDRESS_ODT tablespace gis_data as select * from garland.CCS_ADDRESS_NEW where rownum < 1;

--	=====================================================================	

	Truncate table	garland.CCS_ADDRESS_ODT;

	insert --+ append
	into	garland.CCS_ADDRESS_ODT

	select * 
	from garland.CCS_ADDRESS_NEW
--	from garland.CCS_ADDRESS_NEW@sdep.world 
	order by addr_name, addr_type, addr_prefix, addr_suffix, addr_number;

	COMMIT;
 
--	=====================================================================
