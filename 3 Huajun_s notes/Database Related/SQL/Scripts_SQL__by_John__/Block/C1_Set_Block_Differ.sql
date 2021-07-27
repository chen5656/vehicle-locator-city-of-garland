	set echo		off;
	set fetchrows;
--	===========================================================================
--	set Differ column in Block_Control
--	===========================================================================

--	C1

	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;


--	===========================================================================
--	I N S E R T S
--	===========================================================================

--	===========================================================================
--	new name insert
--	===========================================================================
	explain plan set statement_id =  'diff03'	into garland.plan_table	for

	update garland.Block_Control_vw	v
	set	 differ = '03'
	where	 upper(action) = 'I'

	and	 not exists
(
	select 'x'
	from	 garland.block
	where	 addr_name = v.addr_name
);

--	===========================================================================
--	new street insert
--	===========================================================================
	explain plan set statement_id =  'diff02'	into garland.plan_table	for

	update garland.Block_Control_vw	v
	set	 differ = '02'
	where	 upper(action) = 'I'

	and	 exists
(
	select 'x'
	from	 garland.block		
	where	 addr_name = v.addr_name
)
	and not exists
(
	select 'x'
	from	 garland.block
	where	 addr_name	= v.addr_name
	and	 addr_type	= v.addr_type
	and	 addr_pfx	= v.addr_pfx
	and	 addr_sfx	= v.addr_sfx
);

--	===========================================================================
--	new block insert
--	===========================================================================
	explain plan set statement_id =  'diff01'	into garland.plan_table	for

	update garland.Block_Control_vw	v
	set	 differ = '01'
	where	 upper(action) = 'I'

	and	 exists
(
	select 'x'
	from	 garland.block		
	where	 addr_name = v.addr_name
)

	and exists
(
	select 'x'
	from	 garland.block
	where	 addr_name	= v.addr_name
	and	 addr_type	= v.addr_type
	and	 addr_pfx	= v.addr_pfx
	and	 addr_sfx	= v.addr_sfx
)

	and not exists
(
	select 'x'
	from	 garland.block
	where	 addr_name	= v.addr_name
	and	 addr_type	= v.addr_type
	and	 addr_pfx	= v.addr_pfx
	and	 addr_sfx	= v.addr_sfx
	and	 addr_block	= v.addr_block
);


--	===========================================================================
--	U P D A T E S
--	===========================================================================

--	===========================================================================
--	new name update
--	===========================================================================
	explain plan set statement_id =  'diff13'	into garland.plan_table	for

	update garland.Block_Control_vw	v
	set	 differ = '13'
	where	 upper(action) = 'U'

	and	 not exists
(
	select 'x'
	from	 garland.block
	where	 addr_name = v.addr_name
);

--	===========================================================================
--	new street update
--	===========================================================================
	explain plan set statement_id =  'diff12'	into garland.plan_table	for

	update garland.Block_Control_vw	v
	set	 differ = '12'
	where	 upper(action) = 'U'

	and	 exists
(
	select 'x'
	from	 garland.block		
	where	 addr_name = v.addr_name
)
	and not exists
(
	select 'x'
	from	 garland.block
	where	 addr_name	= v.addr_name
	and	 addr_type	= v.addr_type
	and	 addr_pfx	= v.addr_pfx
	and	 addr_sfx	= v.addr_sfx
);

--	===========================================================================
--	new block update
--	===========================================================================
	explain plan set statement_id =  'diff11'	into garland.plan_table	for

	update garland.Block_Control_vw	v
	set	 differ = '11'
	where	 upper(action) = 'U'

	and	 exists
(
	select 'x'
	from	 garland.block		
	where	 addr_name = v.addr_name
)

	and exists
(
	select 'x'
	from	 garland.block
	where	 addr_name	= v.addr_name
	and	 addr_type	= v.addr_type
	and	 addr_pfx	= v.addr_pfx
	and	 addr_sfx	= v.addr_sfx
)
	and not exists
(
	select 'x'
	from	 garland.block
	where	 addr_name	= v.addr_name
	and	 addr_type	= v.addr_type
	and	 addr_pfx	= v.addr_pfx
	and	 addr_sfx	= v.addr_sfx
	and	 addr_block	= v.addr_block
);

--	===========================================================================
	select * from garland.explain_plan;

	rollback;
	commit;
	alter rollback segment rb1 offline;

--	===========================================================================
	set echo		on;
	set fetchrows;


