	set echo 		off;
	set charwidth	300;
--	==========================================================================

--	Generate adrAlter records from adrAlias & adrAlien records
--	==========================================================================
--	method = 11

	spool	c:\deacutis\scripts\address_resolve\alterations\01_loader\NON_ADDRESS.sql;

	select null 
	|| chr(10)	||	'   insert into garland.adrAlter_vw   values ( '
			||	'''' || alias_lo || ''', '
			||	'''' || alias_hi || ''','
			||	lpad( '''non-address ' || alias_how || '''', 20)

	|| chr(10)	|| '   ,'''|| decode(substr(alias_how,3,1),'$','1','/','0','S') ||'''    '
			||	rpad(	',''' || rtrim(alias_pfx, '*') || ''''	,06)    
			||	rpad(	',''' || rtrim(alias_name,'*') || ''''	,22)    
			||	rpad(	',''' || rtrim(alias_type,'*') || ''''	,08)    
			||	rpad(	',''' || rtrim(alias_sfx, '*') || ''''	,05)

	|| chr(10)	||	'   ,''''     ,'''' ,'''' ,'''' ,'''''
	|| chr(10)	||	'   ,''''     ,'''' ,'''' ,'''' ,'''''


	|| chr(10)	||	'   );'
	" "		from
(	select *
	from	garland.adrAlien
	where	alias_how like '11%'
	order by	alias_how, alias_name, alias_type, alias_pfx, alias_sfx, alias_lo, alias_hi
);

	spool off;

--	==========================================================================
--	method = 22

	spool	c:\deacutis\scripts\address_resolve\alterations\01_loader\NON_GARLAND.sql;


	select	null
	|| chr(10)	||	'   insert into garland.adrAlter_vw   values ( '
			||	'''' || alias_lo || ''', '
			||	'''' || alias_hi || ''','
			||	lpad( '''non-garland ' || alias_how || '''', 20)

	|| chr(10)	||	'   ,''''     ,'''' ,'''' ,'''' ,'''''

	|| chr(10)	|| '   ,'''|| decode(substr(alias_how,3,1),'$','1','/','0','S') ||'''    '
			||	rpad(	',''' || rtrim(alias_pfx, '*') || ''''	,06)    
			||	rpad(	',''' || rtrim(alias_name,'*') || ''''	,22)    
			||	rpad(	',''' || rtrim(alias_type,'*') || ''''	,08)    
			||	rpad(	',''' || rtrim(alias_sfx, '*') || ''''	,05)

	|| chr(10)	||	'   ,''''     ,'''' ,'''' ,'''' ,'''''


	|| chr(10)	||	'   );'
	" "		from
(	select *
	from	garland.adrAlias
	where	alias_how like '22%'
	order by	alias_how, alias_name, alias_type, alias_pfx, alias_sfx, alias_lo, alias_hi
);

	spool off;

--	==========================================================================
--	method = 12

	spool	c:\deacutis\scripts\address_resolve\alterations\01_loader\UNPARSED.sql;


	select null 
	|| chr(10)	||	'   insert into garland.adrAlter_vw   values ( '
			||	'''' || alias_lo || ''', '
			||	'''' || alias_hi || ''','
			||	lpad( '''parsed ' || alias_how || '''', 20)

	|| chr(10)	||		'   ,''S''    '
			||	rpad(	',''' || rtrim(alias_pfx, '*') || ''''	,06)    
			||	rpad(	',''' || rtrim(alias_name,'*') || ''''	,22)    
			||	rpad(	',''' || rtrim(alias_type,'*') || ''''	,08)    
			||	rpad(	',''' || rtrim(alias_sfx, '*') || ''''	,05)

	|| chr(10)	|| '   ,'''|| decode(substr(alias_how,3,1),'$','1','/','0','S') ||'''    '
			||	rpad(	',''' || rtrim(addr_pfx, '*') || ''''	,06)    
			||	rpad(	',''' || rtrim(addr_name,'*') || ''''	,22)    
			||	rpad(	',''' || rtrim(addr_type,'*') || ''''	,08)    
			||	rpad(	',''' || rtrim(addr_sfx, '*') || ''''	,05)

	|| chr(10)	||	'   ,''''     ,'''' ,'''' ,'''' ,'''''

	|| chr(10)	||	'   );'
	" "		from
(	select *
	from	garland.adrAlien
	where	alias_how like '12%'
	order by	alias_how, addr_name, addr_type, addr_pfx, addr_sfx, alias_lo, alias_hi
)

	UNION ALL

--	==========================================================================
--	method = 13

	select null 
	|| chr(10)	||	'   insert into garland.adrAlter_vw   values ( '
			||	'''' || alias_lo || ''', '
			||	'''' || alias_hi || ''','
			||	lpad( '''corrected ' || alias_how || '''', 20)

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
	" "		from
(	select *
	from	garland.adrAlien
	where	alias_how like '13%'
	order by	alias_how, addr_name, addr_type, addr_pfx, addr_sfx, alias_lo, alias_hi
);

	spool off;

--	==========================================================================
--	method = 23

	spool	c:\deacutis\scripts\address_resolve\alterations\01_loader\PARSED.sql;


	select null 
	|| chr(10)	||	'   insert into garland.adrAlter_vw   values ( '
			||	'''' || alias_lo || ''', '
			||	'''' || alias_hi || ''','
			||	lpad( '''corrected ' || alias_how || '''', 20)

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
	" "		from
(	select *
	from	garland.adrAlias
	where	alias_how like '23%'
	order by	alias_how, addr_name, addr_type, addr_pfx, addr_sfx, alias_lo, alias_hi
);

	spool off;

--	==========================================================================
--	method = Type B

	spool	c:\deacutis\scripts\address_resolve\alterations\01_loader\TYPE_B.sql;

	select distinct	null 
	|| chr(10)	||	'   insert into garland.adrAlter_vw   values ( '
			||	'''' || '0' 	|| ''', '
			||	'''' || '999999'	|| ''','
			||	lpad( '''Type B ' || do_alias || '''', 20)


	|| chr(10)	||		'   ,''S''    '
			||	rpad(	',''' || rtrim(appl_pfx, '*') || ''''	,06)    
			||	rpad(	',''' || rtrim(appl_name,'*') || ''''	,22)    
			||	rpad(	',''' || rtrim(appl_type,'*') || ''''	,08)    
			||	rpad(	',''' || rtrim(appl_sfx, '*') || ''''	,05)

	|| chr(10)	||	'   ,''''     ,'''' ,'''' ,'''' ,'''''

	|| chr(10)	||		'   ,''S''    '
			||	rpad(	',''' || rtrim(addr_pfx, '*') || ''''	,06)    
			||	rpad(	',''' || rtrim(addr_name,'*') || ''''	,22)    
			||	rpad(	',''' || rtrim(addr_type,'*') || ''''	,08)    
			||	rpad(	',''' || rtrim(addr_sfx, '*') || ''''	,05)


	|| chr(10)	||	'   );'
	" "		from
(	select *
	from	garland.adrResult
	where	do_name = 'B'
	order by	addr_name, addr_type, addr_pfx, addr_sfx, addr_num
);

	spool off;

--	==========================================================================
--	method = Type C

	spool	c:\deacutis\scripts\address_resolve\alterations\01_loader\TYPE_C.sql;

	select distinct	null 
	|| chr(10)	||	'   insert into garland.adrAlter_vw   values ( '
			||	'''' || '0' 	|| ''', '
			||	'''' || '999999'	|| ''','
			||	lpad( '''Type C ' || do_alias || '''', 20)


	|| chr(10)	||		'   ,''S''    '
			||	rpad(	',''' || rtrim(appl_pfx, '*') || ''''	,06)    
			||	rpad(	',''' || rtrim(appl_name,'*') || ''''	,22)    
			||	rpad(	',''' || rtrim(appl_type,'*') || ''''	,08)    
			||	rpad(	',''' || rtrim(appl_sfx, '*') || ''''	,05)

	|| chr(10)	||	'   ,''''     ,'''' ,'''' ,'''' ,'''''

	|| chr(10)	||		'   ,''S''    '
			||	rpad(	',''' || rtrim(addr_pfx, '*') || ''''	,06)    
			||	rpad(	',''' || rtrim(addr_name,'*') || ''''	,22)    
			||	rpad(	',''' || rtrim(addr_type,'*') || ''''	,08)    
			||	rpad(	',''' || rtrim(addr_sfx, '*') || ''''	,05)


	|| chr(10)	||	'   );'
	" "		from
(	select *
	from	garland.adrResult
	where	do_name = 'C'
	order by	addr_name, addr_type, addr_pfx, addr_sfx, addr_num
);

	spool off;

--	==========================================================================
--	method = Street Qualifications

	spool	c:\deacutis\scripts\address_resolve\alterations\01_loader\STREET.sql;

	select distinct text " " from
(
	select 	null 
	|| chr(10)	||	'   insert into garland.adrAlter_vw   values ( '
			||	rpad('''' || addr_num 	|| ''', ' ||	'''' || addr_num	|| ''','  ,25) 
			||	'''Edit = ' || do_qual || ''''

	|| chr(10)	||		'   ,''S''    '
			||	rpad(	',''' || rtrim(form_pfx, '*') || ''''	,06)    
			||	rpad(	',''' || rtrim(form_name,'*') || ''''	,22)    
			||	rpad(	',''' || rtrim(form_type,'*') || ''''	,08)    
			||	rpad(	',''' || rtrim(form_sfx, '*') || ''''	,05)

	|| chr(10)	||	'   ,''''     ,'''' ,'''' ,'''' ,'''''

	|| chr(10)	||		'   ,''S''    '
			||	rpad(	',''' || rtrim(addr_pfx, '*') || ''''	,06)    
			||	rpad(	',''' || rtrim(addr_name,'*') || ''''	,22)    
			||	rpad(	',''' || rtrim(addr_type,'*') || ''''	,08)    
			||	rpad(	',''' || rtrim(addr_sfx, '*') || ''''	,05)

	|| chr(10)	||	'   );'
	TEXT		
	from	garland.adrResult
	
	where	do_qual like '%Acp%'
	or	do_qual like '%Bcp%'
	or	do_qual like '%Scp%'
	
	or	do_qual like '%Act%'
	or	do_qual like '%Bct%'
--	or	do_qual like '%Sct%'

--	or	do_qual like '%Arp%'
--	or	do_qual like '%Brp%'
--	or	do_qual like '%Srp%'

--	or	do_qual like '%Art%'
--	or	do_qual like '%Brt%'
--	or	do_qual like '%Srt%'

	or	do_qual like '%r%'
	or	do_qual like '%s%'

	order by	addr_name, addr_type, addr_pfx, addr_sfx, do_qual
);

	spool off;

--	==========================================================================

--	select * from adrAlias 
--	where alias_how like '2%'   
--	and rownum < 2 ;
	
--	==========================================================================
	set echo on;
	set charwidth;
