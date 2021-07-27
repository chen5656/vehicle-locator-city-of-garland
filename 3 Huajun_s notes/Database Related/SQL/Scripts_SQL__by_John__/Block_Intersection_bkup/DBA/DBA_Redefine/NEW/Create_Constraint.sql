
--	make constraint definitions 

--	====================================================================
	set echo		off;
	set timing		on;
--	====================================================================

	truncate table	gis_objects	reuse storage;

	alter rollback segment rb_large	online;
	set transaction	use rollback segment	rb_large;

	insert into gis_objects ( item01, item02, item03, item04, item05 )

--	=========================================================================================================

	select 	'select ''' || table_name ||' / '|| constraint_name || ''' " "  from dual;'	" ",
			' -- ' " ", table_name, constraint_name, '0001' seq
	from		dba_constraints,
			tmp_view
	where		constraint_type in ( 'P', 'U' )
	and		constraint_name	= key_
	and		owner			= schema_
	and		'index'		= type_
	union all

--	------------------------------------------------------------------------

	select	rpad (
			'alter table    ' || schema_ ||'.'|| prefix_ || table_name	,60)	" ",
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
			'add constraint ' || prefix_ || constraint_name || '   ' || 
			decode (constraint_type,
					'P',	'primary key',
					'U',	'unique',
						constraint_type	)			,60)	" ",
			' -- ' " ", table_name, constraint_name, '0102' seq
	from		dba_constraints,
			tmp_view	
	where		constraint_type in ( 'P', 'U' )
	and		constraint_name	= key_
	and		owner			= schema_
	and		'index'		= type_

--	------------------------------------------------------------------------

	union all
	select	rpad ('(', 60) " ",
			' -- ' " ", table_name, constraint_name, '0103' seq
	from		dba_constraints	cn,
			tmp_view
	where		constraint_type in ( 'P', 'U' )
	and		constraint_name	= key_
	and		owner			= schema_
	and		'index'		= type_

--	------------------------------------------------------------------------

	union all
	select	rpad 	( nvl (rpad ( ',', sign (position - 1) ), ' ') || cc.column_name	,60),
			' -- ' " ", cn.table_name, cn.constraint_name, rtrim(cc.position + 1000) seq
	from		dba_constraints		cn,
			dba_cons_columns		cc,
			tmp_view
	where		cn.constraint_name = cc.constraint_name
	and		constraint_type in ( 'P', 'U' )
	and		cn.constraint_name	= key_
	and		cn.owner			= schema_
	and		'index'			= type_

--	------------------------------------------------------------------------

	union all
	select	rpad (')', 60) " ",
			' -- ' " ", table_name, constraint_name, '1999' seq
	from		dba_constraints,
			tmp_view
	where		constraint_type in ( 'P', 'U' )
	and		constraint_name	= key_
	and		owner			= schema_
	and		'index'		= type_

--	------------------------------------------------------------------------

	union all
	select	rpad ('using index',60)	" ",
		' -- ' " ", table_name, constraint_name, '9000' seq
	from		dba_constraints,
			tmp_view
	where		constraint_type in ( 'P', 'U' )
	and		constraint_name	= key_
	and		owner			= schema_
	and		'index'		= type_

--	------------------------------------------------------------------------

	union all
	select	rpad (
			'tablespace ' || tablespace_ 		,60)	" ",
			' -- ' " ", table_name, constraint_name, '9001' seq
	from		dba_constraints,
			tmp_view	
	where		constraint_type in ( 'P', 'U' )
	and		constraint_name	= key_
	and		owner			= schema_
	and		'index'		= type_

--	------------------------------------------------------------------------

	union all
	select	rpad (
			'storage (initial ' || initial_ || ' next ' || next_ || ' pctincrease 0' 	,60) " ",
			' -- ' " ", table_name, constraint_name, '9002' seq
	from		dba_constraints		cn,
			tmp_view	
	where		constraint_type in ( 'P', 'U' )
	and		constraint_name	= key_
	and		owner			= schema_
	and		'index'		= type_
		
--	------------------------------------------------------------------------

	union all

	select	rpad (
			'         minextents 1  maxextents ' || maxextents_	,60)	" ",
			' -- ' " ", table_name, constraint_name, '9003' seq
	from		dba_constraints		cn,
			tmp_view	
	where		constraint_type in ( 'P', 'U' )
	and		constraint_name	= key_
	and		owner			= schema_
	and		'index'		= type_
		
--	------------------------------------------------------------------------

	union all
	select	rpad (
			'         ' || 'freelists 1   freelist groups 1' || ')' ,60)	" ",
			' -- ' " ", table_name, constraint_name, '9004' seq
	from		dba_constraints		cn,
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


