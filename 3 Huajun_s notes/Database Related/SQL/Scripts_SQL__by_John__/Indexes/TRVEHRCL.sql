
TRVEHRCL


	desc trvehrcl;

	select * from user_ind_columns	where table_name = 'TRVEHRCL'		order by index_name, column_position;

	select * from user_dependencies	where referenced_name = 'TRVEHRCL';



/*

	
	create index	trvehrcl_x_branch_section
		on		trvehrcl  (branch_no, section_no)
		tablespace	gisindx
		storage	(initial 1m  next 1m  pctincrease 0);

*/








