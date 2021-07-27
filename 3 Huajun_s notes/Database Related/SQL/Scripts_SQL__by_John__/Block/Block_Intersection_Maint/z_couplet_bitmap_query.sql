	set echo	off;
--	===========================================================================
--	obtain statistics of counts for couplet bitmap index
--	===========================================================================

--	truncate table	garland.plan_table	reuse storage;
--	explain plan set statement_id = 'xxx'		into garland.plan_table	for
--	===========================================================================

--	------------------------------------------------------------------------------
/*

	select addr1_pfx, addr1_name, addr1_type, addr2_pfx, addr2_name, addr2_type
	from	 garland.intersection
	where  intersect_id like 'AA%'
	and	( rpad(addr1_name,1) || rpad(addr2_name,1) )  in

*/
--	------------------------------------------------------------------------------

(
	select count(count(*)), min(count(*)), max(count(*)), avg(count(*))	-- 555,4,1388,98

--	select rpad(addr1_name,1) || rpad(addr2_name,1) 

	from	 garland.intersection
	group by rpad(addr1_name,1) || rpad(addr2_name,1)


--	having count(*) < 100		-- 372,4,96,36
--	having count(*) > 100		-- 179,102,1388,227
);

--	------------------------------------------------------------------------------


--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_constraint;
--	select * from garland.explain_column;
--	select * from garland.explain_analyze;
--	===========================================================================




	