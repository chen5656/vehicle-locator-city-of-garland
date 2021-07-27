--	=====================================================================
	select * from viewer.me;
	BEGIN  TEST TEST TEST TEST TEST  TEST TEST TEST TEST TEST  TEST TEST TEST TEST TEST  END;
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


	select
		rpad(item01,20)		item01,
		rpad(item02,20)		item02,
		rpad(item03,20)		item03,
		rpad(item04,20)		item04,
		rpad(item05,20)		item05,
		rpad(item06,20)		item06,
		rpad(item07,20)		item07,
		rpad(item08,20)		item08,
		rpad(item09,20)		item09,
		rpad(item10,20)		item10,
		
		' ' " "
	from	garland.gis_OBJECTS
--	from	garland.gis_TEMP


	where	rownum < 11

	;


