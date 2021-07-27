	set echo off;

	create or replace view	garland.Temp_View1	as

	select

		item01		addr_Name,
		item02		addr_Num,
		item03		addr_Type,
		item04		addr_Pfx,
		item05		addr_Sfx,

		item06		Address_id,
		item07		Parcel_id,
		item08		District,

		item09		KNOWN,
		item10		DCAD,
		item11		SECTION8,
		item12		HOMESTEAD

	from	garland.GIS_Temp1;
