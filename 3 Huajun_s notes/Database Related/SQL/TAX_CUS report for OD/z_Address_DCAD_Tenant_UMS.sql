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

--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan set	statement_id = 'x'	into jdeacutis.plan_table for
--	=====================================================================

	select count(*) from (

	select 
		min(a.parcel_id) ||';'||
		a.addr_num||';'||a.addr_pfx||';'||a.addr_name||';'||a.addr_type||';'||a.addr_sfx||';;'|| 
		min(ltrim(u.first_name))||' '|| min(ltrim(u.last_name))||';'||
		min(a.segment_id)||';;'||
		min(u.location_no)||';'||
		' '
	from	garland.adrResult_UMS_Location	A,
		garland.Common_UMS			U
	where	a.rec_key = u.location_no
	and	a.verify_code = 55
	and	ltrim(a.addr_unit1) is null
	group by a.addr_name, a.addr_type, a.addr_pfx, a.addr_sfx, a.addr_num 
);

--	=====================================================================
--	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================
