	set echo		off;
	set fetchrows;
--	=========================================================================================
--	Set repl_ columns in Block Control
--	Set range columns in Block Control
--	=========================================================================================

--	F1

	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	===========================================================================
--	completion of replacement columns

	explain plan set statement_id =  'repl fill'	into garland.plan_table	for

	update garland.Block_Control_vw
	set	repl_block		= nvl(repl_block,addr_block),
		repl_pfx		= nvl(repl_pfx,  addr_pfx),
		repl_name		= nvl(repl_name, addr_name),
		repl_type		= nvl(repl_type, addr_type),
		repl_sfx		= nvl(repl_sfx,  addr_sfx)
	where	action = 'U';

--	===========================================================================
--	Set Insert Range parameters

	explain plan set statement_id =  'insert range'	into garland.plan_table	for

	update garland.Block_Control_vw		c	
	set	(start_lo, stop_lo, stop_hi, counter) = 
(
	select min(addr_lo), max(addr_lo), max(addr_hi), count(distinct addr_lo ||'.'|| addr_hi)
	from	garland.trvehrcl			t

	where	t.addr_name		= c.addr_name
	and	t.addr_type		= c.addr_type
	and	t.addr_pfx		= c.addr_pfx
	and	t.addr_sfx		= c.addr_sfx
	and	trunc(t.addr_lo, -2)	<= c.addr_block
	and	trunc(t.addr_hi, -2)	>= c.addr_block
)
	where	upper(action) = 'I';

--	===========================================================================
--	Set Update Range parameters

	explain plan set statement_id =  'update range'	into garland.plan_table	for

	update garland.Block_Control_vw		c	
	set	(start_lo, stop_lo, stop_hi, counter) = 
(
	select min(addr_lo), max(addr_lo), max(addr_hi), count(distinct addr_lo ||'.'|| addr_hi)
	from	garland.trvehrcl			t

	where	t.addr_name		= c.repl_name
	and	t.addr_type		= c.repl_type
	and	t.addr_pfx		= c.repl_pfx
	and	t.addr_sfx		= c.repl_sfx
	and	trunc(t.addr_lo, -2)	<= c.repl_block
	and	trunc(t.addr_hi, -2)	>= c.repl_block
)
	where	action = 'U';

--	===========================================================================
--	select * from garland.explain_plan;

	Rollback;
	commit;
	alter rollback segment rb1 offline;

--	===========================================================================
	set echo		on;
	set fetchrows;
