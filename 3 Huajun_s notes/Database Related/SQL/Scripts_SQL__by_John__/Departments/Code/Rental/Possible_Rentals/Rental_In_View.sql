	set echo off;


	create or replace view	garland.Temp_View		as

	select

		item01		App_Key,
		item02		Source,
		item03		addr_Num,
		item04		addr_Pfx,
		item05		addr_Name,
		item06		addr_Type,
		item07		addr_Sfx,
		item08		District,
		item09		Parcel_ID

	from	garland.GIS_Temp2;