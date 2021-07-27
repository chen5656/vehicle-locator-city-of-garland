
--	drop constraint 

--	====================================================================
	set echo		off;
	set timing		on;
--	====================================================================

	truncate table	gis_objects	reuse storage;

	alter rollback segment rb_large	online;
	set transaction	use rollback segment	rb_large;

	insert into gis_objects ( item01, item02, item03, item04, item05 )

--	=========================================================================================================

	select	rpad (
			'alter table     ' || schema_ ||'.'|| prefix_ || table_name	,60)	" ",
			' -- ' " ", table_name, constraint_name, '0101' seq
	from		dba_constraints,
			tmp_view		
	where		constraint_type in ( 'P', 'U' )
	and		constraint_name	= key_
	and		owner			= schema_
	and		'index'		= type_


--	------------------------------------------------------------------------

	union all
	select	rpad (
			'drop constraint ' || prefix_ || constraint_name	,60)	" ",
			' -- ' " ", table_name, constraint_name, '0102' seq
	from		dba_constraints,
			tmp_view	
	where		constraint_type in ( 'P', 'U' )
	and		constraint_name	= key_
	and		owner			= schema_
	and		'index'		= type_

--	------------------------------------------------------------------------

	union all
	select	rpad (';', 60)	" ",
			' -- ' " ", table_name, constraint_name, '9999' seq
	from		dba_constraints	cn,
			tmp_view
	where		constraint_type in ( 'P', 'U' )
	and		constraint_name	= key_
	and		owner			= schema_
	and		'index'		= type_

--	------------------------------------------------------------------------
--	order by	table_name, constraint_name, seq		
--	------------------------------------------------------------------------
;

	commit;
	alter rollback segment	rb_large	offline;	

	set timing	off;

--	------------------------------------------------------------------------

	spool	c:\deacutis\scripts\ora_create\Script_Constraint.sql;

	select rpad (item01, 70) " "	from gis_objects  order by item03, item04, item05;

	spool off;
--	------------------------------------------------------------------------

