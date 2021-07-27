
--	===========================================================================

	create or replace view	garland.Temp_View
(
		esri_node,
		road1_id,
		road2_id,

		addr1_name,
		addr1_type,
		addr2_name,
		addr2_type,

		addr1_pfx_count,
		addr1_sfx_count,
		addr2_pfx_count,
		addr2_sfx_count
)
	as	
	select
		item01, item02, item03,
		item04, item05, item06, item07,
		item08, item09, item10, item11
	from	garland.GIS_Objects;
	
--	===========================================================================
	
	truncate table	garland.GIS_Objects		reuse storage;

--	===========================================================================

	truncate table	garland.plan_table		reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	---------------------------------------------------------------------------
	explain plan set statement_id = 'put count'  into garland.plan_table   for

	insert	--+ append
	into		garland.temp_view

	select	c.esri_node,
			r1.addr_name,
			r1.addr_type,
			r2.addr_name,
			r2.addr_type,

			count(distinct r1.addr_pfx),
			count(distinct r1.addr_sfx),
			count(distinct r2.addr_pfx),
			count(distinct r2.addr_sfx)

	from		garland.Corner		c,
			garland.trvehRCL		r1,
			garland.trvehRCL		r2

	where		c.road1_id	= r1.mslink
	and		c.road2_id	= r2.mslink

	group by	c.esri_node,
			r1.addr_name,
			r1.addr_type,
			r2.addr_name,
			r2.addr_type;

--	---------------------------------------------------------------------------
	explain plan set statement_id = 'get count'  into garland.plan_table   for

	update	garland.Corner	c
	set	(	addr1_pfx_count, addr1_sfx_count, addr2_pfx_count, addr2_sfx_count ) = 
(
	select	addr1_pfx_count, addr1_sfx_count, addr2_pfx_count, addr2_sfx_count 

	from		garland.Temp_View		v,
			garland.trvehRCL		r1,
			garland.trvehRCL		r2

	where		c.esri_node 	= v.esri_node
	and		c.road1_id		= r1.mslink
	and		c.road2_id		= r2.mslink

	and		r1.addr_name	= v.addr1_name
	and		r1.addr_type	= v.addr1_type
	and		r2.addr_name	= v.addr2_name
	and		r2.addr_type	= v.addr2_type
	and		
);

--	---------------------------------------------------------------------------

	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_constraint;
--	select * from garland.explain_column;
--	select * from garland.explain_analyze;

--	===========================================================================

--	ROLLBACK;
	commit;
	alter rollback segment rb1 offline;

	analyze table	garland.Corner	compute statistics;

--	===========================================================================