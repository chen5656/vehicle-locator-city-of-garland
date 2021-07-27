--	UPDATE QUAL COUNTS

	set echo off;
--	=============================================================================
--	Update Corner with counts of distinct prefix & suffix for street1 & street2
--	=============================================================================

	select to_char(sysdate, 'Mon dd,yyyy  hh24:mi') || '  UPDATE QUAL COUNTS' " "	from dual;

	Truncate table			garland.GIS_Objects	reuse storage;

	create or replace view		garland.Temp_View		
(
	esri_node,
	addr1_name, addr1_type, addr2_name, addr2_type,
	addr1_pfx_count, addr1_sfx_count, addr2_pfx_count, addr2_sfx_count
)
	as

	select	item01,
			item02, item03, item04, item05, 
			item06, item07, item08, item09 

	from		garland.GIS_Objects;

--	=============================================================================

	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	===========================================================================
	explain plan set statement_id = 'qual count'	into garland.plan_table	for

	insert --+ append
	into	garland.temp_view

	select	c.esri_node,
			r1.addr1_name, r1.addr1_type,
			r2.addr1_name, r2.addr1_type,
			count(distinct r.addr1_pfx),
			count(distinct r.addr1_sfx),
			count(distinct r.addr1_pfx),
			count(distinct r.addr1_sfx)

	from		garland.Corner		c,
			garland.trvehRCL		r1,
			garland.trvehRCL		r2

	where		c.road1_id		= r1.mslink
	and		c.road2_id		= r2.mslink

	group by	c.esri_node,
			r1.addr1_name, r1.addr1_type,
			r2.addr1_name, r2.addr1_type;

--	===========================================================================
	explain plan set statement_id = 'update count'	into garland.plan_table	for

	update	garland.Corner		c
	set		( addr1_pfx_count, addr1_sfx_count, addr2_pfx_count, addr2_sfx_count ) =
(
	select	  addr1_pfx_count, addr1_sfx_count, addr2_pfx_count, addr2_sfx_count  

	from		garland.temp_view		v,
			garland.trvehRCL		r1,
			garland.trvehRCL		r2

	where		v.esri_node		= rtrim(c.esri_node)
	and		v.addr1_name	= r1.addr_name
	and		v.addr1_type	= r1.addr_type
	and		v.addr2_name	= r2.addr_name
	and		v.addr2_type	= r2.addr_type
	and		c.road1_id		= r1.mslink
	and		c.road2_id		= r2.mslink
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



