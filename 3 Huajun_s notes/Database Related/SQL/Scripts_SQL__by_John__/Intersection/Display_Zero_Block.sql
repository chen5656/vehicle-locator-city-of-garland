	set echo off;

--	=======================================================
--	truncate table	plan_table;
--	explain plan	set statement_id = 'a'		for

	select	distinct
			rpad(s.node,  4)		"node",
			lpad(r.mslink,6)		"mslink",
			rpad(s.terminal,1)	" ",
			r.addr_lo,
			r.addr_hi,
			r.addr_pfx			" ",
			r.addr_name,
			r.addr_type			" ",
			r.addr_sfx			" "
			
	from		spoke		s,
			trvehrcl	r

	where		r.mslink	= to_number(s.segment_id)
	and		s.node	in
(
	select	node
	from		spoke		s,
			trvehrcl	r
	where		r.mslink	= to_number(s.segment_id)
	and		s.terminal	= 'F'
	and		nvl(r.addr_lo,0) = 0

	union

	select	node
	from		spoke		s,
			trvehrcl	r
	where		r.mslink	= to_number(s.segment_id)
	and		s.terminal	= 'T'
	and		nvl(r.addr_hi,0) = 0
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

