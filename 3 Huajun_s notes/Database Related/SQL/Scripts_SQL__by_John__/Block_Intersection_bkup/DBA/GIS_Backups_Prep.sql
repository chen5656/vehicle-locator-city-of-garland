	set echo		off;
	set charwidth	300;
--	===========================================================================================
--	Display new table columns not yet defined in a "_copy" table 
--	The new columns must be defined on the "_copy" table  for the backup to work
--	===========================================================================================

--	--------------------------------------------------
	spool	c:\deacutis\scripts\execute.sql
	spool off
	spool	c:\deacutis\scripts\execute.sql
--	--------------------------------------------------

	select 'set echo off;' " " from dual 
	union all

	select
	'select null "' || replace(table_name, '_COPY') || '" from dual '
	|| ' union all ' ||chr(10)||
	'select column_name from cols where table_name = ''' || replace(table_name, '_COPY')
	||  ''' minus ' ||chr(10)||	
	'select column_name from cols where table_name = ''' || table_name || ''';'
	||chr(10)
	" "
	from	tabs
	where	table_name like '%_COPY'


	union all
	select 'set echo on;' " " from dual;

--	--------------------------------------------------
	spool off
--	--------------------------------------------------
	@c:\deacutis\scripts\execute.sql;	
--	--------------------------------------------------

--	===========================================================================================
	set charwidth;
	set echo		on;

