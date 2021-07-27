	set echo off;
--	=======================================================
--	set UMS_Keys switches to indicate one-many joins
--	=======================================================

--	=======================================================
/*	----	already done by previous job	----
	update	garland.ums_keys
	set		many_acct_locns = 0,
			many_locn_accts = 0,
			many_locn_servs = 0;
*/
--	=======================================================

--	truncate table	garland.plan_table;
--	insert into 	garland.plan_table (object_name, object_owner) values ( '', '');

--	=======================================================

	alter rollback segment rb1	online;
	commit;
	set transaction use rollback segment rb1;

--	=======================================================
--	explain plan	set statement_id = 'acct locns'	into garland.plan_table		for

	update	garland.ums_keys
	set		many_acct_locns = 1
	where		account_no		in
(	
	select	account_no
	from		garland.ums_keys
	group by	account_no
	having	count(distinct location_no) > 1
);

--	=======================================================
--	explain plan	set statement_id = 'locn accts'	into garland.plan_table		for

	update	garland.ums_keys
	set		many_locn_accts = 1
	where		location_no		in
(	
	select	location_no
	from		garland.ums_keys
	group by	location_no
	having	count(distinct account_no) > 1
);

--	=======================================================
--	explain plan	set statement_id = 'locn servs'	into garland.plan_table		for

	update	garland.ums_keys
	set		many_locn_servs = 1
	where		location_no		in
(	
	select	location_no
	from		garland.ums_keys
	group by	location_no
	having	count(distinct service_seq) > 1
);

--	======================================================================

	commit;
	alter rollback segment rb1	offline;

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

