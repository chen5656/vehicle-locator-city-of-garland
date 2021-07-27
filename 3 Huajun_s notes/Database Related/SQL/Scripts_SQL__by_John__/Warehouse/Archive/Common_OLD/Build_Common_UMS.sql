	set echo		off;
    set linesize	2000;
	set timing		OFF;
--	===========================================================================

	alter session	set nls_date_format = 'yyyy-mm-dd';

--	===========================================================================
--	A GIS address is identified by an mslink (segment_id)
--	A GIS address may occur in multiple UMS locations due to multiple units
--	(see query at bottom)
--	Choose a single UMS record for each GIS address (segment_id)
--	===========================================================================

	Truncate table	garland.GIS_Objects	reuse storage;

--	=================================================================================
--	truncate table	garland.plan_table		reuse storage;
--	explain plan	set statement_id = 'pick'	into garland.plan_table	for
--	=================================================================================

	insert --+ append
	into	 garland.GIS_Objects  (item01, item02)

--	select segment_id, max(rowid)
	select segment_id, min(rec_key)

	from	 garland.adrResult_UMS_Location
	where	 verify_code = 55
	and	 rtrim(addr_code1) is null
	and	 rtrim(addr_unit1) is null
	and	 addr_num > 0
	and	 addr_num not between 9000 and 9999

	group  by segment_id;

	Commit;

--	=================================================================================

	analyze table	garland.GIS_Objects	compute statistics;

--	===========================================================================

	Truncate table	jdeacutis.Common_UMS	reuse storage;

--	===========================================================================
--	explain plan set statement_id = 'common ums'	into garland.plan_table	for
--	===========================================================================

--	select count(*) from  

	insert	--+ append
	into		JDEACUTIS.Common_UMS
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

--	and	r.rowid		= chartorowid(g.item02)
	and	r.rec_key		= g.item02

	and	r.verify_code 	= 55
);

--	===========================================================================
--	select * from garland.explain_Plan;
--	insert into garland.plan_table (object_owner, object_name) values('GARLAND', '');
--	execute  explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;
--	===========================================================================

	commit;

--	===========================================================================

	analyze table	JDEACUTIS.Common_UMS	compute statistics;	-- ******

--	===========================================================================

	select count(*)	"GARLAND"
	from	GARLAND.Common_UMS;

	select count(*)	"JDEACUTIS"
	from	JDEACUTIS.Common_UMS;

	select count(count(*))	"Dupes"
	from	JDEACUTIS.Common_UMS
	group by address_id
	having count(*) > 1;

	select * from all_objects where object_name = 'COMMON_UMS';

--	===========================================================================
	set echo		on;
	set timing		off;

