
	drop   view		garland.dupe_intersect;

	create view		garland.dupe_intersect
(
		intersect_id,
		esri_node,

		terminal1,
		addr1_name,
		addr1_type,
		addr1_pfx,
		addr1_sfx,
		addr1_block,

		terminal2,
		addr2_name,
		addr2_type,
		addr2_pfx,
		addr2_sfx,
		addr2_block,

		road_id1,
		rpad_id2,
		row_id
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

		item15,
		item16,

		item17 

	from	gis_temp4;


