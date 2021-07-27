
	create or replace view	garland.adrAlias_vw		as

	select	alias_pfx,
			alias_name,
			alias_type,
			alias_sfx,

			alias_lo,
			alias_hi,

			addr_pfx,
			addr_name,
			addr_type,
			addr_sfx,

			alias_how,
			alias_weight

	from		garland.adrAlias;
