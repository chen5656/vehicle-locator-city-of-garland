	set echo		off;
	set fetchrows;
--	===========================================================================
--	Add new Block table records from Block Control table
--	===========================================================================

--	J1

	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	===========================================================================
	explain plan set statement_id =  'new block id'	into garland.plan_table	for

	update	garland.Block_Control_vw

	set		block_id = block_id_seq.nextval
	
	where	block_id is null
	and	action = 'I';

--	===========================================================================
	explain plan set statement_id =  'new block'	into garland.plan_table	for

	insert into	garland.Block

	select c.addr_block, c.addr_pfx, c.addr_name, c.addr_type, c.addr_sfx,
		 c.block_id,   0,
		 c.start_lo, c.stop_lo,	c.stop_hi, c.counter

	from	garland.Block_Control_vw	c
	where	action = 'I'
	and	differ between 0 and 9;

--	===========================================================================
--	select * from garland.explain_plan;

	Rollback;
	commit;
	alter rollback segment rb1 offline;

--	===========================================================================
	set echo		on;
	set fetchrows;


