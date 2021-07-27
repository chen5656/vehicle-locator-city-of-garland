	set echo 		off;
	set fetchrows	111;
	set charwidth;
	set stoponerror	on;
--	=================================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into jdeacutis.plan_table	for
--	=================================================================================

	select address_id, location_no, person_no
	from	 jdeacutis.Common_UMS
	where	 address_id		in

--	select count(counter), sum(counter)
--	from

(
	select address_id
--		 ,count(*) Counter
	from	JDEACUTIS.Common_UMS
	group by address_id
	having count(*) > 1
)

	order by 1,2,3;


--	=================================================================================
--	select * from jdeacutis.explain_Plan;
--	insert into   jdeacutis.plan_table (object_owner, object_name) values ('JDEACUTIS', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Table;
--	select * from jdeacutis.explain_Index;
--	select * from jdeacutis.explain_Constraint;
--	select * from jdeacutis.explain_Column;
--	select * from jdeacutis.explain_Dependent;
--	select * from jdeacutis.explain_Analyze;
--	=================================================================================
	set fetchrows;
	set charwidth;


