 	set echo off;
--	===============================================================
--	adrResult_User = Address Unit (Temporary extract)

--	Source:	\\Warehouse\GIS_Address_View\Bldg_Unit
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

		building_id,		--	record key
		rowid,			--	record rowid

		addr_num,
		addr_pfx,
		addr_name,
		addr_type,
		addr_sfx,

		addr_bldg,
		'',
		
		'',		--	addr_code2, 
		''		--	addr_unit2

	from	garland.Address_Building_Source

	where	addr_name > '0'
	;

--	===============================================================
