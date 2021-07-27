
	set charwidth	100;

	select 'create synonym   ' || 	rpad (owner || '.' || synonym_name, 30) 	|| 
		 ' for ' 		   ||	rpad (table_owner || '.' || table_name,   30)	|| ';'	" "

	from	dba_synonyms,
		tmp_view

	where	owner		= schema_
--	and	table_name	= key_
	and	'table'	= type_
	;

