	set echo		off;
	set charwidth	200;

	spool c:\deacutis\scripts\Execute.sql;
	spool off;
	spool c:\deacutis\scripts\Execute.sql;

--	===========================================================================================
--	display sample values of "ID" columns in utility tables
--	===========================================================================================

	select	'	select  '''				||
			 rpad(table_name,20) 			|| 
			''','						||
			 rpad(column_name,20) 			|| 
			' from ' || rpad(table_name,12) 	|| 
			'  where '  || column_name || ' > ''0'''	||
			'  and  rownum < 2;'  

			" "
	from		all_tab_columns		c,
			temp_view			v

	where		c.table_name = v.old_table || '_OLD'

	and		owner = 'GARLAND'

	and		table_name 		like 'UT%'

	and		column_name 	like '%ID'
	and		column_name not	like 'MAP%'
	and		column_name not	like '%NODE%'
	and		column_name not	like '%BASIN%'

	order by	table_name, column_name;

--	===========================================================================================

	spool		off;

	@c:\deacutis\scripts\Execute.sql;

--	===========================================================================================

	set echo		on;
	set charwidth;
