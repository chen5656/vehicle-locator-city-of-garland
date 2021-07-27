--	set echo off;
--	===========================================================================
	truncate table	garland.plan_table reuse storage;
--	insert into garland.plan_table(object_name,object_owner) values ( '' , '' );
--	analyze  table	garland.	compute statistics;

--	alter rollback segment rb1 online;
--	commit;
--	set transaction use rollback segment rb1;

	explain plan set statement_id =	'xxx'		into garland.plan_table	for
--	===========================================================================


--	===========================================================================
	commit;
	alter rollback segment rb1 offline;

	select * from garland.explain_plan;
--	select * from garland.explain_remote;

--	select * from garland.explain_indexed;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_constraint;
--	select * from garland.explain_column;

--	select * from garland.explains_indexed;
--	select * from garland.explains_table;
--	select * from garland.explains_index;
--	select * from garland.explains_constraint;
--	select * from garland.explains_column;

--	select * from garland.explain_analyze;
--	select * from garland.explains_analyze;
--	===========================================================================
--	set echo on;

