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

	create or replace view	jdeacutis.Temp_View		as
	select
		item01		seq,
		item02		parcelid,
		item03		addr_num,
		item04		addr_pfx,
		item05		addr_name,
		item06		addr_type,
		item07		addr_sfx,
		item08		dcad,
		item09		tenant,
		item10		gisid,
		item11		taxid,
		item12		umsid
	from	jdeacutis.gis_Objects;

