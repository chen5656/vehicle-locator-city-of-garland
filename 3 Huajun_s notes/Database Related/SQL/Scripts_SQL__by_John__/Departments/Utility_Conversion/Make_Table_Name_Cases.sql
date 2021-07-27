	set echo		off;
	set charwidth	200;
--	======================================================================
--	build table name file
--	======================================================================

	select	'	insert into garland.GIS_Objects  (item01, item02, item03)  values ' 
			||chr(10)||
			'	( '''		||
			table_name		||''','''||
			table_name		||''','''||
			''			||''' );'||
			
			chr(10)		" "
	from		tabs

	where		table_name	like 'UT%'

	and		length(table_name) <= 09

	and		table_name not in ( 'UTWATPLG', 'UTELETVT', 'UTSTOCOM', 'UTSTOCTY', 'UTSTOMDU' )


	order by	table_name;

--	======================================================================
	set echo	on;
	set charwidth;

