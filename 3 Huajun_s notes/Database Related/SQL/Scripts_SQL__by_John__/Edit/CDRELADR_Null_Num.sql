
--	display addresses with no number


	select	

		parcel_id,
		mslink,
		addr_num		"num",
		addr_pfx		"pf",
		addr_name		"name",
		addr_type		"type",
		addr_sfx		"sf"
	from	garland.cdreladr
	where	nvl (addr_num, 0) = 0;
