	set echo off;
--	========================================================================

--	select count(*) from   (


	select parcel_id, addr_num, addr_name, addr_unit1
	from	garland.adrresult_verizon 
	where	addr_unit1 > '0'
	and	parcel_id in
(
	select parcel_id
	from garland.adrresult_verizon
	intersect
	select parcel_id
	from garland.adrresult_verizon_sbc
)

	union

	select parcel_id, addr_num, addr_name, addr_unit1
	from	garland.adrresult_verizon_sbc 
	where	addr_unit1 > '0'
	and	parcel_id in
(
	select parcel_id
	from garland.adrresult_verizon
	intersect
	select parcel_id
	from garland.adrresult_verizon_sbc
)
	order by 1,2


--	)
	;

--	========================================================================
--	all address units


	select parcel_id, addr_num, addr_name, addr_unit1
	from	garland.adrresult_verizon 
	where	addr_unit1 > '0'
	union all
	select parcel_id, addr_num, addr_name, addr_unit1
	from	garland.adrresult_verizon_sbc 
	where	addr_unit1 > '0'
	order by 1,3,2,4;

--	========================================================================


