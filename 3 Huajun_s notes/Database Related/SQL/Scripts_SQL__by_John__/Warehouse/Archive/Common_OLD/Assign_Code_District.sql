	set echo 		off;
	set linesize	2000;
--	=================================================================================
--	Assign Code Inspector Districts to CCS_ADDRESS
--	Assign Nuisance or Rental district according to IS_RENTAL field
--	Join on Parcel ID
--	=================================================================================

--	truncate table	garland.plan_table	reuse storage;
--	=================================================================================
--	explain plan	set statement_id = '111'	into garland.plan_table	for

	update garland.ccs_address	C
	set	inspector_dist =
(
	select min(decode(is_rental, 1,rental_district, nuisance_district))
	from	garland.code_district
	where	parcel_id = to_number(rpad(c.parcel_id,7))
)
	where	translate(rpad(c.parcel_id,7),'/1234567890', '/') is null;

--	=================================================================================
--	explain plan	set statement_id = '222'	into garland.plan_table	for

	select count(*) not_rental
	from	garland.ccs_address		C,
		garland.code_district		D

	where	translate(rpad(c.parcel_id,7),'/1234567890', '/') is null
	and	d.parcel_id		= to_number(rpad(c.parcel_id,7))
	and	d.rental_district	= c.inspector_dist
	and	d.is_rental = 0; 

--	=================================================================================

	select distinct(inspector_dist) 	from garland.CCS_addresses;
	select distinct (rental_district) 	from garland.code_district;
	select distinct (nuisance_district) from garland.code_district;

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

--	desc garland.ccs_address;
--	desc all_dependencies;
--	select * from all_dependencies where name = 'CCS_ADDRESSES'
--	=================================================================================

--	ROLLBACK;

	COMMIT;

--	=================================================================================

