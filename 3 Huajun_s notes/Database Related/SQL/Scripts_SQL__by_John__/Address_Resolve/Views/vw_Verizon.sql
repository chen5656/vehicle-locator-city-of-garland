 	set echo off;
--	===============================================================
--	adrResult_User = Verizon 
--	===============================================================

	create or replace	view	garland.adrResult_User		AS
(
	select	
	
		phone		rec_key,
		rowid		rec_rowid,		

		addrnum	addr_num,
		addrpfx	addr_pfx,
		addrname	addr_name,
		addrtype	addr_type,
		addrsfx	addr_sfx,

		null		addr_code1,
		addrunit	addr_unit1,
		null		addr_code2,
		null		addr_unit2

	from	garland.Temp_View	
);

--	===============================================================

