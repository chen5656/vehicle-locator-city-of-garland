--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

--	execute	garland.CCS_GIS_Update_Intersections;

	create or replace procedure garland.CCS_GIS_Update_Intersections	AS

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
	title := 'UPDATE INTERSECTIONS  ';  dbms_output.put_line(title);
--	===========================================================================

	update  garland.Common_GIS		G
	set	( intersecton1, intersecton2 ) = 
(
	select  
		ltrim(rtrim(x.addr2_pfx ||' '|| x.addr2_name ||' '|| x.addr2_type ||' '|| x.addr2_sfx)),
		ltrim(rtrim(y.addr2_pfx ||' '|| y.addr2_name ||' '|| y.addr2_type ||' '|| y.addr2_sfx))
	from	garland.intersection	X,
		garland.intersection	Y
	where	g.intersect_id1	= x.intersect_id
	and	g.intersect_id2	= y.intersect_id
);

	total_update := sql%rowcount;
	dbms_output.put_line ( 'Total Updates=' || total_update );

	Commit;

	DBMS_UTILITY.EXEC_DDL_STATEMENT ('Analyze table garland.Common_GIS compute statistics');

END;

