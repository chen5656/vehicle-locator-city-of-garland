
--	delete from adrAlias where alias_how = 'mores';
--	commit;
			
--	select count(*)



	select
		'*',										
		rtrim(addr_begin),					
		addr_type,										
		'*',										
		'',				
		addr_name,			
		'',			
		'',				
		1200,
		'mores'

	from
(
	select
		 max(addr_pfx)		addr_pfx,
		 max(addr_name)		addr_name,
		 max(addr_type)		addr_type,
		 max(addr_sfx)		addr_sfx,
		 rtrim(addr_begin)	addr_begin 

	from  garland.adrStreets		s
	where	addr_type   > '0'
	and	addr_ending > '0'

	and not exists
(
	select 'x'
	from	garland.adrAlias
	where	alias_how = 'more'
	and	alias_name = rtrim(s.addr_begin)					
)	

	and not exists				--  dec 2003
(
	select 'x'
	from	adrStreets		ss
	where	rtrim(s.addr_begin) = ss.addr_reduced
	and	s.addr_name		 <> ss.addr_name
)


	and not exists	
(
	select 'x'
	from	 garland.adrAlias
	where	 alias_name = rtrim(s.addr_begin)
	and	 alias_how in ( 'asis' )
)


	and not exists
(
	select 'x'
	from	 garland.adrAlias			a
	where	a.alias_name	= rtrim(s.addr_begin)	
	and	a.alias_type	= s.addr_type	
)


	and not exists
(
	select 'x'
	from	 garland.adrAlias			a
	where	a.alias_name	= rtrim(s.addr_begin)	
	and	a.alias_pfx		= s.addr_pfx	
)


	group by	rtrim(addr_begin), addr_type
	having	count(distinct addr_name) = 1
)



