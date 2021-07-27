

	create or replace	view	twin_compass_view	

		(	node1_id,	node2_id,	x1,		y1,		x2,		y2	)

	as select	item01,	item02,	item03,	item04,	item05,	item06		

	from	gis_temp4;
