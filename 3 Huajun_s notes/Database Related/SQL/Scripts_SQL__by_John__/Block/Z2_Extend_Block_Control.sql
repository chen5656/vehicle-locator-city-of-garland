	set echo		off;
	set fetchrows;
--	===========================================================================
--	Extend Block Control table with new records
--	===========================================================================

--	Z2

--	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

	explain plan set statement_id =  'extend BC'	into garland.plan_table	for
--	===========================================================================

--	select count(*)

	insert into	garland.block_control
	select 	all *	
	from		garland.block_control_vw;

--	===========================================================================
	select * from garland.explain_plan;

--	rollback;
	commit;
	alter rollback segment rb1 offline;

--	===========================================================================
	set echo		on;
	set fetchrows;


