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
--drop   table GARLAND.ADRRESULT_VW;
  create table GARLAND.ADRRESULT_VW  (
  ADDR_TYPE                         VARCHAR2(80)
 ,ADDR_SFX                          VARCHAR2(80)
 ,ADDR_CODE1                        VARCHAR2(80)
 ,ADDR_UNIT1                        VARCHAR2(80)
 ,ADDR_CODE2                        VARCHAR2(80)
 ,ADDR_UNIT2                        VARCHAR2(80)
 ,VERIFY_CODE                       VARCHAR2(2)
 ,DO_PARSE                          VARCHAR2(30)
 ,DO_ALIAS                          VARCHAR2(5)
 ,DO_NAME                           VARCHAR2(1)
 ,DO_QUAL                           VARCHAR2(20)
 ,REC_SEQ                           NUMBER(22)
 ,REC_ROWID                         ROWID(10)
 ,REC_KEY                           VARCHAR2(20)
 ,PARCEL_ID                         VARCHAR2(12)
 ,SEGMENT_ID                        VARCHAR2(20)
 ,FORM_TYPE                         VARCHAR2(80)
 ,FORM_SFX                          VARCHAR2(80)
 ,FORM_CODE1                        VARCHAR2(80)
 ,FORM_UNIT1                        VARCHAR2(80)
 ,FORM_CODE2                        VARCHAR2(80)
 ,FORM_UNIT2                        VARCHAR2(80)
 ,APPL_TYPE                         VARCHAR2(80)
 ,APPL_SFX                          VARCHAR2(80)
 ,APPL_CODE1                        VARCHAR2(80)
 ,APPL_UNIT1                        VARCHAR2(80)
 ,APPL_CODE2                        VARCHAR2(80)
 ,APPL_UNIT2                        VARCHAR2(80)
 ,APPL_NUM                          VARCHAR2(20)
  )  tablespace GIS_DATA  nologging
  ;



--drop   table GARLAND.ADRRESULT_USER;
  create table GARLAND.ADRRESULT_USER  (
  REC_KEY                           NUMBER(12,0)  Not Null
 ,REC_ROWID                         VARCHAR2(0)
 ,ADDR_NUM                          VARCHAR2(18)
 ,ADDR_PFX                          VARCHAR2(5)
 ,ADDR_NAME                         VARCHAR2(40)
 ,ADDR_TYPE                         VARCHAR2(6)
 ,ADDR_SFX                          VARCHAR2(5)
 ,ADDR_CODE1                        VARCHAR2(5)
 ,ADDR_UNIT1                        VARCHAR2(18)
 ,ADDR_CODE2                        VARCHAR2(0)
 ,ADDR_UNIT2                        VARCHAR2(0)
  )  tablespace GIS_DATA  nologging
  ;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--drop   table GARLAND.ADRRESULT_INPUT;
  create table GARLAND.ADRRESULT_INPUT  (
  ADDR_NUM                          VARCHAR2(20)
 ,ADDR_PFX                          VARCHAR2(80)
 ,ADDR_NAME                         VARCHAR2(80)
 ,ADDR_TYPE                         VARCHAR2(80)
 ,ADDR_SFX                          VARCHAR2(80)
 ,ADDR_CODE1                        VARCHAR2(80)
 ,ADDR_UNIT1                        VARCHAR2(80)
 ,ADDR_CODE2                        VARCHAR2(80)
 ,ADDR_UNIT2                        VARCHAR2(80)
 ,VERIFY_CODE                       VARCHAR2(2)
 ,DO_PARSE                          VARCHAR2(30)
 ,DO_ALIAS                          VARCHAR2(5)
 ,DO_NAME                           VARCHAR2(1)
 ,DO_QUAL                           VARCHAR2(20)
 ,REC_SEQ                           NUMBER(22)
 ,REC_ROWID                         ROWID(10)
 ,REC_KEY                           VARCHAR2(20)
 ,PARCEL_ID                         VARCHAR2(12)
 ,SEGMENT_ID                        VARCHAR2(20)
 ,FORM_PFX                          VARCHAR2(80)
 ,FORM_NAME                         VARCHAR2(80)
 ,FORM_TYPE                         VARCHAR2(80)
 ,FORM_SFX                          VARCHAR2(80)
 ,FORM_CODE1                        VARCHAR2(80)
 ,FORM_UNIT1                        VARCHAR2(80)
 ,FORM_CODE2                        VARCHAR2(80)
 ,FORM_UNIT2                        VARCHAR2(80)
 ,APPL_PFX                          VARCHAR2(80)
 ,APPL_NAME                         VARCHAR2(80)
 ,APPL_TYPE                         VARCHAR2(80)
 ,APPL_SFX                          VARCHAR2(80)
 ,APPL_CODE1                        VARCHAR2(80)
 ,APPL_UNIT1                        VARCHAR2(80)
 ,APPL_CODE2                        VARCHAR2(80)
 ,APPL_UNIT2                        VARCHAR2(80)
 ,APPL_NUM                          VARCHAR2(20)
 ,ALIAS_SCORE                       NUMBER(22)
 ,NAME_SCORE                        NUMBER(22)
 ,QUAL_SCORE                        NUMBER(22)
  )  tablespace GIS_DATA  nologging
  ;



--drop   table GARLAND.ADRRESULT_ALTER_VW;
  create table GARLAND.ADRRESULT_ALTER_VW  (
  ADDR_NUM                          VARCHAR2(20)
 ,ADDR_PFX                          VARCHAR2(2)
 ,ADDR_NAME                         VARCHAR2(40)
 ,ADDR_TYPE                         VARCHAR2(4)
 ,ADDR_SFX                          VARCHAR2(2)
 ,ADDR_CODE1                        VARCHAR2(0)
 ,ADDR_UNIT1                        VARCHAR2(0)
 ,ADDR_CODE2                        VARCHAR2(0)
 ,ADDR_UNIT2                        VARCHAR2(0)
 ,FORM_PFX                          VARCHAR2(2)
 ,FORM_NAME                         VARCHAR2(30)
 ,FORM_TYPE                         VARCHAR2(4)
 ,FORM_SFX                          VARCHAR2(2)
 ,FORM_CODE1                        VARCHAR2(0)
 ,FORM_UNIT1                        VARCHAR2(0)
 ,FORM_CODE2                        VARCHAR2(0)
 ,FORM_UNIT2                        VARCHAR2(0)
 ,APPL_NUM                          VARCHAR2(0)
 ,APPL_PFX                          VARCHAR2(0)
 ,APPL_NAME                         VARCHAR2(0)
 ,APPL_TYPE                         VARCHAR2(0)
 ,APPL_SFX                          VARCHAR2(0)
 ,APPL_CODE1                        VARCHAR2(0)
 ,APPL_UNIT1                        VARCHAR2(0)
 ,APPL_CODE2                        VARCHAR2(0)
 ,APPL_UNIT2                        VARCHAR2(0)
 ,VERIFY_CODE                       VARCHAR2(0)
 ,DO_PARSE                          VARCHAR2(0)
 ,DO_ALIAS                          VARCHAR2(0)
 ,DO_NAME                           VARCHAR2(0)
 ,DO_QUAL                           VARCHAR2(0)
 ,REC_SEQ                           VARCHAR2(0)
 ,REC_KEY                           VARCHAR2(0)
 ,SPEC_VERIFY                       VARCHAR2(2)
 ,SPEC_PARSE                        VARCHAR2(30)
 ,SPEC_ALIAS                        VARCHAR2(5)
 ,SPEC_NAME                         VARCHAR2(1)
 ,SPEC_QUAL                         VARCHAR2(20)
 ,SPEC_SEQ                          NUMBER(22)
 ,SPEC_KEY                          VARCHAR2(20)
  )  tablespace GIS_DATA  nologging
  ;


--drop   table GARLAND.ADRRESULT_SOURCE;
  create table GARLAND.ADRRESULT_SOURCE  (
  ADDR_NUM                          VARCHAR2(0)
 ,ADDR_PFX                          VARCHAR2(0)
 ,ADDR_NAME                         VARCHAR2(0)
 ,ADDR_TYPE                         VARCHAR2(0)
 ,ADDR_SFX                          VARCHAR2(0)
 ,ADDR_CODE1                        VARCHAR2(0)
 ,ADDR_UNIT1                        VARCHAR2(0)
 ,ADDR_CODE2                        VARCHAR2(0)
 ,ADDR_UNIT2                        VARCHAR2(0)
 ,VERIFY_CODE                       VARCHAR2(0)
 ,DO_PARSE                          VARCHAR2(0)
 ,DO_ALIAS                          VARCHAR2(0)
 ,DO_NAME                           VARCHAR2(0)
 ,DO_QUAL                           VARCHAR2(0)
 ,REC_SEQ                           NUMBER(22)
 ,REC_ROWID                         VARCHAR2(0)
 ,REC_KEY                           NUMBER(12,0)  Not Null
 ,PARCEL_ID                         VARCHAR2(0)
 ,SEGMENT_ID                        VARCHAR2(0)
 ,FORM_PFX                          VARCHAR2(0)
 ,FORM_NAME                         VARCHAR2(0)
 ,FORM_TYPE                         VARCHAR2(0)
 ,FORM_SFX                          VARCHAR2(0)
 ,FORM_CODE1                        VARCHAR2(0)
 ,FORM_UNIT1                        VARCHAR2(0)
 ,FORM_CODE2                        VARCHAR2(0)
 ,FORM_UNIT2                        VARCHAR2(0)
 ,APPL_PFX                          VARCHAR2(5)
 ,APPL_NAME                         VARCHAR2(40)
 ,APPL_TYPE                         VARCHAR2(6)
 ,APPL_SFX                          VARCHAR2(5)
 ,APPL_CODE1                        VARCHAR2(5)
 ,APPL_UNIT1                        VARCHAR2(18)
 ,APPL_CODE2                        VARCHAR2(0)
 ,APPL_UNIT2                        VARCHAR2(0)
 ,APPL_NUM                          VARCHAR2(18)
 ,ALIAS_SCORE                       VARCHAR2(0)
 ,NAME_SCORE                        VARCHAR2(0)
 ,QUAL_SCORE                        VARCHAR2(0)
  )  tablespace GIS_DATA  nologging
  ;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--drop   table GARLAND.ADRALIAS;
  create table GARLAND.ADRALIAS  (
  ALIAS_PFX                         VARCHAR2(10)  Not Null
 ,ALIAS_NAME                        VARCHAR2(80)  Not Null
 ,ALIAS_TYPE                        VARCHAR2(10)  Not Null
 ,ALIAS_SFX                         VARCHAR2(10)  Not Null
 ,ALIAS_LO                          NUMBER(22)  Not Null
 ,ALIAS_HI                          NUMBER(22)
 ,ADDR_MIN                          NUMBER(22)
 ,ADDR_PFX                          VARCHAR2(2)
 ,ADDR_NAME                         VARCHAR2(30)
 ,ADDR_TYPE                         VARCHAR2(4)
 ,ADDR_SFX                          VARCHAR2(2)
 ,ALIAS_HOW                         VARCHAR2(8)
 ,ALIAS_REDUCED                     VARCHAR2(30)
 ,ALIAS_COMPACT                     VARCHAR2(30)
 ,ALIAS_COMPRESS                    VARCHAR2(30)
 ,ALIAS_WEIGHT                      NUMBER(22)
 ,ALIAS_MATCH                       NUMBER(22)
 ,ALIAS_PRIORITY                    NUMBER(22)
  )  tablespace GIS_DATA  nologging
  ;

--drop   table GARLAND.ADRALIEN;
  create table GARLAND.ADRALIEN  (
  ALIAS_PFX                         VARCHAR2(2)  Not Null
 ,ALIAS_NAME                        VARCHAR2(40)  Not Null
 ,ALIAS_TYPE                        VARCHAR2(4)  Not Null
 ,ALIAS_SFX                         VARCHAR2(2)  Not Null
 ,ALIAS_LO                          NUMBER(22)  Not Null
 ,ALIAS_HI                          NUMBER(22)
 ,ADDR_MIN                          NUMBER(22)
 ,ADDR_PFX                          VARCHAR2(2)
 ,ADDR_NAME                         VARCHAR2(20)
 ,ADDR_TYPE                         VARCHAR2(4)
 ,ADDR_SFX                          VARCHAR2(2)
 ,ALIAS_HOW                         VARCHAR2(5)
 ,ALIAS_WEIGHT                      NUMBER(22)
 ,ALIAS_MATCH                       NUMBER(22)
 ,ALIAS_REDUCED                     VARCHAR2(20)
  )  tablespace GIS_DATA  nologging
  ;

--drop   table GARLAND.ADRALTER;
  create table GARLAND.ADRALTER  (
  FLAG1                             VARCHAR2(5)
 ,PFX1                              VARCHAR2(10)
 ,NAME1                             VARCHAR2(40)
 ,TYPE1                             VARCHAR2(10)
 ,SFX1                              VARCHAR2(10)
 ,FLAG2                             VARCHAR2(5)
 ,PFX2                              VARCHAR2(10)
 ,NAME2                             VARCHAR2(40)
 ,TYPE2                             VARCHAR2(10)
 ,SFX2                              VARCHAR2(10)
 ,FLAG3                             VARCHAR2(5)
 ,PFX3                              VARCHAR2(10)
 ,NAME3                             VARCHAR2(40)
 ,TYPE3                             VARCHAR2(10)
 ,SFX3                              VARCHAR2(10)
 ,LO_RANGE                          VARCHAR2(6)
 ,HI_RANGE                          VARCHAR2(6)
 ,NOTES                             VARCHAR2(40)
  )  tablespace GIS_DATA  nologging
  ;


