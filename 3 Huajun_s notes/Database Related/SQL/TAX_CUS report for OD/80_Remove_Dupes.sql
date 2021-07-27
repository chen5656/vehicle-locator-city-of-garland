--	============================================================
	select * from viewer.me;
--	BEGIN  SERVER USER  SERVER USER  SERVER USER  SERVER USER END;
set	TIMING		ON;
set	sqlblanklines	on;
set	serveroutput	on	size 99999;
set	define		off;
set	linesize		1000;
set	pagesize		50000;
--	sqldeveloper: TOOLS > PREFERENCES > WORKSHEET > max rows to print
--	============================================================
--	execute jdeacutis.show_source	('xxx','garland','');
--	execute jdeacutis.show_error	('xxx','garland','');
--	execute jdeacutis.show_table_column	(' ', ' ', ' ');
--	execute jdeacutis.show_index_column	(' ', ' ', ' ');
--	execute jdeacutis.show_view		(' ', ' ', ' ');
--	alter session set nls_date_format = 'yyyy-mm-dd hh24:mi:ss';  
--	EXECUTE jdeacutis.TEST_PROC;
--	CREATE or replace procedure jdeacutis.TEST_PROC  as
--	DECLARE
--	============================================================

--	============================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan set	statement_id = 'x'	into jdeacutis.plan_table for
--	============================================================

	DELETE	from jdeacutis.Temp_View	A
	where	rowid in

--	select count(*) from

(
 	select	b.rowid 
	from	jdeacutis.Temp_View		B,

(	select	addr_num, addr_pfx, addr_name, addr_type, addr_sfx,
		min(rowid) recid 
	from	jdeacutis.Temp_View		C
	group by addr_num, addr_pfx, addr_name, addr_type, addr_sfx having count(*) > 1
)							C
	where	b.addr_name		= c.addr_name
	and	b.addr_type		= c.addr_type
	and	b.addr_pfx		= c.addr_pfx
	and	b.addr_sfx		= c.addr_sfx
	and	b.addr_num		= c.addr_num
	and	b.rowid	 > c.recid
);

--	COMMIT;

--	============================================================
--	select * from jdeacutis.explain_Plan;
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	============================================================
