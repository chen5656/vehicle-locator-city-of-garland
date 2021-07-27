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

	DROP view  jdeacutis.Temp_View;

	CREATE or replace view	jdeacutis.Temp_View
	(
		seq,
		parcelid,
		addr_num,
		addr_pfx,
		addr_name,
		addr_type,
		addr_sfx,
		dcad,
		tenant,
		gisid,
		taxid,
		umsid
	)
	as	Select
		item01,
		item02,
		item03,
		item04,
		item05,
		item06,
		item07,
		item08,
		item09,
		item10,
		item11,
		item12
	from	jdeacutis.gis_Objects;

