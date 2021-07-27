
/*

--	=====================================================================

	create table	garland.Common_Rental
(
	parcel_id			varchar2(11),
	rental_district		varchar2(02),
	addr_num			number  (06),
	addr_pfx			varchar2(02),
	addr_name			varchar2(25),
	addr_type			varchar2(04),
	addr_sfx			varchar2(02)
)
	tablespace	gis_data
	nologging
	;


--	=====================================================================

	create index	garland.Common_Rental_Parcel
		on		garland.Common_Rental (parcel_id)
	using index
	tablespace		gis_index
	storage		(initial 128K)
	nologging;

--	=====================================================================


*/

