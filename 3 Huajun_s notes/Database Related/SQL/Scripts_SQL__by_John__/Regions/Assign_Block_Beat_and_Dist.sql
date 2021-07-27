	set echo 		off;
	set fetchrows;
	set stoponerror	on;
--	=================================================================================
--	ASSIGN POLICE BEAT TO BLOCK_SIDE
--	=================================================================================

--	=================================================================================
--	truncate table	garland.plan_table		reuse storage;
--	explain plan	set statement_id = 'beat'	into garland.plan_table	for
--	=================================================================================

	update garland.block_side			BB
	set	 police_beat = 
(
--		select count(*)							--  TEST
--		select min(addr_lo), max(addr_lo)				--  TEST

		select max(nvl(r.pol_beat,b.police_beat))

		from	garland.block_side		B,
			garland.trvehrcl			R

		where	r.addr_name	(+)	= b.addr_name	
		and	r.addr_type	(+)	= b.addr_type	
		and	r.addr_pfx	(+)	= b.addr_pfx	
		and	r.addr_sfx	(+)	= b.addr_sfx	
		and	r.addr_lo	(+)  <= b.addr_block	
		and	r.addr_hi	(+)  >= b.addr_block
		and	r.pol_beat  (+)  > 0

		and	b.rowid		= bb.rowid

		group by b.addr_name, b.addr_type, b.addr_pfx, b.addr_sfx, b.addr_block

--		having count(*) > 10						--  TEST
);

--	=================================================================================
--	explain plan	set statement_id = 'dist'	into garland.plan_table	for

--	ASSIGN POLICE DISTRICT TO BLOCK_SIDE

--	update	garland.Block_Side
--	set		police_district = garland.Assign_Beat_District (police_beat);

--	=================================================================================
--	select * from garland.explain_Plan;
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;

--	Rollback;
	Commit;

--	=================================================================================
	set echo 		off;
	set fetchrows;
