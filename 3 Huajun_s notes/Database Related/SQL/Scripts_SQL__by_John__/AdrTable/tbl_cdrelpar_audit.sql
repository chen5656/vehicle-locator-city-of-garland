
	drop table		cdrelpar_audit;

	create table	cdrelpar_audit	
(
	person			varchar2(08),
	action			varchar2(01),
	timestamp			date,
	mslink_bef			number,
	mslink_aft			number,
	parcel_bef			varchar2(12),
	parcel_aft			varchar2(12)
)
	tablespace	gis_data
	storage	( initial 1m   next 320k  pctincrease 0);


