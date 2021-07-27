
--	display index columns for code system


	select	table_name,
			index_name,
			column_name
	from		user_ind_columns

	where		table_name in 	(
			'code',
			'codeaddr', 
			'complaint', 
			'inspection',
			'citation',
			'case_violation',
			' '			)

	order by	table_name, index_name, column_position;
	
	
