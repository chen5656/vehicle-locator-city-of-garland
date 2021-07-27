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

	create or replace view	garland.GIS_Temp_View		as

	select
		rpad(item01, 20)		item01,
		rpad(item02, 20)		item02,
		rpad(item03, 20)		item03,
		rpad(item04, 20)		item04,
		rpad(item05, 20)		item05,
		rpad(item06, 20)		item06,
		rpad(item07, 20)		item07,
		rpad(item08, 20)		item08,
		rpad(item09, 20)		item09,
		rpad(item10, 20)		item10,

		rpad(item11, 20)		item11,
		rpad(item12, 20)		item12,
		rpad(item13, 20)		item13,
		rpad(item14, 20)		item14,
		rpad(item15, 20)		item15,
		rpad(item16, 20)		item16,
		rpad(item17, 20)		item17,
		rpad(item18, 20)		item18,
		rpad(item19, 20)		item19,
		rpad(item20, 20)		item20

--	from	garland.GIS_OBJECTS;

	from	garland.GIS_Temp3;
