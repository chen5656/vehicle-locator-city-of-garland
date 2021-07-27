	set echo off;
--	===============================================================================
--	ALTER TRIGGERS
--	===============================================================================

	select 'Alter Triggers  ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi')  " " from dual;

	spool c:\deacutis\scripts\execute.sql;
	spool off;
	spool c:\deacutis\scripts\execute.sql;

--	===============================================================================

	select '	alter table   GARLAND.' || rpad(table_name,16) ||  'DISABLE		all triggers;' " "
	from		temp_view1;

--	===============================================================================

	spool off;

--	@c:\deacutis\scripts\Execute.sql


--	===============================================================================
	set echo on;
