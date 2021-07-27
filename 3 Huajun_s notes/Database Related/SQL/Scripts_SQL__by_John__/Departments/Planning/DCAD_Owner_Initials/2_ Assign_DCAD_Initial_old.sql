--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	400;
set pagesize	9999;
--	=================================================================================
--	Append Owner Initials to DCAD extract from Planning Dept
--	=================================================================================

--	Find shape file from Planning dept
--	Convert it to TEST SDE feature
--	Append an "Initials" column
--	Assign the Initials
--	Convert Feature to Shape

--	=================================================================================
--	desc  garland.Temp_View
--	=================================================================================

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	=================================================================================
--	explain plan	set statement_id = 'aa '	into garland.plan_table	for
--	=====================================================================

	update  garland.Temp_View
	set initials = 		
		rtrim(
		substr(owner_name, instr(owner_name||' ',' ') + 01, 01) 	||
		substr(owner_name, 01,01))
	where instr(owner_name||' ',' OF ') <> instr(owner_name||' ',' ') 
	and	instr(owner_name||' ',' AT ') <> instr(owner_name||' ',' ') 
	and	instr(owner_name||' ',' &'  ) = 0
	;

--	=================================================================================
--	explain plan	set statement_id = 'bb '	into garland.plan_table	for
--	=================================================================================

	update  garland.Temp_View
	set initials = 
		rtrim(
		substr(owner_name, 01,01) 							||
		substr(owner_name, instr(owner_name||' ', ' ',01,02) + 01, 01) 	||
		substr(owner_name, instr(owner_name||'  ',' ',01,03) + 01, 01))
	where instr(owner_name||' ',' OF ') = instr(owner_name||' ',' ') 
	or	instr(owner_name||' ',' AT ') = instr(owner_name||' ',' ') 
	or	instr(owner_name||' ',' &'  ) > 0
	;

--	=================================================================================

	select rpad(account,20) account,  rpad(owner_name,40) owner_name, rpad(initials,08) initials
	from	garland.Temp_View
	where	length(initials) = 2
	and	rownum < 111;

	select rpad(account,20) account,  rpad(owner_name,40) owner_name, rpad(initials,08) initials
	from	garland.Temp_View
	where	length(initials) = 3
	and	rownum < 111;

--	=================================================================================
--	select * from garland.explain_Plan;
--	insert   into garland.plan_table (object_owner, object_name) values ('GARLAND', '');
--	execute	  garland.explain_More;
--	select * from garland.explain_Column;
--	select * from garland.explain_Table;
--	select * from garland.explain_Analyze;
--	select * from garland.explain_Indexed;
--	=================================================================================
