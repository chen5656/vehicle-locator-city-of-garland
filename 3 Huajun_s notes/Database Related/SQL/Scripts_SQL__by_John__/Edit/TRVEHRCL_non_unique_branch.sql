	set echo	off;
--	=================================================================
--	streets in TRVEHRCL having more than 1 distinct branch number
--	=================================================================

--	desc trvehrcl;

--	truncate table	plan_table;
--	explain plan	set statement_id = 'a'		for

--	=======================================================

	select distinct
		addr_pfx,
		addr_name,
		addr_type,
		addr_sfx,
		branch_no,
		mslink
from		trvehrcl

where		branch_no < 9999


and	(
		addr_name,
		addr_type,
		addr_pfx,
		addr_sfx
	)
in
(
	select
		addr_name,
		addr_type,
		addr_pfx,
		addr_sfx

	from	trvehrcl

	where	branch_no < 9999

	group by 	addr_name, addr_type, addr_pfx, addr_sfx
	having 	count(distinct branch_no) > 1
)

order by	addr_name, addr_type, addr_pfx, addr_sfx, branch_no, mslink
;
		

--	=======================================================

--	select * from explain_plan;

--	select * from explain_indexed;
--	select * from explain_constraint;
--	select * from explain_table;
--	select * from explain_index;
--	select * from explain_analyze;
--	select * from explain_cost;

--	=======================================================
	set echo	on;
