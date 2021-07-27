--	===============================================================================================
	select	'Create Scripts	' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;

	set termout		off;
	set echo		off;
	set serveroutput	on	size 999999;
	set charwidth	100;
	spool off;

--	===============================================================================================

--	spool c:\deacutis\scripts\ora_create\Script_Table.sql;		--	Create Tables
--	@c:\deacutis\scripts\ora_create\Create_Table.sql;
--	spool	off;


--	spool	c:\deacutis\scripts\ora_create\Script_Index.sql;		--	Create Indexes
--	@c:\deacutis\scripts\ora_create\Create_Index.sql;
--	spool	off;


--	spool	c:\deacutis\scripts\ora_create\Script_Constraint.sql;		--	Create Constraints
--	@c:\deacutis\scripts\ora_create\Create_Constraint.sql;
--	spool	off;

--	spool	c:\deacutis\scripts\ora_create\Script_Trigger.sql;		--	Create Triggers
--	@c:\deacutis\scripts\ora_create\Create_Trigger.sql;
--	spool	off;

--	spool	c:\deacutis\scripts\ora_create\Script_View.sql;			--	Create Views
--	@c:\deacutis\scripts\ora_create\Create_View.sql;
--	spool	off;

--	===============================================================================================

	set termout		on;
	set echo		on;

	select	'Finish Scripts	' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') " " from dual;

--	===============================================================================================
