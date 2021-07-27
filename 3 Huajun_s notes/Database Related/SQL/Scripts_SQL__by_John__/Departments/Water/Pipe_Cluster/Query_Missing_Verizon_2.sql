
--	desc garland.verizon_info;


	select streetname, streetnum||''
	from	sde.address_gis_default

	minus

	select streetname, streetnum
	from garland.verizon_info 
	where streetname like 'ARBORVIEW%'
	;