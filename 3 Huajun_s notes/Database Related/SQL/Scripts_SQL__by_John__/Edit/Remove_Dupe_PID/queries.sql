
--	which addresses will be affected by the absence of council districts on CDRELPAR

	select addr_num, addr_pfx, addr_name, addr_type, addr_sfx, parcel_id
	from 	cdreladr		a
	where parcel_id in
(
	select parcel_id
	from cdrelpar
	where council_id is null

	minus

	select parcel_id
	from	cdrelpar
	where	council_id is not null
)
	order by addr_name, addr_type, addr_pfx, addr_sfx, addr_num;

