	set echo 		off;
	set charwidth	200;
--	==========================================================================================================

	spool c:\deacutis\scripts\execute.sql;
	spool off;
	spool c:\deacutis\scripts\execute.sql;

--	select '	select count(*) "' || old_table  || '" from GARLAND.'   || old_table || ';' 	||chr(10)||

	select '	select count(*) "' || new_table  || '" from GARLAND.'   || new_table || ';' 	||chr(10)||
		 '	select count(*) "' || new_table  || '" from JDEACUTIS.' || new_table || ';'   ||chr(10)  

	" "
	from	 temp_view;

	spool	off;

	@c:\deacutis\scripts\execute.sql;

--	==========================================================================================================
/*


	spool c:\deacutis\scripts\execute.sql;
	spool off;
	spool c:\deacutis\scripts\execute.sql;

	select '	select count(*) "' || table_name || '" from GARLAND.'   || table_name || ';' 	||chr(10)||
		 '	select count(*) "' || table_name || '" from JDEACUTIS.' || table_name || ';'  ||CHR(10)  " "

	from	 all_tables		
	where	 owner = 'JDEACUTIS'
	and	 table_name like 'UT%';

	spool	off;

	@c:\deacutis\scripts\execute.sql;

*/
--	==========================================================================================================
	set echo 		on;
	set charwidth;

