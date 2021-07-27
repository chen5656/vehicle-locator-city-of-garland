--	=====================================================================
set echo		off;
set linesize	2000;
set pagesize	9999;
set sqlblanklines	on;
set timing		off;
set serveroutput	on	size 99999;
--	=====================================================================

--	DESTROYED / WASTED / LIQUIDATED

--drop   table GARLAND.BASIC_UMS;
  create table GARLAND.BASIC_UMS  (
  LOCATION_NO                       NUMBER(8,0)
 ,ACCOUNT_NO                        NUMBER(8,0)
 ,SERVICE_SEQ                       NUMBER(4,0)
 ,PERSON_NO                         NUMBER(8,0)
 ,EFFECTIVE_DATE                    DATE
 ,LAST_NAME                         VARCHAR2(40)
 ,FIRST_NAME                        VARCHAR2(20)
 ,BIRTH_DATE                        DATE
 ,DRIVERS_LICENSE                   VARCHAR2(20)
 ,SSN                               VARCHAR2(10)
 ,SEX                               VARCHAR2(5)
 ,ADDR_NUM                          VARCHAR2(10)
 ,ADDR_PFX                          VARCHAR2(40)
 ,ADDR_NAME                         VARCHAR2(40)
 ,ADDR_TYPE                         VARCHAR2(40)
 ,ADDR_SFX                          VARCHAR2(40)
 ,ADDR_BLDG                         VARCHAR2(40)
 ,ADDR_UNIT                         VARCHAR2(40)
 ,LAST_BILL_DATE                    DATE
 ,ADDRESS_ID                        NUMBER(8,0)
  )  tablespace GIS_DATA  nologging
  ;


