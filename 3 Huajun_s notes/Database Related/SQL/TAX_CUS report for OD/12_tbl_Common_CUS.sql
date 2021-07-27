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

	drop table jdeacutis.Common_CUS;

	create table garland.Common_CUS tablespace gis_data as select * from garland.Common_UMS where rownum < 1;

--	=====================================================================	

	Truncate table	garland.Common_CUS;

	insert --+ append
	into	garland.Common_CUS

	select * 
	from garland.Common_UMS 
--	from garland.Common_UMS@sdep.world 
	order by addr_name, addr_type, addr_pfx, addr_sfx, addr_num;

	COMMIT;
 
--	=====================================================================
