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

--	Copy any adrResult table to any other adrResult table
--	================================================================

	drop synonym	garland.syn_input_table;
	drop synonym	garland.syn_output_table;

--	-------------------------------------------------------------------------------------------------------

	create synonym	garland.syn_input_table		for garland.GIS_VERIFY_ADDR;			-- SPECIFY --
--	create synonym	garland.syn_input_table		for garland.ADRRESULT_INPUT;			-- SPECIFY --

	create synonym	garland.syn_output_table	for garland.ADRRESULT_TAX_GDS;	-- SPECIFY --
--	create synonym	garland.syn_output_table	for garland.GIS_VERIFY_ADDR;		-- SPECIFY --

--	-------------------------------------------------------------------------------------------------------

--	create synonym	garland.syn_input_table		for garland.ADRRESULT_;			-- SPECIFY --

--	create synonym	garland.syn_output_table	for garland.GIS_VERIFY_ADDR;			-- SPECIFY --

--	=======================================================================================================

	select synonym_name, rpad(owner,30) " ", rpad(object_name, 30) " ", last_ddl_time 
	from all_objects OBJ, SYN  
	where obj.object_name = syn.table_name	and obj.object_type  = 'TABLE'
	and	obj.owner = syn.table_owner		and syn.synonym_name = 'SYN_INPUT_TABLE';

	select synonym_name, rpad(owner,30) " ", rpad(object_name, 30) " ", last_ddl_time 
	from all_objects OBJ, SYN  
	where obj.object_name = syn.table_name	and obj.object_type  = 'TABLE'
	and	obj.owner = syn.table_owner		and syn.synonym_name = 'SYN_OUTPUT_TABLE';

	select s.table_name "BEFORE", comments	
	from user_tab_comments C, syn S	
	where c.table_name   = s.table_name
	and	s.synonym_name = 'SYN_OUTPUT_TABLE';

--	=======================================================================================================

	spool	c:\deacutis\scripts\execute.sql
	spool off;
	spool	c:\deacutis\scripts\execute.sql

--	=======================================================================================================

	select '    Truncate table  ' || s.table_owner ||'.'|| s.table_name || '   reuse storage;'		" "
	from		syn	s
	where		s.synonym_name = 'SYN_OUTPUT_TABLE'

--	union all
--	select ' '								 from dual
--	union all
--	select '    alter rollback segment rb1	online;' 	 from dual
--	union all
--	select '    commit;'						 from dual
--	union all
--	select '    set transaction use rollback segment rb1;' from dual

	union all
	select ' '								from dual
	union all
	select '    insert --+  append'				from dual
	union all
	select '    into		garland.syn_output_table'	from dual
	union all
	select '    select	all *	'				from dual
	union all
	select '    from		garland.syn_input_table;'	from dual

	union all
	select ' '								from dual
--	union all
--	select '    savepoint xxx;'					from dual
	union all
	select '    commit;'						from dual
--	union all
--	select '	alter rollback segment rb1	offline;'	from dual

	union all
	select ' '								from dual
	union all
	select '    analyze table  ' || s.table_owner ||'.'|| s.table_name || '  compute statistics;'
	from		syn	s
	where		s.synonym_name = 'SYN_OUTPUT_TABLE'
	union all
	select ' '								from dual

	union all
	select '    select count(*) "INPUT"  from garland.syn_input_table;'	from dual
	union all
	select '    select count(*) "OUTPUT" from garland.syn_output_table;'	from dual
	union all
	select ' '											from dual

	union all
	select '    Comment on table	garland.' || o.table_name || ' is ''' || 
			i.table_name 
			|| '  ' || to_char(sysdate, 'Mon dd,yyyy hh24:mi') || ''';'	" "
	from	syn i, syn o
	where	i.synonym_name = 'SYN_INPUT_TABLE' and o.synonym_name = 'SYN_OUTPUT_TABLE'
	union all
	select ' '								 from dual;

--	=======================================================================================================
	spool off;
--	=======================================================================================================

--	@c:\deacutis\scripts\execute.sql;

--	=======================================================================================================

	select s.table_name "AFTER", comments	
	from user_tab_comments C, syn S	
	where c.table_name = s.table_name
	and	s.synonym_name = 'SYN_OUTPUT_TABLE';

--	=======================================================================================================
