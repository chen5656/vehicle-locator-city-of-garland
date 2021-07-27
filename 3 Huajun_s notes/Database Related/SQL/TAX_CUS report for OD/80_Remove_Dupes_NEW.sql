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
		rpad(addr_num	,20),
		rpad(addr_pfx	,20),
		rpad(addr_name	,20),
		rpad(addr_type	,20),
		rpad(addr_sfx	,20),
		rpad(tenant		,20),
		rpad(dcad		,20)

	from	jdeacutis.Temp_View
	where (addr_num, addr_pfx, addr_name, addr_type, addr_sfx )		IN
(
	select addr_num, addr_pfx, addr_name, addr_type, addr_sfx
	from	jdeacutis.Temp_View
	group by  addr_pfx, addr_name, addr_type, addr_sfx,addr_num
	having count(*) > 1
);

--	=====================================================================

	delete from jdeacutis.Temp_View
	where	dcad is null
	and (addr_num, addr_pfx, addr_name, addr_type, addr_sfx )		IN
(
	select addr_num, addr_pfx, addr_name, addr_type, addr_sfx
	from	jdeacutis.Temp_View
	group by  addr_pfx, addr_name, addr_type, addr_sfx,addr_num
	having count(*) > 1
);

	COMMIT;

--	=====================================================================

--	============================================================
	truncate table	jdeacutis.plan_table	reuse storage;
	explain plan set	statement_id = 'x'	into jdeacutis.plan_table for
--	============================================================

	delete from jdeacutis.Temp_View 	A
	where	rowid in
(
 	select b.rowid 
	from	 jdeacutis.Temp_View		B,

(	select addr_num, addr_pfx, addr_name, addr_type, addr_sfx, min(rowid) recid 
	from	jdeacutis.Temp_View	
	group by addr_num, addr_pfx, addr_name, addr_type, addr_sfx having count(*) > 1		)	C

	where	b.addr_name		= c.addr_name
	and	b.addr_num		= c.addr_num
	and	b.addr_type		= c.addr_type
	and	b.addr_pfx		= c.addr_pfx
	and	b.addr_sfx		= c.addr_sfx
	and	b.rowid	> c.recid
);
--	============================================================
	select * from jdeacutis.explain_Plan;
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	============================================================


--	=====================================================================
