
	create or replace view	node
(
	esri_node,
	x,
	y
)
	as

	select	item01,
			item02,
			item03
	from		gis_temp2;

