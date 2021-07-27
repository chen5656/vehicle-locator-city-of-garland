	set echo		off;
	set termout		off;
	set charwidth	200;

--	=================================================================================================
--	show utility records where ID is populated and NUM is null
--	=================================================================================================

	spool c:\deacutis\scripts\execute.sql;
	spool off;
	spool c:\deacutis\scripts\execute.sql;


	select	'	select ''' || table_name || ''' "' || table_name || '", '	||
				object_id	  || ' "' || object_id || '"'				||chr(10)||
			'	from '	|| table_name						||chr(10)||
			'	where length(rtrim(' || object_id || ')) > 9'			||chr(10)||
			'	and   ' || object_num || ' is null;'				||chr(10)


			" "
	from		temp_view1;


	spool off;


--	=================================================================================================

	set termout		on;

	@c:\deacutis\scripts\execute.sql

--	=================================================================================================
	set echo		on;
	set charwidth;

