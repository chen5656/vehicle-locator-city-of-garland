
--	create "rename table" commands


	spool	c:\deacutis\scripts\ora_create\Script_Rename.sql;

--	spool	d:\scripts\ora_create\Script_Rename.sql;


	select	'	rename ' || a.prefix_ || a.key_	|| 
			'  to  ' 	   ||	a.key_    || ';' 			" "

	from		tmp_view	a
	where		a.type_ = 'table'
	;


	spool off;

 