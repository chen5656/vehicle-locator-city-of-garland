--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

--	execute	garland.CCS_GIS_Put_Intersect_ID;

	create or replace procedure garland.CCS_GIS_Put_Intersect_ID	AS

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
	title := 'PUT INTERSECT ID ';  dbms_output.put_line(title);
--	===========================================================================

	update	garland.Common_GIS		G
	set	  (	intersect_id1, intersect_id2  ) =
(
	select	min(item02), max(item03)
	from		garland.GIS_Objects		T
	where		item01 = rtrim(G.address_id)
);

	total_update := sql%rowcount;
	dbms_output.put_line ( 'Total Updates=' || total_update );

	Commit;

END;

