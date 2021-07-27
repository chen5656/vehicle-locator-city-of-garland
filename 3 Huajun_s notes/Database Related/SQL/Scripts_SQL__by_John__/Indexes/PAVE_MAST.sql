
	desc pave_mast;

	select * from user_ind_columns	where table_name = 'PAVE_MAST'	order by index_name, column_position;

	select * from user_dependencies	where referenced_name = 'PAVE_MAST';




/*

	alter table		pave_mast
		drop		constraint	pave_mast_pk;				--	CATEGORY, BRANCH, SECTION



	alter table		pave_mast
		add		constraint	pave_mast_pk
				primary key (branch, section, category);		--	BRANCH, SECTION, CATEGORY

*/