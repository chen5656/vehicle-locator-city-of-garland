	set echo		off;
	set serveroutput	on	size 999999;
--	======================================================================================
--	generate "dime" list of all address ranges in Garland 
--	======================================================================================

--	truncate table	plan_table;
--	explain plan	set statement_id = 'test'		for

	select

		lpad(t.addr_left_from,05) ||'-'|| rpad(t.addr_left_to,05)	"Left Range",
		lpad(t.addr_rght_from,05) ||'-'|| rpad(t.addr_rght_to,05)	"Right Range",

		rpad(t.addr_pfx,   02)		"Pf",	
		rpad(t.addr_name,  25)		"Name",
		rpad(t.addr_type,  04)		"Type",	
		rpad(t.addr_sfx,   02)		"Sf"

	from	garland.trvehrcl		t

	where	nvl(t.addr_left_from,0) > 0
	and	nvl(t.addr_rght_from,0) > 0

	order by	4,5,3,6,1

--	select * from explain_plan;

