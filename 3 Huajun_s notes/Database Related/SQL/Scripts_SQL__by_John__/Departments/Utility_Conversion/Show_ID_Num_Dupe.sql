	set echo		off;
	set termout		off;
	set charwidth	200;
--	=================================================================================================
--	show utility records w/ populated ID that corresponds to duplicate NUM
--	=================================================================================================

	spool c:\deacutis\scripts\execute.sql;
	spool off;
	spool c:\deacutis\scripts\execute.sql;


	select	'	select ''' || table_name || ''' "' || table_name || '", '	||
				object_num	  || ' "' || object_num || '", count(*) " "'	||chr(10)||
			'	from '	|| table_name				||chr(10)||
			'	where length(rtrim(' || object_id || ')) > 9'	||chr(10)||
			'	group by '	|| object_num				||chr(10)||	
			'	having count(*) > 1; '					||chr(10)	


			" "
	from		temp_view1;


	spool off;


--	=================================================================================================

	set termout		on;

	@c:\deacutis\scripts\execute.sql

--	=================================================================================================
	set echo		on;
	set charwidth;

