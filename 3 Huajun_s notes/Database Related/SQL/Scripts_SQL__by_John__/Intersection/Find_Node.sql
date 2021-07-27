	set echo off;
--	==================================================================
--	find node number at intersection with specified constraints
--	==================================================================

--	2768		SYLVAN / NASH
--	1735		FIFTH  / AUSTIN
--	2811		FIFTH  / WALNUT
--	2799		FIRST  / WALNUT
--	2083		COLONY / COUNTRY CLUB
--	3634		SHILOH / GEORGE BUSH SERVICE
--	==================================================================

--	truncate table	plan_table;
--	explain plan	set statement_id = 'a'		for

	
	select 	distinct
			lpad (esri_node, 06)		"node",
			rpad (addr_name, 20)		"name",
			addr_type				"type",
			replace (addr_pfx,' ','-')	"pf",
			replace (addr_sfx,' ','-')	"sf",
			addr_lo				"       lo",
			addr_hi				"       hi",
			mslink				"   mslink",
			lpad(terminal,4)			"term"

	from		spoke			s,
			trvehrcl		r

	where		s.road_id = rtrim(r.mslink)
	and		s.esri_node		in 

(
	select s.esri_node
	from	spoke			s,
		trvehrcl		r

	where	rtrim(r.mslink)	= s.road_id

	and	r.addr_name		like	( 'BIG SPRINGS%' )

--	and	r.addr_name		in	( 'AVENUE A' )

--	and	r.addr_pfx		in	( 'W' )

--	and	r.addr_sfx		in	( 'N' )

--	and	r.addr_type		in	( '' )


	intersect

	select s.esri_node
	from	spoke			s,
		trvehrcl		r

	where	rtrim(r.mslink)	= s.road_id

	and	r.addr_name		like	( 'CALLEJO%'	)

--	and	r.addr_name		in	( 'FIRST' )

--	and	r.addr_pfx		in	( 'S' )

--	and	r.addr_sfx		in	( 'S' )

--	and	r.addr_type		in	( '' )

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
