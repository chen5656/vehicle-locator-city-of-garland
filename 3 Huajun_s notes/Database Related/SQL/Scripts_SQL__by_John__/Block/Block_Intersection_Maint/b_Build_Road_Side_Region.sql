	set echo off;
--	=============================================================================
--	Build Road Side Region table from Radial Side & Specification tables
--	=============================================================================

	select to_char(sysdate, 'Mon dd,yyyy  hh24:mi') || '  BUILD ROAD SIDE REGION' " "	from dual;

	Truncate table	garland.Road_Side_Region	reuse storage;

	truncate table	garland.plan_table		reuse storage;

--	=============================================================================

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	=============================================================================
--	************************	1 Clone for each Region Type	************************
--	=============================================================================
	explain plan set statement_id = 'POLBEAT'		into garland.plan_table	for

	insert /*+ append */	into  garland.Road_Side_Region

	select	road_id, side, region_type, parity, region_id, count(*)		from
(
	select	ss.road_id,  ss.side,  sp.region_type,  ss.parity,	p.POLICE_BEAT	region_id

	from	garland.Specification sp,  garland.Radial_Side ss,  garland.trvehRCL r,  
		garland.cdrelADR a,	   garland.cdrelPAR p, 

	where	 sp.topic = 'REGION TYPE'   and   sp.region_name =		'POLICE BEAT'	      
   
	and	ss.road_id = r.mslink	  and ss.junction = 'F'  and  p.parcel_id = a.parcel_id 
	and	a.addr_name = r.addr_name and a.addr_type = r.addr_type  
	and	a.addr_pfx  = r.addr_pfx  and a.addr_sfx  = r.addr_sfx
	and	a.addr_num between r.addr_lo and r.addr_hi
)
	group by	road_id, side, region_type, parity, region_id;

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

	analyze table	garland.Road_Side_Region	compute statistics;

--	=============================================================================
	set echo on;
