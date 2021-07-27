	set echo	off;
--	=========================================================================================   

--	alter rollback segment	rb1			online;
--	commit;
--	set transaction 	use rollback segment	rb1;

--	=========================================================================================   

	select 'XXX' " " from dual;

--	=========================================================================================   
--	PARTIAL STREET NAME + STREET TYPE determines FULL STREET NAME

	insert into	garland.adrAlias
(
			alias_pfx,
			alias_name,
			alias_type,
			alias_sfx,
			alias_lo,
			alias_hi,
			addr_min,
			addr_pfx,
			addr_name,
			addr_type,
			addr_sfx,

			alias_weight,		
			alias_match,		
			alias_how,
			alias_reduced,
			alias_compact,
			alias_compress
)

	select	alias_pfx,
			alias_name,
			alias_type,
			alias_sfx,
			0,
			999999,
			0,
			addr_pfx,
			addr_name,
			addr_type,
			addr_sfx,

			alias_weight,
			0							alias_match,
			alias_how,
			adr_compress_name (alias_name, '1'),
			adr_compress_name (alias_name, '4'),
			adr_compress_name (alias_name, '6')
	from
(
	select	''		alias_pfx,
			''		alias_name,
			''		alias_type,
			''		alias_sfx,
			''		addr_pfx,
			''		addr_name,
			''		addr_type,
			''		addr_sfx,
			0		alias_weight,
			''		alias_how
	from		dual
	where		dummy = 'bogus'

--	=========================================================================================   
--	PARTIAL STREET NAME + STREET PREFIX determines FULL STREET NAME

	union
	select
		'*',										
		rtrim(addr_begin),					
		addr_type,										
		'*',										
		'',				
		addr_name,			
		'',			
		'',				
		003,
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

	and exists
(
	select 'x'
	from	garland.adrAlias			
	where	alias_how = 'asis'
	and	alias_reduced = s.addr_reduced
)	

	and not exists
(
	select 'x'
	from	garland.adrAlias
	where	alias_how = 'asis'
	and	alias_reduced = s.addr_reduced
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
	group by	rtrim(addr_begin), addr_type
	having	count(distinct addr_name) = 1
)

--	=========================================================================================   
--	PARTIAL STREET NAME + STREET TYPE + STREET PREFIX determines FULL STREET NAME

	union
	select
		'*',										
		rtrim(addr_begin),					
		addr_type,										
		'*',										
		'',				
		addr_name,			
		'',			
		'',				
		003,
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

--	=========================================================================================   

	union
	select
		addr_pfx,										
		rtrim(addr_begin),					
		addr_type,										
		'*',										
		'',				
		addr_name,			
		'',			
		'',				
		003,
		'mores'			
	from
(
	select
		 max(addr_pfx)		addr_pfx,
		 max(addr_name)		addr_name,
		 max(addr_type)		addr_type,
		 max(addr_sfx)		addr_sfx,
		 rtrim(addr_begin)	addr_begin 
	from  garland.adrStreets			s
	where	addr_ending > '0'
	and	addr_pfx   > '0'
	and	addr_type  > '0'

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
	and	a.alias_pfx	 	= s.addr_pfx	
	and	a.alias_type	= s.addr_type	
)
	group by	rtrim(addr_begin), addr_pfx, addr_type
	having	count(distinct addr_name) = 1
)

--	=========================================================================================   

);

	commit;
--	alter rollback segment	rb1			offline;

--	=========================================================================================   

