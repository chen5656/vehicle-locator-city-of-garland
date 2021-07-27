	set echo off;

	create or replace view	garland.Alias_adrAlias	
	as

	Select

		alias_how		category,

		alias_pfx		bef_prefix,
		alias_name		bef_name,
		alias_type		bef_type,
		alias_sfx		bef_suffix,
		'*'			bef_bldg,
		'*'			bef_unit,

		addr_pfx		aft_prefix,
		addr_name		aft_name,
		addr_type		aft_type,
		addr_sfx		aft_suffix,
		''			aft_bldg,
		''			aft_unit,
	
		alias_lo		range_lo,
		alias_hi		range_hi,

		alias_match		match,
		alias_weight	rank

	from	garland.adrAlias;
