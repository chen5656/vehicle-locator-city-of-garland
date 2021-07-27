
--	make "create index" definitions for specified tables 

--	========================================================================
	set echo 	off;
	set timing	off;
--	========================================================================
/*	
	select rpad (segment_name,25),  segment_type, bytes, extents, owner, tablespace_name	
	from	dba_segments
	where	segment_name 	in (select alph1 from adrdebug)
	and 	owner			in ( 'GARLAND' )
	and	tablespace_name	in ( 'GIS_DATA' )  

	order by extents desc, segment_name;

	select rpad (segment_name,25),  segment_type, bytes, extents, owner, tablespace_name	
	from	dba_segments
	where	segment_name 	in (select index_name from ind where table_name in (select alph1 from adrdebug))
	and 	owner			in ( 'GARLAND' )
	and	tablespace_name	in ( 'GIS_DATA' )  

	order by extents desc, segment_name;
*/

--	=========================================================================================================

	truncate table	gis_objects	reuse storage;

	alter rollback segment rb_large	online;
	set transaction	use rollback segment	rb_large;

	insert into gis_objects ( item01, item02, item03, item04, item05 )
		
--	========================================================================
--	========================================================================

	select 	'select ''' || index_name ||''' " " from dual;' " ",
			' -- ' " ", table_name, index_name, '0001' seq

	from 		dba_indexes ix,
			tmp_view
	where		ix.index_name	= key_
	and		ix.owner		= schema_
	and		'index'		= type_
	and not exists (select 'x' from dba_constraints  where constraint_name = ix.index_name and owner = ix.owner)
	union all

	
	select	rpad (
			'drop   index   ' || schema_ || '.' || prefix_ ||  index_name || ';'	,60) " ",
			' -- ' " ", table_name, index_name, '0002' seq
	from 		dba_indexes ix,
			tmp_view
	where		ix.index_name	= key_
	and		ix.owner		= schema_
	and		'index'		= type_
	and		'drop'		= option1_
	and not exists (select 'x' from dba_constraints  where constraint_name = ix.index_name and owner = ix.owner)
	union all

--	------------------------------------------------------------------------

	select 	'create'	|| decode ( uniqueness, 'UNIQUE', ' unique ', ' ') ||	
			'index   '	|| schema_ || '.' || prefix_ || index_name	" ", 
			' -- ' " ", table_name, index_name, '0101' seq
	from 		dba_indexes ix,
			tmp_view	vw
	where		ix.index_name	= key_
	and		ix.owner		= schema_
	and		'index'		= type_
	and not exists (select 'x' from dba_constraints  where constraint_name = ix.index_name and owner = ix.owner)

--	------------------------------------------------------------------------

	union all
	select	'       on      '   || schema_ || '.' || prefix_ || table_name		" ", 
			' -- ' " ", table_name, index_name, '0102' seq
	from 		dba_indexes ix,
			tmp_view	vw
	where		ix.index_name	= key_
	and		ix.owner		= schema_
	and		'index'		= type_
	and not exists (select 'x' from dba_constraints  where constraint_name = ix.index_name and owner = ix.owner)

--	------------------------------------------------------------------------

	union all
	select 	'(',	
			' -- ' " ", table_name, index_name, '0103' seq
	from 		dba_indexes ix,
			tmp_view	vw
	where		ix.index_name	= key_
	and		ix.owner		= schema_
	and		'index'		= type_
	and not exists (select 'x' from dba_constraints  where constraint_name = ix.index_name and owner = ix.owner)

--	------------------------------------------------------------------------

--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'		for

	union all
	select
	rpad 	( nvl (rpad ( ',', sign ( column_position - 1) ), ' ') || rpad (column_name, 25), 50)		" ",
			' -- ' " ", ix.table_name, ix.index_name, rtrim(column_position + 1000) seq
	from		dba_ind_columns	co,
	 		dba_indexes 	ix,
			tmp_view		vw
	where		ix.index_name 	= co.index_name
	and		ix.table_name	= key_
	and		ix.owner		= schema_
	and		'table'		= type_
	and not exists (select 'x' from dba_constraints  where constraint_name = ix.index_name and owner = ix.owner)

--	@c:\deacutis\scripts\plans\exhibit.sql;

--	------------------------------------------------------------------------

	union all
	select 	')',	
			' -- ' " ", table_name, index_name, '1999' seq
	from 		dba_indexes ix,
			tmp_view	vw
	where		ix.index_name	= key_
	and		ix.owner		= schema_
	and		'index'		= type_
	and not exists (select 'x' from dba_constraints  where constraint_name = ix.index_name and owner = ix.owner)

--	------------------------------------------------------------------------

	union all
	select	rpad (
	 	'tablespace ' || tablespace_ 	,60)	" ",
		' -- ' " ", table_name, index_name, '9001' seq
	from 		dba_indexes ix,
			tmp_view	vw
	where		ix.index_name	= key_
	and		ix.owner		= schema_
	and		'index'		= type_
	and not exists (select 'x' from dba_constraints  where constraint_name = ix.index_name and owner = ix.owner)

--	------------------------------------------------------------------------

	union all
	select	rpad (
			'storage   (initial ' || initial_ || ' next ' || next_ || ' pctincrease 0' 	,60) " ",
			' -- ' " ", table_name, index_name, '9003' seq
	from 		dba_indexes 	ix,
			tmp_view		vw
	where		ix.index_name	= key_
	and		ix.owner		= schema_
	and		'index'		= type_
	and not exists (select 'x' from dba_constraints  where constraint_name = ix.index_name and owner = ix.owner)

--	------------------------------------------------------------------------

	union all
	select	rpad (
			'           ' || 'minextents 1  maxextents '  || maxextents_	,60)	" ",
			' -- ' " ", table_name, index_name, '9004' seq
	from 		dba_indexes ix,
			tmp_view	vw
	where		ix.index_name	= key_
	and		ix.owner		= schema_
	and		'index'		= type_
	and not exists (select 'x' from dba_constraints  where constraint_name = ix.index_name and owner = ix.owner)
	
--	------------------------------------------------------------------------

	union all
	select	rpad (
			'           ' || 'freelists  1  freelist groups 1' || ')'	,60)	" ",
			' -- ' " ", table_name, index_name, '9005' seq
	from 		dba_indexes ix,
			tmp_view	vw
	where		ix.index_name	= key_
	and		ix.owner		= schema_
	and		'index'		= type_
	and not exists (select 'x' from dba_constraints  where constraint_name = ix.index_name and owner = ix.owner)

--	------------------------------------------------------------------------

	union all
	select 	';',	
			' -- ' " ", table_name, index_name, '9999' seq
	from 		dba_indexes ix,
			tmp_view	vw
	where		ix.index_name	= key_
	and		ix.owner		= schema_
	and		'index'		= type_
	and not exists (select 'x' from dba_constraints  where constraint_name = ix.index_name and owner = ix.owner)

--	------------------------------------------------------------------------
--	order by	table_name, index_name, seq;
--	------------------------------------------------------------------------

--	------------------------------------------------------------------------
;

	commit;
	alter rollback segment	rb_large	offline;	

	set timing	off;

--	------------------------------------------------------------------------
	spool	c:\deacutis\scripts\ora_create\Script_Index.sql;

	select rpad (item01, 70) " "	from gis_objects  order by item03, item04, item05;

	spool off;
--	------------------------------------------------------------------------



