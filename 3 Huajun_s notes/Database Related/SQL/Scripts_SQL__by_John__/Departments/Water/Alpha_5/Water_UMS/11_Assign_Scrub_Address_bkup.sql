	set echo	off;
--	set timing	on;
--	=================================================================================
--	Obtain the Location Number and Address for each Water Serial Number
--	=================================================================================

--	truncate table	garland.plan_table	reuse storage;
--	explain plan set statement_id = ' '		into garland.plan_table		for

--	=================================================================================

	update garland.Temp_View2			TT
	set	( addr_num,	addr_pfx, addr_name, addr_type, addr_sfx, addr_bldg, addr_unit )	=
(
	select	nvl(r.addr_num, 	t.addr_num ),
			nvl(r.addr_pfx, 	t.addr_pfx ),
			nvl(r.addr_name, 	t.addr_name),
			nvl(r.addr_type, 	t.addr_type),
			nvl(r.addr_sfx, 	t.addr_sfx ),
			nvl(r.addr_code1,	t.addr_bldg),
			nvl(r.addr_unit1,	t.addr_unit)

	from	 garland.Temp_View2			T,
		 garland.adrResult_UMS_Location	R

	where	t.rowid		= tt.rowid
	and	t.location_no	= r.rec_key (+)
);

	Commit;

--	=================================================================================
--	select * from garland.explain_Plan;
--	execute  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;
--	=================================================================================
	set echo	on;
	set timing	off;

