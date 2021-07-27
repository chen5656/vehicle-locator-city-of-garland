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

	select
		rpad(seq		,05)		seq,
		rpad(parcelid		,15)		parcelid,
		rpad(addr_num		,10)		num,
		rpad(addr_pfx		,05)		pfx,
		rpad(addr_name		,20)		name,
		rpad(addr_type		,05)		type,
		rpad(addr_sfx		,05)		sfx,
		rpad(dcad		,20)		dcad,
		rpad(tenant		,30)		tenant,
		rpad(gisid		,10)		gisid,
		rpad(taxid		,10)		taxid,
		rpad(umsid		,10)		umsid
	from	jdeacutis.Temp_View
	where	rownum < 111
	;
