
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

--	========================================================================
--	========================================================================

select 	'create'	|| decode ( uniqueness, 'UNIQUE', ' unique ', ' ') ||	
		'index   '	|| vw.schema_ || '.' || index_name	" ", 
		' -- ' " ", table_name, index_name, 01 seq
from 		dba_indexes ix,
		tmp_view	vw
where		table_name 	in (select key_ from tmp_view )
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= owner
and not exists (select 'x' from dba_constraints cn  where constraint_name = index_name and owner = vw.schema_)

--	------------------------------------------------------------------------

union all
select	'    on table   '   || schema_ || '.' || table_name		" ", 
		' -- ' " ", table_name, index_name, 02 seq
from 		dba_indexes ix,
		tmp_view	vw
where		table_name 	in (select key_ from tmp_view )
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= owner
and not exists (select 'x' from dba_constraints cn  where constraint_name = index_name and owner = vw.schema_)

--	------------------------------------------------------------------------

union all
select 	'(',	
		' -- ' " ", table_name, index_name, 03 seq
from 		dba_indexes ix,
		tmp_view	vw
where		table_name 	in (select key_ from tmp_view )
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= owner
and not exists (select 'x' from dba_constraints cn  where constraint_name = index_name and owner = vw.schema_)

--	------------------------------------------------------------------------

--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'		for

union all
select
rpad 	( nvl (rpad ( ',', sign ( column_position - 1) ), ' ') || rpad (column_name, 25), 50)		" ",
		' -- ' " ", ix.table_name, ix.index_name, column_position + 1000 seq
from		dba_ind_columns	co,
 		dba_indexes 	ix,
		tmp_view		vw
where		ix.table_name 	in (select key_ from tmp_view )
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= owner
and not exists (select 'x' from dba_constraints cn  where constraint_name = ix.index_name and ix.owner = vw.schema_)
and		co.index_name = ix.index_name

--	@c:\deacutis\scripts\plans\exhibit.sql;

--	------------------------------------------------------------------------

union all
select 	')',	
		' -- ' " ", table_name, index_name, 1999 seq
from 		dba_indexes ix,
		tmp_view	vw
where		table_name 	in (select key_ from tmp_view )
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= owner
and not exists (select 'x' from dba_constraints cn  where constraint_name = index_name and owner = vw.schema_)

--	------------------------------------------------------------------------

union all
select 	'tablespace ' || tablespace_ || '   pctfree ' || pctfree_ || '  pctused ' || pctused_ || '      initrans 1    maxtrans ' || maxtrans_,
		' -- ' " ", table_name, index_name, 9001 seq
from 		dba_indexes ix,
		tmp_view	vw
where		table_name 	in (select key_ from tmp_view )
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= owner
and not exists (select 'x' from dba_constraints cn  where constraint_name = index_name and owner = vw.schema_)

--	------------------------------------------------------------------------

union all
select	'storage (initial ' || initial_ || '  next ' || next_ || '  pctincrease 0   minextents 1  maxextents ' || maxextents_,
		' -- ' " ", table_name, index_name, 9002 seq
from 		dba_indexes ix,
		tmp_view	vw
where		table_name 	in (select key_ from tmp_view )
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= owner
and not exists (select 'x' from dba_constraints cn  where constraint_name = index_name and owner = vw.schema_)
		
--	------------------------------------------------------------------------

union all
select	'         ' || 'freelists 1   freelist groups 1' || ')',
		' -- ' " ", table_name, index_name, 9003 seq
from 		dba_indexes ix,
		tmp_view	vw
where		table_name 	in (select key_ from tmp_view )
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= owner
and not exists (select 'x' from dba_constraints cn  where constraint_name = index_name and owner = vw.schema_)

--	------------------------------------------------------------------------


union all
select 	';',	
		' -- ' " ", table_name, index_name, 9999 seq
from 		dba_indexes ix,
		tmp_view	vw
where		table_name 	in (select key_ from tmp_view )
and		vw.key_	= 'TABLE SPECS'
and		vw.schema_	= owner
and not exists (select 'x' from dba_constraints cn  where constraint_name = index_name and owner = vw.schema_)

--	------------------------------------------------------------------------
order by	table_name, index_name, seq;
--	------------------------------------------------------------------------


--	========================================================================	
--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'		for
--	@c:\deacutis\scripts\plans\exhibit.sql;
--	========================================================================	

