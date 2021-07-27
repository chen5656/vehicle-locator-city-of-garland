
--	make "create table" command

--	========================================================================
	set echo 		off;
	set timing		on;
	set serveroutput	on;
--	=========================================================================================================

	truncate table	gis_objects	reuse storage;

	alter rollback segment rb_large	online;
	set transaction	use rollback segment	rb_large;

	insert into gis_objects ( item01, item02, item03, item04 )

--	------------------------------------------------------------------------
--	------------------------------------------------------------------------

	select 	'select ''CREATE ' || table_name || ''' " " from dual;'	" ",
		 	' -- ' " ", rpad (table_name,30) table_name, '0001' seq
	from 		dba_tables,
			tmp_view
	where		table_name		= key_
	and		owner			= schema_
	and		'table'		= type_
	union all

--	------------------------------------------------------------------------

	select	rpad (
			'drop   table   ' || schema_ || '.' || prefix_ || table_name || ';'	,60) " ",
			' -- ' " ", rpad (table_name,30) table_name, '0002' seq
	from 		dba_tables,
			tmp_view	
	where		table_name		= key_
	and		owner			= schema_
	and		'table'		= type_
	and		'drop'		= option1_
	union all

--	------------------------------------------------------------------------

	select	rpad (
		 	'create table   ' || owner || '.' || prefix_ || table_name	 		,60)	" ",	
			' -- ' " ", rpad (table_name,30) table_name, '0101' seq
	from 		dba_tables,
			tmp_view	
	where		table_name		= key_
	and		owner			= schema_
	and		'table'		= type_

--	------------------------------------------------------------------------

	union all
	select 	'(',	
			' -- ' " ", rpad (table_name,30) table_name, '0102' seq
	from 		dba_tables,
			tmp_view	
	where		table_name		= key_
	and		owner			= schema_
	and		'table'		= type_

--	------------------------------------------------------------------------

union all
select

rpad 	(	nvl (rpad ( ',', sign ( column_id - 1) ), ' ') 	||	

		rpad (column_name, 30) || 	rpad (data_type, 08)  ||

		decode  (	data_type,	
		upper ('number'),		' (' || least (data_length, nvl (data_precision, 9999)) || 	
						decode ( nvl (data_scale, 0), 
							   0, ')',	',' ||  data_scale || ')'  ),	

		upper ('varchar2'),	' (' || data_length || ')',
		upper ('char'),		' (' || data_length || ')',
		upper ('float'),		' (' || least (data_length, nvl (data_precision, 9999)) || ')',	
		upper ('raw'),		' (' || data_length || ')',
	  	' ')		||													

		decode  (nullable, upper ('n'), ' not null', null)

,70)		" ",
		' -- ' " ", rpad (table_name,30) table_name, rpad (1000 + column_id, 04) seq
from		dba_tab_columns,
		tmp_view
where		table_name		= key_
and		owner			= schema_
and		'table'		= type_

--	------------------------------------------------------------------------

	union all
	select 	')',	
			' -- ' " ", rpad (table_name,30) table_name, '1999' seq
	from 		dba_tables,
			tmp_view

	where		table_name		= key_
	and		owner			= schema_
	and		'table'		= type_

--	------------------------------------------------------------------------

	union all
	select	rpad (
		 	'tablespace ' || tablespace_ || '   pctfree ' || pctfree_ || '  pctused ' || pctused_	,60)	" ",
			' -- ' " ", rpad (table_name,30) table_name, '9001' seq
	from 		dba_tables,
			tmp_view	
	where		table_name		= key_
	and		owner			= schema_
	and		'table'		= type_

--	------------------------------------------------------------------------

	union all
	select	rpad (
		 	'           ' || 'initrans 1 maxtrans ' || maxtrans_		,60)	" ",
			' -- ' " ", rpad (table_name,30) table_name, '9002' seq
	from 		dba_tables,
			tmp_view	
	where		table_name		= key_
	and		owner			= schema_
	and		'table'		= type_

--	------------------------------------------------------------------------

	union all
	select	rpad (
			'storage   (initial ' || initial_ || ' next ' || next_ || ' pctincrease 0' 	,60) " ",
			' -- ' " ", rpad (table_name,30) table_name, '9004' seq
	from 		dba_tables,
			tmp_view	
	where		table_name		= key_
	and		owner			= schema_
	and		'table'		= type_

--	------------------------------------------------------------------------

	union all
	select	rpad (
			'           ' || 'minextents 1  maxextents '  || maxextents_	,60)	" ",
			' -- ' " ", rpad (table_name,30) table_name, '9005' seq
	from 		dba_tables,
			tmp_view	
	where		table_name		= key_
	and		owner			= schema_
	and		'table'		= type_

--	------------------------------------------------------------------------

	union all
	select	rpad (
			'           ' || 'freelists  1  freelist groups 1' || ')'	,60)	" ",
			' -- ' " ", rpad (table_name,30) table_name, '9006' seq
	from 		dba_tables,
			tmp_view
	where		table_name		= key_
	and		owner			= schema_
	and		'table'		= type_

--	------------------------------------------------------------------------

	union all
	select 	';',	
			' -- ' " ", rpad (table_name,30) table_name, '9999' seq
	from 		dba_tables,
			tmp_view
	where		table_name		= key_
	and		owner			= schema_
	and		'table'		= type_

--	------------------------------------------------------------------------
;

	commit;
	alter rollback segment	rb_large	offline;	

	set timing	off;

--	------------------------------------------------------------------------
	spool	c:\deacutis\scripts\ora_create\Script_Table.sql;

	select rpad (item01, 70) " "	from gis_objects  order by item03, item04, item05;

	spool off;
--	------------------------------------------------------------------------
