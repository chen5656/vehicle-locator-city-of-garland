

	create or replace view	garland.Find_Address_Input
(
	rec_seq,

	user_num,
	user_pfx,
	user_name,
	user_type,
	user_sfx,
	user_bldg,
	user_unit,

	control,
	choice,
	occurs,

	region1,
	region2,
	region3
)

	As	Select  item01,

		item02, item03, item04, item05, item06, item07, item08,
		item09, item10, item11,
		item12, item13, item14

		from	 garland.GIS_Objects;
