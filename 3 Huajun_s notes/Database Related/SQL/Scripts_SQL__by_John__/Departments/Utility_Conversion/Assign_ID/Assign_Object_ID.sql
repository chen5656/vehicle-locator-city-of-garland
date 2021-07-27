	set echo		off;
	set charwidth	200;
--	===========================================================================
--	assign _ID value on tables based on Grid, Quad, and _Num
--	===========================================================================

	spool c:\deacutis\scripts\execute.sql;
	spool off;
	spool c:\deacutis\scripts\execute.sql;

--	===========================================================================

	select	'	alter rollback segment rb1  online;'		||chr(10)||
			'	commit;'							||chr(10)||
			'	set transaction use rollback segment rb1;'	||chr(10)
			" "
	from		dual

	union all
	select

		'	update GARLAND.'	|| rpad(table_name,12)	|| chr(10) ||

		'		set ' || object_id || ' = ''' ||

		id_prefix	|| ''' || map_grid || map_quad || ''-'' || '	|| object_num ||

		' || ''' || id_suffix  || ''''						|| chr(10)||

		'		where map_grid > 0  and map_quad >= ''A'' and '		||

		object_num	|| ' > 0'								|| chr(10) ||

		'		and rtrim(' || object_id || ') is null'			|| chr(10) ||
		'	;'


	from	garland.Temp_View1

	union all
	select	'	commit;'							||chr(10)||
			'	alter rollback segment rb1  offline;'		||chr(10)
			" "
	from		dual;

--	===========================================================================

	spool off;

--	@c:\deacutis\scripts\Execute.sql

--	===========================================================================
	set echo		on;
	set charwidth;
