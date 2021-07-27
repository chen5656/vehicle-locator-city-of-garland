	set echo		off;
	set termout		off;
	set charwidth	300;
--	=================================================================================
--	display the minimum, maximum, count, and distinct count  for table columns
--	optional: use analyze results
--	=================================================================================

	variable	 owner	varchar2(20);
	variable	 tables	varchar2(20);

	execute	:owner  := 	'GARLAND';
	execute	:tables := 	'UTSTO%';

--	=================================================================================

	spool	c:\deacutis\scripts\execute.sql
	spool off;
	spool	c:\deacutis\scripts\execute.sql

--	=================================================================================

--	truncate table	plan_table	reuse storage;
--	explain plan	set statement_id = 'xxx'	for

--	-----------------------------------------------------------------------------

--	select '	analyze table garland.' || old_table || ' compute statistics;'	" "
--	from	 temp_view		union all

--	-----------------------------------------------------------------------------

	select
		'	select '' '' " ",		
					 '' '' "Table",		'' '' "Column", 
					 '' '' "Min Value",	'' '' "Max Value",
					 '' '' "Count ",  
					 '' '' "Domain" 		
						from dual' 
			" "	from dual
	union all

(
	select	
		'	union all  select null " "  '
			|| ',''' || table_name  || '  ''   '  
			|| ' ,'' '''
			|| ' ,'' '''
			|| ' ,'' '''
			|| ' ,lpad(count(*),06) '
			|| ' ,'' '''
			|| ' from garland.' ||table_name 
	" "
	from	 dba_tab_columns		c,
		 temp_view			v

	where	 c.owner		= :owner		
	and	 c.table_name like  :tables		
	and	 c.table_name 	= v.old_table		--  special


	union


	select	

		'	union all  select null " "  '

			|| ',''' || table_name  || '  ''   '  
			|| ',''' || column_name || '  ''   '  

			|| ' ,rpad(min('  ||column_name|| '),25)  '
			|| ' ,rpad(max('  ||column_name|| '),25)  '


			|| ' ,lpad(count(' ||column_name|| '),06) '
--			|| ' ,replace(lpad('	||nvl(t.num_rows,0)|| ',06), '' 0'')  '	--	EXCESSIVE TIME

			|| ' ,replace(lpad(nvl(count(distinct ' || column_name || '), 0), 6), '' 0'')  '
--			|| ' ,replace(lpad('	||nvl(c.num_distinct,0)|| ',06), '' 0'') ' --	ANALYZE TABLE

			|| ' from garland.' ||table_name 
	" "
	from	
(
	select distinct c.table_name, c.column_name, c.num_distinct
	from	 dba_tab_columns		c,
		 temp_view			v

	where	 c.owner		= :owner		
	and	 c.table_name like  :tables		

	and	 c.table_name 	= v.new_table		--  SPECIFY

	order by  c.table_name, column_name
)
)


	union all
	select	'	;' " "		from dual;


--	=================================================================================

--	select * from explain_plan;


	spool off;
	set termout		on;

--	=================================================================================

	@c:\deacutis\scripts\execute.sql;

--	=================================================================================
	set echo		on;
	set charwidth;



