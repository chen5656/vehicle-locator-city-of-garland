	set echo off;
--	=========================================================================

	create table  garland.Phone_Verizon
(
	PHONE                                   VARCHAR2(10),
	STREETNUM                               VARCHAR2(10),
	STREETPREFIX                            VARCHAR2(2),
	STREETNAME                              VARCHAR2(20),
	STREETTYPE                              VARCHAR2(4),
	STREETSUFFIX                            VARCHAR2(2),
	UNITNUM                                 VARCHAR2(20),
	CITY                                    VARCHAR2(10),
	STATE                                   VARCHAR2(2),
	CUSTOMER                                VARCHAR2(40),
	MAIN                                    VARCHAR2(10),
	PARCEL_ID					    NUMBER(7),
	ZIP_CODE					    NUMBER(5)
)
	tablespace	gis_data
	nologging;

--	=========================================================================

	create index	garland.Phone_Verizon_Phone
		on		garland.Phone_Verizon(Phone)
	tablespace		gis_index
	nologging;

--	=========================================================================

	create index	garland.Phone_Verizon_Parcel
		on		garland.Phone_Verizon(Parcel_ID)
	tablespace		gis_index
	nologging;

--	=========================================================================

