	set echo		off;
	set timing		off;
	set charwidth	300;
--	===============================================================================
--	Copy application table to temporary table
--	===============================================================================

	spool	c:\deacutis\scripts\EXECUTE_2.sql
	spool off
	spool	c:\deacutis\scripts\EXECUTE_2.sql

--	===============================================================================

	select	'	select count(*) "SOURCE" from ' || table_owner ||'.'|| table_name ||';'		" "
			from  syn	s
			where	synonym_name = 'TEMP_SYN2'	
	union all
	select	'	select count(*) "TARGET" from ' || table_owner ||'.'|| table_name ||';' ||chr(10)
			from  syn	s
			where	synonym_name = 'TEMP_SYN1'	


	union all
	select 
		'	TRUNCATE table	' || s.table_owner ||'.'|| s.table_name  || 
		'	reuse storage;' 	||chr(10)||chr(10)||
		'	alter rollback segment rb1  online;	'		 			||chr(10)||		
		'	commit;  '										||chr(10)||
		'	set transaction use rollback segment  rb1; '	 			||chr(10)
	" "
	from  syn	s
	where	synonym_name = 'TEMP_SYN1'

	union all

	select	'	insert /*+ append */	into ' || table_owner ||'.'|| table_name
			|| chr(10) || '('		" "
	from		syn
	where	 	synonym_name = 'TEMP_SYN1'

	union all


	select * from
(
	select	'	' || decode (column_id, 1, ' ', ',') || column_name	" " 
	from	 cols		c,
		 syn		s
	where	 c.table_name = s.table_name  
	and	 s.synonym_name = 'TEMP_SYN1'
	and		column_id <=
(
	select max(column_id)
	from	 cols		c,
		 syn		s
	where	 c.table_name = s.table_name  
	and	 s.synonym_name = 'TEMP_SYN2'
)
	order by	column_id
)

	union all
	select	')' || chr(10) || '	select ' 
	from		dual


	union all
	select * from
(
	select	'	' || decode (column_id, 1, ' ', ',') || column_name	" " 
	from	 cols		c,
		 syn		s
	where	 c.table_name = s.table_name  
	and	 s.synonym_name = 'TEMP_SYN2'
	and		column_id <=
(
	select max(column_id)
	from	 cols		c,
		 syn		s
	where	 c.table_name = s.table_name  
	and	 s.synonym_name = 'TEMP_SYN1'
)
	order by	column_id
)

	union all
	select '	from ' || table_owner ||'.'|| table_name ||';'
	from	syn
	where	synonym_name = 'TEMP_SYN2'

	union all
	select	chr(10) ||
		'	commit;  '								|| chr(10)||
		'	alter rollback segment rb1  offline;	  '		|| chr(10)
	from dual


	union all
	select	chr(10) ||
			'	select count(*) "SOURCE" from ' || table_owner ||'.'|| table_name ||';'
			from  syn	s
			where	synonym_name = 'TEMP_SYN2'	
	union all
	select	'	select count(*) "TARGET" from ' || table_owner ||'.'|| table_name ||';' ||chr(10)
			from  syn	s
			where	synonym_name = 'TEMP_SYN1'	

	;

--	===============================================================================

	spool	off;

--	===============================================================================
	set charwidth;




