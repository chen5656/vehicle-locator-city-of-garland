--	BUILD Radial SIDE


	set echo off;
--	=============================================================================
--	Build Radial Side table from Centerline & ESRI extracts
--	=============================================================================

--	Truncate table	garland.Radial_Side	reuse storage;

--	=============================================================================

	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	===========================================================================
	explain plan set statement_id = 'Radial'	into garland.plan_table	for

	select
	mslink,
	'L', 'F',
	mod(addr_LEFT_FROM, 2),
	F.node_num,
	T.x_coord - F.x_coord,
	T.y_coord - F.y_coord,
	null,					-- corner compass
	null,					-- region type
	null					-- region id

	from	garland.Trvehrcl		r,
		garland.Esri_Edge		e,
		garland.Esri_Node		f,
		garland.Esri_Node		t

	where	e.road_id		= r.mslink
	and	e.from_node		= f.node_num
	and	e.to_node		= t.node_num

--	===========================================================================
	union

	select
	mslink,
	'R', 'F',
	mod(addr_RGHT_FROM, 2),
	F.node_num,
	T.x_coord - F.x_coord,
	T.y_coord - F.y_coord,
	null,					-- corner compass
	null,					-- region type
	null					-- region id

	from	garland.Trvehrcl		r,
		garland.Esri_Edge		e,
		garland.Esri_Node		f,
		garland.Esri_Node		t

	where	e.road_id		= r.mslink
	and	e.from_node		= f.node_num
	and	e.to_node		= t.node_num

--	===========================================================================
	union

	select
	mslink,
	'L', 'T',
	mod(addr_LEFT_TO, 2),
	T.node_num,
	F.x_coord - T.x_coord,
	F.y_coord - T.y_coord,
	null,					-- corner compass
	null,					-- region type
	null					-- region id

	from	garland.Trvehrcl		r,
		garland.Esri_Edge		e,
		garland.Esri_Node		f,
		garland.Esri_Node		t

	where	e.road_id		= r.mslink
	and	e.from_node		= f.node_num
	and	e.to_node		= t.node_num

--	===========================================================================
	union

	select
	mslink,
	'R', 'T',
	mod(addr_RGHT_TO, 2),
	T.node_num,
	F.x_coord - T.x_coord,
	F.y_coord - T.y_coord,
	null,					-- corner compass
	null,					-- region type
	null					-- region id

	from	garland.Trvehrcl		r,
		garland.Esri_Edge		e,
		garland.Esri_Node		f,
		garland.Esri_Node		t

	where	e.road_id		= r.mslink
	and	e.from_node		= f.node_num
	and	e.to_node		= t.node_num

--	===========================================================================
	;
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


	analyze table	garland.Radial_Side	compute statistics;

--	=============================================================================
	set echo on;

