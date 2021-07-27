	set echo off;
--	=========================================================
--	gis_app_addr	view of nsa_crime
--	=========================================================

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

		lwmainid,			--	rec_key	
		rowid,			--	rec rowid

		addr_num,			--	addr_num
		addr_pfx,			--	addr_pfx
		addr_name,			--	addr_name	
		addr_type,			--	addr_type
		addr_sfx,			--	addr_sfx

		'',				--	addr_code1
		addr_unit,			--	addr_unit1
		'',				--	addr_code2
		''				--	addr_unit2

	from		garland.NSA_CRIME

	where		rtrim(xstr_name) is null

--	and		to_char(date_rept, 'yyyy') between '1998' and '1999'
	;

--	================================================================================================
