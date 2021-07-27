
	drop   view		garland.non_partial_intersect;

	create view		garland.non_partial_intersect
(
		addr_name,
		addr_type,
		is_pfx_sfx
)

	as select	item01,
			item02,
			item03
	from		gis_temp4;



