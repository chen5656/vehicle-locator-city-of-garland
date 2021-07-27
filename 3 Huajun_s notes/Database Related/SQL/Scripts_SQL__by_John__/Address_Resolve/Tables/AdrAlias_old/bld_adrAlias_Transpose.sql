
--	=========================================================================================   
--	VALID NAMES THAT TRANSPOSE INTO VALID NAMES
--	FOR ALTERNATIVE POSSIBILITIES ONLY	
--	NOT FOR ADDRESS CORRECTION !!   

--	Example:	Woodhaven / Havenwood

	insert into garland.adrAlias

	select 	distinct
		'*',
		a.addr_name,					
		'*',
		'*',
		01,999999,0,
		'',
		b.addr_name,
		'',
		'',
		'trans',
		' ', ' ', ' '
		,001
		,0				-- alias_match		nov 2003

	from	adrStreets		a,
		adrStreets		b

	where	a.addr_begin	like '%' || b.addr_ending
	and	a.addr_ending	like b.addr_begin || '%'
	and	rtrim(a.addr_begin)  is not null
	and	rtrim(b.addr_ending) is not null

--	=========================================================================================   
