	set echo off;
--	======================================================================================

	truncate table	garland.Alias	reuse storage;

--	======================================================================================

	insert --+  append
	into	 garland.Alias
	select * from garland.Alias_adrAlias
	where	alias_how = lower(alias_how)
	and	alias_how not in ( 'mixed', 'part', 'more', 'rhyme' )
	and	range_hi  not in (  888888,  999999)

	UNION ALL

	select * from garland.Alias_adrAlias
	where	alias_how in ( 'LIKE', 'AVE', 'NTH',  'NUM' )

	UNION ALL

	select A.*
	from	garland.Alias_adrAlias	A,
		garland.Alias_Street	S
	where	s.street_name = a.aft_name
	and	a.alias_how	  = 'more'
	and (	length(s.addr_begin)  > 3
	and	length(s.addr_ending) > 3 

	UNION ALL

	select A.*
	from	garland.Alias_adrAlias	A,
	where	a.alias_how	  = 'more'
	and	a.addr_name like '% %'
	;


	commit;

--	======================================================================================
--	insert Alias records per simple name compression

	insert
	into	 garland.Alias
	select 
		a.category,	  a.bef_prefix,
		s.name_begin ||' '|| s.name_end,
		a.bef_type,	  a.bef_suffix, a.bef_bldg, a.bef_unit,
		a.aft_prefix, a.aft_name,
		a.aft_type,   a.aft_suffix, a.aft_bldg, a.aft_unit,
		a.range_lo,	  a.range_hi,
		a.match,	  a.rank

	from	garland.Alias_adrAlias	A,
		garland.Alias_Street	S

	where	s.street_name = a.aft_name
	and	s.name_end    > '0'
	and	s.name_begin || s.name_end = s.street_name

	UNION ALL

	select 
		a.category,	  a.bef_prefix,
		s.name_begin || s.name_end,
		a.bef_type,	  a.bef_suffix, a.bef_bldg, a.bef_unit,
		a.aft_prefix, a.aft_name,
		a.aft_type,   a.aft_suffix, a.aft_bldg, a.aft_unit,
		a.range_lo,	  a.range_hi,
		a.match,	  a.rank

	from	garland.Alias_adrAlias	A,
		garland.Alias_Street	S

	where	s.street_name = a.aft_name
	and	s.name_end    > '0'
	and	s.name_begin ||' '|| s.name_end = s.street_name
	;

	commit;

--	======================================================================================

	update garland.Alias
	set 	category = 'valid'
	where category = 'asis';

	update garland.Alias
	set 	bef_auffix = '*'
	where category = 'pulls';

	commit;

--	======================================================================================
