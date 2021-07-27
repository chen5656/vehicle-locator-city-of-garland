
--	generate sql to redefine table & column comments for a specified table


	set echo 		off;
	set charwidth	200;

	variable 	spec_name	varchar2;
	execute	:spec_name := 'PAVE_MAST';		<<<<======



--	EXTRACT TABLE COMMENTS

	select
		'comment on table '	||
		:spec_name			||
		'   is '''			||		
		comments			|| 
		''';'				" "
	from	user_tab_comments
	where	table_name = 'PAVE_MAST_BKUP';



--	EXTRACT COLUMN COMMENTS

	select
		'comment on column '	||
		:spec_name			||
		'.'				||
		column_name			||
		'   is '''			||
		comments			|| 
		''';'				" "

	from	user_col_comments
	where	table_name = 'PAVE_MAST_BKUP';




	set echo 		on;
	set charwidth	80;
