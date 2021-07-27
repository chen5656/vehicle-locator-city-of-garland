	set echo 		off;
	set fetchrows;
	set charwidth;
	set stoponerror	on;
--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table	for
--	=================================================================================

	select chr(10)				" ",
		rpad(addr_name,		30)	"street_name", 
--		lpad(' ',			10)	"street_num", 
		count(*)				"     total",
		lpad(' ',			10)	"cluster_id", 
		lpad(' ',10)			" lo_number",
		lpad(' ',10)			" hi_number",
--		lpad(' ',15)			"      parcel_lo",
--		lpad(' ',12)			"   parcel_hi"
		' '					" "
	from	garland.cdreladr
	where	addr_name > '0'
	and	addr_name < 'B'		-- TEST
	group by addr_name

	UNION

	select ' ',
		rpad(a.addr_name||'.'||a.addr_type||'.'||a.addr_pfx,	30),
--		lpad(' ',								10),
		count(*),	
		lpad(w.cluster_id,						10),
		lpad(min(a.addr_num),						10),
		lpad(max(a.addr_num),						10),
--		lpad(min(a.parcel_id),						15),
--		lpad(max(a.parcel_id),						12)
		' '					" "
	from	garland.cdreladr			A,
		garland.water_ivr_parcel	W
	where	a.parcel_id		= w.parcel_id || '.000'
	and	a.addr_name > '0'
	and	a.addr_name < 'B'		-- TEST
	group by a.addr_name||'.'||a.addr_type||'.'||a.addr_pfx, w.cluster_id 

	order by 2,3;


--	=================================================================================
--	select * from garland.explain_Plan;
--	insert into   garland.plan_table (object_owner, object_name) values ('GARLAND', '');
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;

	Rollback;
	Commit;

--	=================================================================================
	set echo		on;
	set fetchrows;
	set charwidth;

