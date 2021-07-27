
--	drop table		sani_commercial;

	create table	sani_commercial
(
	rec_key		number,
	addr_num		varchar2(05),
	addr_pfx		varchar2(02),
	addr_name		varchar2(30),
	addr_type		varchar2(04),
	addr_sfx		varchar2(02),
	busi_name		varchar2(40),
	busi_type		varchar2(40),
	parcel_id		varchar2(11)
)
	tablespace		gis_data
	storage		( initial 320k  next 320k  pctincrease 0);