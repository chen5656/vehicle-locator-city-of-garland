	set echo off;

--	============================================================
--	JOB CONTROLS

	create or replace view	garland.Temp_View		as
	select	
		'180'			buffer,
		'15'			extend,
		'1'			use_arms,
		'1'			use_drop
	from	dual;


--	============================================================
--	TAP COORDINATES

	create or replace view	garland.Temp_View1	as
	select	
		item01		tap_x,
		item02		tap_y,
		item03		tap_id
	from	garland.GIS_Temp1;

--	============================================================
--	PIPE ENDPOINT NODES

	create or replace view	garland.Temp_View3	as
	select	
		item01		pipe_id,
		item02		node1,
		item03		node2
	from	garland.GIS_Temp3;

--	============================================================
--	NODE COORDINATES

	create or replace view	garland.Temp_View4	as
	select	
		item01		pipe_node,
		item02		node_x,
		item03		node_y
	from	garland.GIS_Temp4;

--	============================================================
--	PIPE COORDINATES

	create or replace view	garland.Temp_View2	as
	select	
		item01		pipe_id,

		item02		pipe_x1,
		item03		pipe_y1,
		item04		pipe_x2,
		item05		pipe_y2,

		item06		minx,
		item07		maxx,
		item08		miny,
		item09		maxy

	from	garland.GIS_Temp2;

--	============================================================
	set echo on;

