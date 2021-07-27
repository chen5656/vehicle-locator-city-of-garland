  	set echo off;
--	===================================================================
--	adrResult_User = Potential Rentals for John Teel  (Code)

--	\\deacutis\scripts\departments\code\rental\potential_vs_known
--	===================================================================

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

		App_Key,		--	record key
		rowid,		--	record rowid

		ltrim(addr_num,'0'),			--	addr_num,

		addr_pfx,		--	addr_pfx,

		garland.string_cleaner(addr_name),	--	addr_name,		

		addr_type,	--	addr_type,
		addr_sfx,	--	addr_sfx,

		'',		--	addr_code1,
		'',		--	addr_unit1,
		'#',		--	addr_code2, 
		source	--	addr_unit2

	from	garland.Temp_View

	where	district = 'xxx'				-- non duplicates
	;

--	===============================================================
