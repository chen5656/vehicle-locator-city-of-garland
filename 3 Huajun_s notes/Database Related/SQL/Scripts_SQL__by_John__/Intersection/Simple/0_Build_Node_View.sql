--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;
set pagesize	9999;
--	===========================================================================================
--	0_Build_Node_View
--	===========================================================================================
/*
	create or replace view	garland.Temp_View1	as
	select	item01	node_id,
			item02	x_coord,
			item03	y_coord
	from		garland.GIS_Temp1;
*/		
--	===========================================================================================

	select 'NODE BUILD  ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;

	truncate table	garland.GIS_Temp1		reuse storage;

	insert --+ append
	into	 garland.Temp_View1
	(
		node_id,
		x_coord,
		y_coord
	)
	select
		X1 || Y1,
		X1,
		Y1
	from	gis.feature_coordinates
	where	featureclass = 'ROAD'
	
	UNION

	select
		X2 || Y2,
		X2,
		Y2
	from	gis.feature_coordinates
	where	featureclass = 'ROAD';


--	===========================================================================================

	analyze table garland.GIS_Temp1  compute statistics;

--	===========================================================================================
