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
--	==============================================================================================

	alter session	set nls_data_format = 'yyyymmdd';
	select sysdate from dual;

--	==============================================================================================

	truncate table	garland.GIS_Temp3		reuse storage;

	insert --+ append

	into garland.GIS_Temp3 

	(	item01, item02, item03, item04, item05, item06, item07, item08, item09, item10, 
		item11, item12, item13, item14, item15, item16, item17, item18, item19, item20,  
		item21, item22, item23, item24, item25, item26, item27, item28, item29, item30
		item31, item32, item33, item34, item35, item36, item37, item38, item39, item40,
		item41, item42, item43, item44, item45, item46, item47, item48, item49, item50,
		item51, item52, item53, item54, item55, item56, item57, item58, item59, item60

--		item1, item2, item3, item4, item5, item6, item7, item8, item9, item0,
	)


	select * 
	from	 garland.	
	;

--	==============================================================================================

	commit;  

--	==============================================================================================
