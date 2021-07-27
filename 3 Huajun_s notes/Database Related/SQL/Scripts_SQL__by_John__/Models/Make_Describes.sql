	set echo	off;
	set termout	off;

	spool	c:\deacutis\scripts\SQL.sql;

	select	'	select ''' || table_name ||''' " " from dual;'	||chr(10)||
			'	desc    '  || table_name || ';'			||chr(10)	" "

	from		tabs
	where		table_name		like 'UT%'
	and		table_name not	like '%_BKUP'
	and		table_name not	like '%_ATS1'
	and		table_name not	like '_BKUP'
	;

	spool	off;
	set termout	on;

	@c:\deacutis\scripts\SQL.sql;

	set echo	on;


