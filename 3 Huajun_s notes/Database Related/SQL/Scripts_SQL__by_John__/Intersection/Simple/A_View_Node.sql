--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	2000;
set pagesize	9999;
--	===========================================================================================
--	A_View_Node
--	===========================================================================================
	select 'NODE VIEW  ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;


	create or replace view	garland.Temp_View1	as
		
	select	item01	node_id,
			item02	x_coord,
			item03	y_coord
	from		garland.GIS_Temp1;
		
