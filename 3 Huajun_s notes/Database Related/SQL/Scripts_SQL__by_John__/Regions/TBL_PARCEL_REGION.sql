
--	create table to receive parcel region id from arcview
--	use to update cdrelpar 

--	council districts updated apr 2000

--	===============================================================

	drop 	table		tmp_parcel_region;

	create table	tmp_parcel_region
	(
		parcel_id		varchar2(11),
		region_id		varchar2(20)
	)
	storage	( initial 2m   next 2m  pctincrease 0 );

--	===============================================================

	create index	tmp_parcel_region_x_pid
		on		tmp_parcel_region	(parcel_id)
	storage	( initial 2m   next 2m  pctincrease 0 );

--	===============================================================

	comment on table tmp_parcel_region	is 'contains region id for each parcel id, source is arcview';	

--	===============================================================
