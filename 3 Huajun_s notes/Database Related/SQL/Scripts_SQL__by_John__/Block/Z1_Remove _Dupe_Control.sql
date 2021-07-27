	set echo		off;
	set fetchrows;
--	===========================================================================
--	Remove duplicate pending block controls from extract
--	Exists in block_control.  Exists in extract.
--	===========================================================================

--	Z1

	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

	explain plan set statement_id =  'add ctl'	into garland.plan_table	for
--	===========================================================================

	delete from	 garland.Block_Control_vw	t	
	where exists
(
	select 'x'
	from 	garland.Block_Control	
	where	 action 	= lower(action)
	and	 addr_name	= t.addr_name	 
	and	 addr_type	= t.addr_type	 
	and	 addr_pfx 	= t.addr_pfx	 
	and	 addr_sfx 	= t.addr_sfx	 
	and	 addr_block	= t.addr_block 

	and	 action	= lower(action)
	and	 date_add 	< t.date_add
);

--	===========================================================================
	select * from garland.explain_plan;

	Rollback;
	commit;
	alter rollback segment rb1 offline;

--	===========================================================================

--	@c:\deacutis\scripts\block\Temp2_Block_Control.sql;		-- Define View
--	truncate table	gis_temp2		reuse storage;		-- Empty View 

--	select 	block_id, null, null, 'd', null, 
--			addr_block, addr_pfx, addr_name, addr_type,	addr_sfx,
--			null,	   null,	 null,	null,		null,
--			'B', sysdate	  	

--	===========================================================================
	set echo		on;
	set fetchrows;

--	===========================================================================


