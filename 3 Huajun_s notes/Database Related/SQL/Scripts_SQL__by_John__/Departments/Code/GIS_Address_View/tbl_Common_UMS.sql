	set echo	off;
--	========================================================================

--	drop   table	garland.Common_UMS;

	Create table	garland.Common_UMS
(
	address_id		number,

	location_no		number,
	account_no		number,
	person_no		number,

	last_name		varchar2(40),
	first_name		varchar2(40),
	drivers_license	varchar2(20),
	birth_date		date
)

	tablespace		gis_data
	storage		(initial 1M  next 1M  pctincrease 0)
	nologging;

--	========================================================================

	create index	garland.Common_UMS_AID
		on		garland.Common_UMS (address_id)
	tablespace		gisindx
	storage		(initial 100k  next 100k pctincrease 0)
	nologging;

--	========================================================================
/*
	create index	garland.Common_UMS_Location
		on		garland.Common_UMS (location_no)
	using index
	tablespace		gisindx
	storage		(initial 100k  next 100k pctincrease 0)
	nologging;
*/
--	========================================================================
	set echo	on;

