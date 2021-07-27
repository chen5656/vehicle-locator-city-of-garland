	set echo	off;
	
--	===================================================================================
--	how many parcel regions are still null
--	===================================================================================

	select	a.addr_num, a.addr_pfx, a.addr_name, a.addr_type, a.addr_sfx,  
			a.parcel_id, v.region_id 
--	select 	count(*) 

	from	 tmp_view2		v,
		 cdreladr		a
	where	v.region_id is null
	and	v.parcel_id = a.parcel_id

/*
	and	a.parcel_id in
	(
	select parcel_id
	from 	 cdrelpar
	group by parcel_id
	having count(*) > 1
	)
*/

	order by 3,4,2,5,1;

	set echo	on;
