--	UPDATE INTERSECTION



	set echo off;
--	=============================================================================
--	Update Intersection streets when they do not match Centerline streets
--	Place on temporary table for update of Intersection table
--	=============================================================================

	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

	explain plan set statement_id = 'update intersection'	into garland.plan_table	for
--	===========================================================================

	truncate table	garland.GIS_Objects	reuse storage;

	insert into	garland.temp_view

	select
		x.intersect_id,

		c.trunc(street1_num, -2),
		r1.addr_pfx,
		r1.addr_name,
		r1.addr_type,
		r1.addr_sfx,

		c.trunc(street2_num, -2),
		r2.addr_pfx,
		r2.addr_name,
		r2.addr_type,
		r2.addr_sfx,

		x.road1_id,
		x.side1,
		x.road2_id,
		x.side2,
		x.rowid
	
	from	garland.Intersection	x,
		garland.Corner		c,
		garland.Trvehrcl		r1,
		garland.Trvehrcl		r2

	where x.intersect_id	= c.intersect_id

	and	x.road1_id		= r1.mslink
	and	x.road2_id		= r2.mslink

	and not
(
		x.addr1_name	= r1.addr_name
	and	x.addr1_type	= r1.addr_type
	and	x.addr1_pfx		= r1.addr_pfx
	and	x.addr1_sfx		= r1.addr_sfx

	and	x.addr2_name	= r2.addr_name
	and	x.addr2_type	= r2.addr_type
	and	x.addr2_pfx		= r2.addr_pfx
	and	x.addr2_sfx		= r2.addr_sfx
);

--	===========================================================================
	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_constraint;
--	select * from garland.explain_column;
--	select * from garland.explain_analyze;

	commit;
	alter rollback segment rb1 offline;

	analyze table	garland.GIS_Objects	compute statistics;

--	=============================================================================
	set echo on;



