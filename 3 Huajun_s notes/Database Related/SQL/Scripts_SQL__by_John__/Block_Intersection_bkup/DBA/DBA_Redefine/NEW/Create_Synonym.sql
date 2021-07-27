
	set charwidth 120;

	select 'drop synonym   ' || 	rpad (owner || '.' || synonym_name, 30) 				" "
	from	dba_synonyms,
		tmp_view
	where	table_name		= key_
	and	table_owner		= schema_
	and	'table'		= type_
	and	'drop'		= option1_

	union all

	select 'create synonym   ' || 	rpad (owner || '.' || synonym_name, 30) 	|| 
		 ' for ' 		   ||	rpad (table_owner || '.' || table_name,   30)	|| ';'	" "
	from	dba_synonyms,
		tmp_view
	where	table_name		= key_
	and	table_owner		= schema_
	and	'table'		= type_

	;