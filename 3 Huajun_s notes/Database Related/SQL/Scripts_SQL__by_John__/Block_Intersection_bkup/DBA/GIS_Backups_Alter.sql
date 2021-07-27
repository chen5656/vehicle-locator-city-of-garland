	set echo off;
--	================================================================================

	select
		'    alter table   garland.' || table_name || '  add   ' || rpad(column_name,20) ||'  '||  
		data_type || '(' || data_length || ');'

	" "
	from

(
	select 'CDRELADR' table_name, column_name, data_type, data_length, column_id
	from
(
	select column_name, data_type, data_length, column_id	from all_tab_columns
	where	 table_name = 'CDRELADR'
	minus
	select column_name, data_type, data_length, column_id	from all_tab_columns
	where	 table_name = 'CDRELADR_COPY'
)

	UNION ALL

	select 'CDRELPAR' table_name, column_name, data_type, data_length, column_id
	from
(
	select column_name, data_type, data_length, column_id	from all_tab_columns
	where	 table_name = 'CDRELPAR'
	minus
	select column_name, data_type, data_length, column_id	from all_tab_columns
	where	 table_name = 'CDRELPAR_COPY'
)


	UNION ALL

	select 'TRVEHRCL' table_name, column_name, data_type, data_length, column_id
	from
(
	select column_name, data_type, data_length, column_id	from all_tab_columns
	where	 table_name = 'TRVEHRCL'
	minus
	select column_name, data_type, data_length, column_id	from all_tab_columns
	where	 table_name = 'TRVEHRCL_COPY'
)



	UNION ALL

	select 'PAVE_MAST' table_name, column_name, data_type, data_length, column_id
	from
(
	select column_name, data_type, data_length, column_id	from all_tab_columns
	where	 table_name = 'PAVE_MAST'
	minus
	select column_name, data_type, data_length, column_id	from all_tab_columns
	where	 table_name = 'PAVE_MAST_COPY'
)
)

	order by table_name, column_id;

--	================================================================================
	set echo on;



