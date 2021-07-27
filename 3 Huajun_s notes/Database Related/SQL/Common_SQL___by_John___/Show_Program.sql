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
--	PROGRAM LISTING
--	======================================================================

	select 	

		line,

		rtrim(ltrim(text,chr(09)), ' ' || chr(10))		text

	from	All_Source

--	----------------------------------------------------------------------
--	SPECIFY PROGRAM NAME

	where	name	=	upper (	''	)

--	----------------------------------------------------------------------
--	SPECIFY PROGRAM TYPE
						
--	and	type	= 'PACKAGE BODY'
--	and	type	= 'PROCEDURE'
--	and	type	= 'FUNCTION'

--	----------------------------------------------------------------------

	order by	type, name, line;

--	======================================================================
