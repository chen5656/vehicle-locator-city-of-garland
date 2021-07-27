 	set echo off;
--	===============================================================
--	adrResult_User = 
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

		cog_tax_id,		--	record key
		rowid,		--	record rowid

		address_number,		--	addr_num,
		address_prefix,		--	addr_pfx,
		address_name,		--	addr_name,
		address_type,		--	addr_type,
		address_suffix,		--	addr_sfx,

		address_suppl#,		--	addr_code1,
		address_sullp_type,	--	addr_unit1,
		'',				--	addr_code2, 
		''				--	addr_unit2

	from	garland.AddrVrfy
	;

--	===============================================================
