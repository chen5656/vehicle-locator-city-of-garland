
--	create "drop table" commands


	spool	c:\deacutis\scripts\ora_create\Script_Drop.sql;


	select	'	drop table ' || key_ || ';   --  cascade constraints'		" "
	from		tmp_view
	where		type_ = 'table';


	spool off;
