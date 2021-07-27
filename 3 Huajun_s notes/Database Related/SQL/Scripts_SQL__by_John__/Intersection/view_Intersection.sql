
	drop   view		garland.intersection;

	create view		garland.intersection
(
		addr1_name,
		addr1_type,
		addr1_pfx,
		addr1_sfx,
		addr1_block,

		addr2_name,
		addr2_type,
		addr2_pfx,
		addr2_sfx,
		addr2_block,

		corner_compass,
		twin_compass,

		node_id,
		intersect_id,

		police_beat

)
	as select

		item01,
		item02,
		item03,
		item04,
		item05,

		item06,
		item07,
		item08,
		item09,
		item10,

		item11,
		item12,

		item13,
		item14,

		item15

	from	gis_objects;

