
--	drop table		garland.ums_detail;

	create table	garland.ums_detail
(
	location_no		number,
	account_no		number,
	service_seq		number,

	service_type	varchar2(5),
	bill_date		date,

	cons_amt		number(19,6),
	detail_amt		number(15,2),

	parcel_id		varchar2(12),
	asset_no		number,
	asset			varchar2(10)
)

	nologging
	tablespace		gis_data
	pctfree		04	
	pctused		95
	storage		(initial 60m  next 10m  pctincrease 0);
