	set echo		off;
--	set termout		off;
	set charwidth	200;
--	====================================================================================
--	Clone script by substituting place holders in SCRIPT table
--	with different sets of values in CASE table
--	====================================================================================

	variable	case_id		varchar2(80);
	variable	script_id		varchar2(80);

	execute	:case_id		:= 'UTILITY CONVERT';		-- SPECIFY
	execute	:script_id		:= 'UTILITY INDEX';		-- SPECIFY

--	========================================================================

	analyze table	garland.clone_script		compute statistics;
	analyze table	garland.clone_case		compute statistics;

	select count(*) from garland.clone_script;	
	select count(*) from garland.clone_case;		

--	========================================================================

	spool c:\deacutis\scripts\execute.sql;
	spool off;
	spool c:\deacutis\scripts\execute.sql;

--	--------------------------------------------------------------------

--	truncate table	plan_table		reuse storage;
--	explain plan	set statement_id = 'clone'	for

	select
		replace (
		replace (
		replace (
		replace (
		replace (
		replace (
		replace (
		replace (

		rtrim(script_line)

		,'===AAA===', rtrim(item_A))
		,'===BBB===', rtrim(item_B))
		,'===CCC===', rtrim(item_C))
		,'===DDD===', rtrim(item_D))
		,'===EEE===', rtrim(item_E))
		,'===FFF===', rtrim(item_F))
		,'===GGG===', rtrim(item_G))
		,'===HHH===', rtrim(item_H))

	" "
	from
(
	select	s.*, c.*
	from		garland.clone_script	s,
			garland.clone_case	c

	where		s.script_id		= :script_id
	and		c.case_id		= :case_id
	order by	c.item_A, s.script_seq	
);

--	--------------------------------------------------------------------
	
--	select * from explain_plan;

	spool off;

--	@c:\deacutis\scripts\Execute.sql	--	CAUTION	<<<<<<<<<<<<<<<

--	=====================================================================
	set echo		on;
	set termout		on;
	set charwidth;
