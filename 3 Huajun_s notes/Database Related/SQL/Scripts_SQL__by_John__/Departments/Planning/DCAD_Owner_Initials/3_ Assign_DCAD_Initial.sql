	set linesize 2000;
	set pagesize 200;
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
--	explain plan	set statement_id = ' '	into garland.plan_table	for
--	=================================================================================
--	get 2 character initials

	update  garland.Temp_View	V
	set initials = 
(
	select 
		rtrim(
		substr(owner_name, instr(owner_name||' ', ' ') + 01, 01) 			||
		substr(owner_name, 01,01))
	from	garland.Temp_View	VV
	where	vv.rowid = v.rowid
	and (	instr(owner_name||' ',' OF ') <> instr(owner_name||' ',' ') 
	and	instr(owner_name||' ',' AT ') <> instr(owner_name||' ',' ') 
	)
)	;

--	=================================================================================
--	get 3 character initials

	update  garland.Temp_View	V
	set initials = 
(
	select 
		rtrim(
		substr(owner_name, 01,01) 							||
		substr(owner_name, instr(owner_name||' ', ' ',01,02) + 01, 01) 	||
		substr(owner_name, instr(owner_name||'  ',' ',01,03) + 01, 01))
	from	garland.Temp_View	VV
	where	vv.rowid = v.rowid
	and (	instr(owner_name||' ',' OF ') = instr(owner_name||' ',' ') 
	or	instr(owner_name||' ',' AT ') = instr(owner_name||' ',' ') 
	)
)
	where exists
(
	select 'x'
	from	garland.Temp_View	VV
	where	vv.rowid = v.rowid
	and (	instr(owner_name||' ',' OF ') = instr(owner_name||' ',' ') 
	or	instr(owner_name||' ',' AT ') = instr(owner_name||' ',' ') 
	)
);

--	=================================================================================

	COMMIT;

--	=================================================================================

	select	rpad(account,20) account,  rpad(owner_name,40) owner_name, rpad(initials,08) initials
	from	garland.Temp_View
	where	length(initials) = 2
	and	rownum < 111;

	select	rpad(account,20) account,  rpad(owner_name,40) owner_name, rpad(initials,08) initials
	from	garland.Temp_View
	where	length(initials) = 3
	and	rownum < 111;


	select count(initials) total from garland.Temp_View;

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
