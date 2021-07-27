 	set echo off;
--	===============================================================
--	adrResult_User = Rental Registration
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

		certificate#,				--	record key
		rowid,					--	record rowid

		street_no,					--	addr_num,
		'',		--	addr_pfx,
		address_of_rental_property,		--	addr_name,
		'',		--	addr_type,
		'',		--	addr_sfx,

		'',		--	addr_code1,
		'',		--	addr_unit1,
		'',		--	addr_code2, 
		''		--	addr_unit2

	from	cog.rental_registration@cdep.world;

--	===============================================================
