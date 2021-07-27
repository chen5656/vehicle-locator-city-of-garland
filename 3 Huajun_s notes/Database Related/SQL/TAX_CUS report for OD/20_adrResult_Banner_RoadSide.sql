--	=====================================================================
	select * from viewer.me;
--	BEGIN  SERVER USER  SERVER USER  SERVER USER  SERVER USER  SERVER USER  SERVER USER  END;
set	TIMING		ON;
set	sqlblanklines	on;
set	serveroutput	on	size 99999;
set	linesize		1000;
set	pagesize		50000;
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

	create or replace view garland.adrResult_Input_View  
	as select * from jdeacutis.Temp_View;

--	select count(*) app_input from garland.adrResult_Input_View;

--	=====================================================================	

DECLARE
	compile_only			integer := 0;
	do_update			integer := 01;
	do_print			integer := 40;
	do_prints			integer := 40;

	total_input			integer := 0;
	total_update			integer := 0;

CURSOR	Read_Road	is

	select 
		ar.rowid		AR,
		rd.rowid		RD
	from	garland.adrResult_INPUT_VIEW	AR,
		gis.Road			RD

	where	ar.verify_code 	between 20 and 45
--	where	ar.verify_code 	between 20 and 44
	
	and	ar.addr_name		= rd.streetname		
	and	ar.addr_type		= rd.streettype		
	and	ar.addr_pfx		= rd.streetprefix		
	and	ar.addr_sfx		= rd.streetsuffix		
	and	ar.addr_num	  between rd.rangelo and rd.rangehi 
	;

CURSOR	Read_Roadside		is

	select 
		ar.rowid		AR,
		rs.rowid		RS
	from	garland.adrResult_INPUT_VIEW	AR,
		gis.RoadSide			RS

	where	ar.verify_code 	= 45
	and	rs.roadid	= ar.segment_id + 0
	and	rs.parity 	= mod(ar.addr_num,2);

--	=====================================================================
	AR		garland.adrResult_INPUT_VIEW%rowtype;
	RD		gis.ROAD%rowtype;
	RS		gis.ROADSIDE%rowtype;
--	=====================================================================
BEGIN
	if	compile_only > 0		then
		return;
	end if;

FOR READ in Read_Road		LOOP
	total_input	:= total_input + 01;

	select * into AR	from garland.adrResult_Input_View	where rowid = read.AR;
	select * into RD	from gis.ROAD				where rowid = read.RD;

	if	do_update > 0		then
		update	garland.adrResult_Input_View

		set		 parcel_id	= rs.parcelid
--				,segment_id 	= rd.roadid
--				,verify_code	= 45
		where		rowid = read.AR;
	end if;

	if	do_print > 0		then
		do_print := do_print - 01;
			dbms_output.put_line(ar.addr_num||' / '||rpad(rd.rangelo||'-'||rd.rangehi||' '|| rd.streetlabel,30) 
				||' / '|| rd.roadid );
	end if;

	total_update	:= total_update + 01;

END LOOP;

	if	do_update > 0		then
		COMMIT;
	end if;

	dbms_output.put_line ( 'Total Road Input:   ' || total_input  );
	dbms_output.put_line ( 'Total Road Update:  ' || total_update );

--	========================================================================================

	do_print	:= do_prints;
	total_input	:= 0;
	total_update	:= 0;

FOR SCAN in Read_Roadside	LOOP
	total_input	:= total_input + 01;

	select *  into AR	from garland.adrResult_Input_View	where rowid = scan.AR;
	select *  into RS	from gis.ROADSIDE			where rowid = scan.RS;

	if	do_update > 0		then
		update	garland.adrResult_Input_View
		set	parcel_id = rs.parcelid
		where	rowid = scan.AR;
	end if;

	if	do_print > 0		then
		do_print := do_print - 01;
			dbms_output.put_line(ar.addr_num||' / '||rpad(rs.rangelo||'-'||rs.rangehi, 30)
				||' / '|| rs.roadid ||' '||rs.parcelid);
	end if;

	total_update	:= total_update + 01;

END LOOP;

	if	do_update > 0		then
		COMMIT;
	end if;

	dbms_output.put_line ( 'Total Road Input:   ' || total_input  );
	dbms_output.put_line ( 'Total Road Update:  ' || total_update );
	dbms_output.put_line ( '====================================' );
END;


--	============================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan set	statement_id = 'x'	into jdeacutis.plan_table for
--	============================================================

--	============================================================
--	select * from jdeacutis.explain_Plan;
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	============================================================
