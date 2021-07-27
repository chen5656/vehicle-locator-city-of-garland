
--	create "rename table" commands



	spool	c:\deacutis\scripts\ora_create\Script_Rename.sql;


	select	'	rename ' || prefix_ || key_	|| 
			'  to  ' 	   ||	key_    || ';' 			" "
	from		tmp_view	
	where		type_ = 'table';


	spool off;

 