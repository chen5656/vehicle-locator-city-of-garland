	set echo off;
--	===============================================================
--	adrResult_User = GIS OBJECTS
--	===============================================================

	create or replace	view	garland.adrResult_User
	(
		rec_key,
		rec_rowid,

		addr_num,
		addr_pfx,
		addr_name,
		addr_type,
		addr_sfx,

		addr_code1,
		addr_unit1,
		addr_code2,
		addr_unit2
	)
	as
	select

		item01,
		rowid,

		null, null,
		item02,
		null, null,

		null, null, null, null

	from	garland.gis_objects

--	from	garland.gis_temp1


	where	item02 not like '%&%'		-- ignore street intersections
	;


--	===============================================================

