	set echo		off;
	set charwidth	200;
	set fetchrows	111;
--	=========================================================================================
--	Show table columns that are too small for data being loaded
--	=========================================================================================

--	=============================================================

	spool	c:\deacutis\scripts\EXECUTE.sql
	spool off
	spool	c:\deacutis\scripts\EXECUTE.sql

--	=============================================================


	select

	'	select ''' || v.column_name || ''' " ",  length(' || v.column_name || ') " ",  ' ||
	
	'''' || g.data_length 	||'   '' " ",  ''///'',  '|| v.column_name ||  ' " " ' || 

	' from temp_view1 ' ||

	' where length(' || v.column_name || ') > ' || g.data_length ||';'	" "

	from	cols		V,
		cols		G
	where	v.column_name = g.column_name

	and	v.table_name  = 'TEMP_VIEW1'
	and	g.table_name  = 'GDS_ACCOUNT'
	;


--	=============================================================

	spool	off;

--	@c:\deacutis\scripts\EXECUTE.sql

--	=========================================================================================
	set fetchrows;
	set charwidth;
	set echo	on;

