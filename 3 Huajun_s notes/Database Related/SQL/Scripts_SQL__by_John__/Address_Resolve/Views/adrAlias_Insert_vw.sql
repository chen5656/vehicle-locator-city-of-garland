

	create or replace view		garland.adrAlias_Insert_vw	

	as	select

		alias_lo, alias_hi, addr_min, alias_weight, alias_how,

		alias_pfx, alias_name, alias_type, alias_sfx, 

		addr_pfx, addr_name, addr_type, addr_sfx

		from	garland.adrAlias; 