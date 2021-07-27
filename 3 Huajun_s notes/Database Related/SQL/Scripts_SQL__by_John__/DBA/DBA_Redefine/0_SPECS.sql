	set echo		off;	
--	========================================================================
--	RE-ORG SPECIFICATIONS
--	========================================================================
--	PREPARATION

--		SPECIFY TABLE NAMES	to be processed	<<<<<<******************

--		Specify parameters 	for tables
--		Specify parameters 	for indexes
--		Specify parameters 	for snapshots
--		Specify schema name	to be processed
--	========================================================================

	@c:\deacutis\scripts\dba\dba_redefine\View_Specs.sql;

	Truncate table	GIS_Objects		reuse storage;

--	========================================================================
--	TABLE PARAMETERS

	insert into 	tmp_view	
	(	key_,		 type_,	schema_,	 prefix_,	suffix_,	tablespace_,   
		initial_,	 next_,	maxextents_, maxtrans_, pctfree_,	pctused_,   
		option1_,	 option2_,	dblink_
	) 

	select	
		seg.segment_name,						--	key
		'table',							--	type
		seg.owner,							--	schema
		'',								--	prefix

		'',								--	suffix
--		'_COPY',							--	suffix


		'GIS_DATA',							--	tablespace			
--		seg.tablespace_name,

		'50K',
--		(ceil(seg.bytes/1000000) + 0) || 'M',		--	initial	
--		floor (seg.initial_extent/1000000) || 'M',

		'50K',
--		(ceil(seg.bytes/(10 * 1000000)) + 0) || 'M',	--	next
--		floor (seg.next_extent/1000000) || 'M',

--		'249',	 						--	maxextents
		seg.max_extents,

--		'255',							--	maxtrans
		tab.max_trans,

--	 	'10', 	 						--	pctfree
		tab.pct_free,

--		'40',         						--	pctused
		tab.pct_used,

		'drop',							--	option1   ('drop')
		' ',								--	option2

		''
--		'@gis2.world'						--	dblink

	
	from	dba_segments	seg,
		dba_tables		tab

	where	segment_type	in ( 'TABLE' )
	and	tab.owner		= seg.owner
	and	tab.table_name	= seg.segment_name

--	and	( extents > 01	)

--	============================================================================================
--	SPECIFY TABLES FOR RE-ORG
--	============================================================================================

	and	tab.owner 	= 'SDE'
--	and	tab.owner 	= 'GARLAND'

--	-------------------------------------------------------------------------------------------

--	and	table_name = 'ADRSTREETS'

--	and	table_name like 'UT%'

--	and	table_name like '%OLD'	

--	and	length (table_name) <= 09


--	and	table_name not like '%COPY'	
--	and	table_name not like '%BKUP'	
--	and	table_name not like '%ATS1'	
--	and	table_name not like 'POPCN%'	
--	and	table_name not like 'RI05%'	
--	and	table_name not like 'EVT%'	
--	and	table_name not like 'SM%'	

--	-------------------------------------------------------------------------------------------
/*

--	and (	tab.table_name	like '%'
--	or	tab.table_name	like '%'
--	or	tab.table_name	like '%'
--	or	tab.table_name	like '%'
--	or	tab.table_name	like '%'
--	or	tab.table_name	like '%'
--	or	tab.table_name	like '%'
	)

*/
--	-------------------------------------------------------------------------------------------
/*

	and	tab.table_name	in	
(
	' '
)

*/
--	-------------------------------------------------------------------------------------------

	and	not exists
	( 	select 	'x'	
		from 		dba_tab_columns 
		where		data_type = 'LONG'
		and		table_name	= seg.segment_name	
	)

	order by 1

	;
	commit;

--	============================================================================================
--	INDEX PARAMETERS

	insert into 	tmp_view	
	(	key_,		 type_,	schema_,	prefix_,	suffix_,	tablespace_,   
		initial_,	 next_,	maxextents_, maxtrans_, pctfree_,	pctused_,   
		option1_,	 option2_
	) 

	select	

		segment_name,						--	key
		'index',							--	type
		seg.owner,							--	schema
		'',								--	prefix

		'',								--	suffix
--		'_COPY',							--	suffix

		'GISINDX',							--	tablespace			
--		seg.tablespace_name,

		'50K',
--		(ceil(seg.bytes/1000000) + 0) || 'M',		--	initial	
--		floor (seg.initial_extent/1000000) || 'M',

		'50K',
--		(ceil(seg.bytes/(10 * 1000000)) + 0) || 'M',	--	next
--		floor (seg.next_extent/1000000) || 'M',

--		'249',	 						--	maxextents
		seg.max_extents,

--		'255',							--	maxtrans
		ind.max_trans,

--	 	'05', 	 						--	pctfree
		ind.pct_free,

		'40',         						--	pctused

		' ',								--	option1
		' '								--	option2

	from	dba_segments	seg,
		dba_indexes		ind,
		tmp_view

	where	segment_type	in ( 'INDEX' )
	and	ind.owner		= seg.owner
	and	ind.index_name	= seg.segment_name
	and	ind.table_owner	= schema_
	and	ind.table_name	= key_
	and	'table'		= type_

	order by 1
	;
	commit;

--	============================================================================================
--	SNAPSHOT PARAMETERS

/*

	insert into 	tmp_view	
	(	key_,		 type_,	schema_,	 prefix_,	suffix_,	tablespace_,   
		initial_,	 next_,	maxextents_, maxtrans_, pctfree_,	pctused_,   
		option1_,	 option2_
	) 

	select	

		seg.segment_name,						--	key
		'snapshot',							--	type
		seg.owner,							--	schema
		'',								--	prefix
		'',								--	suffix

--		'GIS_DATA',							--	tablespace			
		seg.tablespace_name,

		(ceil(seg.bytes/1000000) + 0) || 'M',		--	initial	
--		floor (seg.initial_extent/1000000) || 'M',

		(ceil(seg.bytes/(10*1000000)) + 0) || 'M',	--	next
--		floor (seg.next_extent/1000000) || 'M',

--		'249',	 						--	maxextents
		seg.max_extents,

--		'255',							--	maxtrans
		tab.max_trans,

--	 	'10', 	 						--	pctfree
		tab.pct_free,

--		'40',         						--	pctused
		tab.pct_used,

		' ',								--	option1
		' '								--	option2

	from	dba_snapshots	snap,
		dba_dependencies	depm,			--	MVIEW$
		dba_dependencies	deps,			--	SNAP$					method 1		
		dba_segments	seg,
		dba_tables		tab,
		tmp_view

	where	schema_			= depm.referenced_owner 
	and	key_				= depm.referenced_name
	and	type_				= 'table'

	and	depm.type			= 'VIEW'
	and	depm.owner			= snap.owner
	and	depm.name			= snap.master_view

--	and	seg.segment_type		= 'TABLE'						--	method 2
--	and	seg.owner			= depm.referenced_owner	
--	and	seg.segment_name		= 'SNAP$_' || substr (depm.name, 08)	

	and	deps.type			= 'VIEW'						--	method 1
	and	deps.owner			= snap.owner
	and	deps.name			= snap.name

	and	seg.segment_type		= 'TABLE'						--	method 1
	and	seg.owner			= deps.referenced_owner	
	and	seg.segment_name		= deps.referenced_name	

	and	seg.owner			= tab.owner
	and	seg.segment_name		= tab.table_name

	order by	1
	;
	commit;

*/

--	============================================================================================
--	SCHEMA SPECIFICATION

	insert into 	tmp_view	
	(	key_,		 type_,	schema_,	prefix_,	suffix_,	tablespace_,   
		initial_,	 next_,	pctfree_,	pctused_,   maxextents_, maxtrans_,
		option1_,	 option2_
	) 
	values
	(  
		'all',						--	key

--		'as',							--	type		for create AS select
		'all',						--	type		for ALL objects in schema

		'GARLAND',     					--	schema
		 null, null, null, 
		 null, null, null, null, null, null,
		 null, null  
	);
	commit;

--	============================================================================================
--	DISPLAY REORG SPECIFICATION TABLE

	select * 
	from		tmp_view
	order by	type_	desc, 
			key_	asc
	;

--	============================================================================================

	set echo	on;

