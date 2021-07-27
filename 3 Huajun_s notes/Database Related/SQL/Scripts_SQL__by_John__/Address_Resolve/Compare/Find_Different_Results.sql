	set echo off;
--	======================================================================
--	Obtain all application keys for which Address Resolve (A) 
--	got a different result from another address scrubbing method (B)

--	======================================================================
	truncate table	garland.plan_table;
	explain plan	set statement_id = 'a'	into garland.plan_table		for
--	======================================================================

	select	a.rec_key
	from		garland.adrResult			A,
			garland.adrResult_Input		B
	where		a.rec_key = b.rec_key
	and not (
				a.addr_name	= b.addr_name
			and	a.addr_type	= b.addr_type
			and	a.addr_pfx	= b.addr_pfx
			and	a.addr_sfx	= b.addr_sfx
			and	a.addr_num	= b.addr_num
		  );

--	======================================================================
	select * from garland.explain_plan;
--	select * from garland.explain_analyze;
--	select * from garland.explain_indexed;
--	select * from garland.explain_constraint;
--	select * from garland.explain_table;
--	select * from garland.explain_index;
--	select * from garland.explain_cost;
--	select * from garland.explain_remote;
--	======================================================================
	set echo on;
