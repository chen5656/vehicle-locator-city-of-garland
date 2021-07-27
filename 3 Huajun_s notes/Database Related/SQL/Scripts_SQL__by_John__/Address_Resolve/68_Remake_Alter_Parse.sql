	set charwidth	300;
--	==========================================================================
--	method = parse

--	spool	c:\deacutis\scripts\address_resolve\alterations\01_loader\PARSE.sql;

	select distinct text	from
(
	select	null 
	|| chr(10)	||	'   insert into garland.adrAlter_vw   values ( '
			||	'''' || '0' || ''', '
			||	'''' || '999999' || ''','
			||	lpad( '''parse = ' || do_parse || '''', 30)

	|| chr(10)	||		'   ,''S''    '
			||	rpad(	',''' || rtrim(appl_pfx ) || ''''	,06)    
			||	rpad(	',''' || rtrim(appl_name) || ''''	,22)    
			||	rpad(	',''' || rtrim(appl_type) || ''''	,08)    
			||	rpad(	',''' || rtrim(appl_sfx)  || ''''	,05)
			||	rpad(	',''' || rtrim(appl_code1)|| ''''	,10)
			||	rpad(	',''' || ltrim(rtrim(appl_unit1))|| ''''	,10)

	|| chr(10)	|| '   ,'''|| decode(substr(do_alias,3,1),'$','1','/','0','S') ||'''    '
			||	rpad(	',''' || rtrim(form_pfx)  || ''''	,06)    
			||	rpad(	',''' || rtrim(form_name) || ''''	,22)    
			||	rpad(	',''' || rtrim(form_type) || ''''	,08)    
			||	rpad(	',''' || rtrim(form_sfx)  || ''''	,05)
			||	rpad(	',''' || rtrim(form_code1)|| ''''	,10)
			||	rpad(	',''' || rtrim(form_unit1)|| ''''	,10)

	|| chr(10)	||	'   ,''''     ,'''' ,'''' ,'''' ,'''''

	|| chr(10)	||	'   );'
	TEXT		
	from  garland.adrResult
	where	translate(lower(do_parse), '|npmt.', '|') is  not null
	and	do_parse not like '!%'
	and	do_parse not like '%\hiwy%'
	and	do_alias not in ( '-', 'AVE', 'PULL')
	order by	addr_name, addr_type, addr_pfx, addr_sfx
);

	spool off;

	set charwidth;
