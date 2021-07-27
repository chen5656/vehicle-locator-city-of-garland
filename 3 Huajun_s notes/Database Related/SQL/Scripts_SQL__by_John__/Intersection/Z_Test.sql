	set echo off;
--	======================================================================
--	analyze table	garland.		compute statistics;
--	insert into plan_table (object_name, object_owner) values (upper( ' ' ),	'GARLAND');

--	truncate table	garland.plan_table;
--	explain plan	set statement_id = 'a'	into garland.plan_table		for
--	======================================================================

		select		distinct

			lpad(s.esri_node,4,'0'),

			s.street_id,
			r.addr_name,
			r.addr_type,
			r.addr_pfx,
			r.addr_sfx,
			s.block_id


--			trunc(nvl(r.addr_lo,0), -2)		addr_block,

--			s.terminal,	

--			r.mslink					road_id,

--			trunc(nvl(r.addr_hi,0), -2)		addr_block2,



		from	spoke		s,
			trvehrcl	r

		where	s.road_id	 = rtrim(r.mslink)
		and	s.terminal	 = 'F'
		and	r.addr_name	 > '0'
		and	r.addr_lo 	 >  0

		and	s.esri_node	between 1 and 100
		and	1234	in (0, 1234)
		;



--	======================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_analyze;
--	select * from garland.explain_indexed;
--	select * from garland.explain_constraint;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_cost;
--	select * from garland.explain_remote;
--	======================================================================
	set echo on;


