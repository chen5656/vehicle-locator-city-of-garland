
	drop table		cdreladr_audit;

	create table	cdreladr_audit	
(
	person			varchar2(08),
	action			varchar2(01),
	timestamp			date,

	parcel_bef			varchar2(12),
	parcel_aft			varchar2(12),
	num_bef			number,
	num_aft			number,
	pfx_bef			varchar2(02),
	pfx_aft			varchar2(02),
	name_bef			varchar2(20),
	name_aft			varchar2(20),
	type_bef			varchar2(04),
	type_aft			varchar2(04),
	sfx_bef			varchar2(02),
	sfx_aft			varchar2(02)
)
	tablespace	gis_data
	storage	(initial 1m   next 320k  pctincrease 0);

