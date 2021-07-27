 	set echo off;
--	===============================================================
--	adrResult_User = Verizon SBC
--	===============================================================

	create or replace	view	garland.adrResult_User		AS
(
	select	
	
		phone			rec_key,
		rowid			rec_rowid,		

		streetnum		addr_num,
		streetprefix	addr_pfx,
		streetname		addr_name,
		streettype		addr_type,
		streetsuffix	addr_sfx,

		null			addr_code1,
		unitnum		addr_unit1,
		null			addr_code2,
		null			addr_unit2

	from	garland.VERIZON_SBC_INFO
);

--	===============================================================

