	set echo	off;
	set termout	off;


	spool c:\deacutis\scripts\execute.sql;
	spool off;
	spool c:\deacutis\scripts\execute.sql;

	select	'	select ''' || v.new_table ||''' "new", ''' || v.old_table || ''' "old" ' ||

			'  from dual;'						 ||chr(10)||


			'	desc    '  || t.table_name || ';'	


			" "
	from		tabs		t,
			temp_view	v

	where		t.table_name = v.new_table
	;

	spool	off;
	set termout	on;

	@c:\deacutis\scripts\Execute.sql;

	set echo	on;


