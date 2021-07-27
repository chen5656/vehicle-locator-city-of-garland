
	create table garland.WMS_ADDRESS
(
	Address_ID		number(10,0),
	SubAddress_ID	number(10,0),
	Parcel_ID		number(10,0),
	CustServ_ID		number(10,0),

	streetnum		number(10,0),
	streetprefix	varchar2(02),
	streetname		varchar2(30),
	streettype		varchar2(04),
	streetsuffix	varchar2(02),
	unitnum		varchar2(10),

	water_zone		varchar2(4),	-- E or W
	water_basin		varchar2(10)	-- DUCK CREEK or ROWLETT.
)

	tablespace		gis_data
	pctfree		5
	nologging
	;
