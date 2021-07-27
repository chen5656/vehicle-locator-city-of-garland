	set echo		off;
	set charwidth	200;
--	=============================================================================

	variable	user1		varchar2(20);
	variable	user2		varchar2(20);

	execute	:user1	:= 'JDEACUTIS';		--  SOURCE
	execute	:user2	:= 'GARLAND';		--  TARGET

--	=============================================================================

	select	'	truncate table  '  || :USER2 ||'.' || ITEM01 || '      reuse storage;'	" "
	from		garland.GIS_Objects
	union all
	select	chr(10)	from	dual

	union all
	select	'	alter rollback segment rb1  online;'		||chr(10)||
			'	commit;'							||chr(10)||
			'	set transaction use rollback segment rb1;'	||chr(10)
			" "
	from		dual

	union all
	select
		'	insert --+ append '					||chr(10)||
		'	into   '		|| :USER2 ||'.'|| table_name	||chr(10)||
		'	select * from '	|| :USER1 ||'.'|| table_name	||';'||

		chr(10)	" "

	from	garland.TEMP_VIEW1


	union all
	select	'	commit;'							||chr(10)||
			'	alter rollback segment rb1  offline;'		||chr(10)
			" "
	from		dual;

--	=============================================================================
	set echo		on;
	set charwidth;
