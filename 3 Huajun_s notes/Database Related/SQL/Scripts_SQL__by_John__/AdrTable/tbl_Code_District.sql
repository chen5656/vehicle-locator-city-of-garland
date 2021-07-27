	set echo off;
--	===============================================================
--	===============================================================

	create table	garland.Code_District
(
		parcel_id		number(07),
		district		varchar2(02),
		inspector		varchar2(20),
		phone			varchar2(15),
		council_id		varchar2(01),
		police_beat		number(03)
)
	tablespace	gis_data
--	storage	(initial 2m)
	pctfree	5
	nologging;

--	===============================================================

	create index garland.Code_District_Parcel
		on	 garland.Code_District(Parcel_ID)

	tablespace	gis_index
	storage	(initial 1m)
	nologging;

--	===============================================================
	set echo on;
