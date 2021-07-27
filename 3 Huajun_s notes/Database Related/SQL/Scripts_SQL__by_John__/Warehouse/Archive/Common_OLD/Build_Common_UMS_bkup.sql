    set linesize	2000;
	set echo		off;
	set timing		OFF;
--	===========================================================================

	alter session	set nls_date_format = 'yyyy-mm-dd';

--	===========================================================================

	Truncate table	GARLAND.Common_UMS	reuse storage;		--  *****

--	===========================================================================
/*

	truncate table	garland.GIS_Objects	reuse storage;

	insert --+ append
	into	 garland.GIS_Objects  (item01, item02)

	select segment_id, max(rowid)
	from	 garland.adrResult_UMS_Location

	where	 verify_code = 55
	and	 rtrim(addr_code1) is null
	and	 rtrim(addr_unit1) is null

	group  by segment_id;

	analyze table	garland.GIS_Objects	compute statistics;

*/
--	===========================================================================
	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	===========================================================================
--	explain plan set statement_id = 'common ums'	into garland.plan_table	for

--	select count(*) from  

	insert	--+ append
	into		GARLAND.Common_UMS						-- *****
(
	select distinct

		r.segment_id,

		r.addr_num,
		r.addr_pfx,
		r.addr_name,
		r.addr_type,
		r.addr_sfx,
		null, null,

		b.location_no,
		b.account_no,
		b.person_no,

		b.last_name,
		b.first_name,
		b.drivers_license,

		b.birth_date,

		null				-- parent_id

	from	garland.Basic_UMS				B,	
		garland.adrResult_UMS_Location	R,
		garland.GIS_Objects			G

	where	b.location_no	= to_number(r.rec_key)

	and	rtrim(b.addr_bldg) is null
	and	rtrim(b.addr_unit) is null

	and	r.segment_id	= g.item01
	and	r.rowid		= chartorowid(g.item02)

	and	r.verify_code 	= 55
);

--	===========================================================================
--	insert into garland.plan_table (object_owner, object_name) values('GARLAND', '');

--	execute  explain_More;
--	select * from garland.explain_Plan;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;
--	===========================================================================

	commit;
	alter rollback segment rb1 offline;

	analyze table	GARLAND.Common_UMS	compute statistics;	-- ******

--	===========================================================================

	select count(*)	"Total"
	from	GARLAND.common_ums;

	select count(count(*))	"Dupes"
	from	GARLAND.common_ums							-- ******
	group by address_id
	having count(*) > 1;

--	===========================================================================
	set echo		on;
	set timing		off;


