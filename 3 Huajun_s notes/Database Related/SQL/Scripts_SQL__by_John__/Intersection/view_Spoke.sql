	set echo off;

	create or replace view		Spoke
(
	esri_node,
	road_id,
	terminal,
	from_node,
	to_node,

	coord_x,
	coord_y,
	vector_x,
	vector_y,

	street_id,
	block_id
)
	as

	select	item01,
			item02,
			item03,
			item04,
			item05,
			item06,
			item07,
			item08,
			item09,
			item10,
			item11
	from		gis_temp1;


	set echo on;
