	set echo		off;
	set charwidth	160;
--	================================================================================
--	Show utility date columns 
--	Look for those containing the standard Oracle date format (15-MAR-03)
--	================================================================================

	spool c:\deacutis\scripts\execute.sql;
	spool off;
	spool c:\deacutis\scripts\execute.sql;


	select	' select ''' || table_name || ''' " ",''' || column_name ||
			''' " ", max(' || column_name ||')	" "'	||
			'  from  garland.'   || table_name || 
			'  where ' || column_name || ' is not null;'	


	" "
	from		all_tab_columns

	where		owner = 'GARLAND'

	and		table_name like 'UT%'
	and		length(table_name) <= 10
	and		column_name like '%DATE%'
	;

	
	spool off;

	@c:\deacutis\scripts\execute.Execute;

--	================================================================================
	set echo		on;
	set charwidth;
