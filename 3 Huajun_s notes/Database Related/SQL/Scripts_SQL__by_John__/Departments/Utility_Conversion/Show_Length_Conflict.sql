
--	============================================================================
--	which GARLAND columns have a longer length than their JDEACUTIS columns
--	============================================================================

	select g.table_name, g.column_name, rpad(g.data_type,10) data_type, 
		 g.data_length, j.data_length

	from	all_tab_columns	g,
		all_tab_columns	j,
		temp_view		v

	where	g.owner		= 'GARLAND'
	and	j.owner		= 'JDEACUTIS'

	and	j.table_name	like 'UT%'

	and	g.table_name	= v.old_table
	and	j.table_name	= v.new_table

	and	g.column_name	= j.column_name
	and	g.data_length	> j.data_length
	;
