	set echo off;
	set sqlblanklines on;
--	=========================================================
--	adrResult_User = UMS Location
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
		location_no				rec_key,	
--		rowid					rec_rowid,
		null					rec_rowid,
		rtrim(ltrim(house_no))		addr_num,
		rtrim(street_pfx_dir)		addr_pfx,
		rtrim(street_nm)			addr_name,		
		rtrim(street_nm_sfx)		addr_type,
		rtrim(street_sfx_dir)		addr_sfx,
		rtrim(sec_addr_id)		addr_code1,
		rtrim(sec_addr_range)		addr_unit1,
		''					addr_code2,
		''					addr_unit2
	from	sfg.um00100m@umsrep.world	
	where	location_stat = 'ACT'
	and	street_nm not like 'FLOATING%'
	and	street_nm not like 'FIRE HYDRANT%'
	and	translate (house_no, '/1234567890 ', '/') is null
	;

--	=========================================================
