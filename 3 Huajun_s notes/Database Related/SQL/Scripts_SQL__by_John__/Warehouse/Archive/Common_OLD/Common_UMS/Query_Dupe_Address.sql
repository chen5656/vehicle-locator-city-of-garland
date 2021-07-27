	set echo 		off;
	set fetchrows;
--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table	for
--	=================================================================================

	select 
--		 u.address_id, 
		 u.addr_num, u.addr_pfx, u.addr_name, u.addr_type, u.addr_sfx, 
		 u.person_no, p.person_stat, u.last_name 
--		 ,u.first_name

--	from	jdeacutis.Common_UMS		U
	from	garland.Common_UMS		U

		,sfg.sg00100m@umsrep.world	P
		
	where address_id	in
(
	select address_id
--	from	jdeacutis.Common_UMS
	from	garland.Common_UMS
	group by address_id
	having count(*) > 1
)

	and	u.person_no = p.person_no

	order by addr_name, addr_type, addr_pfx, addr_sfx, addr_num 
;
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
	set fetchrows;
	set charwidth;
