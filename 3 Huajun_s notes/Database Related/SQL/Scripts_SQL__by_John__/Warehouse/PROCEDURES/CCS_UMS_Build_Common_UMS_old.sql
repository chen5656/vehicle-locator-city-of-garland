--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

--	execute	garland.CCS_UMS_Build_Common_UMS;

--	create or replace procedure garland.CCS_UMS_Build_Common_UMS	as

	DECLARE

--	=====================================================================

	compile_only	integer	:= 01;

	total_processed	integer	:= 0;
	title			varchar2(100);
	heading		varchar2(100);
	script		varchar2(2000);

begin

	if	compile_only > 0		then
		return;
	end if;

	select '   CCS UMS Build Common UMS  '||to_char(sysdate,'Mon dd hh24:mi') into heading from dual; 
	dbms_output.put_line(heading);

	script := 'alter session set nls_date_format = ''yyyy-mm-dd''';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

	script := 'Truncate table garland.Common_UMS reuse storage';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table	for
--	=================================================================================

	insert --+ append
	into	 garland.Common_UMS

	select distinct
		b.address_id,
		b.addr_num,
		ltrim(rtrim(b.addr_pfx)),
		ltrim(rtrim(b.addr_name)),
		ltrim(rtrim(b.addr_type)),
		ltrim(rtrim(b.addr_sfx)),
		null, null,
		b.location_no,
		b.account_no,
		b.person_no,
		ltrim(rtrim(b.last_name)),
		ltrim(rtrim(b.first_name)),
		ltrim(rtrim(b.drivers_license)),
		b.birth_date,
		null	
	from	garland.Basic_UMS		B,
(
	select address_id, 
		 max(effective_date)	effective_date
	from	garland.Basic_UMS
	group by address_id
)						U
	where	b.address_id 	= u.address_id
	and	b.effective_date	= u.effective_date
	and	translate(b.addr_num, '/1234567890','/') is null;

	total_processed := sql%rowcount;
	dbms_output.put_line ( 'UMS CCS Common UMS create:   ' || total_processed);

--	=================================================================================

	COMMIT;

--	=================================================================================
--	select * from garland.explain_Plan;
--	insert into   garland.plan_table (object_owner, object_name) values ('JDEACUTIS', '');
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;
--	=================================================================================

	script := 'analyze table garland.Common_UMS compute statistics';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

end;

--	===========================================================================
