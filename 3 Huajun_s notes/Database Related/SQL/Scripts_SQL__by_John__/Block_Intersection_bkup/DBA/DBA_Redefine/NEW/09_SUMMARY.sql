	set echo off;

--	Summarize results of table re-org


	select 
		rpad(owner, 12)			owner,
		rpad(table_name, 30)		table_name,
		rpad(tablespace_name, 20)	tablespace
	from dba_tables
	where	(table_name, owner) in  (select key_, schema_ from tmp_view where tablespace_ = '=table=');


	select 
		rpad(owner, 12)			owner,
		rpad(index_name, 30)		index_name,
		rpad(table_name, 30)		table_name,
		rpad(tablespace_name, 20)	tablespace,
		uniqueness
	from dba_indexes
	where	(table_name, owner) in  (select key_, schema_ from tmp_view where tablespace_ = '=table=');


	select  
		rpad(owner, 12)			owner,
		rpad(constraint_name, 30)	constraint_name,
		rpad(table_name, 30)		table_name,
		constraint_type,
		rpad(r_owner, 12)			parent_owner,
		rpad(r_constraint_name, 30)	parent_constraint
	from dba_constraints
	where	(table_name, owner) in  (select key_, schema_ from tmp_view where tablespace_ = '=table=')
	and constraint_type <> 'C';


	select
		rpad(owner, 12)			owner,
		rpad(segment_name, 30)		table_segment,
		bytes,
		extents,
		initial_extent,
		next_extent,
		rpad (tablespace_name, 20)	tablespace
	from 	dba_segments
	where	segment_type = 'TABLE'
	and (segment_name, owner) in  (select key_, schema_ from tmp_view where tablespace_ = '=table=');


	select
		rpad(owner, 12)			owner,
		rpad(segment_name, 30)		index_ssegment,
		bytes,
		extents,
		initial_extent,
		next_extent,
		rpad (tablespace_name, 20)	tablespace
	from 	dba_segments
	where	segment_type = 'INDEX'
	and (segment_name, owner)  in
	    (select index_name, owner from dba_indexes	where (table_name, table_owner) in
		   	(select key_, schema_ from tmp_view where tablespace_ = '=table=')	    );



