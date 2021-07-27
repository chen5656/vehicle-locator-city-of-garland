	set echo 		off;
	set fetchrows;
	set stoponerror	on;
--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into garland.plan_table	for
--	=================================================================================

	update garland.VERIZON		V
	set	 zip_code =
(
	select min(a.zip_code) 
	from	garland.cdreladr		A
	where	a.parcel_id = v.parcel_id || '.000'
	and	rtrim(a.unit_num) is null
	group by a.parcel_id
);

	select zip_code from garland.verizon where zip_code is not null and rownum < 22;

	Commit;

--	=================================================================================
--	select * from garland.explain_Plan;
--	insert into   garland.plan_table (object_owner, object_name) values ('GARLAND', '');
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Table;
--	select * from garland.explain_Index;
--	select * from garland.explain_Constraint;
--	select * from garland.explain_Column;
--	select * from garland.explain_Dependent;
--	select * from garland.explain_Analyze;
--	=================================================================================
/*
	select addressid, zipcode, count(*) 
	from
(
	select v.parcel_id||'.000', 
		 min(a.zipcode) zipcode
	from	gis.address		A,
		garland.cdreladr	B,
		garland.cdrelpar	P
		,garland.verizon	V
	where	a.addressid		= b.mslink
	and	b.parcel_id		= p.parcel_id 
	and	b.parcel_id		= v.parcel_id || '.000'
	and	rtrim(a.unit) is null
	group by a.addressid 
--	group by a.addressid, b.parcel_id, v.parcel_id||'.000'
)
	group by addressid, zipcode
	having count(*) > 1;
*/
--	=================================================================================
	set fetchrows;



