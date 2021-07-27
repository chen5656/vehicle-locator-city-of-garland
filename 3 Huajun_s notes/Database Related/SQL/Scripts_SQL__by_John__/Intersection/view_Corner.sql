	set echo off;

	create or replace view	corner
(
		esri_node,
		node_id,
		intersect_rowid,
		block1_rowid,
		block2_rowid,
		spoke1_rowid,
		spoke2_rowid,
		road1_rowid,
		road2_rowid,
		corner_compass
)
	as
	select
		item01,
		item02,
		item03,
		item04,
		item05,
		item06,
		item07,
		item08,
		item09,
		item10
	from	gis_temp3;

	set echo on;
