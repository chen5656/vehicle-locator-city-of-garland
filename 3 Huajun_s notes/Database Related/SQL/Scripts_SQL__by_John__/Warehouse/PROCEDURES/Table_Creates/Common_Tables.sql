--	=====================================================================
set echo		off;
set linesize	2000;
set pagesize	9999;
set sqlblanklines	on;
set timing		off;
set serveroutput	on	size 99999;
--  alter session set nls_date_format = 'yyyy-mm-dd hh24:mi:ss';  
--	=====================================================================

--drop   table GARLAND.COMMON_ADDRESS_IDS;
  create table GARLAND.COMMON_ADDRESS_IDS  (
  ADDR_NAME                         VARCHAR2(1000)
 ,ADDR_NUM                          VARCHAR2(2000)
 ,ADDR_TYPE                         VARCHAR2(2000)
 ,ADDR_PFX                          VARCHAR2(2000)
 ,ADDR_SFX                          VARCHAR2(2000)
 ,ADDR_CODE                         VARCHAR2(2000)
 ,ADDR_BLDG                         VARCHAR2(2000)
 ,ADDR_UNIT                         VARCHAR2(2000)
 ,GIS_KEY                           VARCHAR2(2000)
 ,TAX_KEY                           VARCHAR2(2000)
 ,UMS_KEY                           VARCHAR2(2000)
 ,UNIT_KEY                          VARCHAR2(2000)
 ,GIS_ID                            VARCHAR2(2000)
 ,PARCEL_ID                         VARCHAR2(2000)
 ,SOURCE                            VARCHAR2(2000)
  )  tablespace GIS_DATA  nologging
  ;

--drop   table GARLAND.COMMON_ADDRESS_KEYS;
  create table GARLAND.COMMON_ADDRESS_KEYS  (
  ADDR_NUM                          NUMBER(8,0)
 ,ADDR_PFX                          VARCHAR2(2)
 ,ADDR_NAME                         VARCHAR2(30)
 ,ADDR_TYPE                         VARCHAR2(4)
 ,ADDR_SFX                          VARCHAR2(2)
 ,SOURCE                            VARCHAR2(5)
 ,PARCEL_ID                         VARCHAR2(11)
 ,SEQUENCE                          NUMBER(8,0)
 ,GIS_KEY                           NUMBER(8,0)
 ,TAX_KEY                           NUMBER(8,0)
 ,UMS_KEY                           NUMBER(8,0)
  )  tablespace GIS_DATA  nologging
  ;

--drop   table GARLAND.COMMON_ADDRESS_REFS;
  create table GARLAND.COMMON_ADDRESS_REFS  (
  ADDR_NAME                         VARCHAR2(1000)
 ,ADDR_NUM                          VARCHAR2(2000)
 ,ADDR_TYPE                         VARCHAR2(2000)
 ,ADDR_PFX                          VARCHAR2(2000)
 ,ADDR_SFX                          VARCHAR2(2000)
 ,ADDR_BLDG                         VARCHAR2(2000)
 ,ADDR_UNIT                         VARCHAR2(2000)
 ,REF_KEY                           VARCHAR2(2000)
  )  tablespace GIS_DATA  nologging
  ;

--drop   table GARLAND.COMMON_ARCHIVE_KEYS;
  create table GARLAND.COMMON_ARCHIVE_KEYS  (
  ADDR_NAME                         VARCHAR2(1000)
 ,ADDR_NUM                          VARCHAR2(2000)
 ,ADDR_TYPE                         VARCHAR2(2000)
 ,ADDR_PFX                          VARCHAR2(2000)
 ,ADDR_SFX                          VARCHAR2(2000)
 ,ADDR_CODE                         VARCHAR2(2000)
 ,ADDR_BLDG                         VARCHAR2(2000)
 ,ADDR_UNIT                         VARCHAR2(2000)
 ,GIS_KEY                           VARCHAR2(2000)
 ,TAX_KEY                           VARCHAR2(2000)
 ,UMS_KEY                           VARCHAR2(2000)
 ,UNIT_KEY                          VARCHAR2(2000)
 ,GIS_ID                            VARCHAR2(2000)
 ,PARCEL_ID                         VARCHAR2(2000)
 ,SOURCE                            VARCHAR2(2000)
 ,TIMESTAMP                         VARCHAR2(2000)
  )  tablespace GIS_DATA  nologging
  ;

--drop   table GARLAND.COMMON_GIS;
  create table GARLAND.COMMON_GIS  (
  ADDR_NUM                          NUMBER(22)
 ,ADDR_PFX                          VARCHAR2(2)
 ,ADDR_NAME                         VARCHAR2(20)
 ,ADDR_TYPE                         VARCHAR2(4)
 ,ADDR_SFX                          VARCHAR2(2)
 ,ADDR_BLDG                         VARCHAR2(20)
 ,ADDR_UNIT                         VARCHAR2(20)
 ,ADDRESS_ID                        NUMBER(22)
 ,PARCEL_ID                         VARCHAR2(11)
 ,BLOCK_ID                          NUMBER(22)
 ,ROAD_ID                           NUMBER(22)
 ,INTERSECT_ID1                     VARCHAR2(20)
 ,INTERSECT_ID2                     VARCHAR2(20)
 ,PARENT_ID                         NUMBER(22)
 ,INTERSECTON1                      VARCHAR2(40)
 ,INTERSECTON2                      VARCHAR2(40)
 ,ADDRESS_TYPE                      VARCHAR2(20)
  )  tablespace GIS_DATA  nologging
  ;

--drop   table GARLAND.COMMON_RECORD_SEQ;
  create table GARLAND.COMMON_RECORD_SEQ  (
  GIS_KEY                           NUMBER(8,0)
 ,TAX_KEY                           NUMBER(8,0)
 ,UMS_KEY                           NUMBER(8,0)
 ,SEQUENCE                          NUMBER(8,0)
  )  tablespace GIS_DATA  nologging
  ;

--drop   table GARLAND.COMMON_REF;
  create table GARLAND.COMMON_REF  (
  ADDRESS_ID                        NUMBER(22)
 ,TAX_ID                            VARCHAR2(40)
 ,UMS_ID                            VARCHAR2(40)
  )  tablespace GIS_DATA  nologging
  ;

--drop   table GARLAND.COMMON_TAX;
  create table GARLAND.COMMON_TAX  (
  TAX_ADDRESS_ID                    NUMBER(22)
 ,TAX_ACCOUNT                       VARCHAR2(25)
 ,TAX_DCAD                          VARCHAR2(25)
 ,TAX_ADDR_NUM                      NUMBER(22)
 ,TAX_ADDR_PFX                      VARCHAR2(2)
 ,TAX_ADDR_NAME                     VARCHAR2(20)
 ,TAX_ADDR_TYPE                     VARCHAR2(4)
 ,TAX_ADDR_SFX                      VARCHAR2(2)
 ,TAX_ADDR_BLDG                     VARCHAR2(10)
 ,TAX_ADDR_UNIT                     VARCHAR2(20)
 ,TAX_ADDR_ZIP                      VARCHAR2(10)
 ,TAX_OWNER                         VARCHAR2(40)
 ,TAX_ADDR1                         VARCHAR2(40)
 ,TAX_ADDR2                         VARCHAR2(50)
 ,TAX_CITY                          VARCHAR2(30)
 ,TAX_STATE                         VARCHAR2(2)
 ,TAX_ZIP                           VARCHAR2(10)
 ,TAX_PROP_TYPE                     VARCHAR2(1)
 ,TAX_ZONING_CODE                   VARCHAR2(10)
 ,TAX_EXEMPT                        VARCHAR2(20)
 ,TAX_COLLECT_MORTGAGE              VARCHAR2(3)
 ,TAX_COLLECT_AGENT                 VARCHAR2(3)
 ,TAX_COLLECT_LENDER                VARCHAR2(5)
 ,TAX_DEED_CHNG_DATE                VARCHAR2(10)
 ,LEGAL_DESC                        VARCHAR2(200)
 ,OCCUPIED                          VARCHAR2(1)
 ,PARENT_ID                         NUMBER(22)
  )  tablespace GIS_DATA  nologging
  ;

--drop   table GARLAND.COMMON_UMS;
  create table GARLAND.COMMON_UMS  (
  ADDRESS_ID                        NUMBER(22)
 ,ADDR_NUM                          NUMBER(22)
 ,ADDR_PFX                          VARCHAR2(2)
 ,ADDR_NAME                         VARCHAR2(30)
 ,ADDR_TYPE                         VARCHAR2(4)
 ,ADDR_SFX                          VARCHAR2(2)
 ,ADDR_BLDG                         VARCHAR2(10)
 ,ADDR_UNIT                         VARCHAR2(20)
 ,LOCATION_NO                       NUMBER(22)
 ,ACCOUNT_NO                        NUMBER(22)
 ,PERSON_NO                         NUMBER(22)
 ,LAST_NAME                         VARCHAR2(40)
 ,FIRST_NAME                        VARCHAR2(40)
 ,DRIVERS_LICENSE                   VARCHAR2(20)
 ,BIRTH_DATE                        VARCHAR2(10)
 ,PARENT_ID                         NUMBER(22)
  )  tablespace GIS_DATA  nologging
  ;


