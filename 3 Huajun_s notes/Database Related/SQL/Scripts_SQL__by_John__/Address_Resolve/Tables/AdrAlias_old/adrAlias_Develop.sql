	set echo	off;

--	=========================================================================================   
--	SUBSTITUTE ALTERNATIVE PREFIX
--	SUBSTITUTE ALTERNATIVE TYPE
--	Example:	N Shiloh Rd		NO Shiloh Rd
--			N Fifth  Cir	N  Fifth  CR

	insert into garland.adrAlias

	select 	
		i.possible,
		a.alias_name,
		a.alias_type, 
		a.alias_sfx,
		a.alias_lo,
		a.alias_hi,
		a.addr_min,
		a.addr_pfx,
		a.addr_name,
		a.addr_type,					
		a.addr_sfx,
		a.alias_how || ';',
		a.alias_reduced,
		a.alias_compact,
		a.alias_compress,
		a.alias_weight

	from	garland.adrAlias		a,
		garland.adrItem		i				

	where i.class = 'D'
	and 	a.alias_pfx  = i.standard
	and	a.alias_pfx <> i.possible
	and	i.name	<> i.possible

	union all

	select 	
		a.alias_pfx,
		a.alias_name,
		i.possible,
		a.alias_sfx,
		a.alias_lo,
		a.alias_hi,
		a.addr_min,
		a.addr_pfx,
		a.addr_name,
		a.addr_type,					
		a.addr_sfx,
		a.alias_how || ';',
		a.alias_reduced,
		a.alias_compact,
		a.alias_compress,
		a.alias_weight

	from	garland.adrAlias		a,
		garland.adrItem		i				

	where i.class = 'T'
	and 	a.alias_type  = i.standard
	and	a.alias_type <> i.possible
	and	i.name	 <> i.possible;


	commit;

--	=========================================================================================   

	set echo	on;


