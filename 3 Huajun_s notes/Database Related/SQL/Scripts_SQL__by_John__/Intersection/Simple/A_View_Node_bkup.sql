	set echo off;


	create or replace view	garland.Temp_View1	as
		
	select	item01	node_id,
			item02	x_coord,
			item03	y_coord

	from		garland.GIS_Temp1;
		
	set echo on;
