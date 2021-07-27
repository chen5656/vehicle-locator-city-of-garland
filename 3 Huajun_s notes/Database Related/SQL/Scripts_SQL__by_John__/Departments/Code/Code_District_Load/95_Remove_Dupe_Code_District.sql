	set echo 		off;
	set stoponerror	on;
--	=================================================================================
	truncate table	garland.plan_table	reuse storage;
--	=================================================================================

/*
--	=================================================================================
--	how many duplicate Code District records
--	=================================================================================

	select sum(count(*))			--4106
	from	garland.code_district
	group by	parcel_id
	having count(*) > 1;

--	=================================================================================
--	how many Distinct duplicate Code District records
--	=================================================================================

	select distinct *		from
(
	select *
	from	garland.code_district
	where	parcel_id	in
(
	select parcel_id
	from	garland.code_district
	group by	parcel_id
	having count(*) > 1
));

--	=================================================================================
--	how many distinct Parcel IDs in duplicate Code District records
--	=================================================================================

	select count(distinct parcel_id)
	from
(
	select parcel_id
	from	garland.code_district
	group by	parcel_id
	having count(*) > 1
);

*/

--	=================================================================================
--	Remove duplicate Code District records
--	=================================================================================
--	explain plan	set statement_id = ' '	into garland.plan_table	for
--	=================================================================================

	delete from garland.Code_District	C			-- 3277

	where	c.parcel_id		in
(
	select parcel_id
	from	garland.Code_District
	group by	parcel_id
	having	count(*) > 1
)

	and exists
(
	select 'x'
	from	
(
	select parcel_id, 
		 max(rowid)		max_rowid
	from	 garland.Code_District
	group by	parcel_id
	having	count(*) > 1
)
	where	c.parcel_id		= parcel_id
	and	c.rowid 		< max_rowid
);

--	=================================================================================
--	insert into garland.plan_table (object_owner, object_name) values ('GARLAND', '');

--	select * from garland.explain_Plan;
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;

--	Rollback;
	Commit;

--	Comment on table	garland.	is '' ;

--	=================================================================================
	set echo on;
