	set echo off;

	select	addr_num, addr_pfx, addr_name, addr_type, addr_sfx, parcel_id, mslink
			,unit_type	,unit_num
	from		cdreladr

	where	(	addr_num, addr_pfx, addr_name, addr_type, addr_sfx, parcel_id )
	in	
(
	select	addr_num, addr_pfx, addr_name, addr_type, addr_sfx, parcel_id
	from		cdreladr
	group by	addr_num, addr_pfx, addr_name, addr_type, addr_sfx, parcel_id
	having	count(*) > 1
)
	order	by	addr_name, addr_type, addr_pfx, addr_sfx, addr_num, parcel_id;

	set echo on;
