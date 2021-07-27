	set echo 	off;
--	============================================================
--	create "drop table" commands
--	============================================================

	spool	c:\deacutis\scripts\ora_create\Script_Drop.sql;


	select	'	drop table ' || key_ || ';   --  cascade constraints'		" "
	from		tmp_view
	where		type_ = 'table'

	union all

	select	'	drop index ' || key_ || ';'   	" "
	from		tmp_view
	where		type_ = 'index'

	;


--	============================================================

	spool 	off;
	set echo	on;
