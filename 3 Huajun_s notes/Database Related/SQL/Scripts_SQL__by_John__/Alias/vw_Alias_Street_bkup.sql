	set echo off;

	create or replace view	garland.Alias_Street	
	as

	Select

		addr_pfx		street_prefix,
		addr_name		street_name,	
		addr_type		street_type,	
		addr_sfx		street_suffix,	

		addr_begin		name_begin,
		addr_ending		name_end,

		street_id		street_id,
		addr_compact	name_compress1,
		addr_compress	name_compress2,
		addr_soundex	name_soundex

	from	garland.adrStreets;

