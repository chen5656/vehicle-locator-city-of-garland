--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

--	execute	garland.CCS_GIS_Get_Intersect_ID;

	create or replace procedure garland.CCS_GIS_Get_Intersect_ID	AS

--	DECLARE

--	=====================================================================

	compile_only	integer	:= 0;

	total_select	integer	:= 0;
	total_insert	integer	:= 0;
	total_update	integer	:= 0;
	total_delete	integer	:= 0;

	title			varchar2(100);
	heading		varchar2(100);

BEGIN
	if	compile_only > 0		then
		return;
	end if;

--	===========================================================================
	title := 'GET INTERSECT ID  ';  dbms_output.put_line(title);
--	===========================================================================

	DBMS_UTILITY.EXEC_DDL_STATEMENT ('Truncate table garland.GIS_OBJECTS reuse storage');

	insert	--+ append
	into		garland.GIS_Objects  (item01, item02, item03)

	select	--+ use_hash (g)  index (x intersection_name1)
		g.address_id,
		x.intersect_id,
		y.intersect_id
	from	garland.Common_GIS	G, 
		garland.TrvehRCL		R1,
		garland.TrvehRCL		R2,
		garland.Intersection	X,
		garland.Intersection	Y
	where	to_number(g.road_id)	= r1.mslink
	and	to_number(g.road_id)	= r2.mslink
	and	x.addr1_name ||'.' || x.addr2_name <> y.addr1_name ||'.' || y.addr2_name 
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
	and	y.addr2_pfx		= r2.addr_pfx
	and	y.addr2_name	= r2.addr_name
	and	y.addr2_type	= r2.addr_type
	and	y.addr2_sfx		= r2.addr_sfx
	and	y.addr2_block	= trunc(r2.addr_hi, -2)
	;

	total_insert := sql%rowcount;
	dbms_output.put_line ( 'Total Inserts=' || total_insert );

	Commit;

	DBMS_UTILITY.EXEC_DDL_STATEMENT ('Analyze table garland.GIS_OBJECTS compute statistics');

END;

