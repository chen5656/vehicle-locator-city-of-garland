	set echo		off;
	set fetchrows	111;
--	=================================================================================
	truncate table	garland.plan_table	reuse storage;
--	explain plan set statement_id = ' '		into garland.plan_table	for

/*
	select segment_id, 
		 rec_key,
		lpad(nvl(ltrim(appl_num),0),05)	"num", 
		rpad(nvl(appl_pfx, ' '),02)		"pf", 
		rpad(nvl(appl_name,' '),20)		"name",
		rpad(nvl(appl_type,' '),04)		"type",	 
		rpad(nvl(appl_sfx, ' '),02)		"sf"
		,rpad(nvl(addr_code1, ' '),10)	"bldg"
		,rpad(nvl(addr_unit1, ' '),10)	"unit"
	from adrResult
	where	addr_num > '0'
	and	rtrim(addr_code1) is null
	and	rtrim(addr_unit1) is null
	and	segment_id 	in
*/


(

--	select segment_id
	select count(count(*)), sum(count(*))

	from	adrResult
	where	segment_id > '0'
	group by segment_id
	having count(*) > 1
)
--	order by segment_id
;

--	=================================================================================
--	insert into garland.plan_table (object_owner, object_name) values ('GARLAND', '');

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
	set echo	on;
	set fetchrows;
