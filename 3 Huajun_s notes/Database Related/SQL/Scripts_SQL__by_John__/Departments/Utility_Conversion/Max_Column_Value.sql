	set echo	off;
--	===============================================================================
--	find maximum value of a column name that is common to many tables
--	===============================================================================

	variable	col_name	varchar2(40);

	execute	:col_name	:= 'MAP_GRID';	--  SPECIFY COLUMN NAME

--	-------------------------------------------------------------------------------

	select '   select max(' || :col_name || ') from '	" "  from dual
	union all

	select
		decode (rownum, 1, ' (		 ', '   union all ')	 ||
		'select max(' || :col_name || ') ' || :col_name || ' from ' || c.owner ||'.'|| c.table_name
		" "
	from	  all_tab_columns		c,
		  all_objects		o	

	where	o.object_name	= c.table_name
	and	o.object_type	= 'TABLE'
	and	c.column_name	= :col_name

	and	c.data_type		= 'NUMBER'				--	OPTIONAL

	and	c.table_name	not like '%BKUP'
	and	c.table_name	not like '%COPY'
	and	c.table_name	not like '%ATS1'

--	and	c.table_name	not like '%ARW'
--	and	c.table_name	not like '%JUNCTION'
--	and	c.table_name	not like '%SRVLN'
--	and	c.table_name	not like '%HDWL'
--	and	c.table_name	not like '%MTR'
--	and	c.table_name	not like '%PLG'

	union all
	select ' );' " " from dual
	;

--	-------------------------------------------------------------------------------
	set echo	on;
