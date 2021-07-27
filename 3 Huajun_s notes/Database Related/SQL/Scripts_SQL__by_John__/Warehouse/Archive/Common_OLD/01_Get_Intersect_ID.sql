--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
-- set serveroutput	on	size 99999;
-- alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';  
-- select sysdate from dual;	
--	================================================================
--	===========================================================================
--	Get nearest Intersection ID's to Common GIS address
--	===========================================================================

	Truncate table	garland.GIS_Objects	reuse storage;

--	===========================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan set statement_id =  'xxx'	into garland.plan_table	for
--	===========================================================================

	insert	--+ append
	into		garland.GIS_Objects  (item01, item02, item03)
	select	--+ use_hash (g)  index (x intersection_name1)
		g.address_id,
--		a.mslink,
		x.intersect_id,
		y.intersect_id
--		g.addr_num,  g.addr_pfx,   g.addr_name,  g.addr_type, g.addr_sfx, chr(10),
--		x.addr2_pfx, x.addr2_name, x.addr2_type, x.addr2_sfx, chr(10),
--		y.addr2_pfx, y.addr2_name, y.addr2_type, y.addr2_sfx, chr(10)
	from	JDEACUTIS.Common_GIS	g, 
		garland.TrvehRCL		r1,
		garland.TrvehRCL		r2,
		garland.Intersection	x,
		garland.Intersection	y
	where	to_number(g.road_id)	= r1.mslink
	and	to_number(g.road_id)	= r2.mslink
	and	x.addr1_name ||'.' || x.addr2_name <> y.addr1_name ||'.' || y.addr2_name 	-- feb 2006
	and	g.addr_pfx		= r1.addr_pfx
	and	g.addr_name		= r1.addr_name
	and	g.addr_type		= r1.addr_type
	and	g.addr_sfx		= r1.addr_sfx
	and	g.addr_num		between r1.addr_lo and r1.addr_hi
	and	x.intersect_id	like 'BB%'
	and	x.addr1_pfx		= r1.addr_pfx
	and	x.addr1_name	= r1.addr_name
	and	x.addr1_type	= r1.addr_type
	and	x.addr1_sfx		= r1.addr_sfx
	and	x.addr1_block	= trunc(r1.addr_lo, -2)
	and	y.intersect_id	like 'BB%'
	and	y.addr1_pfx		= r2.addr_pfx
	and	y.addr1_name	= r2.addr_name
	and	y.addr1_type	= r2.addr_type
	and	y.addr1_sfx		= r2.addr_sfx
	and	y.addr1_block	= trunc(r2.addr_hi, -2)
	;

	Commit;

	Analyze table	garland.GIS_Objects	compute statistics;	

--	===========================================================================
--	select * from garland.explain_Plan;
--	insert into   garland.plan_table (object_owner, object_name) values ('GARLAND', '');
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;
--	===========================================================================
