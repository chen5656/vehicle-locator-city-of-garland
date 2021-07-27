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

	select
			rpad(owner,		12)					object_owner,
			rpad(object_name, 25)					object_name,
			rpad(object_type, 08)					type, 
			to_char(last_ddl_time, 'Mon dd,yyyy hh24:mi')	last_ddl_time
			,'   ' " "
			,to_char(created, 'Mon dd,yyyy hh24:mi')		create_time 
	from ALL_Objects
	where	object_name like upper('%%')
	and	owner		like upper('%%')
	and	object_type in ( 'TABLE' )
--	and	to_char(last_ddl_time, 'yyyy-mm-dd') >	'2005-01-01'
--	and	to_char(created, 'yyyy-mm-dd') > 		'2005-01-01'
	order by object_name, owner;
--	order by last_ddl_time;
--	order by created;


