
--	how many orphan parcel ids are in addressed table

	select all *	from CDRELADR
--	select count(*)	from CDRELADR
	where	 parcel_id	in
(
	select parcel_id	from CDRELADR	where parcel_id > '0'	and addr_status <> 'd'
	minus
	select parcel_id	from cdrelpar	where parcel_id > '0'
)
	order by addr_name, addr_num;;


--	does any parcel_id map to multiple geocode values

	select	parcel_id, count(*)
	from		cdrelpar
	group by	parcel_id
	having	count (distinct ( ZIP_CODE )) > 1;


--	how many unpopulated cdrelpar rows correspond to existing cdreladr rows

--		select count(*)	from cdrelpar	where parcel_id	in


--	which cdreladr rows correspond to unpopulated cdrelpar rows

		select p.mslink, p.parcel_id, addr_num, addr_pfx, addr_name, addr_type, 	a.zip_code		
		from	cdreladr 	a,
			cdrelpar	p
		where	a.parcel_id = p.parcel_id
		and	p.parcel_id		in


--	which unpopulated cdrelpar that match cdreladr also match arcview extract
 	
--		select parcel_id	from tmp_parcel_region
--		intersect

--	filter for unpopulated cdrelpar that match existing cdreladr

	(
		select parcel_id	from cdrelpar	where zip_code is null
		intersect
		select parcel_id	from cdreladr
	);
