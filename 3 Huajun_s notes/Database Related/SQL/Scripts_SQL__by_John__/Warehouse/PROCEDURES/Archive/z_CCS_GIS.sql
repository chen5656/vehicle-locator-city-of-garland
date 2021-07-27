--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;
set pagesize	9999;
--	=====================================================================

--	execute	garland.CCS_GIS;

	create or replace procedure garland.CCS_GIS		as

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

--	=================================================================================
	title := '***  CCS GIS ***  ';
	dbms_output.put_line(title);
--	=================================================================================

	garland.CCS_GIS_Build_Common_GIS;

	garland.CCS_GIS_Remove_Dupe;

	garland.CCS_GIS_Get_Intersect_ID;

	garland.CCS_GIS_Put_Intersect_ID;

	garland.CCS_GIS_Update_Intersections;

--	=================================================================================

END;

