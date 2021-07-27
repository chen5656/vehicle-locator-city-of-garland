	set echo	off;
--	set timing	on;
--	=================================================================================
--	Obtain the Location Number and Address for each Water Serial Number
--	=================================================================================

	create or replace view	garland.Temp_View		AS

	select
		item01	serial_no,	
		item02	location_no,

		item03	addr_num,
		item04	addr_pfx,
		item05	addr_name,
		item06	addr_type,
		item07	addr_sfx,
		item08	addr_bldg,
		item09	addr_unit,

		item10	company_cd
	
	from	garland.GIS_Objects;

--	=================================================================================

	Truncate table	garland.GIS_Objects	reuse storage;

--	=================================================================================

--	truncate table	garland.plan_table	reuse storage;
--	explain plan set statement_id = ' '		into garland.plan_table		for

--	=================================================================================

	insert --+ append
	into	 garland.Temp_View

	select
		t.serial_no,			
		t.location_no,

		t.addr_num,
		t.addr_pfx,
		t.addr_name,
		t.addr_type,
		t.addr_sfx,
		t.addr_bldg,
		t.addr_unit,

		u.company_cd
	
	from	garland.Temp_View2		T,
		sfg.um00300m@umsrep.world		U

	where	t.serial_no	= u.serial_no (+);


	Commit;


--	=================================================================================
--	how many locations have multiple serial numbers

	select count(counter) occurs, sum(counter) summed, max(counter) maximum, avg(counter) average
	from
(
	select location_no, count(*) counter
	from	 garland.Temp_View
	group by location_no
	having count(distinct serial_no) > 1
);

--	=================================================================================
--	select * from garland.explain_Plan;
--	execute  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;
--	=================================================================================
	set echo	on;
	set timing	off;


