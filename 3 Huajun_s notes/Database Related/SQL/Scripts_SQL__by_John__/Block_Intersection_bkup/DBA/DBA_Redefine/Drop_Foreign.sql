

	select	'alter table ' || con.owner ||'.'|| con.table_name ||		chr(10) ||
			'drop constraint ' ||  con.constraint_name || ';'		" "

	from		user_constraints		con,
			user_cons_columns		col,
			tmp_view

	where		con.constraint_type	= 'R'	
	and		con.r_constraint_name	= col.constraint_name
	and		col.owner			= schema_
	and		col.table_name		= key_
	and		col.position		= 01
	;



