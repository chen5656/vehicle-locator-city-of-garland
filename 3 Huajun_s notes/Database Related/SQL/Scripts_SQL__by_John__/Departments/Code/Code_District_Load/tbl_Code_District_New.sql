	set echo off;
--	===============================================================
--
--	===============================================================

	drop table		garland.Code_District_New;

	create table	garland.Code_District_New
(
		parcel_id			number(07,0),

		nuisance_district		number(02,0),
		nuisance_inspector	varchar2(20),
		nuisance_phone		varchar2(15),

		rental_district		number(02,0),
		rental_inspector		varchar2(20),
		rental_phone		varchar2(15),

		is_rental			number(01,0),

		council_id			number(01,0),
		police_beat			number(03,0),
		zip_code			number(05,0)

)
	tablespace	gis_data
	pctfree	10
	nologging;

--	===============================================================

	create index garland.Code_District_new_Parcel
		on	 garland.Code_District_new(Parcel_ID)

	tablespace	gis_index
	storage	(initial 1m)
	nologging;

--	===============================================================
	set echo on;
