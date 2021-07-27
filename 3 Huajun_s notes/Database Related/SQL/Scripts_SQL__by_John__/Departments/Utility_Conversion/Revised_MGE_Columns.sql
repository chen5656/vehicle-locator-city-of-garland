	
--	======================================================================

--	select distinct table_name from user_tab_columns
--	where  table_name like 'UT%'
--	and	column_name like 'ASBUILT%';

--	======================================================================

--	select distinct table_name from TABS
--	where  table_name like 'UT%';

--	======================================================================

	select	distinct 
			a.column_name, a.data_length, b.data_length


	from all_tab_columns a, all_tab_columns b   


	where a.owner	= 'GARLAND'

	and	b.owner	= 'JDEACUTIS'

	and	a.table_name  = b.table_name

	and	a.column_name = b.column_name

	and	a.table_name = 'ATTRIBUTE_CATALOG'

	order by 1;
	
--	======================================================================

