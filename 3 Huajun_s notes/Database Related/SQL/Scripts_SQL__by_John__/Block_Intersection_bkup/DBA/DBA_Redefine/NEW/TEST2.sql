
	select	
		constraint_name,						--	key
		'foreign',							--	type
		owner,							--	schema

		' ',								--	prefix
		' ',								--	suffix

		' ',								--	tablespace

		' ',								--	initial

		' ',		   						--	next

	 	' ', 	 							--	pctfree
		' ',         						--	pctused
		' ',	 							--	maxextents
		' '								--	maxtrans
	
		from	dba_constraints
		where	constraint_type = 'R'
		and	(owner,  table_name)	in
		(
			select	schema_, key_
			from		tmp_view
			where		type_ = 'table'	
		);
