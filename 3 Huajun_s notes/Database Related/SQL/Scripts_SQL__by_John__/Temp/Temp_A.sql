	set echo 		off;
	set charwidth	300;
	set fetchrows	11;
--	==========================================================================

--	Generate adrAlter records from adrAlias & adrAlien records

--	==========================================================================
--	method = 22

	select null 
	|| chr(10)	||	'   insert into garland.adrAlter_vw   values ( '
			||	'''' || alias_lo || ''', '
			||	'''' || alias_hi || ''','
			||	lpad( '''non-garland''', 20)

	|| chr(10)	||	'   ,''''     ,'''' ,'''' ,'''' ,'''''

	|| chr(10)	||		'   ,''1''    '
			||	rpad(	',''' || rtrim(alias_pfx, '*') || ''''	,06)    
			||	rpad(	',''' || rtrim(alias_name,'*') || ''''	,22)    
			||	rpad(	',''' || rtrim(alias_type,'*') || ''''	,08)    
			||	rpad(	',''' || rtrim(alias_sfx, '*') || ''''	,05)

	|| chr(10)	||	'   ,''''     ,'''' ,'''' ,'''' ,'''''


	|| chr(10)	||	'   );'
	" "
	from adrAlias
	where	alias_how like '22$%'
	order by	alias_name, alias_type, alias_pfx, alias_sfx, alias_lo, alias_hi;

--	==========================================================================
--	method = 11

	select null 
	|| chr(10)	||	'   insert into garland.adrAlter_vw   values ( '
			||	'''' || alias_lo || ''', '
			||	'''' || alias_hi || ''','
			||	lpad( '''non-address''', 20)

	|| chr(10)	||		'   ,''0''    '
			||	rpad(	',''' || rtrim(alias_pfx, '*') || ''''	,06)    
			||	rpad(	',''' || rtrim(alias_name,'*') || ''''	,22)    
			||	rpad(	',''' || rtrim(alias_type,'*') || ''''	,08)    
			||	rpad(	',''' || rtrim(alias_sfx, '*') || ''''	,05)

	|| chr(10)	||	'   ,''''     ,'''' ,'''' ,'''' ,'''''
	|| chr(10)	||	'   ,''''     ,'''' ,'''' ,'''' ,'''''


	|| chr(10)	||	'   );'
	" "
	from adrAlien
	where	alias_how like '11/%'
	order by	alias_name, alias_type, alias_pfx, alias_sfx, alias_lo, alias_hi;

--	==========================================================================
--	method = 12

	select null 
	|| chr(10)	||	'   insert into garland.adrAlter_vw   values ( '
			||	'''' || alias_lo || ''', '
			||	'''' || alias_hi || ''','
			||	lpad( '''1parsed''', 20)

	|| chr(10)	||		'   ,''S''    '
			||	rpad(	',''' || rtrim(alias_pfx, '*') || ''''	,06)    
			||	rpad(	',''' || rtrim(alias_name,'*') || ''''	,22)    
			||	rpad(	',''' || rtrim(alias_type,'*') || ''''	,08)    
			||	rpad(	',''' || rtrim(alias_sfx, '*') || ''''	,05)

	|| chr(10)	||		'   ,''S''    '
			||	rpad(	',''' || rtrim(addr_pfx, '*') || ''''	,06)    
			||	rpad(	',''' || rtrim(addr_name,'*') || ''''	,22)    
			||	rpad(	',''' || rtrim(addr_type,'*') || ''''	,08)    
			||	rpad(	',''' || rtrim(addr_sfx, '*') || ''''	,05)

	|| chr(10)	||	'   ,''''     ,'''' ,'''' ,'''' ,'''''

	|| chr(10)	||	'   );'
	" "
	from adrAlien
	where	alias_how like '12%'
	order by	alias_name, alias_type, alias_pfx, alias_sfx, alias_lo, alias_hi;


--	==========================================================================
--	method = 13

	select null 
	|| chr(10)	||	'   insert into garland.adrAlter_vw   values ( '
			||	'''' || alias_lo || ''', '
			||	'''' || alias_hi || ''','
			||	lpad( '''1corrected''', 20)

	|| chr(10)	||		'   ,''S''    '
			||	rpad(	',''' || rtrim(alias_pfx, '*') || ''''	,06)    
			||	rpad(	',''' || rtrim(alias_name,'*') || ''''	,22)    
			||	rpad(	',''' || rtrim(alias_type,'*') || ''''	,08)    
			||	rpad(	',''' || rtrim(alias_sfx, '*') || ''''	,05)

	|| chr(10)	||	'   ,''''     ,'''' ,'''' ,'''' ,'''''

	|| chr(10)	||		'   ,''S''    '
			||	rpad(	',''' || rtrim(addr_pfx, '*') || ''''	,06)    
			||	rpad(	',''' || rtrim(addr_name,'*') || ''''	,22)    
			||	rpad(	',''' || rtrim(addr_type,'*') || ''''	,08)    
			||	rpad(	',''' || rtrim(addr_sfx, '*') || ''''	,05)

	|| chr(10)	||	'   );'
	" "
	from adrAlien
	where	alias_how like '13%'
	order by	alias_name, alias_type, alias_pfx, alias_sfx, alias_lo, alias_hi;

--	==========================================================================
--	method = 23

	select null 
	|| chr(10)	||	'   insert into garland.adrAlter_vw   values ( '
			||	'''' || alias_lo || ''', '
			||	'''' || alias_hi || ''','
			||	lpad( '''2corrected''', 20)

	|| chr(10)	||	'   ,''''     ,'''' ,'''' ,'''' ,'''''

	|| chr(10)	||		'   ,''S''    '
			||	rpad(	',''' || rtrim(alias_pfx, '*') || ''''	,06)    
			||	rpad(	',''' || rtrim(alias_name,'*') || ''''	,22)    
			||	rpad(	',''' || rtrim(alias_type,'*') || ''''	,08)    
			||	rpad(	',''' || rtrim(alias_sfx, '*') || ''''	,05)

	|| chr(10)	||		'   ,''S''    '
			||	rpad(	',''' || rtrim(addr_pfx, '*') || ''''	,06)    
			||	rpad(	',''' || rtrim(addr_name,'*') || ''''	,22)    
			||	rpad(	',''' || rtrim(addr_type,'*') || ''''	,08)    
			||	rpad(	',''' || rtrim(addr_sfx, '*') || ''''	,05)

	|| chr(10)	||	'   );'
	" "
	from adrAlias
	where	alias_how like '23%'
	order by	alias_name, alias_type, alias_pfx, alias_sfx, alias_lo, alias_hi;



--	==========================================================================
/*

--	select * from adrAlias where alias_how like '2%'   and rownum < 2 
	
insert into garland.adrAlter_vw	values ( '','',              ' ='
,''	,'' ,'' ,'' ,'' 
,''	,'' ,'' ,'' ,'' 
,''	,'' ,'' ,'' ,'' 
  ); 

*/
--	==========================================================================
	set echo on;
	set charwidth;
	set fetchrows;
