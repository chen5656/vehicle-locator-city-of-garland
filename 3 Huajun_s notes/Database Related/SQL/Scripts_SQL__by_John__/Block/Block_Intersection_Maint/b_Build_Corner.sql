	set echo off;
--	=============================================================================
--	Build Corner table from Radial Sides
--	=============================================================================

	select to_char(sysdate, 'Mon dd,yyyy  hh24:mi') || '  BUILD CORNER' " "	from dual;

--	Truncate table	garland.Corner	reuse storage;

--	=============================================================================
	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

	explain plan set statement_id = 'corner'		into garland.plan_table	for
--	===========================================================================

	insert  --+ append
	into	  garland.Corner

	select distinct
		s1.road_id,
		s2.road_id,
		null,				-- intersection id
		s1.side, 
		s2.side, 
		s1.junction,
		s2.junction,

		decode (s1.junction, 'F', r1.addr_lo, r1.addr_hi),	-- street1 num
		decode (s2.junction, 'F', r2.addr_lo, r2.addr_hi),	-- street2 num	

		s1.esri_node,
		null,				-- region type
		null				-- region id

	from	garland.Radial_Side	s1,
		garland.Radial_Side	s2,
		garland.trvehRCL		r1,
		garland.trvehRCL		r2

	where	s1.esri_node = s2.esri_node

	and	s1.road_id	 = r1.mslink
	and	s2.road_id	 = r2.mslink

	and	s1.side 	= 'L'	
	and	s2.side 	= 'R'

	and	r1.addr_name ||'.'|| r1.addr_type <> r2.addr_name ||'.'|| r2.addr_type
	and	(s1.x_vector * s2.y_vector) - (s2.x_vector * s1.y_vector) > 0	-- vector cross product
	;

--	===========================================================================
	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_constraint;
--	select * from garlandF.explain_column;
--	select * from garland.explain_analyze;

	commit;
	alter rollback segment rb1 offline;

	analyze table	garland.Corner		compute statistics;

--	=============================================================================
	set echo on;


