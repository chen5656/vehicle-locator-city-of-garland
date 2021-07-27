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
--drop   table GARLAND.ADRSTREETS;
  create table GARLAND.ADRSTREETS  (
  ADDR_PFX                          VARCHAR2(2)  Not Null
 ,ADDR_NAME                         VARCHAR2(30)  Not Null
 ,ADDR_TYPE                         VARCHAR2(4)  Not Null
 ,ADDR_SFX                          VARCHAR2(2)  Not Null
 ,STREET_ID                         NUMBER(22,0)
 ,ADDR_COMPRESS                     VARCHAR2(30)
 ,ADDR_COMPACT                      VARCHAR2(30)
 ,ADDR_REDUCED                      VARCHAR2(30)
 ,ADDR_BEGIN                        VARCHAR2(30)
 ,ADDR_ENDING                       VARCHAR2(30)
 ,ADDR_SOUNDEX                      VARCHAR2(20)
 ,ADDR_PERMUTE                      NUMBER(24,0)
  )  tablespace GIS_DATA  nologging
  ;

--drop   table GARLAND.BLOCK;
  create table GARLAND.BLOCK  (
  BLOCK_ID                          NUMBER(22)
 ,ADDR_BLOCK                        NUMBER(22)  Not Null
 ,ADDR_PFX                          VARCHAR2(2)  Not Null
 ,ADDR_NAME                         VARCHAR2(30)  Not Null
 ,ADDR_TYPE                         VARCHAR2(4)  Not Null
 ,ADDR_SFX                          VARCHAR2(2)  Not Null
 ,START_LO                          NUMBER(22)
 ,STOP_LO                           NUMBER(22)
 ,STOP_HI                           NUMBER(22)
 ,COUNTER                           NUMBER(22)
 ,INTERSECT1_ID                     VARCHAR2(20)
 ,INTERSECT2_ID                     VARCHAR2(20)
  )  tablespace GIS_DATA  nologging
  ;

--drop   table GARLAND.CDRELADR;
  create table GARLAND.CDRELADR  (
  PARCEL_ID                         VARCHAR2(11)
 ,ADDR_ID                           NUMBER(8,0)
 ,ADDR_NUM                          NUMBER(6,0)
 ,ADDR_PFX                          VARCHAR2(2)
 ,ADDR_NAME                         VARCHAR2(20)
 ,ADDR_TYPE                         VARCHAR2(4)
 ,ADDR_SFX                          VARCHAR2(2)
 ,ADDR_BLDG                         VARCHAR2(20)
 ,UNIT_TYPE                         VARCHAR2(20)
 ,UNIT_NUM                          VARCHAR2(20)
 ,ZIP_CODE                          NUMBER(5,0)
 ,ZIP_PLUS                          NUMBER(5,0)
 ,ADDR_STATUS                       VARCHAR2(3)
 ,MAP_GRID                          NUMBER(5,0)
 ,UNIT_AUX                          VARCHAR2(20)
 ,MSLINK                            NUMBER(6,0)
 ,MAPID                             NUMBER(4,0)
 ,PRIVATE_STR                       VARCHAR2(3)
 ,X_COORD                           NUMBER(38,8)
 ,Y_COORD                           NUMBER(38,8)
 ,TAX_KEY                           NUMBER(8,0)
 ,UMS_KEY                           NUMBER(8,0)
 ,PARCELID                          NUMBER(8,0)
 ,ADDRESS_LABEL                     VARCHAR2(50)
 ,ADDRESS_TYPE                      VARCHAR2(20)
  )  tablespace GIS_DATA  nologging
  ;

--drop   table GARLAND.INTERSECTION;
  create table GARLAND.INTERSECTION  (
  ADDR1_BLOCK                       NUMBER(8,0)
 ,ADDR1_PFX                         VARCHAR2(2)
 ,ADDR1_NAME                        VARCHAR2(20)
 ,ADDR1_TYPE                        VARCHAR2(4)
 ,ADDR1_SFX                         VARCHAR2(2)
 ,ADDR2_BLOCK                       NUMBER(8,0)
 ,ADDR2_PFX                         VARCHAR2(2)
 ,ADDR2_NAME                        VARCHAR2(20)
 ,ADDR2_TYPE                        VARCHAR2(4)
 ,ADDR2_SFX                         VARCHAR2(2)
 ,CORNER_COMPASS                    VARCHAR2(2)
 ,TWIN_COMPASS                      VARCHAR2(2)
 ,NODE_ID                           VARCHAR2(20)
 ,INTERSECT_ID                      VARCHAR2(20)
 ,TAX_ACCT                          VARCHAR2(17)
 ,SUBDIV_ID                         VARCHAR2(5)
 ,COUNCIL_ID                        VARCHAR2(1)
 ,ZIP_CODE                          VARCHAR2(5)
 ,CODE_INSPECT_AREA                 VARCHAR2(2)
 ,FIRE_DISTRICT                     VARCHAR2(1)
 ,POLICE_BEAT                       NUMBER(3,0)
 ,POLICE_DISTRICT                   VARCHAR2(3)
 ,ANIMAL_CONTROL                    VARCHAR2(1)
 ,X_COORD                           NUMBER(38,8)
 ,Y_COORD                           NUMBER(38,8)
  )  tablespace GIS_DATA  nologging
  ;

--drop   table GARLAND.TRVEHRCL;
  create table GARLAND.TRVEHRCL  (
  MSLINK                            NUMBER(10,0)  Not Null
 ,MAPID                             NUMBER(10,0)
 ,CLINE_ID                          NUMBER(10,0)
 ,BRANCH_NO                         NUMBER(5,0)
 ,SECTION_NO                        NUMBER(5,0)
 ,NUM_LANES                         NUMBER(5,0)
 ,FR_COORD                          NUMBER(22)
 ,TO_COORD                          NUMBER(22)
 ,CLINE_LENGTH                      NUMBER(22)
 ,ST_NAME                           VARCHAR2(40)
 ,COUNCIL_DISTRICT                  NUMBER(5,0)
 ,BOND_PROJ                         VARCHAR2(16)
 ,ADDR_NUM                          NUMBER(22)
 ,ADDR_PFX                          VARCHAR2(2)
 ,ADDR_NAME                         VARCHAR2(35)
 ,ADDR_TYPE                         VARCHAR2(4)
 ,ADDR_SFX                          VARCHAR2(2)
 ,ADDR_LEFT_FROM                    NUMBER(6,0)
 ,ADDR_LEFT_TO                      NUMBER(6,0)
 ,ADDR_RGHT_FROM                    NUMBER(6,0)
 ,ADDR_RGHT_TO                      NUMBER(6,0)
 ,PILOT                             VARCHAR2(1)
 ,SOURCE                            VARCHAR2(1)
 ,NOTCARRIED                        VARCHAR2(1)
 ,ADDR_LO                           NUMBER(10,0)
 ,ADDR_HI                           NUMBER(10,0)
 ,SEGMENT_ID                        NUMBER(4,0)
 ,SPEED_LIMIT                       NUMBER(2,0)
 ,ROW_MAINTAIN                      VARCHAR2(10)
 ,ROW_LOCATION                      VARCHAR2(10)
 ,CITY                              VARCHAR2(15)
 ,REVIEW_FLAG                       VARCHAR2(25)
 ,FIRE_DIST                         NUMBER(2,0)
 ,POL_BEAT                          NUMBER(3,0)
 ,STREETCLASS                       VARCHAR2(10)
 ,LEFTCITY                          VARCHAR2(15)
 ,RIGHTCITY                         VARCHAR2(15)
  )  tablespace GIS_DATA  nologging
  ;


