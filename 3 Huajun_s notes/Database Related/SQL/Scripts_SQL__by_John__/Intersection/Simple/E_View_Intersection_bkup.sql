
	create or replace view	Temp_View4		as

	select
		item01	strname1,
		item02	strtype1,
		item03	strpre1,
		item04	strsuf1,
		item05	strblok1,

		item06	strname2,
		item07	strtype2,
		item08	strpre2,
		item09	strsuf2,
		item10	strblok2,

		item11	Intersect_Type,
		item12	node_id

	from	garland.GIS_Temp4;
