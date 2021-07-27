	set echo	off;
--	===========================================================================
	truncate table	garland.plan_table	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	explain plan set statement_id = 'xxx'	into garland.plan_table	for
--	===========================================================================

--	select count (distinct address_id) from

	delete	from garland.common_ums
	where		(address_id, rowid)	in
(
	select u.address_id, row_id
	from	common_ums		u,
(	
	select address_id, min(rowid) row_id
	from  garland.common_ums 
	group by address_id 
	having count(*) > 1
)					v
	where	u.address_id	= v.address_id
	and	u.rowid		> v.row_id
);

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;

	commit;
	alter rollback segment rb1 offline;
--	===========================================================================
	set echo	on;
