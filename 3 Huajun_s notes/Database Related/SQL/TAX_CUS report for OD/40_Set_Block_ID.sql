--	=====================================================================
	select * from viewer.me;
--	BEGIN  TEST TEST TEST TEST TEST  TEST TEST TEST TEST TEST  TEST TEST TEST TEST TEST  END;
set	TIMING		OFF;
set	sqlblanklines	on;
set	serveroutput	on	size 99999;
set	linesize		1000;
set	pagesize		0000;
--	execute jdeacutis.show_table_column	('ccs_address block', 'garland', '');
--	execute jdeacutis.show_source		('test_proc', 'jdeacutis', '');
--	execute jdeacutis.show_error		('test_proc', 'jdeacutis', '');
--	execute jdeacutis.show_view		('', '', '');
--	execute jdeacutis.show_index_column	('', '', '');
--	SELECT  to_char(sysdate,'Mon dd,yyyy hh24:mi')||'  ***  ' " "  from dual;
--	EXECUTE jdeacutis.TEST_PROC;
--	CREATE or replace procedure jdeacutis.TEST_PROC  as
--	DECLARE
--	=====================================================================	

DECLARE
	compile_only		integer := 0;
	do_update			integer := 01;
	total_input			integer := 0;
	total_update		integer := 0;

Cursor	Read_CCS_Block	is

	select 
		c.rowid		CCS,
		b.rowid		BLOK
	from	jdeacutis.CCS_Address_ODT	C,
		jdeacutis.Block			B
	where	c.address_id	= 0
	and	b.addr_name	= c.addr_name
	and	b.addr_type	= c.addr_type
	and	b.addr_pfx	= c.addr_prefix
	and	b.addr_sfx	= c.addr_suffix
	and	b.addr_block	= trunc(c.addr_number, -2)
	;

--	=====================================================================	
	CCS		garland.CCS_Address%rowtype;
	BLOK		garland.Block%rowtype;
--	=====================================================================	
BEGIN
	if	compile_only > 0	then
		return;
	end if;

for	READ in Read_CCS_Block		Loop
	total_input	:= total_input + 01;

	select * into BLOK	from jdeacutis.Block	where rowid = read.BLOK;

	if	do_update > 0		then
		update jdeacutis.CCS_Address_ODT
		set	ROAD_ID = 01
		where	rowid = read.CCS;

		total_update := total_update + 01;
	end if;
end loop;

	dbms_output.put_line ( 'Total Input:  ' || total_input );
	dbms_output.put_line ( 'Total Update  ' || total_update);
END;

--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan set	statement_id = 'x'	into jdeacutis.plan_table for
--	=====================================================================

--	=====================================================================
--	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================
