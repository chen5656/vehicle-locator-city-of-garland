--	===========================================================================
--	ESRI address extract table
--	===========================================================================

	create table	esri_address
(
		key			number,
		mslink		number,
		parcel_id		varchar2(12),
		region		varchar2(20),
		address		varchar2(80)
)
	tablespace		gis_data
	storage	(	initial 320k  next 320k  pctincrease 0)
	pctfree  1		pctused  99;

--	===========================================================================

	alter table		esri_address
	add constraint	esri_address_pkey
				primary key (key)
	using index
	tablespace		gisindx
	storage	(	initial 320k  next 320k  pctincrease 0);

--	===========================================================================

