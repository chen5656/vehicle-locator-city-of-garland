--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';
--	===========================================================================================s

	variable	app_name	varchar2(40)
	execute	:app_name	:= 'COMMON TAX:   ';

--	===========================================================================================s

	spool	c:\deacutis\scripts\EXECUTE.sql
	spool off
	spool	c:\deacutis\scripts\EXECUTE.sql

--	===========================================================================================

	select '  select rpad(max(length(rtrim(' || column_name || '))),30) ' ||
			:app_name || column_name  || 
			'  from ' || owner || '.' || table_name	|| ';'		" "
	from all_tab_columns
	where	table_name =	'COMMON_TAX'
	and	owner =		'JDEACUTIS'
	order by column_id;

--	-------------------------------------------------------------------

	spool off

	@c:\deacutis\scripts\EXECUTE.sql

--	===========================================================================================
	set echo on;
