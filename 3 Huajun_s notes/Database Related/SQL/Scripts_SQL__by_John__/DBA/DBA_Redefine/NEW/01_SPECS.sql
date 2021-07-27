	set charwidth	100;
	set echo 		off;
	set timing		off;

--	========================================================================
--	CREATE ALL SCRIPTS FOR SPECIFIC TABLES
--	========================================================================

--	========================================================================
--	Specify control parameters in tmp_view  (below)
--	Note:  The INITIAL size is dynamically calculated as the smallest multiple of 32K needed for 1 extent
--		 ie. the initial_ spec is ignored. 

--	Specify which tables should be re-org'd (further below)
--	========================================================================


--	========================================================================
	truncate table	gis_objects	reuse storage;
--	========================================================================

	insert into 	tmp_view	
	(   key_,		schema_,	  tablespace_,   initial_,      next_,        pctfree_,  pctused_,   maxextents_,  maxtrans_, name_append	) 
	values
	(  'TABLE SPECS', 'GARLAND',   'GIS_DATA',    '500K',        '32K',         10, 	   40,         249,	    255,		'NEW_'	);


	insert into 	tmp_view	
	values
	(  'FROM SCHEMA', 'GARLAND',     null, null, null, null, null, null, null, null  );

	commit;

--	========================================================================

	insert into		tmp_view	(key_, schema_, tablespace_ )	
		select	segment_name, owner, '=table=' 		
		from   	dba_segments	

		where		segment_type	in ( 'TABLE', 		' ')
		and		owner 		in ( 'GARLAND', 		' ')
		and	(	extents > 01	or 	bytes < 33000	)

--	------------------------------------------------------------------------
--	SPECIFY TABLES FOR RE-ORG

	and segment_name in	
	(

	select segment_name from user_segments
		 where segment_type = 'TABLE'

--	 	and	segment_name like 'POPCN%'

--		and	extents between 02 and 05

		and	segment_name like 'UT%'


	minus	(
		select item01	from john_active
		union
		select table_name	from tabs		where table_name like 'RI05%'

		union
		select table_name	from dba_constraints where constraint_name in (select r_constraint_name from dba_constraints)
		union
		select table_name	from dba_tab_columns where data_type = 'LONG'
		)
	)


--	============================================================================================
/*

	select segment_name from user_segments 	where segment_type = 'TABLE' and bytes < 33000
	minus	( select item01	from john_active
	

*/
--	============================================================================================


	;  
	commit;
--	========================================================================
