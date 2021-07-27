	set echo off;

--	Summarize results of table re-org


	select 
		rpad(owner, 12)			owner,
		rpad(table_name, 30)		table_name,
		rpad(tablespace_name, 20)	tablespace
	from 	dba_tables,
		tmp_view
	where	table_name	= key_
	and	owner		= schema_
	and	'table'	= type_	
	;


	select 
		rpad(owner, 12)			owner,
		rpad(index_name, 30)		index_name,
		rpad(table_name, 30)		table_name,
		rpad(tablespace_name, 20)	tablespace,
		uniqueness
	from 	dba_indexes,
		tmp_view
	where	table_name	= key_
	and	owner		= schema_
	and	'table'	= type_	
	;

	select  
		rpad(owner, 12)			owner,
		rpad(constraint_name, 30)	constraint_name,
		rpad(table_name, 30)		table_name,
		constraint_type,
		rpad(r_owner, 12)			parent_owner,
		rpad(r_constraint_name, 30)	parent_constraint
	from 	dba_constraints,
		tmp_view
	where	table_name	= key_
	and	owner		= schema_
	and	'table'	= type_	
	and constraint_type <> 'C'
	;


	select
		rpad(owner, 12)			owner,
		rpad(segment_name, 30)		table_segment,
		bytes,
		extents,
		initial_extent,
		next_extent,
		rpad (tablespace_name, 20)	tablespace
	from 	dba_segments,
		tmp_view
	where	segment_type = 'TABLE'
	and	segment_name	= key_
	and	owner			= schema_
	and	'table'		= type_
	;	


	select
		rpad(owner, 12)			owner,
		rpad(segment_name, 30)		index_segment,
		bytes,
		extents,
		initial_extent,
		next_extent,
		rpad (tablespace_name, 20)	tablespace
	from 	dba_segments
	where	segment_type = 'INDEX'
	and ( segment_name, owner)  in
		(	    
			select index_name, owner 
			from 	dba_indexes,
				tmp_view		
			where	table_name	= key_	
			and	owner		= schema_
			and	'table'	= type_	
		);



	select  
		rpad(owner, 12)			owner,
		rpad(constraint_name, 30)	constraint_name,
		rpad(table_name, 30)		table_name,
		constraint_type,
		rpad(r_owner, 12)			parent_owner,
		rpad(r_constraint_name, 30)	parent_constraint
	from 	dba_constraints,
		tmp_view
	where	table_name	= key_
	and	owner		= schema_
	and	'table'	= type_	
	and constraint_type = 'R'
	;



	select
		table_name,
		trigger_name,
		trigger_type
	from	dba_triggers,
		tmp_view
	where	table_name	= key_
	and	owner		= schema_
	and	'table'	= type_
	;



	select
		table_name,
		privilege
	from	dba_tab_privs,
		tmp_view
	where	table_name	= key_
	and	owner		= schema_
	and	'table'	= type_
	

