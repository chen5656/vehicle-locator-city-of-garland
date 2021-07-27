	set echo 		off;
    set linesize	2000;
	set fetchrows;
	set charwidth;
	set stoponerror	on;
--	=================================================================================
--	display owner formatting errors
--	=================================================================================

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table	for
--	=================================================================================

	select	 rpad(s.gis_key,	10)		"Address ID"
			,rpad(s.sequence,	10)		"Record Seq"
			,rpad(account,	12) 		"Account" 

			,rpad(attn,20) "Attn" 	 ,rpad(name,30) "Name"
			,rpad(strt,20) "Address" ,rpad(city,15) "City" 

--			,rpad(unit,20) "Unit"

--			,rpad(cast,25) "Cast" ,rpad(error,15) "Error"
	
	from		garland.TEMP_VIEW1		V,
			garland.COMMON_RECORD_SEQ	S

	where		v.account = s.tax_key||''
	and		v.error > '0';

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
--	=================================================================================


--	====================================================================================
--	examine input for particular cases

/*
	select * from garland.gds_account 
	where rownum < 	0
	and	account	in 
	(

	0000000330, 0000000366, 0000000477, 0000000621

	);

*/
--	====================================================================================

--	desc temp_view1;

--	====================================================================================
	set echo on;
