	set echo 		off;
	set charwidth;
	set stoponerror	on;
--	=================================================================================

--	see \\ scripts\verizon\VIEW_VERIZON

--	=================================================================================

	Truncate table	garland.Verizon	reuse storage;

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table	for
--	=================================================================================

	insert --+ append
	into	 garland.Verizon_Info
	(		phone, streetnum, streetprefix, streetname, streettype, streetsuffix, unitnum,
			city, state, customer, main	
	)
	select	v.phone,

			a.addr_num,
			a.addr_pfx,
			a.addr_name,
			a.addr_type,
			a.addr_sfx,
			a.addr_unit1,

			v.city,
			v.state,
			v.customer,
			v.main

	from	garland.Temp_View			V,
		garland.adrResult_Verizon	A

	where	v.phone = a.rec_key;

	Commit;

--	=================================================================================
--	select * from garland.explain_Plan;
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;
--	=================================================================================
	set echo		on;
	set charwidth;

