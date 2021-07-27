 	set echo off;
--	===============================================================
--	adrResult_User = CODE_Inspection
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

		rowid,			--	rec_key		(unique key or rowid)
		rowid,

		address_number,		--	addr_num	
		address_prefix,		--	addr_pfx
		address_name,		--	addr_name
		address_type,		--	addr_type
		address_suffix,		--	addr_sfx

		address_sullp_type,	--	addr_code1
		address_suppl#,		--	addr_unit1
		'',				--	addr_code2
		''				--	addr_unit2

	from	codeaddr@cdep.world	--	(application table)

	;



--	================================================================================
/*

	select count(*)
	from	 codeaddr@cdep.world		a,
		 inspection@cdep.world		i
	where	a.addr_id = i.addr_id
	and	to_char (i.inspection_date, 'yyyy') = 2001

*/
--	================================================================================

