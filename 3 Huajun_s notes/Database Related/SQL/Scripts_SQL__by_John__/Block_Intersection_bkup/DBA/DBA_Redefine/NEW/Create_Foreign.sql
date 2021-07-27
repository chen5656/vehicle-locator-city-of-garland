
--	make referential integrity definitions for re-org tables

--	========================================================================
	set echo 		off;
	set timing		on;
	set serveroutput	on;
--	=========================================================================================================

	truncate table	gis_objects	reuse storage;

	alter rollback segment rb_large	online;
	set transaction	use rollback segment	rb_large;

	insert into gis_objects ( item01, item02, item03, item04, item05 )

--	=========================================================================================================

	select 	'select ''FOREIGN ' || table_name || ''' " " from dual;'	" ",
			' -- ' " ", table_name, constraint_name, '0101' seq
	from 		dba_constraints,
			tmp_view
	where		constraint_type 	= 'R'	
	and		constraint_name	= key_
	and		owner			= schema_
	and		'foreign' 		= type_

	union all
	select	'alter table    ' || owner || '.' || table_name		" ",
			' -- ' " ", table_name, constraint_name, '0101' seq
	from 		dba_constraints,	
			tmp_view
	where		constraint_type 	= 'R'	
	and		constraint_name	= key_
	and		owner			= schema_
	and		'foreign' 		= type_


	union all
	select	'add constraint ' || constraint_name ||'     foreign key '	" ",
			' -- ' " ", table_name, constraint_name, '0102' seq
	from 		dba_constraints,	
			tmp_view
	where		constraint_type 	= 'R'	
	and		constraint_name	= key_
	and		owner			= schema_
	and		'foreign' 		= type_


--	@c:\deacutis\scripts\plans\exhibit.sql;

--	------------------------------------------------------------------------

	union all
	select	'(' 	" ",
			' -- ' " ", table_name, constraint_name, '2002' seq
	from 		dba_constraints,	
			tmp_view
	where		constraint_type 	= 'R'	
	and		constraint_name	= key_
	and		owner			= schema_
	and		'foreign' 		= type_

--	------------------------------------------------------------------------

--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'		for

	union all
	select
	rpad 		( nvl (rpad ( ',', sign ( pr.position - 1) ), ' ') || rpad (pr.column_name, 25), 50)	" ",
			' -- ' " ", cn.table_name, cn.constraint_name, rtrim(pr.position + 3000) seq
	from 		dba_constraints	cn,
			dba_cons_columns	pr,
			tmp_view
	where		cn.r_constraint_name = pr.constraint_name
	and		cn.constraint_type 	= 'R'	
	and		cn.constraint_name	= key_
	and		cn.owner			= schema_
	and		'foreign' 			= type_

--	@c:\deacutis\scripts\plans\exhibit.sql;

--	------------------------------------------------------------------------

	union all
	select	')' 	" ",
			' -- ' " ", table_name, constraint_name, '3999' seq
	from 		dba_constraints,	
			tmp_view
	where		constraint_type 	= 'R'	
	and		constraint_name	= key_
	and		owner			= schema_
	and		'foreign' 		= type_

--	------------------------------------------------------------------------

	union all
	select	' references '	|| cn.r_owner || '.' || cn.r_constraint_name 	" ",
			' -- ' " ", cn.table_name, cn.constraint_name, '4001' seq
	from 		dba_constraints	cn,
			tmp_view
	where		cn.constraint_type 	= 'R'	
	and		cn.constraint_name	= key_
	and		cn.owner			= schema_
	and		'foreign' 			= type_

--	------------------------------------------------------------------------

	union all
	select	'ON DELETE CASCADE'	" ",
			' -- ' " ", table_name, constraint_name, '5001' seq
	from 		dba_constraints,	
			tmp_view
	where		delete_rule = 'CASCADE'
	and		constraint_type 	= 'R'	
	and		constraint_name	= key_
	and		owner			= schema_
	and		'foreign' 		= type_

--	------------------------------------------------------------------------

	union all
	select 	';',	
			' -- ' " ", table_name, constraint_name, '9999' seq
	from 		dba_constraints,	
			tmp_view
	where		constraint_type 	= 'R'	
	and		constraint_name	= key_
	and		owner			= schema_
	and		'foreign' 		= type_

--	------------------------------------------------------------------------
--	order by	table_name, constraint_name, seq
--	------------------------------------------------------------------------
;

	commit;
	alter rollback segment	rb_large	offline;	

	set timing	off;

--	------------------------------------------------------------------------
	spool	c:\deacutis\scripts\ora_create\Script_Foreign.sql;

	select rpad (item01, 70) " "	from gis_objects  order by item03, item04, item05;

	spool off;
--	------------------------------------------------------------------------






