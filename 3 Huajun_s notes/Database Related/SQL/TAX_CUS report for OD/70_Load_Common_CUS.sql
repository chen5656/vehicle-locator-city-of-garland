--	============================================================
	select * from viewer.me;
--	BEGIN  SERVER USER  SERVER USER  SERVER USER  SERVER USER END;
set	TIMING		OFF;
set	sqlblanklines	on;
set	serveroutput	on	size 99999;
set	linesize		1000;
set	pagesize		0;
--	execute jdeacutis.show_table_column	(' ', ' ', ' ');
--	execute jdeacutis.show_source		('test_proc', 'jdeacutis', '');
--	execute jdeacutis.show_error		('test_proc', 'jdeacutis', '');
--	execute jdeacutis.show_view		(' ', ' ', ' ');
--	execute jdeacutis.show_index_column	(' ', ' ', ' ');
--	EXECUTE jdeacutis.TEST_PROC;
--	CREATE or replace procedure jdeacutis.TEST_PROC  as
--	DECLARE
--	============================================================
/*
	create table jdeacutis.Common_CUS	tablespace gis_data 
	from select * from jdeacutis.Common_UMS where rownum < 1;
*/
--	=====================================================================	

--	=====================================================================	
DECLARE

	compile_only		integer := 0;
	do_insert		integer := 01;
	do_refresh		integer := 0;
	total_input		integer := 0;
	total_insert		integer := 0;
	total_address		integer := 0;
	this_seq		integer;

CURSOR	Read_CUS_Block	is

	select 
		c.rowid		CUS,
--		b.rowid		BLOK,
		a.rowid		ADDR
	from	jdeacutis.Common_CUS		C,
		garland.Block			B,
		gis.Address			A
	where	b.addr_name	= c.addr_name
	and	b.addr_type	= c.addr_type
	and	b.addr_pfx	= c.addr_pfx
	and	b.addr_sfx	= c.addr_sfx
	and	b.addr_block	= trunc(c.addr_num,-2)
	and	a.addressid (+)	= c.address_id
	and not exists
(		select 0
		from	jdeacutis.Temp_View	T
		where	t.addr_name	= c.addr_name
		and	t.addr_num	= c.addr_num
		and	t.addr_type	= c.addr_type
		and	t.addr_pfx	= c.addr_pfx
		and	t.addr_sfx	= c.addr_sfx
)
	order by c.addr_name,c.addr_type,c.addr_pfx,c.addr_sfx,c.addr_num;

--	=====================================================================	
	CUS		jdeacutis.Common_CUS%rowtype;
	ADDR		gis.Address%rowtype;
--	BLOK		garland.Block%rowtype;
--	=====================================================================	

BEGIN
	if	compile_only > 0	then
		return;
	end if;

	if	do_refresh > 0		then
		execute immediate 'truncate table jdeacutis.Common_CUS';
		INSERT --+ append
		into jdeacutis.Common_CUS
		select * from garland.Common_UMS;
		COMMIT;
	end if;

	select max(seq+0) into this_seq 	from jdeacutis.Temp_View;

for	READ in Read_CUS_Block		Loop
	total_input	:= total_input + 01;

	select * into CUS	from jdeacutis.Common_CUS	where rowid = read.CUS;
--	select * into BLOK	from garland.Block		where rowid = read.BLOK;

	if	read.ADDR is null		then
		ADDR	:= null;
	else
		total_address	:= total_address + 01;
		select * into ADDR	from gis.Address	where rowid = read.ADDR;
	end if;

	if	do_insert > 0		then
		this_seq	:= this_seq + 01;

		INSERT into jdeacutis.Temp_View
		values
	(
		this_seq,
		addr.parcelid,
		cus.addr_num,
		cus.addr_pfx,
		cus.addr_name,
		cus.addr_type,
		cus.addr_sfx,
		null,
		cus.first_name ||' '|| cus.last_name,
		addr.addressid,
		null,
		cus.account_no
	);

		total_insert := total_insert + 01;
	end if;
end loop;

	COMMIT;

	dbms_output.put_line ( 'Total Input:   ' || total_input );
	dbms_output.put_line ( 'Total Insert:  ' || total_insert);
	dbms_output.put_line ( 'Total Address: ' || total_address);
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
