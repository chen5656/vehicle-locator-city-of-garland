	set echo off;
--	==========================================================================

	select 'UMS' " ",parcel_id, counter from
(
	select parcel_id, count(*) counter
	from	garland.Temp_View
	group by parcel_id
	having count(*) > 1
)
	order by counter desc, parcel_id;

--	==========================================================================

	select 'UMS' " ", address_id, counter from
(
	select address_id, count(*) counter
	from	garland.Temp_View1
	group by address_id
	having count(*) > 1
);

--	==========================================================================

	select 'GIS' " ", mslink, counter from
(
	select mslink, count(*) counter
	from	garland.cdreladr
	group by mslink
	having count(*) > 1
);

--	==========================================================================

	select 'GIS' " ", parcel_id, counter from
(
	select parcel_id, count(*) counter
	from	garland.cdrelpar
	group by parcel_id
	having count(*) > 1
);

--	==========================================================================
