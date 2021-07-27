--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================
--	Update Address info in Basic UMS with scrubbed address info
--	=====================================================================

--	execute	garland.CCS_UMS_Get_Address;

	create or replace procedure garland.CCS_UMS_Get_Address	as

--	DECLARE

--	=====================================================================

	compile_only	integer	:= 0;

	total_processed	integer	:= 0;
	title			varchar2(100);
	heading		varchar2(100);
	script		varchar2(2000);

BEGIN
	if	compile_only > 0		then
		return;
	end if;

	title := 'GET BASIC ADDRESS ';	dbms_output.put_line(title);

--	===========================================================================
--	truncate table	garland.plan_table		reuse storage;
--	explain plan set statement_id = 'ums basic'	into garland.plan_table	for
--	===========================================================================

	update garland.Basic_UMS			U
	set	(address_id, addr_num, addr_pfx, addr_name, addr_type, addr_sfx)  =
(
	select 
		nvl(r.segment_id, v.address_id)	address_id,
		nvl(r.addr_num,	v.addr_num)		addr_num,
		nvl(r.addr_pfx,	v.addr_pfx)		addr_pfx,
		nvl(r.addr_name,	v.addr_name)	addr_name,
		nvl(r.addr_type,	v.addr_type)	addr_type,
		nvl(r.addr_sfx,	v.addr_sfx)		addr_sfx

	from	garland.Basic_UMS				V,
		garland.adrResult_UMS_Location	R

	where	v.rowid			= u.rowid
	and	v.location_no||''		= r.rec_key (+)
	and	translate(r.addr_num, '/1234567890','/') is null
);

	total_processed := sql%rowcount;
	dbms_output.put_line ( 'Set Address Total: ' || total_processed);

	COMMIT;

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	select * from garland.explain_table;
--	===========================================================================

	title := 'Clean Address';  dbms_output.put_line(title);

	update garland.Basic_UMS
	set	addr_pfx		= nvl(addr_pfx, ' '),
		addr_name		= nvl(addr_name,' '),
		addr_type		= nvl(addr_type,' '),
		addr_sfx		= nvl(addr_sfx, ' '),
		addr_unit		= nvl(addr_unit,' ');


	COMMIT;

--	===========================================================================

end;

