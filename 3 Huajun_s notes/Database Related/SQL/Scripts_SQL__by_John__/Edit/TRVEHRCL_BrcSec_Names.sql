
--	display which trvehrcl branch/section comprise multiple street names

--	display trvehrcl & pave_mast having the same branch-section 
--	but different street name

--	=============================================================

	select	
			branch_no,
			section_no
	from		trvehrcl

	where		branch_no < 7777

	group by 	branch_no, section_no
	having	count (distinct addr_name) > 1
	;

--	=============================================================


--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'	for


select	distinct
		r.branch_no,
		r.section_no,
		r.addr_name,
		s.addr_name

from		trvehrcl	r,
		pave_mast	s

where		r.branch_no  = s.branch
and		r.section_no = s.section
and		s.category	= 's'

and		r.addr_name <> s.addr_name

and		r.branch_no < 7777
and		s.branch    < 7777;


--	@c:\deacutis\scripts\plans\exhibit.sql
