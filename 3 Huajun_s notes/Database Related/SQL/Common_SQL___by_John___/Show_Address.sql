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

--		rpad(rec_key,	10)		"key",

		lpad(nvl(addr_num,   0), 05)		"num", 
		rpad(nvl(addr_pfx, ' '), 02)		"pf", 
		rpad(nvl(addr_name,' '), 20)		"name",
		rpad(nvl(addr_type,' '), 04)		"type",	 
		rpad(nvl(addr_sfx, ' '), 02)		"sf"

--		,rpad(nvl(addr_code1, ' '), 10)	"bldg"
--		,rpad(nvl(addr_unit1, ' '), 10)	"unit"
