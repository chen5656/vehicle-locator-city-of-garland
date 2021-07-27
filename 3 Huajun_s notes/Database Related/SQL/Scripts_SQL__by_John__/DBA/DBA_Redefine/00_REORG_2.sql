	set echo	off;

--	=====================================================================================================
--	CREATE NEW TABLE COPIES

	@c:\deacutis\scripts\ora_create\03_TABLES.sql;		

--	@d:\scripts\ora_create\NEW\03_TABLES.sql;		

--	=====================================================================================================
--	VERIFY GOOD COPIES OF ORIGINAL TABLE


	select	count(*) 			"ORIGINALS"	
	from		tmp_view	
	where		type_ = 'table';


	select 	count(*) 			"COPIES"	
	from		dba_tables,
			tmp_view	
	where 	table_name	= key_
	and		owner		= schema_
	and		'table'	= type_
	;

	select key_					"MISSING COPIES"
	from 	tmp_view
	where type_ = 'table'
	and	not exists
	(
		select	table_name
		from		dba_tables
		where		table_name	= prefix_ || key_ 
		and		owner		= schema_
	);


--	=====================================================================================================
--	VERIFY STORAGE PARAMETERS OF COPIES


	select	segment_type			"SEGMENT TYPE",
			rpad (segment_name, 30)		"SEGMENT NAME", 
			extents				"EXTENTS", 
			initial_extent			"INITIAL",
			next_extent				"NEXT",
			bytes					"SIZE"

	from		dba_segments,
		  	tmp_view

	where   	segment_name	in ( key_,  prefix_ || key_	)

	and		owner			=  schema_
	and		segment_type	in ('TABLE', 'INDEX' )
	and		type_			in ( 'table', 'index' )

	order by	1  desc, 2
	;		

--	===================================================================================================
