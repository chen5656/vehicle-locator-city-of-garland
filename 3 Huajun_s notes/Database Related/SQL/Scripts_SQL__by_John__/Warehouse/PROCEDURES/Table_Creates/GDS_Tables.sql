--	=====================================================================
set echo		off;
set linesize	2000;
set pagesize	9999;
set sqlblanklines	on;
set timing		off;
set serveroutput	on	size 99999;
--  alter session set nls_date_format = 'yyyy-mm-dd hh24:mi:ss';  
--	=====================================================================

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--drop   table GARLAND.GDS_ACCOUNT;
  create table GARLAND.GDS_ACCOUNT  (
  ACCOUNT                           VARCHAR2(100)
 ,PIDN                              VARCHAR2(100)
 ,ADDR_NUM                          VARCHAR2(100)
 ,ADDR_NAME                         VARCHAR2(100)
 ,OWNER_NAME                        VARCHAR2(100)
 ,OWNER_ADDR1                       VARCHAR2(100)
 ,OWNER_ADDR2                       VARCHAR2(100)
 ,OWNER_ADDR3                       VARCHAR2(100)
 ,OWNER_ADDR4                       VARCHAR2(100)
 ,OWNER_ZIP                         VARCHAR2(100)
 ,LEGAL1                            VARCHAR2(100)
 ,LEGAL2                            VARCHAR2(100)
 ,LEGAL3                            VARCHAR2(100)
 ,LEGAL4                            VARCHAR2(100)
 ,MORTGAGE_CO                       VARCHAR2(100)
 ,ACCT_TYPE                         VARCHAR2(100)
 ,ACCT_USE                          VARCHAR2(100)
  )  tablespace GIS_DATA  nologging
  ;

--drop   table GARLAND.GDS_ACCOUNT_EXTERNAL;
  create table GARLAND.GDS_ACCOUNT_EXTERNAL  (
  ACCOUNT                           VARCHAR2(40)
 ,PIDN                              VARCHAR2(40)
 ,STATUS_ACCT                       VARCHAR2(40)
 ,STATUS_INF                        VARCHAR2(40)
 ,STATUS_MAIL                       VARCHAR2(40)
 ,OWNER_NAME                        VARCHAR2(40)
 ,OWNER_ADDR1                       VARCHAR2(40)
 ,OWNER_ADDR2                       VARCHAR2(40)
 ,OWNER_ADDR3                       VARCHAR2(40)
 ,OWNER_ADDR4                       VARCHAR2(40)
 ,OWNER_ZIP                         VARCHAR2(40)
 ,MORTGAGE_CO                       VARCHAR2(40)
 ,ADDR_NUM                          VARCHAR2(40)
 ,ADDR_NAME                         VARCHAR2(40)
 ,ACRES                             VARCHAR2(40)
 ,LEGAL1                            VARCHAR2(40)
 ,LEGAL2                            VARCHAR2(40)
 ,LEGAL3                            VARCHAR2(40)
 ,LEGAL4                            VARCHAR2(40)
 ,ACCT_TYPE                         VARCHAR2(40)
 ,ACCT_USE                          VARCHAR2(40)
  )  tablespace GIS_DATA  nologging
  ;

--drop   table GARLAND.GDS_CROSSREF;
  create table GARLAND.GDS_CROSSREF  (
  GDS_ACCT                          VARCHAR2(10)
 ,COG_ACCT                          VARCHAR2(10)
 ,DCAD_ACCT                         VARCHAR2(20)
  )  tablespace GIS_DATA  nologging
  ;

--drop   table GARLAND.GDS_EXEMPTION;
  create table GARLAND.GDS_EXEMPTION  (
  ACCOUNT                           VARCHAR2(10)
 ,TAX_YEAR                          NUMBER(4,0)
 ,TAX_ENTITY                        VARCHAR2(4)
 ,EXEMPT_CODE                       VARCHAR2(2)
  )  tablespace GIS_DATA  nologging
  ;

--drop   table GARLAND.GDS_EXEMPTION_EXTERNAL;
  create table GARLAND.GDS_EXEMPTION_EXTERNAL  (
  ACCOUNT                           VARCHAR2(40)
 ,YEAR                              VARCHAR2(40)
 ,ENTITY                            VARCHAR2(40)
 ,EXEMPTION                         VARCHAR2(40)
  )  tablespace GIS_DATA  nologging
  ;

--drop   table GARLAND.GDS_VALUE;
  create table GARLAND.GDS_VALUE  (
  ACCOUNT                           VARCHAR2(10)
 ,YEAR                              VARCHAR2(4)
  )  tablespace GIS_DATA  nologging
  ;

--drop   table GARLAND.GDS_YEAR;
  create table GARLAND.GDS_YEAR  (
  ACCOUNT                           VARCHAR2(10)
 ,YEAR                              VARCHAR2(4)
 ,ACCT_TYPE                         VARCHAR2(1)
  )  tablespace GIS_DATA  nologging
  ;

--drop   table GARLAND.GDS_YEAR_EXTERNAL;
  create table GARLAND.GDS_YEAR_EXTERNAL  (
  ACCOUNT                           VARCHAR2(40)
 ,YEAR                              VARCHAR2(40)
 ,DUMMY1                            VARCHAR2(40)
 ,DUMMY2                            VARCHAR2(40)
 ,ACCT_TYPE                         VARCHAR2(40)
  )  tablespace GIS_DATA  nologging
  ;


