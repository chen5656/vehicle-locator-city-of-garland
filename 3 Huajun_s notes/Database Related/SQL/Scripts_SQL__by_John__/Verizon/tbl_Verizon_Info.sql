	set echo off;
--	=========================================================================

	create table  garland.Verizon_Info
(
	PHONE                                   VARCHAR2(10)
	STREETNUM                               VARCHAR2(10)
	STREETPREFIX                            VARCHAR2(2)
	STREETNAME                              VARCHAR2(20)
	STREETTYPE                              VARCHAR2(4)
	STREETSUFFIX                            VARCHAR2(2)
	UNITNUM                                 VARCHAR2(20)
	CITY                                    VARCHAR2(10)
	STATE                                   VARCHAR2(2)
	CUSTOMER                                VARCHAR2(40)
	MAIN                                    VARCHAR2(10),
	PARCEL_ID					    NUMBER(7),
	ZIP_CODE					    NUMBER(5)
)
	tablespace	gis_data
	nologging;

--	=========================================================================

	create index	garland.Verizon_Info_Phone
		on		garland.Verizon_info(Phone)
	tablespace		gis_index
	nologging;

--	=========================================================================

