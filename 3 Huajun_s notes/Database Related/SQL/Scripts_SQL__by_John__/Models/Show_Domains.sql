	set echo		off;
	set charwidth	200;
--	--------------------------------------------------------------------------------------
--	display domains of table columns whose num_distinct < specified limit
--	--------------------------------------------------------------------------------------

	spool	c:\deacutis\scripts\execute.sql
	spool off
	spool	c:\deacutis\scripts\execute.sql

--	--------------------------------------------------

	select '	analyze table   garland.' || new_table || '    compute statistics;'	
	" "
	from	(	select new_table from garland.temp_view

			where new_table like 'UTSTO%'

			order by new_table	

		)


	union all
	select ' ' " " from dual
	union all


	select 	'select distinct ''' || rpad(table_name,12) ||''', '''|| rpad(column_name,20) ||''',  '||
		    	rpad(column_name,20) || ' " " '||
		 	'  from garland.'	   || table_name || ';'
	" "
	from
(	
	select	c.table_name, c.column_name

	from		cols				c,
			garland.temp_view		v			--  CHANGE

	where		c.table_name = v.new_table			--  CHANGE
	and		c.num_distinct < 100				--  CHANGE

	and		c.table_name like 'UTWAT%'

	and		c.column_name not like 'MAP%'			--  CHANGE
	and		c.column_name not like '%NUM'			--  CHANGE
	and		c.column_name not like '%ID'			--  CHANGE
	and		c.column_name not like '%_NODE'		--  CHANGE

	and		c.column_name not like '%ELEV'		--  CHANGE
	and		c.column_name not like '%SIZE%'		--  CHANGE
	and		c.column_name not like '%COMMENT%'		--  CHANGE

	and		c.column_name not in ( 'MSLINK', 'PROJECT_NUM', 'QUANTITY' )


	and		c.low_value is not null
	order by	c.table_name, c.column_name
);

--	--------------------------------------------------
	spool off
--	--------------------------------------------------

	@c:\deacutis\scripts\execute.sql;

--	--------------------------------------------------------------------------------------
	set echo	on;
	set charwidth;

			