--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	===========================================================================
--	Build Basic UMS extract for general use by other routines
--	===========================================================================

--	=====================================================================

--	execute	garland.CCS_UMS_Build_Basic_UMS;

--	create or replace procedure garland.CCS_UMS_Build_Basic_UMS		as

	DECLARE

--	=====================================================================

	compile_only	integer	:= 01;

	total_processed	integer	:= 0;
	title			varchar2(100);
	heading		varchar2(100);
	script		varchar2(2000);

	location		number := 0;
	person		number;
	effective		varchar2(10);
	insert_count	integer := 0;

cursor	Read_UMS_Keys	is

	select	
		to_number(location_no)		location_no, 
		effective_dt, 
		to_number(person_no),		person_no, 
		to_number(account_no)		account_no, 
		to_number(service_seq)		service_seq
	from	garland.TEMP_VIEW4
	order by 1, 2 desc, 3;

begin

	if	compile_only > 0		then
		return;
	end if;

	title := 'Build Basic UMS  ';	dbms_output.put_line(title);

	DBMS_UTILITY.EXEC_DDL_STATEMENT ( 'Truncate table  garland.BASIC_UMS  reuse storage' );

for	read in Read_UMS_Keys		loop

	if	read.location_no > location		then
		location	:= read.location_no;
		effective	:= read.effective_dt;
		person	:= null;
	end if;

	if	read.effective_dt < effective	
	or	read.person_no 	= person		then
		goto	end_loop;
	end if;

	person := read.person_no;

	insert into garland.Basic_UMS
	select
		read.location_no,
		read.account_no,
		read.service_seq,
		read.person_no,
		to_date(read.effective_dt,'yyyymmdd'),
		ltrim(rtrim	(p.person_lnm)),
		ltrim(rtrim	(p.person_fnm)),
		p.birth_inc_dt,
		ltrim(rtrim	(p.i_drivers_lic_no)),
		rtrim		(p.o_fen),
		rtrim		(p.i_gender),
		rtrim(ltrim(l.house_no)),
		nvl(rtrim(l.street_pfx_dir),	' '),
		nvl(rtrim(l.street_nm),		' '),
		nvl(rtrim(l.street_nm_sfx),	' '),
		nvl(rtrim(l.street_sfx_dir),	' '),
		null, null,					
		null,						
		null						
	from	sfg.um00100m@umsrep.world	L,
		sfg.um00200m@umsrep.world	A,
		sfg.sg00100m@umsrep.world	P
	where	l.location_no	= read.location_no
	and	a.account_no	= read.account_no
	and	p.person_no		= read.person_no;
	
	insert_count := insert_count + 01;

<<end_loop>>
	null;
end loop;

	COMMIT;

	script := 'analyze table garland.Basic_UMS compute statistics';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

	dbms_output.put_line ( 'Basic UMS Total: '  || insert_count);
end;


