	set echo	off;
--	===================================================================

	spool	c:\deacutis\scripts\EXECUTE.sql
	spool off
	spool	c:\deacutis\scripts\EXECUTE.sql

--	-------------------------------------------------------------------

	select	'	create or replace view	garland.TEMP_VIEW1 '  ||chr(10)|| '('	" "
	from	dual

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
	select	')' || chr(10) || '	as select ' 
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
	;

--	-------------------------------------------------------------------

	spool off

--	@c:\deacutis\scripts\EXECUTE.sql

	desc garland.temp_view1;

--	===================================================================
	set echo	on;


