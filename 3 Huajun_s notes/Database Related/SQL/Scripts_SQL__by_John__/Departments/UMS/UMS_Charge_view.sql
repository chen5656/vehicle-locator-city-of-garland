	set echo	off;

--	==============================================================================

	create or replace view		garland.ums_charge
	(	
		parcel_id, 
		service_type, 
		bill_year, 
		consumption,
		asset
	)
	as	select 
		item01, item02, item03,	item04, item05

	from	garland.gis_temp1;
--	from	garland.gis_objects;

--	==============================================================================

	select count(*)	from garland.ums_charge;

	select 
		rtrim(rpad(parcel_id,	12	))	parcel, 
		rtrim(rpad(service_type,05	))	serv_type, 
		rtrim(rpad(bill_year,	10	))	bill_year,
		rtrim(lpad(consumption, 06,'0'))	consumption, 
		rtrim(rpad(asset,		05	))	asset
	from	garland.ums_charge
	where	rownum < 1111;

--	==============================================================================

	set echo	on;
