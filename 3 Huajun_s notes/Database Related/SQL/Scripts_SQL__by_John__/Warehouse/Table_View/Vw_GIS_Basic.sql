
	create or replace view	garland.GIS_Basic
(
		address_id,
		dummy_addrid,
		parcel_id,
		block_id,
		road_id,

		intersect1_id,
		intersect2_id,

		tax_id,
		tax_bldg,
		tax_unit,
		ums_id,
		ums_bldg,
		ums_unit
)

	as select	item01, item02, item03, item04, item05, 
			item06, item07, item08, item09, item10, item11,
			item12,item13

	from	garland.GIS_Temp1;
