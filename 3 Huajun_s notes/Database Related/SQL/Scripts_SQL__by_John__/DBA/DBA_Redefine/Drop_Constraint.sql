	set echo		off;
	set timing		off;
--	====================================================================
--	disable constraint 
--	drop    constraint 
--	====================================================================

	select	rpad (
			'alter table     ' || schema_ ||'.'|| prefix_ || table_name	,60)	" "
	from		dba_constraints,
			tmp_view		
	where		constraint_type in ( 'P', 'U' )
	and		table_name		= key_
	and		owner			= schema_
	and		'table'		= type_

--	------------------------------------------------------------------------

	union all
	select	rpad (
			'disable constraint ' || prefix_ || constraint_name	,60)	" "
	from		dba_constraints,
			tmp_view	
	where		constraint_type in ( 'P', 'U' )
	and		table_name		= key_
	and		owner			= schema_
	and		'table'		= type_

--	------------------------------------------------------------------------

	union all
	select	rpad (';', 60)	" "
	from		dba_constraints	cn,
			tmp_view
	where		constraint_type in ( 'P', 'U' )
	and		table_name		= key_
	and		owner			= schema_
	and		'table'		= type_

--	------------------------------------------------------------------------

	union all
	select	rpad (
			'alter table     ' || schema_ ||'.'|| prefix_ || table_name	,60)	" "
	from		dba_constraints,
			tmp_view		
	where		constraint_type in ( 'P', 'U' )
	and		table_name		= key_
	and		owner			= schema_
	and		'table'		= type_

--	------------------------------------------------------------------------

	union all
	select	rpad (
			'drop constraint ' || prefix_ || constraint_name	,60)	" "
	from		dba_constraints,
			tmp_view	
	where		constraint_type in ( 'P', 'U' )
	and		table_name		= key_
	and		owner			= schema_
	and		'table'		= type_

--	------------------------------------------------------------------------

	union all
	select	rpad (';', 60)	" "
	from		dba_constraints	cn,
			tmp_view
	where		constraint_type in ( 'P', 'U' )
	and		table_name		= key_
	and		owner			= schema_
	and		'table'		= type_

;
--	------------------------------------------------------------------------

	set timing	off;
	set echo	on;


