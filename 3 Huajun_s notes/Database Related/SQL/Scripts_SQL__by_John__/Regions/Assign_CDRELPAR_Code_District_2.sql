	set echo off;
--	=================================================================================
	truncate table	garland.plan_table	reuse storage;
	explain plan	set statement_id = 'beat'	into garland.plan_table	for
--	=================================================================================

	update garland.CDRELPAR		P

	set	code_inspect_area = 
(
	select	distinct item02
	from		garland.gis_objects
	where		item01 = p.parcel_id
	and		item02 > '0'
)

	where exists
(
	select	'x'
	from		garland.gis_objects
	where		item01 = p.parcel_id
);

--	=================================================================================
	select * from garland.explain_Plan;
--	=================================================================================
	set echo on;
