
--	make "create table as select" command

--	========================================================================
	set echo 		off;
--	=========================================================================================================

	truncate table	gis_objects	reuse storage;

	alter rollback segment rb_large	online;
	set transaction	use rollback segment	rb_large;

	insert into gis_objects ( item01, item02, item03, item04 )

--	=========================================================================================================

	select 	'select ''CREATE ' || table_name || ''' " " from dual;'	" ",
		 	' -- ' " ", rpad (table_name,30) table_name, '0001' seq
	from 		dba_tables,
			tmp_view
	where		table_name	= key_
	and		owner		= schema_
	and		type_		= 'table'
	union all

	
	select	rpad (
			'drop   table   ' || schema_ || '.' || prefix_ || table_name || suffix_ || ';'	,60) " ",
			' -- ' " ", rpad (table_name,30) table_name, '0002' seq
	from 		dba_tables,
			tmp_view
	where		table_name	= key_
	and		owner		= schema_
	and		type_		= 'table'
	and		option1_	= 'drop'
	union all


--	------------------------------------------------------------------------
--	------------------------------------------------------------------------

select	rpad (
	 	'create table   ' || owner || '.' || prefix_ || table_name || suffix_	,60)	" ",	
		' -- ' " ", rpad (table_name,30) table_name, '0101' seq
from 		dba_tables,
		tmp_view	
where		table_name	= key_
and		owner		= schema_
and		'table'	= type_

--	------------------------------------------------------------------------

union all
select	rpad (
	 	'tablespace ' || tablespace_ || '   pctfree ' || pctfree_ || '  pctused ' || pctused_	,60)	" ",
		' -- ' " ", rpad (table_name,30) table_name, '9001' seq
from 		dba_tables,
		tmp_view	
where		table_name	= key_
and		owner		= schema_
and		'table'	= type_

--	------------------------------------------------------------------------

union all
select	rpad (
	 	'           ' || 'initrans 1 maxtrans ' || maxtrans_		,60)	" ",
		' -- ' " ", rpad (table_name,30) table_name, '9002' seq
from 		dba_tables,
		tmp_view	
where		table_name	= key_
and		owner		= schema_
and		'table'	= type_

--	------------------------------------------------------------------------

union all
select	rpad (
		'storage   (initial ' || initial_ || '  next ' || next_ || '  pctincrease 0'		,60)   " ", 

		' -- ' " ", rpad (table_name,30) table_name, '9003' seq
from 		dba_tables,
		tmp_view	
where		table_name	= key_
and		owner		= schema_
and		'table'	= type_

--	------------------------------------------------------------------------

union all
select	rpad (
		'           ' || 'minextents 1  maxextents '  || maxextents_	,60)	" ",
		' -- ' " ", rpad (table_name,30) table_name, '9005' seq
from 		dba_tables,
		tmp_view	
where		table_name	= key_
and		owner		= schema_
and		'table'	= type_

--	------------------------------------------------------------------------

union all
select	rpad (
		'           ' || 'freelists  1  freelist groups 1' || ')'	,60)	" ",
		' -- ' " ", rpad (table_name,30) table_name, '9006' seq
from 		dba_tables,
		tmp_view	
where		table_name	= key_
and		owner		= schema_
and		'table'	= type_
		
--	------------------------------------------------------------------------
--	------------------------------------------------------------------------

union all
select	rpad (
		'as select * from ' || v2.schema_ || '.' || table_name || ';'		,60) " ",
		' -- ' " ", rpad (table_name,30) table_name, '9101' seq

from 		dba_tables,
		tmp_view		v1,
		tmp_view		v2
where		table_name	= v1.key_
and		owner		= v1.schema_
and		'table'	= v1.type_
and		'as'		= v2.type_	
and		'all'		= v2.key_	
and		owner		= v2.schema_

--	------------------------------------------------------------------------

union all
--select 	'select count(*) "' || table_name || '" from ' || schema_ ||'.'|| table_name  || ';',	
select 	'select count(*) "' || table_name || '" from ' || table_name  || ';',	
		' -- ' " ", rpad (table_name,30) table_name, '9201' seq
from 		dba_tables,
		tmp_view	
where		table_name	= key_
and		owner		= schema_
and		'table'	= type_

--	------------------------------------------------------------------------

union all
--select 	'select count(*) " " from ' || schema_ ||'.'|| prefix_ || table_name || ';'	" ",	
select 	'select count(*) " " from ' || prefix_  || table_name || ';'				" ",	
		' -- ' " ", rpad (table_name,30) table_name, '9202' seq
from 		dba_tables,
		tmp_view	
where		table_name	= key_
and		owner		= schema_
and		'table'	= type_

--	------------------------------------------------------------------------

union all
select 	';',	
		' -- ' " ", rpad (table_name,30) table_name, '9999' seq
from 		dba_tables,
		tmp_view	
where		table_name	= key_
and		owner		= schema_
and		'table'	= type_

--	------------------------------------------------------------------------
;

	commit;

	alter rollback segment	rb_large	offline;	

	set timing	off;

--	------------------------------------------------------------------------
	spool	c:\deacutis\scripts\ora_create\Script_Select_As.sql;

	select rpad (item01, 70) " "	from gis_objects  order by item03, item04, item05;

	spool off;
--	------------------------------------------------------------------------
