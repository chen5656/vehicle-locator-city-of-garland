--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

--	=====================================================================

--	execute	garland.CCS_GIS_Set_Intersections;

--	create or replace procedure garland.CCS_GIS_Set_Intersections	AS

	DECLARE

--	=====================================================================

	compile_only	integer	:= 01;
	total_update	integer	:= 0;

	title			varchar2(100);
	heading		varchar2(100);

	this_rowid		rowid;

cursor  Read_Address_Intersections	is

--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan set	statement_id = 'x'	into jdeacutis.plan_table for
--	=====================================================================

	select --+ use_hash (g)  index (x intersection_name1)
		g.rowid	GISrowid,
		x.rowid	X1rowid,
		y.rowid	X2rowid

	from	garland.Common_GIS	G, 
		garland.TrvehRCL		R,
		garland.Intersection	X,
		garland.Intersection	Y

	where	g.addr_name		= r.addr_name
	and	g.addr_type		= r.addr_type
	and	g.addr_pfx		= r.addr_pfx
	and	g.addr_sfx		= r.addr_sfx
	and	g.addr_num		between r.addr_lo and r.addr_hi

	and	x.intersect_id	like 'BB%'
	and	x.addr1_name	= r.addr_name
	and	x.addr1_type	= r.addr_type
	and	x.addr1_pfx		= r.addr_pfx
	and	x.addr1_sfx		= r.addr_sfx
	and	x.addr1_block	= trunc(r.addr_lo, -2)

	and	y.intersect_id	like 'BB%'
	and	y.addr1_name	= r.addr_name
	and	y.addr1_type	= r.addr_type
	and	y.addr1_pfx		= r.addr_pfx
	and	y.addr1_sfx		= r.addr_sfx
	and	y.addr1_block	= trunc(r.addr_hi, -2)

	and	x.addr2_name ||'.'|| x.addr2_type <> y.addr2_name ||'.'|| y.addr2_type 
	order by 1,2,3;

--	=====================================================================
нн--	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================

BEGIN
	if	compile_only > 0		then
		return;
	end if;

--	===========================================================================
	title := 'SET INTERSECT IDS  ';  dbms_output.put_line(title);
--	===========================================================================

for	Read in Read_Address_Intersections		Loop

	if	this_rowid is null
	or	this_rowid  < read.GISrowid	then

		this_rowid := read.GISrowid;

		update garland.Common_GIS	Set

		(intersect_id1, intersecton1)  = 
	(	select intersect_id,
		ltrim(rtrim(addr2_pfx ||' '|| addr2_name ||' '|| addr2_type ||' '|| addr2_sfx))
		from	garland.intersection	
		where	rowid = read.X1rowid	),

		(intersect_id2, intersecton2) = 
	(	select intersect_id,
		ltrim(rtrim(addr2_pfx ||' '|| addr2_name ||' '|| addr2_type ||' '|| addr2_sfx))
		from	garland.intersection	
		where	rowid = read.X2rowid	)

		where	rowid = read.GISrowid;

		total_update := total_update + 01;

	end if;

end loop;

	COMMIT;

	dbms_output.put_line ('Common GIS Updates = ' || total_update);

end;
