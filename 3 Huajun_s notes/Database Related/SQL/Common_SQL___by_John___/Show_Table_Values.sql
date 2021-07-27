--	=====================================================================
	select * from viewer.me;
	BEGIN  TEST TEST TEST TEST TEST  TEST TEST TEST TEST TEST  TEST TEST TEST TEST TEST  END;
set	TIMING		OFF;
set	sqlblanklines	on;
set	serveroutput	on	size 99999;
set	linesize		1000;
set	pagesize		0000;
--	execute jdeacutis.show_table_column	('', '', '');
--	execute jdeacutis.show_source		('test_proc', 'jdeacutis', '');
--	execute jdeacutis.show_error		('test_proc', 'jdeacutis', '');
--	execute jdeacutis.show_view		('', '', '');
--	execute jdeacutis.show_index_column	('', '', '');
--	SELECT  to_char(sysdate,'Mon dd,yyyy hh24:mi')||'  ***  ' " "  from dual;
--	EXECUTE jdeacutis.TEST_PROC;
--	CREATE or replace procedure jdeacutis.TEST_PROC  as
--	DECLARE
--	=====================================================================	
--	=============================================================================================
--	make sample table display
--	=============================================================================================

	variable tablename	varchar2(40);
	execute	 :tablename :=	'TBL_ADDRESSLIST';

--	===================================================================

--	spool off
	spool	c:\deacutis\sde\EXECUTE.sql
	spool off
	spool	c:\deacutis\sde\EXECUTE.sql

--	-------------------------------------------------------------------

	select '   select ''' ||:tablename|| ''' " "' " " from dual
	union all
	select '  ,rpad("' ||column_name|| '",   00015   ) "' ||column_name|| '"'  " "
	from   all_tab_columns
	where  table_name = :tablename
	union all
	select '   from garland.' ||:tablename||chr(10)|| '   where rownum <    00011   ;' from dual;
	
--	-------------------------------------------------------------------

	spool off

	@c:\deacutis\sde\EXECUTE.sql

--	===================================================================
		    
	

