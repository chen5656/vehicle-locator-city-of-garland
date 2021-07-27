	set echo off;
--	=============================================================================
--	Generate Intersection records from Corner table
--	=============================================================================

	select to_char(sysdate, 'Mon dd,yyyy  hh24:mi') || '  INSERT INTERSECTION' " "	from dual;

	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

	explain plan set statement_id = 'insert intersection'	into garland.plan_table	for
--	===========================================================================

	insert into	garland.Intersection

	select distinct
		trunc(c.street1_num, -2),
		r1.addr_pfx,
		r1.addr_name,
		r1.addr_type,
		r1.addr_sfx,

		trunc(c.street2_num, -2),
		r2.addr_pfx,
		r2.addr_name,
		r2.addr_type,
		r2.addr_sfx,

		'..', '..',									-- corner & twin compass
		null, 									-- node id
		intersection_id_seq.next_val,						-- intersection id

		null, null, null, null, null, null, null, null, null		-- regions

	from	garland.Corner		c,
		garland.Trvehrcl		r1,
		garland.Trvehrcl		r2

	where	c.road1_id	= r1.mslink
	and	c.road2_id	= r2.mslink

	and not exists
(
	select 'x'
	from	garland.Intersection	x

	where	x.addr1_name	= r1.addr_name
	and	x.addr1_type	= r1.addr_type
	and	x.addr1_pfx		= r1.addr_pfx
	and	x.addr1_sfx		= r1.addr_sfx
	and	x.addr1_block	= trunc(c.street1_num,-2)

	and	x.addr2_name	= r2.addr_name
	and	x.addr2_type	= r2.addr_type
	and	x.addr2_pfx		= r2.addr_pfx
	and	x.addr2_sfx		= r2.addr_sfx
	and	x.addr2_block	= trunc(c.street2_num,-2)
)
	;

--	===========================================================================
	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_constraint;
--	select * from garland.explain_column;
--	select * from garland.explain_analyze;

	ROLLBACK;
	commit;
	alter rollback segment rb1 offline;

	analyze table	garland.Intersection	compute statistics;

--	=============================================================================
	set echo on;

