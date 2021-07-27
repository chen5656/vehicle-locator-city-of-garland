	set echo 		off;
	set stoponerror	on;
--	=================================================================================
--	truncate table	garland.plan_table		reuse storage;
--	explain plan	set statement_id = 'beat'	into garland.plan_table	for

	update garland.CDRELPAR		P
	set	code_inspect_area = 
(
	select	distinct district
	from		garland.Code_District
	where		parcel_id = garland.convert_old_parcelid (p.parcel_id)
)
	where		translate (p.parcel_id, '/.0123456789', '/') is null;

--	select * from garland.explain_Plan;

--	=================================================================================

	select count(district)			"code_dist"	from garland.Code_District;

	select count(code_inspect_area) 	"cdrelpar"	from garland.cdrelpar;

	select distinct code_inspect_area	"cdrelpar"
	from garland.cdrelpar 
	order by lpad(code_inspect_area,2,'0');

	select parcel_id, count(*) districts
	from	garland.code_district
	group by	parcel_id
	having count(distinct district) > 1;

--	=================================================================================

--	Rollback;
	Commit;

--	=================================================================================
	set echo on;

