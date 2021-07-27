	set echo 		off;
	set stoponerror	on;
--	=================================================================================
--	Append Owner Initials to DCAD extract from Planning Dept

--	=================================================================================

--	Find shape file from Planning dept
--	Convert it to TEST SDE feature
--	Append an "Initials" column
--	Assign the Initials
--	Convert Feature to Shape

--	=================================================================================
--	DESC  gis.dcad_2005_parcel
--	=================================================================================

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table	for
--	=================================================================================

	update  gis.DCAD_2005_PARCEL
	set initials = 
(
	select 
--		acct, owner_name,
	rtrim(
	substr(owner_name, instr(owner_name||' ', ' ') + 01, 01) 	||
	substr(owner_name, 01,01))
	from	gis.dcad_2005_parcel
	where(instr(owner_name||' ',' OF ') <> instr(owner_name||' ',' ') 
	and	instr(owner_name||' ',' AT ') <> instr(owner_name||' ',' ') 
	)
--	and	rownum < 11		--  T E M P O R A R Y
)	;

--	=================================================================================

	update  gis.DCAD_2005_PARCEL
	set initials = 
(
	select 
--		acct, owner_name,
	rtrim(
	substr(owner_name, 01,01) 							||
	substr(owner_name, instr(owner_name||' ', ' ',01,02) + 01, 01) 	||
	substr(owner_name, instr(owner_name||'  ',' ',01,03) + 01, 01)),
	' '
	from	gis.dcad_2005_parcel
	where(instr(owner_name||' ',' OF ') = instr(owner_name||' ',' ') 
	or	instr(owner_name||' ',' AT ') = instr(owner_name||' ',' ') 
	)
--	and	rownum < 11		--  T E M P O R A R Y
)	;

--	=================================================================================

	select acct, owner_name, initials from gis.dcad_2005_parcel 
	where length(initials) = 2
	and	rownum < 111;

	select acct, owner_name, initials from gis.dcad_2005_parcel 
	where length(initials) = 3
	and	rownum < 111;

--	=================================================================================
--	select * from garland.explain_Plan;
--	insert   into garland.plan_table (object_owner, object_name) values ('GARLAND', '');
--	delete   from jdeacutis.plan_table where object_name like 'SDE%' or object_name like 'GDB%';

--	execute	  garland.explain_More;
--	select * from garland.explain_Column;
--	select * from garland.explain_Table;
--	select * from garland.explain_Analyze;
--	select * from garland.explain_Indexed;

--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Dependent;
--	=================================================================================
	set fetchrows;
	set charwidth;

