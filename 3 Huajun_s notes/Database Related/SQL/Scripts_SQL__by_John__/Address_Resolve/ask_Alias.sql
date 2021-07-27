
	select alias_pfx,	rpad(alias_name,20) alias_name,  alias_type,  alias_sfx, 

		 nvl(addr_pfx, '*')	pfx, 
		 rpad(addr_name,20)	name,	
		 nvl(addr_type,'*')	type, 
		 nvl(addr_sfx, ' ')	sfx 

	from  garland.adrAlias
	where	addr_name in 



(	'WEST WAY'			)

	;

