	set echo 		off;
    set linesize	2000;
	set fetchrows;
	set charwidth;
	set stoponerror	on;

--	=================================================================================

--	analyze table garland.gis_temp1  compute statistics;

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table	for
--	=================================================================================

--	select count(*)

	select record_seq, tax_owner, tax_addr1, tax_addr2

	from	garland.Temp_View1		V,
		garland.Common_Record_Seq	S,
		garland.CCS_Address		A

	where	s.TAX_key	= to_number(v.Account)
	and	s.Sequence	= a.Record_SEQ
	and	v.error > '0'
	;

--	=================================================================================
--	select * from garland.explain_Plan;
--	insert into   garland.plan_table (object_owner, object_name) values ('GARLAND', '');
--	insert into   garland.plan_table (object_owner, object_name) values ('GARLAND', 'CCS_ADDRESS');
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;
--	=================================================================================
	set fetchrows;
	set charwidth;


