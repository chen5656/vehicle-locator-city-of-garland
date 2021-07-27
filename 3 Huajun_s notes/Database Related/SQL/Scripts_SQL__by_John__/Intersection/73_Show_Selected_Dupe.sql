	set echo off;
--	=======================================================
--	display which of many-node duplicates were selected
--	    and which if many-node duplicates were rejected
--	=======================================================

--	truncate table	plan_table;
--	explain plan	set statement_id = 'a'		for


--	select 	count(*)


	select	' ' ||
			rpad(addr1_block,05)	" ", 
			rpad(addr1_pfx,  02)	" ",
			rpad(addr1_name, 20)	" ",
			rpad(addr1_type, 04)	" ",
			rpad(addr1_sfx,  02)	" ",
			chr(10)			" ",

			rpad(addr2_block,05)	" ", 
			rpad(addr2_pfx,  02)	" ",
			rpad(addr2_name, 20)	" ",
			rpad(addr2_type, 04)	" ",
			rpad(addr2_sfx,  02)	" ",
			chr(10)			" ",

			rpad(' ', 09) ||
			rpad(flag,03)			" ",	
			substr(intersect_id,01,	02)	" ",
			rpad(intersect_id,	15)	" ", 
			chr(10)				" "


	from
(

--			the dupe intersections that were selected
(
	select	x.addr1_name, x.addr1_type, x.addr1_pfx, x.addr1_sfx, x.addr1_block, 
			x.addr2_name, x.addr2_type, x.addr2_pfx, x.addr2_sfx, x.addr2_block,
			01	flag,	
			x.intersect_id 
	from		dupe_intersect	x

	intersect

	select	x.addr1_name, x.addr1_type, x.addr1_pfx, x.addr1_sfx, x.addr1_block, 
			x.addr2_name, x.addr2_type, x.addr2_pfx, x.addr2_sfx, x.addr2_block,
			01	flag,	
			x.intersect_id 
	from		intersection	x
)

	union

--			the dupe intersections that were rejected
(
	select	x.addr1_name, x.addr1_type, x.addr1_pfx, x.addr1_sfx, x.addr1_block, 
			x.addr2_name, x.addr2_type, x.addr2_pfx, x.addr2_sfx, x.addr2_block,
			02	flag,	
			x.intersect_id 
	from		dupe_intersect	x

	minus
	
	select	x.addr1_name, x.addr1_type, x.addr1_pfx, x.addr1_sfx, x.addr1_block, 
			x.addr2_name, x.addr2_type, x.addr2_pfx, x.addr2_sfx, x.addr2_block,
			02	flag,	
			x.intersect_id 
	from		intersection	x
)

);


--	======================================================================
--	select * from explain_plan;
--	select * from explain_indexed;
--	select * from explain_analyze;
--	select * from explain_table;
--	select * from explain_index;
--	select * from explain_constraint;
--	select * from explain_cost;
--	======================================================================
	set echo on;

