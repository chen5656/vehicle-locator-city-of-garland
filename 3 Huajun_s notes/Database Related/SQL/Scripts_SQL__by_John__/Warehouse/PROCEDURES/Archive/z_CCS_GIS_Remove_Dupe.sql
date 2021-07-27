--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

--	execute	garland.CCS_GIS_Remove_Dupe;

	create or replace procedure garland.CCS_GIS_Remove_Dupe		AS

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
	title := 'REMOVE DUPE GIS  ';  dbms_output.put_line(title);
--	===========================================================================

	Delete from	garland.Common_GIS
	where	(address_id, road_id)	in
(
	select g.address_id, g.road_id
	from	garland.Common_GIS	G,
(
	select address_id, max(road_id) road_id
	from	garland.Common_GIS
	group by address_id
	having count(distinct road_id) > 01
)						M
	where	g.address_id = m.address_id
	and	g.road_id	 < m.road_id
);

	total_delete := sql%rowcount;
	dbms_output.put_line ( 'Total Delete=' || total_delete);

	COMMIT;

END;

