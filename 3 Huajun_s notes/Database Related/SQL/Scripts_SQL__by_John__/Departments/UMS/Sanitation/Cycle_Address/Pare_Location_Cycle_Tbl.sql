	set echo	off;
	set timing	off;
--	=======================================================
--	For locations with multiple cycle codes,
--	remove all except the smallest cycle code
--	=======================================================

	alter rollback segment rb1	online;
	commit;
	set transaction use rollback segment rb1;

--	truncate table	plan_table;
--	explain plan	set statement_id = 'a'		for

	delete from	garland.gis_objects	
	where	(item01, item02 )		in
(
--	select	count(*)
	select	a.item01, a.item02
	from		garland.gis_objects		a,
(							--	find lowest cycle for dupe locations
	select	item01		location, 
			min(item02)		cycle
	from		garland.gis_objects
	group by	item01
	having	count(item02) > 1
)						b
	where	a.item01 = b.location
	and	a.item02 > b.cycle		--	choose cycles > lowest cycle
);

--	======================================================================
--	select * from explain_plan;
--	select * from explain_analyze;
--	select * from explain_indexed;
--	select * from explain_constraint;
--	select * from explain_table;
--	select * from explain_index;
--	select * from explain_cost;
--	======================================================================

	commit;
	alter rollback segment rb1	offline;

--	=======================================================
	set echo on;


