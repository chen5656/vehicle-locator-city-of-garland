--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
-- set serveroutput	on	size 99999;
-- alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';  
-- select sysdate from dual;	
--	===========================================================================
--	Update Address info in Basic UMS with scrubbed address info
--	===========================================================================

	analyze table	garland.Basic_UMS				compute statistics;
	analyze table	garland.adrResult_UMS_Location	compute statistics;

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

--	===========================================================================

	update garland.Basic_UMS
	set	addr_pfx		= nvl(addr_pfx, ' '),
		addr_name		= nvl(addr_name,' '),
		addr_type		= nvl(addr_type,' '),
		addr_sfx		= nvl(addr_sfx, ' '),
		addr_unit		= nvl(addr_unit,' ');
	Commit;

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	select * from garland.explain_table;
--	===========================================================================
