	set echo 		off;
	set fetchrows	11;
	set charwidth;
	set stoponerror	on;
--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table	for
--	=================================================================================

--	insert --+ append 		-- First Time Only

	insert 
	into	 garland.Common_Record_Seq		
(
	select nvl(gis_key,0), 
		 nvl(tax_key,0), 
		 nvl(ums_key,0),	
		 highest + seq
	from
(
	select gis_key, tax_key, ums_key, 
		 rownum					Seq
	from	garland.Extract1_Address_Keys		KKK
	where	not exists
(
	select 'x'
	from	garland.Common_Record_Seq		KK
	where	kk.gis_key	= nvl(kkk.gis_key,0)			-- AUG 2005
	and	kk.tax_key	= nvl(kkk.tax_key,0)
	and	kk.ums_key	= nvl(kkk.ums_key,0)
))								K,
(
	select nvl(max(Sequence),0)			Highest
	from	garland.Common_Record_Seq		
)								S
)
	order by 1,2,3;

--	=================================================================================
/*
	select Sequence, count(*) dupeseq
	from	 garland.Common_Record_Seq	
	group by Sequence
	having count(*) > 1;


	select gis_key, tax_key, ums_key, count(*) dupekey
	from	 garland.Common_Record_Seq	
	group by gis_key, tax_key, ums_key
	having count(*) > 1;
*/
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


	ROLLBACK;

	Commit;

--	=================================================================================

--	analyze table	garland.Common_Record_Seq	compute statistics;

--	=================================================================================
	set fetchrows;
	set charwidth;
