	set echo off;
	set timing off;
--	==============================================================================

	truncate table	plan_table;

--	analyze table	cdreladr			compute statistics;

--	analyze index	cdreladr_x_namnum		compute statistics;


--	===============================================================================
--	does not scan index only
--	cost = 12000
	explain plan	set statement_id = '01'		for

	select
--+ 	index(a)
-- 	index_ffs (a)
		addr_name,
		addr_num
	from	cdreladr	a;
--	==============================================================================




--	==============================================================================
	select * from explain_plan;
	select * from explain_indexed;
--	select * from explain_constraint;
--	select * from explain_table;
--	select * from explain_index;
--	select * from explain_analyze;
--	select * from explain_cost;
--	==============================================================================
	set echo on;

