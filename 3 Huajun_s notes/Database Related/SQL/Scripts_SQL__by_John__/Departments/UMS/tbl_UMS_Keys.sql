
	drop table		garland.ums_keys;

	create table	garland.ums_keys
(
	location_no		number,
	account_no		number,
	service_seq		number,
	person_no		number,
	service_type	varchar2(5),

--				switches = 0,1
	many_acct_locns	number,
	many_locn_accts	number,
	many_locn_servs	number,

	parcel_id		varchar2(12),

	constraint		ums_keys_pkey
	primary key		(location_no, account_no, service_seq)
)

	organization	index
	tablespace		gisindx
	nologging
	storage		(initial 2m  next 1m  pctincrease 0)
	;
