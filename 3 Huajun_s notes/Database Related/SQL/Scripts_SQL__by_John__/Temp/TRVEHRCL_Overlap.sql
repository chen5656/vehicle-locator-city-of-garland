	set echo off;

--	=================================================================================
--	Obtain the low range segment where two segment ranges overlap
--	This "to node" spoke should be ignored when building the intersection table
--	=================================================================================

--	truncate table	plan_table;
--	explain plan	set statement_id = 'a'		for

	select addr_name, addr_type, addr_pfx, addr_sfx, addr_lo, addr_hi, mslink
	from	trvehrcl
	where	(addr_name, addr_type, addr_pfx, addr_sfx, trunc(addr_hi,-2), addr_hi)	in
(
	select r.addr_name, r.addr_type, r.addr_pfx, r.addr_sfx, b.addr_block, min(r.addr_hi) addr_hi
	from	trvehrcl		r,
(
	select addr_name, addr_type, addr_pfx, addr_sfx, addr_block
	from	adrBlock 
	where	counter > 1
)					b
	where	b.addr_name		= r.addr_name
	and	b.addr_type		= r.addr_type
	and	b.addr_pfx		= r.addr_pfx
	and	b.addr_sfx		= r.addr_sfx
	and	b.addr_block	= trunc(r.addr_lo, -2)

	group by r.addr_name, r.addr_type, r.addr_pfx, r.addr_sfx, b.addr_block
);

--	=======================================================
--	select * from explain_plan;
--	select * from explain_indexed;
--	select * from explain_constraint;
--	select * from explain_table;
--	select * from explain_index;
--	select * from explain_analyze;
--	select * from explain_cost;
--	=======================================================
	set echo on;
