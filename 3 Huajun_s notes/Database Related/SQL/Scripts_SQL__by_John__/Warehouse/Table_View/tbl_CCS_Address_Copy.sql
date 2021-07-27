	set echo off;
--	===========================================================

	drop   table  garland.CCS_ADDRESS_COPY;

	create table  garland.CCS_ADDRESS_COPY
(
	ADDRESS_ID                              NUMBER(8,0),
	ADDR_BLOCK                              NUMBER(8,0),
	ADDR_NUMBER                             NUMBER(8,0),
	ADDR_PREFIX                             VARCHAR2(2),
	ADDR_NAME                               VARCHAR2(30),
	ADDR_TYPE                               VARCHAR2(4),
	ADDR_SUFFIX                             VARCHAR2(2),
	ADDR_BLDG                               VARCHAR2(20),
	ADDR_UNIT                               VARCHAR2(20),
	ADDR_CITY                               VARCHAR2(15),
	ADDR_ZIP                                VARCHAR2(5),
	ADDR_TEN_CODE                           VARCHAR2(4),
	COUNCIL_DIST                            VARCHAR2(1),
	INSPECTOR_DIST                          VARCHAR2(2),
	POLICE_BEAT                             NUMBER(3,0),
	TAX_ACCOUNT                             VARCHAR2(25),
	TAX_DCAD                                VARCHAR2(25),
	TAX_PROP_TYPE                           VARCHAR2(1),
	TAX_ZONING_CODE                         VARCHAR2(10),
	TAX_EXEMPTION                           VARCHAR2(12),
	TAX_DEED_CHNG_DATE                      VARCHAR2(10),
	TAX_OWNER                               VARCHAR2(100),
	TAX_ADDR1                               VARCHAR2(50),
	TAX_ADDR2                               VARCHAR2(50),
	TAX_CITY                                VARCHAR2(30),
	TAX_STATE                               VARCHAR2(2),
	TAX_ZIP                                 VARCHAR2(5),
	TAX_TEN_CODE                            VARCHAR2(4),
	TAX_OCCUPIED                            VARCHAR2(1),
	TAX_LEGAL_DESC                          VARCHAR2(200),
	UMS_LAST_NAME                           VARCHAR2(40),
	UMS_FIRST_NAME                          VARCHAR2(40),
	UMS_DRIVERS_LIC                         VARCHAR2(20),
	UMS_BIRTH_DATE                          VARCHAR2(10),
	INTERSECTION1                           VARCHAR2(40),
	INTERSECTION2                           VARCHAR2(40),
	PARCEL_ID                               VARCHAR2(11),
	STREET_ID                               VARCHAR2(06),
	BLOCK_ID                                NUMBER(8,0),
	ROAD_ID                                 NUMBER(8,0),
	INTERSECT_ID1                           VARCHAR2(20),
	INTERSECT_ID2                           VARCHAR2(20),
	TAX_ID                                  VARCHAR2(25),
	UMS_ID                                  NUMBER(8,0),
	RECORD_SEQ                              VARCHAR2(20),
	PARCEL_ID_NEW				    NUMBER(10,0),
	CDBG						    NUMBER(04,0)	
)

	Tablespace	GIS_Data
	Nologging
	PctFree	5
	;
	
--	===========================================================
