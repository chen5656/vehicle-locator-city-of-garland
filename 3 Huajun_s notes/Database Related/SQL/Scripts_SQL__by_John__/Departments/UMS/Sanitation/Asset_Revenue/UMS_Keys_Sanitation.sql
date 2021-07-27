

	create or replace view	garland.ums_keys_sanitation		
(
	location_no,
	account_no,
	service_seq,
	person_no,
	service_type,
	parcel_id,
	asset_no,
	asset_size,
	asset_share,
	many_acct_locns,
	many_locn_accts,
	many_locn_servs
)

	as	
	select	item01, item02, item03, item04, item05, item06, item07, item08, item09,
			item10, item11, item12
	from		gis_temp4;


