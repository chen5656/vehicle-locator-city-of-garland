	set echo off;
--	=============================================================================
--	Extend Road Side Regioin table with new Radial Side regions
--	=============================================================================

	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

	explain plan set statement_id = 'update seg region1'	into garland.plan_table	for
--	==========================================================================

	insert into	garland.Road_Side_Region

	select	road_id,	 side,	region_type,	region_id,		parity,

			0,			--  priority
			count(*)		--  parcel count
	from
(
	select	s.road_id,	s.side,	s.region_type, 	s.region_id,	s.parity,

	from	garland.Radial_Side	s,
		garland.trvehRCL		r,  
		garland.cdrelADR		a,	   
		garland.cdrelPAR		p 

	where	ss.road_id	= r.mslink	  
	and	ss.junction = 'F'  
	and   p.parcel_id = a.parcel_id 

	and	a.addr_name = r.addr_name 
	and	a.addr_type = r.addr_type  
	and	a.addr_pfx  = r.addr_pfx  
	and	a.addr_sfx	= r.addr_sfx
	and	a.addr_num between r.addr_lo and r.addr_hi

	and	(	s.road_id,	s.side,	s.region_type,	s.region_id	)	in
(
	select	road_id,	side,		region_type,	region_id	from garland.Radial_Side
	minus
	select	road_id,	side,		region_type,	region_id	from garland.Rode_Side_Region
)
)
	group by	road_id, side, region_type, region_id, parity;

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

	analyze table	garland.Segment_Side_Region		compute statistics;

--	=============================================================================
	set echo on;




