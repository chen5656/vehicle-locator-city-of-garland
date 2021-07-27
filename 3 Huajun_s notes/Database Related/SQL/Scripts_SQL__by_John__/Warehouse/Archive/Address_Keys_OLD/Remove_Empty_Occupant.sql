	set echo 		off;
	set stoponerror	on;
--	=================================================================================

--	SAME AS REMOVE_NULL_UMS

--	=================================================================================
--	Sometimes two records are associated with the same GIS/TAX address
--	One contains a UMS key and one does not
--	The Address Key record w/out the UMS key needs to be removed
--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table	for
--	=================================================================================

--	select count(*)
--	select a.gis_key, a.tax_key, a.ums_key

	Delete
	from	garland.Common_Address_Keys
	where	(nvl(gis_key,0), nvl(tax_key,0), nvl(ums_key,0))		IN
(
	select nvl(a.gis_key,0), nvl(a.tax_key,0), nvl(a.ums_key,0)
	from	garland.Common_Address_Keys		A,
(
	select nvl(gis_key, 0)	gis_key, 
		 nvl(tax_key, 0)	tax_key
	from	garland.Common_Address_Keys	
	group by nvl(gis_key,0), nvl(tax_key,0)
	having count(distinct nvl(ums_key,0)) > 1
)								B
	where	nvl(a.gis_key,0)	= b.gis_key
	and	nvl(a.tax_key,0)	= b.tax_key
	and not exists
(
	select 'x'
	from	garland.Basic_UMS			U
	where	u.location_no = a.ums_key
)
);


	Rollback;
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

