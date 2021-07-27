--	set echo	off;
--	======================================================================
--	build table name file
--	======================================================================

	spool	c:\deacutis\scripts\EXECUTE.sql
	spool off
	spool	c:\deacutis\scripts\EXECUTE.sql

--	-------------------------------------------------------------------
			
	select	'	desc garland.' || t.table_name || ';'

			" "
	from		tabs		T,
			temp_view	V


	where		t.table_name = v.new_table

--	where		table_name	like 'UT%'
--	and		length(table_name) <= 09
--	and		table_name not in ( 'UTELETVT', 'UTSTOCOM', 'UTSTOCTY', 'UTSTOMDU' )
--	and		table_name not in ( 'UTWATPLG')
--	and		table_name not like '%ARW'

	order by	table_name;

--	-------------------------------------------------------------------

	spool off

	@c:\deacutis\scripts\EXECUTE.sql

--	===================================================================
	set echo	on;

