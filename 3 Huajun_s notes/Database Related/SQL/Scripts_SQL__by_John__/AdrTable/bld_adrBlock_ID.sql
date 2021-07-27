	set echo	off;
--	===========================================================================
--	D O   N O T   R E R U N   S E Q U E N C E   D E F I N I T I O N

--	\deacutis\scripts\block\block_id_seq.sql;	

--	===========================================================================
	truncate table	garland.plan_table	reuse storage;

--	alter rollback segment rb1 online;
--	commit;
--	set transaction use rollback segment rb1;

--	===========================================================================

--	explain plan set statement_id = 'xxx'  into garland.plan_table   for

	update garland.adrBlock
	set	block_id	= block_id_seq.nextval

	where	block_id = 999999		--	V E R I F Y
	;

--	select * from garland.explain_plan;

--	===========================================================================

--	ROLLBACK;
	commit;
--	alter rollback segment rb1 offline;

	analyze table	garland.BLOCK	compute statistics;

--	===========================================================================
	set echo	on;
