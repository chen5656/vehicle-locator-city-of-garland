	set echo		off;
	set charwidth	200;
--	=============================================================
--	Save adrResult into application adrResult
--	=============================================================

	drop synonym	syn_input_table;
	drop synonym	syn_output_table;

	create synonym	syn_input_table	for garland.adrResult;				--	CHANGE
	create synonym	syn_output_table	for garland.adrResult_UMS_LOCATION;		--	CHANGE

--	=============================================================
--	table comments

	comment on table	garland.syn_output_table	is
	'WATER ALPHA5 Nov 3 2004';									--	CHANGE

--	=============================================================

	spool	c:\deacutis\scripts\EXECUTE.sql
	spool off
	spool	c:\deacutis\scripts\EXECUTE.sql

--	=============================================================

	select 
		'	TRUNCATE table	' || s.table_owner ||'.'|| s.table_name  || 
		'	reuse storage;' 	||chr(10)||chr(10)||
		'	alter rollback segment rb1  online;	'		 			||chr(10)||		
		'	commit;  '										||chr(10)||
		'	set transaction use rollback segment  rb1; '	 			||chr(10)
	" "
	from  syn	s
	where	synonym_name = 'SYN_OUTPUT_TABLE'

	union all

	select	'	insert /*+ append */	into ' || table_owner ||'.'|| table_name   " "
	from		syn
	where	 	synonym_name = 'SYN_OUTPUT_TABLE'

	union all
	select * from
(
	select	'	select all *		from ' || s.table_owner ||'.'|| s.table_name ||';'
	from	 syn		s
	where	 s.synonym_name = 'SYN_INPUT_TABLE'
)

	union all
	select	chr(10) ||
		'	commit;  '								|| chr(10)||
		'	alter rollback segment rb1  offline;	  '		|| chr(10)
	from dual

	union all
	select	chr(10) ||
			'	select rpad(count(*),30) "' || table_name || '" from ' || 
				table_owner   ||'.'|| table_name ||';' ||chr(10)
			from  syn	s
			where	synonym_name = 'SYN_INPUT_TABLE'	

	union all
	select	'	select rpad(count(*),30) "' || table_name || '" from ' || 
				table_owner   ||'.'|| table_name ||';' ||chr(10)
			from  syn	s
			where	synonym_name = 'SYN_OUTPUT_TABLE'	

	union all
	select	'	analyze table   ' || s.table_owner ||'.'|| table_name || '	compute statistics;'
			from  syn	s
			where	synonym_name = 'SYN_OUTPUT_TABLE'	
	;

--	=============================================================

	spool	off;

	@c:\deacutis\scripts\EXECUTE.sql

--	=============================================================
	set charwidth;
	set echo	on;


