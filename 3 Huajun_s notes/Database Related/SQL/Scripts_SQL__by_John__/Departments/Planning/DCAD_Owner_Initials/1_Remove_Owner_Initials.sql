--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	400;
set pagesize	9999;
--	=====================================================================
--	Remove Initials from Owner_Names in garland.Temp_View
--	=====================================================================

--	=====================================================================
	truncate table	jdeacutis.plan_table	reuse storage;
--	=====================================================================
	explain plan set	statement_id = 'a'	into jdeacutis.plan_table for
--	=====================================================================

	update garland.Temp_View	B
	set	owner_names = 
(
	select
		 ltrim(substr(b.owner_names, 01, a.posn - 01))	||
		 substr(b.owner_names, a.posn + 03) 
	from
(	
	select 
		instr(translate(owner_names,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','XXXXXXXXXXXXXXXXXXXXXXXXXX'), ' X ') POSN
	from	garland.temp_view	
	where	instr(translate(owner_names,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','XXXXXXXXXXXXXXXXXXXXXXXXXX'), ' X ') > 0
)					A
	where	a.rowid = b.rowid
)
	where exists
(	
	select 'x'
	from	garland.temp_view	X
	where	instr(translate(owner_names,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','XXXXXXXXXXXXXXXXXXXXXXXXXX'), ' X ') > 0
	and	x.rowid = b.rowid
);

--	=====================================================================
	select * from jdeacutis.explain_Plan;
	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================

