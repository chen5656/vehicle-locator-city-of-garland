
--	=========================================================================================   
--	QUALIFIER NAME IN ALIAS NAME IS ABBREVIATED (if not already done)
--	EXAMPLE:	Both 'Miller Park' and 'Miller Pk' will be in table

--	alter rollback segment	rb1			online;
--	commit;
--	set transaction 	use rollback segment	rb1;

	insert into garland.adrAlias
	select distinct
		alias_pfx,
 		replace(ltrim(rtrim(replace (a.alias_name, i.name, ' '|| i.standard ||' '))),'  ',' '),
		alias_type,
		alias_sfx,
		alias_lo,
		alias_hi,
		addr_min,
		addr_pfx,
		addr_name,
		addr_type,
		addr_sfx,
		a.alias_how || '.',
		alias_reduced,
		alias_compact,
		alias_compress,
		alias_weight
		,0				-- alias_match		nov 2003
		,0				-- alias_priority		dec 2004
	from	garland.adrAlias		a,
		garland.adrItem		i

	where	i.class in ('T', 'D')
	and	i.standard <> i.name
	and	(' '|| a.alias_name ||' ') like ('% '|| i.name ||' %')
	and	translate (lower(a.alias_how), '/abcdefghijklmnopqrstuvwxyz@','/') is null

	and	lower(a.alias_how) not like '%push%'		-- nov 2004

	and not exists
(
	select 'x'
	from	garland.adrAlias
	where	alias_name	= replace(ltrim(rtrim(replace (a.alias_name, i.name, ' '|| i.standard ||' '))),'  ',' ')
	and	alias_type	= a.alias_type
	and	alias_pfx	= a.alias_pfx
	and	alias_sfx	= a.alias_sfx
);

	commit;
--	alter rollback segment	rb1			offline;

