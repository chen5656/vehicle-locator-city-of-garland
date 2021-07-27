	set echo	off;

	spool c:\deacutis\scripts\execute.sql;
	spool off;
	spool c:\deacutis\scripts\execute.sql;


	select	'	drop table GARLAND.'  || new_table ||';'   " "
	from		temp_view;


	spool off;


--	c:\deacutis\scripts\execute.sql;


	set echo	on;
