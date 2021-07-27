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

----	=====================================================================
set	echo			off;
set	timing		off;
set	sqlblanklines	on;
set	serveroutput	on	size 99999;
set	linesize		1000;
set	pagesize		9999;
--	execute jdeacutis.show_table_column	('', '', '');
--	execute jdeacutis.show_index_column	('', '', '');
--	execute jdeacutis.show_source		('', '', '');
--	execute jdeacutis.show_error		('', '', '');
--	alter session	set nls_date_format = 'yyyy-mm-dd hh24:mi';   --'DD-MON-RR';
--	=====================================================================

--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan set	statement_id = 'x'	into jdeacutis.plan_table for
--	=====================================================================
	
	
--	select 'Laura Dupes' " ", count(*) from (

	select count(*) from (
--	select * from (

	select 
		rec_key	CUS_ID, 
		parcel_id,
		segment_id	GIS_ID, 
		u.addr_num, u.addr_pfx, u.addr_name, u.addr_type, u.addr_sfx 
	from garland.adrResult_UMS_Location	U,
	     garland.common_ums			C
	where u.rec_key = c.location_no
	and segment_id in
    (
	select segment_id from garland.adrREsult_UMS_Location 
	where ltrim(addr_unit1) is null and verify_code = 55 
	group by segment_id having count(*) > 1
    )
	order by segment_id, rec_key

	);

--	=====================================================================
--	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================

	select 'Common UMS Dupes' " ", counter, count(*) 
	from
(
	select count(*) counter
	from garland.common_ums
	group by location_no
	having count(*) > 1
)
	group by counter;

--	=====================================================================
