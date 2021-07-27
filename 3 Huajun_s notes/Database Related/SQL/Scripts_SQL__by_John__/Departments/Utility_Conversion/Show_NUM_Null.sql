	set echo		on;
	set charwidth	200;
--	=======================================================================

	spool c:\deacutis\scripts\execute.sql;
	spool off;
	spool c:\deacutis\scripts\execute.sql;

	select	'	select count(*) "'|| table_name || '",'	||
			'  count(*) - count(' || object_num || ') "null",'	||
			'  min(' 	|| object_num	||') "min", max(' || object_num ||') "max"'	||
			'  from '	|| table_name	||
			';'

--			'  where '	|| object_num || '  is null;'
			" "
	from		garland.temp_view1	g

	where exists
(
	select 'x'
	from	cols
	where	table_name	= g.table_name
	and	column_name = g.object_num
);


--	spool off;

--	=======================================================================

--	@c:\deacutis\scripts\execute.sql;

--	=======================================================================
	set echo		on;
	set charwidth;

	