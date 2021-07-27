	set echo 		off;
--	=================================================================================

	Truncate table	garland.COMMON_RECORD_SEQ	reuse storage;	

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table	for
--	=================================================================================

	insert --+ append 								
	into	 garland.COMMON_RECORD_SEQ
(
	select nvl(gis_key,0), 
		 nvl(tax_key,0), 
		 nvl(ums_key,0),	
		 highest + seq
	from
(
	select gis_key, tax_key, ums_key, 
		 rownum					Seq
	from	garland.COMMON_ADDRESS_KEYS		KKK			-- jan 2006
	where	not exists
(
	select 'x'
	from	garland.COMMON_RECORD_SEQ		KK
	where	kk.gis_key	= nvl(to_number(kkk.gis_key),0)
	and	kk.tax_key	= nvl(to_number(kkk.tax_key),0)
	and	kk.ums_key	= nvl(to_number(kkk.ums_key),0)
))								K,
(
	select nvl(max(Sequence),0)			Highest
	from	garland.COMMON_RECORD_SEQ		
)								S
)
	order by 1,2,3;


--	ROLLBACK;
	Commit;

--	=================================================================================

	select Sequence, count(*) dupeseq
	from	 garland.COMMON_RECORD_SEQ		
	group by Sequence
	having count(*) > 1;

	select gis_key, tax_key, ums_key, count(*) dupekey
	from	 garland.COMMON_RECORD_SEQ		
	group by gis_key, tax_key, ums_key
	having count(*) > 1;

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

	analyze table	garland.COMMON_RECORD_SEQ	compute statistics;

--	=================================================================================
