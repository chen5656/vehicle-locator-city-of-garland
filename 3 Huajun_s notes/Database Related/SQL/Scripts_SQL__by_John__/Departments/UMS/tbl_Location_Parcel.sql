--	=======================================================================================
--	UMS reference table that links UMS locations to a parcel id
--	=======================================================================================

	drop table		ums_location_parcel;

	create table	ums_location_parcel
	(
		location_no		number,
		parcel_id		varchar2(12),

		constraint		ums_location_parcel_pkey
		primary key		(location_no)
	)
		organization index
		tablespace	 gisindx
		storage	( initial 1m  next 1m  pctincrease 0 );


--	=======================================================================================


