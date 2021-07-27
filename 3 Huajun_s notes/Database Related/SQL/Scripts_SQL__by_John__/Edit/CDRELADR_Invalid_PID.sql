	set echo	off;

--	look for invalid parcel id formats in cdreladr & cdrelpar

--	=================================================================================

--	display cdreladr records with invalid parcel id format  

	select	
		'CDRELADR'			" ",
		mslink		"mslink",
		parcel_id		"PARCEL ID",
		addr_num		"number",
		addr_pfx		"pf",
		addr_name		"name",
		addr_type		"type",
		addr_sfx		"sf"
	from	cdreladr

	where	translate (parcel_id, '123456789AB', '00000000000') <> '0000000.000'

	order by	parcel_id

--	order by	addr_name,
--			addr_type,
--			addr_pfx,
--			addr_num;
	;

--	=================================================================================
--	display cdrelpar records with invalid parcel id format  (valid = nnnnnnn.nnn)

	select	
		'CDRELPAR'			" ",
		lpad (mslink,07)		"mslink",
		parcel_id			"PARCEL ID"

	from	cdrelpar

	where	translate (parcel_id, '123456789AB', '00000000000') <> '0000000.000'
	order by	parcel_id;

--	=================================================================================
	set echo on;
