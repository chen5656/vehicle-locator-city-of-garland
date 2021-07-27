	set echo off;

--	application table relationships
--	======================================================================================================
--	dependencies

	select name, type, rpad(referenced_name,20) "ref name", referenced_type "ref type", dependency_type "type"
	from user_dependencies	where name in 
	( 'P2K_HR_IDENTITIES', 'P2K_HR_PERSONALS',  'P2K_AM_USER_FIELD_VALUES' )
	order by name, referenced_name;

	select name, type, rpad(referenced_name,20) "ref name", referenced_type "ref type", dependency_type "type"
	from user_dependencies	where referenced_name in 
	( 'P2K_HR_IDENTITIES', 'P2K_HR_PERSONALS',  'P2K_AM_USER_FIELD_VALUES' )
	order by referenced_name, name;

--	======================================================================================================
--	constraints

	select constraint_name "name", rpad(constraint_type,4) "type", table_name, r_constraint_name, 
		 status, delete_rule, search_condition
	from user_constraints	where table_name in 
	( 'P2K_HR_IDENTITIES', 'P2K_HR_PERSONALS',  'P2K_AM_USER_FIELD_VALUES' )
	order by constraint_name, table_name;

	select constraint_name, table_name, rpad(column_name,20) "column", position
	from user_cons_columns	where table_name in 
	( 'P2K_HR_IDENTITIES', 'P2K_HR_PERSONALS',  'P2K_AM_USER_FIELD_VALUES' )
	order by constraint_name, table_name, column_name, position;

--	======================================================================================================
--	indexes

	select table_name, index_name, index_type, uniqueness, tablespace_name, distinct_keys, num_rows, last_analyzed 
	from user_indexes		where table_name in 
	( 'P2K_HR_IDENTITIES', 'P2K_HR_PERSONALS',  'P2K_AM_USER_FIELD_VALUES' )
	order by table_name, index_name; 

	select table_name, index_name, rpad(column_name,20) "column", column_position "pos", column_length "len"  
	from user_ind_columns	where table_name in 
	( 'P2K_HR_IDENTITIES', 'P2K_HR_PERSONALS',  'P2K_AM_USER_FIELD_VALUES' )
	order by table_name, index_name, column_position;

--	======================================================================================================
--	tables

	select table_name, num_rows, avg_row_len, last_analyzed, chain_cnt
	from user_tables		where table_name in 
	( 'P2K_HR_IDENTITIES', 'P2K_HR_PERSONALS',  'P2K_AM_USER_FIELD_VALUES' )
	order by table_name;

	select table_name, column_name, data_type, data_length, rpad(nullable,4) "null"
	from user_tab_columns	where table_name in 
	( 'P2K_HR_IDENTITIES', 'P2K_HR_PERSONALS',  'P2K_AM_USER_FIELD_VALUES' )
	order by table_name, column_name;

--	======================================================================================================
--	comments

	select * from user_tab_comments	where table_name in 
	( 'P2K_HR_IDENTITIES', 'P2K_HR_PERSONALS',  'P2K_AM_USER_FIELD_VALUES' )
	order by table_name;

	select * from user_col_comments	where table_name in 
	( 'P2K_HR_IDENTITIES', 'P2K_HR_PERSONALS',  'P2K_AM_USER_FIELD_VALUES' )
	order by table_name, column_name;

--	======================================================================================================
