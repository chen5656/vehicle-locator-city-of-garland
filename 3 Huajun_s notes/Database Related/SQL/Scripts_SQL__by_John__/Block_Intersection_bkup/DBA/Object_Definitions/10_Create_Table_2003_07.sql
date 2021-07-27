
 
select 'CREATE ADDRVRFY' " " from dual;
create table   GARLAND.ADDRVRFY
(
 ADDRESS_NAME                  VARCHAR2 (40) not null
,ADDRESS_TYPE                  VARCHAR2 (4)
,ADDRESS_PREFIX                VARCHAR2 (2)
,ADDRESS_NUMBER                NUMBER   (8) not null
,ADDRESS_SUFFIX                VARCHAR2 (2)
,ADDRESS_SUPPL#                VARCHAR2 (6)
,ADDRESS_SULLP_TYPE            VARCHAR2 (6)
,ZIP_CODE                      VARCHAR2 (5)
,TEN_CODE                      VARCHAR2 (4)
,COUNCIL_DISTRICT              VARCHAR2 (1)
,POLICE_BEAT                   VARCHAR2 (3)
,OWNER_NAME                    VARCHAR2 (34)
,OWNER_MAILING_ADDR            VARCHAR2 (34)
,OWNER_CITY_ST_ZIP             VARCHAR2 (26)
,COG_TAX_ID                    VARCHAR2 (13) not null
,LOT                           VARCHAR2 (3)
,BLOCK                         VARCHAR2 (3)
,LEGAL_DESCRIPTION             VARCHAR2 (118)
,OCCUPANT_NAME                 VARCHAR2 (25)
,OCCUPANT_SEX                  VARCHAR2 (1)
,OCCUPANT_DL#                  VARCHAR2 (13)
,OCCUPANT_SSN                  VARCHAR2 (11)
,OCCUPANT_DOB                  DATE      not null
,CITY_SWITCH                   VARCHAR2 (1)
,SEQUENCE                      NUMBER   (8) not null
,INSPECTOR                     VARCHAR2 (3)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 32M next 4M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE ADRALIEN' " " from dual;
create table   GARLAND.ADRALIEN
(
 ALIAS_PFX                     VARCHAR2 (2) not null
,ALIAS_NAME                    VARCHAR2 (40) not null
,ALIAS_TYPE                    VARCHAR2 (4) not null
,ALIAS_SFX                     VARCHAR2 (2) not null
,ALIAS_LO                      NUMBER   (22) not null
,ALIAS_HI                      NUMBER   (22)
,ADDR_MIN                      NUMBER   (22)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (20)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
,ALIAS_HOW                     VARCHAR2 (5)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 2M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE ADRALTER' " " from dual;
create table   GARLAND.ADRALTER
(
 FLAG1                         VARCHAR2 (5)
,PFX1                          VARCHAR2 (10)
,NAME1                         VARCHAR2 (40)
,TYPE1                         VARCHAR2 (10)
,SFX1                          VARCHAR2 (10)
,FLAG2                         VARCHAR2 (5)
,PFX2                          VARCHAR2 (10)
,NAME2                         VARCHAR2 (40)
,TYPE2                         VARCHAR2 (10)
,SFX2                          VARCHAR2 (10)
,FLAG3                         VARCHAR2 (5)
,PFX3                          VARCHAR2 (10)
,NAME3                         VARCHAR2 (40)
,TYPE3                         VARCHAR2 (10)
,SFX3                          VARCHAR2 (10)
,LO_RANGE                      VARCHAR2 (6)
,HI_RANGE                      VARCHAR2 (6)
,NOTES                         VARCHAR2 (40)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE ADRENDING' " " from dual;
create table   GARLAND.ADRENDING
(
 NAME                          VARCHAR2 (10)
,NAME_TAIL                     VARCHAR2 (3)
)
tablespace GIS_DATA   pctfree 1  pctused 99
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE ADRGAP' " " from dual;
create table   GARLAND.ADRGAP
(
 ADDR_NUM                      NUMBER   (6)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (20)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 2M next 1M pctincrease 0
           minextents 1  maxextents 121
           freelists  1  freelist groups 1)
;

 
select 'CREATE ADRITEM' " " from dual;
create table   GARLAND.ADRITEM
(
 CLASS                         VARCHAR2 (1)
,POSSIBLE                      VARCHAR2 (10)
,STANDARD                      VARCHAR2 (5)
,NAME                          VARCHAR2 (20)
)
tablespace GIS_DATA   pctfree 1  pctused 99
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE ADRNAME' " " from dual;
create table   GARLAND.ADRNAME
(
 ADDR_NAME                     VARCHAR2 (20) not null
,ADDR_COMPRESS                 VARCHAR2 (20)
,ADDR_COMPACT                  VARCHAR2 (20)
,ADDR_REDUCED                  VARCHAR2 (20)
,ADDR_ENDING                   VARCHAR2 (20)
,ADDR_SOUNDEX                  VARCHAR2 (4)
,ADDR_PERMUTE                  NUMBER   (22)
,DATE_CREATED                  DATE     
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE ADRPERMUTE' " " from dual;
create table   GARLAND.ADRPERMUTE
(
 ADDR_NUM                      NUMBER   (6)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (20)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
,ADDR_PERMUTE                  NUMBER   (22)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 4M next 1M pctincrease 0
           minextents 1  maxextents 121
           freelists  1  freelist groups 1)
;

 
select 'CREATE ADRRESULT_CODEADDR' " " from dual;
create table   GARLAND.ADRRESULT_CODEADDR
(
 ADDR_NUM                      NUMBER   (22)
,ADDR_PFX                      VARCHAR2 (10)
,ADDR_NAME                     VARCHAR2 (40)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (10)
,ADDR_CODE                     VARCHAR2 (10)
,ADDR_UNIT                     VARCHAR2 (10)
,VERIFY_CODE                   NUMBER   (2)
,DO_PARSE                      VARCHAR2 (6)
,DO_ALIAS                      VARCHAR2 (10)
,DO_NAME                       VARCHAR2 (1)
,DO_QUAL                       VARCHAR2 (30)
,PARCEL_ID                     VARCHAR2 (12)
,SEGMENT_ID                    NUMBER   (22)
,OLD_PFX                       VARCHAR2 (2)
,OLD_NAME                      VARCHAR2 (40)
,OLD_TYPE                      VARCHAR2 (4)
,OLD_SFX                       VARCHAR2 (2)
,OLD_UNIT                      VARCHAR2 (5)
,REC_KEY                       VARCHAR2 (256)
,REC_SEQ                       NUMBER   (22)
,REC_ROWID                     ROWID    
,OLD_CODE                      VARCHAR2 (5)
,APP_PFX                       VARCHAR2 (10)
,APP_NAME                      VARCHAR2 (80)
,APP_TYPE                      VARCHAR2 (10)
,APP_SFX                       VARCHAR2 (10)
,APP_CODE                      VARCHAR2 (10)
,APP_UNIT                      VARCHAR2 (10)
,REGION_ID                     VARCHAR2 (5)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 4M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE ADRSTREET' " " from dual;
create table   GARLAND.ADRSTREET
(
 ADDR_PFX                      VARCHAR2 (2) not null
,ADDR_NAME                     VARCHAR2 (30) not null
,ADDR_TYPE                     VARCHAR2 (4) not null
,ADDR_SFX                      VARCHAR2 (2) not null
,STREET_ID                     NUMBER   (8)
,ADDR_COMPRESS                 VARCHAR2 (30)
,ADDR_COMPACT                  VARCHAR2 (30)
,ADDR_REDUCED                  VARCHAR2 (30)
,ADDR_BEGIN                    VARCHAR2 (30)
,ADDR_ENDING                   VARCHAR2 (30)
,ADDR_SOUNDEX                  VARCHAR2 (20)
,ADDR_PERMUTE                  NUMBER   (22)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE ADRSTREETS' " " from dual;
create table   GARLAND.ADRSTREETS
(
 ADDR_PFX                      VARCHAR2 (2) not null
,ADDR_NAME                     VARCHAR2 (30) not null
,ADDR_TYPE                     VARCHAR2 (4) not null
,ADDR_SFX                      VARCHAR2 (2) not null
,STREET_ID                     NUMBER   (8)
,ADDR_COMPRESS                 VARCHAR2 (30)
,ADDR_COMPACT                  VARCHAR2 (30)
,ADDR_REDUCED                  VARCHAR2 (30)
,ADDR_BEGIN                    VARCHAR2 (30)
,ADDR_ENDING                   VARCHAR2 (30)
,ADDR_SOUNDEX                  VARCHAR2 (20)
,ADDR_PERMUTE                  NUMBER   (22)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE ANIMAL_CONTROL_LOG' " " from dual;
create table   GARLAND.ANIMAL_CONTROL_LOG
(
 REC_KEY                       NUMBER   (22)
,ADDR_NUM                      NUMBER   (22)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (80)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
,ADDR_UNIT                     VARCHAR2 (10)
,PARCEL_ID                     VARCHAR2 (11)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE ATTRIBUTE_CATALOG' " " from dual;
create table   GARLAND.ATTRIBUTE_CATALOG
(
 TABLENAME                     VARCHAR2 (18) not null
,COLUMNNAME                    VARCHAR2 (18) not null
,DISPLAYFORMAT                 VARCHAR2 (16)
,IS_REQUIRED                   NUMBER   (5)
,IS_UNIQUE                     NUMBER   (5)
,DEFAULTUNIT                   VARCHAR2 (15)
,DEFAULTVALUE                  VARCHAR2 (240)
,COLUMNDOMAIN                  NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE BDJURBEAT' " " from dual;
create table   GARLAND.BDJURBEAT
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,BEAT_NUM                      NUMBER   (5)
,SECTOR_NUM                    NUMBER   (5)
,DIST_NUM                      NUMBER   (5)
,BEAT_AREA                     FLOAT    (21)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE BDJURCODEDIST' " " from dual;
create table   GARLAND.BDJURCODEDIST
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,DIST_CODE                     VARCHAR2 (2)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE BDJURDST' " " from dual;
create table   GARLAND.BDJURDST
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,DISTRICT_ID                   NUMBER   (5)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE BDJURPOLDIST' " " from dual;
create table   GARLAND.BDJURPOLDIST
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,DIST_NUM                      NUMBER   (5)
,SECTOR_NUM                    NUMBER   (5)
,DIST_AREA                     FLOAT    (21)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE BDJURSECTOR' " " from dual;
create table   GARLAND.BDJURSECTOR
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,SECTOR_NUM                    NUMBER   (5)
,SECTOR_AREA                   FLOAT    (21)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE BUILDING' " " from dual;
create table   GARLAND.BUILDING
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,BLDG_NAME                     VARCHAR2 (30)
,BLDG_TYPE                     VARCHAR2 (12)
,ADDRESS                       VARCHAR2 (30)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE CATEGORY' " " from dual;
create table   GARLAND.CATEGORY
(
 MSLINK                        NUMBER   (10) not null
,CNAME                         VARCHAR2 (32)
,INDEXNAME                     VARCHAR2 (64)
,INDEXLEVEL                    NUMBER   (5)
,INDEXTYPE                     VARCHAR2 (8)
,CNAME_TSSDS                   VARCHAR2 (32)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE CDBG' " " from dual;
create table   GARLAND.CDBG
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,ID                            NUMBER   (5)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE CDBGPAR' " " from dual;
create table   GARLAND.CDBGPAR
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,PARCEL_ID                     VARCHAR2 (12)
,AREA_SIZE                     NUMBER   (22)
,AREA_U_D                      VARCHAR2 (16)
,PERIMETER                     NUMBER   (22)
,PERIM_U_D                     VARCHAR2 (16)
,X_COORD                       NUMBER   (22)
,Y_COORD                       NUMBER   (22)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE CDBG_INSPECTION' " " from dual;
create table   GARLAND.CDBG_INSPECTION
(
 TAX_ID                        VARCHAR2 (15)
,NO_OF_CASES                   NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE CDRELADR' " " from dual;
create table   GARLAND.CDRELADR
(
 PARCEL_ID                     VARCHAR2 (20) not null
,ADDR_ID                       NUMBER   (10)
,ADDR_NUM                      NUMBER   (10)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (20)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
,ADDR_BLDG                     VARCHAR2 (20)
,UNIT_TYPE                     VARCHAR2 (20)
,UNIT_NUM                      VARCHAR2 (20)
,ZIP_CODE                      NUMBER   (10)
,ZIP_PLUS                      NUMBER   (5)
,ADDR_STATUS                   VARCHAR2 (3)
,MAP_GRID                      NUMBER   (5)
,UNIT_AUX                      VARCHAR2 (20)
,MSLINK                        NUMBER   (10)
,MAPID                         NUMBER   (10)
,PRIVATE_STR                   VARCHAR2 (3)
,X_COORD                       NUMBER   (22)
,Y_COORD                       NUMBER   (22)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 7M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE CHAINED_ROWS' " " from dual;
create table   GARLAND.CHAINED_ROWS
(
 OWNER_NAME                    VARCHAR2 (30)
,TABLE_NAME                    VARCHAR2 (30)
,CLUSTER_NAME                  VARCHAR2 (30)
,PARTITION_NAME                VARCHAR2 (30)
,HEAD_ROWID                    ROWID    
,ANALYZE_TIMESTAMP             DATE     
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 2M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE CODE_INSPECTOR' " " from dual;
create table   GARLAND.CODE_INSPECTOR
(
 INSPECT_AREA                  VARCHAR2 (2)
,INSPECTOR                     VARCHAR2 (20)
,INSPECTOR_ID                  VARCHAR2 (3)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE COM_IMPERVIOUS' " " from dual;
create table   GARLAND.COM_IMPERVIOUS
(
 PARCEL_ID                     VARCHAR2 (20)
,ACCOUNT                       NUMBER   (10)
,ACCT_USE                      NUMBER   (10)
,ST_NUMBER                     VARCHAR2 (14)
,ST_PREFIX                     VARCHAR2 (8)
,ST_NAME                       VARCHAR2 (25)
,ST_TYPE                       VARCHAR2 (8)
,ZIPCODE                       VARCHAR2 (14)
,CUSTOMER                      VARCHAR2 (32)
,MULTI_ADDR                    VARCHAR2 (6)
,PARCEL_AREA                   NUMBER   (10)
,TTL_IMPERVIOUS                NUMBER   (10)
,PCT_IMPERVIOUS                NUMBER   (10)
,IND_IMPERVIOUS                NUMBER   (10)
,START_DATE                    VARCHAR2 (12)
,FEE                           NUMBER   (10)
,MSLINK                        NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE DCAD_TAX_UB' " " from dual;
create table   GARLAND.DCAD_TAX_UB
(
 SUBDIV                        VARCHAR2 (30)
,OWNER                         VARCHAR2 (40)
,DCAD_ACCT                     VARCHAR2 (17)
,TAX_ADDR                      VARCHAR2 (40)
,TAX_CITY                      VARCHAR2 (20)
,TAX_ST                        VARCHAR2 (2)
,TAX_ZIP                       VARCHAR2 (10)
,ADDR_NUM                      NUMBER   (5)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (20)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
,PROP_ZIP                      VARCHAR2 (10)
,BILL_AMT                      NUMBER   (8)
,BILL_ASSESS                   NUMBER   (8)
,OCCUPANT                      VARCHAR2 (40)
,DL                            VARCHAR2 (13)
,SSN                           VARCHAR2 (11)
,PARCEL_ID                     VARCHAR2 (11)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 16M next 2M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE DOMAIN_CATALOG' " " from dual;
create table   GARLAND.DOMAIN_CATALOG
(
 MSLINK                        NUMBER   (10) not null
,DOMAINNAME                    VARCHAR2 (32)
,DOMAINTYPE                    NUMBER   (5) not null
,TABLENAME                     VARCHAR2 (18) not null
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE D_ADDR_BASIS' " " from dual;
create table   GARLAND.D_ADDR_BASIS
(
 LDOMAIN                       NUMBER   (10) not null
,DOMAINVALUE                   VARCHAR2 (20)
,DOMAINDESC                    VARCHAR2 (32)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE D_ADDR_PFX_SFX' " " from dual;
create table   GARLAND.D_ADDR_PFX_SFX
(
 LDOMAIN                       NUMBER   (10) not null
,DOMAINVALUE                   VARCHAR2 (8)
,DOMAINDESC                    VARCHAR2 (32)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE D_ADDR_STATUS' " " from dual;
create table   GARLAND.D_ADDR_STATUS
(
 LDOMAIN                       NUMBER   (10) not null
,DOMAINVALUE                   VARCHAR2 (8)
,DOMAINDESC                    VARCHAR2 (32)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE D_ADDR_TYPE' " " from dual;
create table   GARLAND.D_ADDR_TYPE
(
 LDOMAIN                       NUMBER   (10) not null
,DOMAINVALUE                   VARCHAR2 (8)
,DOMAINDESC                    VARCHAR2 (32)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE D_ZIPCODE' " " from dual;
create table   GARLAND.D_ZIPCODE
(
 LDOMAIN                       NUMBER   (10) not null
,DOMAINVALUE                   VARCHAR2 (8)
,DOMAINDESC                    VARCHAR2 (32)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE ESZ_FIRE' " " from dual;
create table   GARLAND.ESZ_FIRE
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,ESZ_NUMBER                    NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE FEATURE' " " from dual;
create table   GARLAND.FEATURE
(
 MSLINK                        NUMBER   (10) not null
,FCODE                         VARCHAR2 (12) not null
,FNAME                         VARCHAR2 (32)
,CATEGORY                      NUMBER   (10)
,TABLENAME                     VARCHAR2 (18)
,FTYPE                         NUMBER   (5)
,FLEVEL                        NUMBER   (5)
,FSTYLE                        NUMBER   (5)
,FWEIGHT                       NUMBER   (5)
,FCOLOR                        NUMBER   (5)
,DIGCMD                        VARCHAR2 (240)
,FELEMENT                      NUMBER   (5)
,FANGLE                        VARCHAR2 (16)
,FHEIGHT                       NUMBER   (22)
,FWIDTH                        NUMBER   (22)
,FLINESPACE                    NUMBER   (22)
,TEXTUNIT                      VARCHAR2 (15)
,LINELENGTH                    NUMBER   (5)
,FFONT                         NUMBER   (5)
,FSYMBOL                       VARCHAR2 (1)
,FJUSTIFICATION                VARCHAR2 (3)
,CELLLIBRARY                   VARCHAR2 (64)
,FCELLNAME                     VARCHAR2 (6)
,CELLSCALE                     NUMBER   (22)
,STREAMDELTA                   NUMBER   (22)
,STREAMTOLERANCE               NUMBER   (22)
,STREAMUNIT                    VARCHAR2 (15)
,SNAPTYPE                      NUMBER   (5)
,SNAPTOLERANCE                 NUMBER   (5)
,NEWDUP                        NUMBER   (5)
,FDASTYPE                      NUMBER   (5)
,COMP_FEATURE_ID               NUMBER   (10)
,USE_RANGE                     VARCHAR2 (1)
,IS_OPTIONAL                   VARCHAR2 (1)
,IS_REPEATING                  VARCHAR2 (1)
,MIN_DISPLAYSCALE              NUMBER   (10)
,MAX_DISPLAYSCALE              NUMBER   (10)
,DISPLAYPRIORITY               NUMBER   (5)
,TSSDS_FNAME                   VARCHAR2 (32)
,GARLAND_INUSE                 VARCHAR2 (1)
,GARLAND_NEW                   VARCHAR2 (1)
,GARLAND_DATASOURCE            VARCHAR2 (32)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE GARLAND_WORK_MASTER' " " from dual;
create table   GARLAND.GARLAND_WORK_MASTER
(
 SFG_NUMBER                    NUMBER   (5)
,COST                          NUMBER   (10)
,SFG_NAME                      VARCHAR2 (20)
,SFG_UNITS                     VARCHAR2 (4)
,SFG_TIME                      VARCHAR2 (40)
,CATEGORY                      VARCHAR2 (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE GIS_ABSTACT' " " from dual;
create table   GARLAND.GIS_ABSTACT
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,ABSTRACT_NO                   NUMBER   (10)
,ABSTRACT_NAME                 VARCHAR2 (20)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE GIS_COUNCIL_DIST' " " from dual;
create table   GARLAND.GIS_COUNCIL_DIST
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,DIST_NUM                      VARCHAR2 (2)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE GIS_FIRE_DIST' " " from dual;
create table   GARLAND.GIS_FIRE_DIST
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,DISTRICT_NUM                  VARCHAR2 (4)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE GIS_ZIP_CODE' " " from dual;
create table   GARLAND.GIS_ZIP_CODE
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,ZIP_CODE                      VARCHAR2 (5)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE GPLSRVA' " " from dual;
create table   GARLAND.GPLSRVA
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,OWNER                         VARCHAR2 (10)
,PARCEL_ID                     NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE IDX' " " from dual;
create table   GARLAND.IDX
(
 TABLE_NAME                    VARCHAR2 (30) not null
,TABLESPACE_NAME               VARCHAR2 (30) not null
,INDEX_NAME                    VARCHAR2 (30) not null
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE INSPECTION_MASTER' " " from dual;
create table   GARLAND.INSPECTION_MASTER
(
 CLASS_NAME                    VARCHAR2 (10) not null
,CLASS_MIN                     NUMBER   (3)
,CLASS_MAX                     NUMBER   (3)
,CLASS_DIVISOR                 NUMBER   (1)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE INSP_ARCH' " " from dual;
create table   GARLAND.INSP_ARCH
(
 CATEGORY                      VARCHAR2 (1)
,BRANCH                        NUMBER   (4)
,SECTION                       NUMBER   (4)
,SEGMENT                       NUMBER   (4)
,LENG                          NUMBER   (5)
,LANES                         NUMBER   (2,1)
,SURF_TYPE                     VARCHAR2 (3)
,REAR_ENTRY                    VARCHAR2 (1)
,CDBG                          VARCHAR2 (1)
,CONST_DATE                    DATE     
,LAST_INSPECT_DATE             DATE     
,NEXT_INSPECT_DATE             DATE     
,PCI                           NUMBER   (5,2)
,CLASS                         VARCHAR2 (10)
,CRACK_SEAL                    VARCHAR2 (1)
,DISTRESSES                    NUMBER   (4)
,POT_HOLE_REQ                  VARCHAR2 (1)
,COUN_DIST                     NUMBER   (2)
,THOR_TYPE                     VARCHAR2 (2)
,ADDR_NUM                      NUMBER   (6)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (40)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
,FROM_ADDR_NUM                 NUMBER   (6)
,FROM_ADDR_PFX                 VARCHAR2 (2)
,FROM_ADDR_NAME                VARCHAR2 (40)
,FROM_ADDR_TYPE                VARCHAR2 (4)
,FROM_ADDR_SFX                 VARCHAR2 (2)
,TO_ADDR_NUM                   NUMBER   (6)
,TO_ADDR_PFX                   VARCHAR2 (2)
,TO_ADDR_NAME                  VARCHAR2 (40)
,TO_ADDR_TYPE                  VARCHAR2 (4)
,TO_ADDR_SFX                   VARCHAR2 (2)
,REMARKS                       VARCHAR2 (40)
,TIME_STAMP                    DATE     
,THOR_TYPE_NEW                 VARCHAR2 (2)
,MISSING_SDWK                  VARCHAR2 (1)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 5M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE JOIN_CATALOG' " " from dual;
create table   GARLAND.JOIN_CATALOG
(
 JOINID                        NUMBER   (10) not null
,TABLE1                        VARCHAR2 (18) not null
,TABLE2                        VARCHAR2 (18) not null
,RELATIONSHIP                  VARCHAR2 (240) not null
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE LABEL' " " from dual;
create table   GARLAND.LABEL
(
 LABEL                         NUMBER   (10) not null
,CONTENTSTMT                   VARCHAR2 (240)
,X_OFFSET                      NUMBER   (22)
,Y_OFFSET                      NUMBER   (22)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE LIBRARY_PATRON' " " from dual;
create table   GARLAND.LIBRARY_PATRON
(
 PATRON_KEY                    VARCHAR2 (6)
,ADDR_NUM                      NUMBER   (22)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (40)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
,ADDR_CODE                     VARCHAR2 (4)
,ADDR_UNIT                     VARCHAR2 (6)
,VERIFY_CODE                   VARCHAR2 (1)
,CENSUS_BLOK                   VARCHAR2 (6)
,PARCEL_ID                     VARCHAR2 (11)
,SEGMENT_ID                    VARCHAR2 (4)
,DATE_ADD                      DATE     
,DATE_MODIFY                   DATE     
,DATE_SCRUB                    DATE     
,CITY                          VARCHAR2 (10)
,ZIP                           VARCHAR2 (5)
,PATRON_ID                     VARCHAR2 (5)
)
tablespace GIS_DATA   pctfree 40  pctused 59
           initrans 1 maxtrans 255
storage   (initial 6M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE LIST_DOMAIN' " " from dual;
create table   GARLAND.LIST_DOMAIN
(
 LDOMAIN                       NUMBER   (10) not null
,DOMAINVALUE                   VARCHAR2 (8) not null
,DOMAINDESC                    VARCHAR2 (32)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE MAPBOOK2' " " from dual;
create table   GARLAND.MAPBOOK2
(
 MSLINK                        NUMBER   (10) not null
,GRID_ID                       VARCHAR2 (3)
,ST_NAME                       VARCHAR2 (40)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE MAPCOADDRESS' " " from dual;
create table   GARLAND.MAPCOADDRESS
(
 MSLINK                        NUMBER   (10) not null
,GRID_ID                       VARCHAR2 (3)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (20)
,ADDR_SFX                      VARCHAR2 (2)
,ADDR_TYPE                     VARCHAR2 (4)
,ODDLO                         NUMBER   (10)
,ODDHI                         NUMBER   (10)
,EVENLO                        NUMBER   (10)
,EVENHI                        NUMBER   (10)
,MID_NO                        NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE MAPCOGRID' " " from dual;
create table   GARLAND.MAPCOGRID
(
 MSLINK                        NUMBER   (10) not null
,GRDBK_GRID_ID                 VARCHAR2 (3)
,TRVEH_ST_NAME                 VARCHAR2 (40)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE MAPCOPAGE' " " from dual;
create table   GARLAND.MAPCOPAGE
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,GRID_ID                       VARCHAR2 (3)
,PAGE_NO                       NUMBER   (5)
,GRID_LETTER                   VARCHAR2 (1)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE MAPS' " " from dual;
create table   GARLAND.MAPS
(
 MSLINK                        NUMBER   (10) not null
,MAPNAME                       VARCHAR2 (64)
,CATEGORY                      NUMBER   (10)
,XHIGH                         NUMBER   (10)
,YHIGH                         NUMBER   (10)
,XLOW                          NUMBER   (10)
,YLOW                          NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE MLOG$_TST_JOHN' " " from dual;
create table   GARLAND.MLOG$_TST_JOHN
(
 M_ROW$$                       VARCHAR2 (18)
,SNAPTIME$$                    DATE     
,DMLTYPE$$                     VARCHAR2 (1)
,OLD_NEW$$                     VARCHAR2 (1)
,CHANGE_VECTOR$$               RAW      (255)
)
tablespace GIS_DATA   pctfree 60  pctused 30
           initrans 1 maxtrans 255
storage   (initial 2M next 1M pctincrease 0
           minextents 1  maxextents 121
           freelists  1  freelist groups 1)
;

 
select 'CREATE MSCATALOG' " " from dual;
create table   GARLAND.MSCATALOG
(
 TABLENAME                     VARCHAR2 (32) not null
,ENTITYNUM                     NUMBER   (10) not null
,NEXTOCC                       NUMBER   (10)
,SCREENFORM                    VARCHAR2 (64)
,REPORTTABLE                   VARCHAR2 (64)
,SQLREVIEW                     VARCHAR2 (240)
,FENCEFILTER                   VARCHAR2 (240)
,DASTABLE                      VARCHAR2 (32)
,TABLETYPE                     NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE MSFORMS' " " from dual;
create table   GARLAND.MSFORMS
(
 ENTITY                        NUMBER   (10)
,MSLINK                        NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE NSA_CODEADDR_1ST' " " from dual;
create table   GARLAND.NSA_CODEADDR_1ST
(
 ADDR_NUM                      NUMBER   (6)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (40)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
,ADDR_CODE                     VARCHAR2 (10)
,ADDR_UNIT                     VARCHAR2 (10)
,VERIFY_CODE                   NUMBER   (2)
,PARCEL_ID                     VARCHAR2 (11)
,SEGMENT_ID                    NUMBER   (5)
,COUNCIL_DISTRICT              VARCHAR2 (1)
,SUBDIV_ID                     VARCHAR2 (5)
,INSPECT_AREA                  VARCHAR2 (2)
,ADDR_ID                       VARCHAR2 (374)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 2M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE NSA_CODE_INSPECT' " " from dual;
create table   GARLAND.NSA_CODE_INSPECT
(
 CASE_NUMBER                   NUMBER   (10)
,INSPECTION_DATE               DATE     
,CASE_CLOSED_DATE              DATE     
,ADDR_NUM                      NUMBER   (6)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (40)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
,UNIT_CODE                     VARCHAR2 (6)
,UNIT_NUM                      VARCHAR2 (6)
,ZIP_CODE                      VARCHAR2 (5)
,ISSUE_DATE                    DATE     
,COMPLY_DATE                   DATE     
,ACTION                        NUMBER   (2)
,FOLLOW_UP_ACTION              NUMBER   (2)
,STATUS                        VARCHAR2 (1)
,CODE_ID                       VARCHAR2 (5)
,VIOLATION_ID                  VARCHAR2 (10)
,VIOLATION                     VARCHAR2 (30)
,INSPECTOR                     VARCHAR2 (25)
,LEGAL1                        VARCHAR2 (35)
,LEGAL2                        VARCHAR2 (35)
,INSPECT_AREA                  VARCHAR2 (2)
,COUNCIL_ID                    VARCHAR2 (1)
,SUBDIV_ID                     VARCHAR2 (5)
,NSA_ID                        VARCHAR2 (5)
,PARCEL_ID                     VARCHAR2 (11)
,SEGMENT_ID                    NUMBER   (6)
,VERIFY_CODE                   NUMBER   (2)
,INSTIGATOR                    VARCHAR2 (1)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 8M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE NSA_CODE_INSPECT_1999' " " from dual;
create table   GARLAND.NSA_CODE_INSPECT_1999
(
 CASE_NUMBER                   NUMBER   (10)
,INSPECTION_DATE               DATE     
,CASE_CLOSED_DATE              DATE     
,ADDR_NUM                      NUMBER   (6)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (40)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
,UNIT_CODE                     VARCHAR2 (6)
,UNIT_NUM                      VARCHAR2 (6)
,ZIP_CODE                      VARCHAR2 (5)
,ISSUE_DATE                    DATE     
,COMPLY_DATE                   DATE     
,FOLLOW_UP_ACTION              NUMBER   (2)
,ACTION                        NUMBER   (2)
,STATUS                        VARCHAR2 (1)
,CODE_ID                       VARCHAR2 (5)
,VIOLATION_ID                  VARCHAR2 (10)
,VIOLATION                     VARCHAR2 (30)
,LEGAL1                        VARCHAR2 (40)
,LEGAL2                        VARCHAR2 (40)
,SUBDIV_ID                     VARCHAR2 (5)
,NSA_ID                        VARCHAR2 (5)
,PARCEL_ID                     VARCHAR2 (11)
,SEGMENT_ID                    NUMBER   (8)
,VERIFY_CODE                   NUMBER   (4)
,COUNCIL_DISTRICT              VARCHAR2 (1)
,INSPECT_AREA                  VARCHAR2 (2)
,INSPECTOR                     VARCHAR2 (25)
,INSTIGATOR                    VARCHAR2 (1)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 7M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE NSA_CODE_INSPECT_2000' " " from dual;
create table   GARLAND.NSA_CODE_INSPECT_2000
(
 CASE_NUMBER                   NUMBER   (10)
,INSPECTION_DATE               DATE     
,CASE_CLOSED_DATE              DATE     
,ADDR_NUM                      NUMBER   (6)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (40)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
,UNIT_CODE                     VARCHAR2 (6)
,UNIT_NUM                      VARCHAR2 (6)
,ZIP_CODE                      VARCHAR2 (5)
,ISSUE_DATE                    DATE     
,COMPLY_DATE                   DATE     
,ACTION                        NUMBER   (2)
,FOLLOW_UP_ACTION              NUMBER   (2)
,STATUS                        VARCHAR2 (1)
,CODE_ID                       VARCHAR2 (5)
,VIOLATION_ID                  VARCHAR2 (10)
,VIOLATION                     VARCHAR2 (30)
,INSPECTOR                     VARCHAR2 (25)
,LEGAL1                        VARCHAR2 (35)
,LEGAL2                        VARCHAR2 (35)
,INSPECT_AREA                  VARCHAR2 (2)
,COUNCIL_ID                    VARCHAR2 (1)
,SUBDIV_ID                     VARCHAR2 (5)
,NSA_ID                        VARCHAR2 (5)
,PARCEL_ID                     VARCHAR2 (11)
,SEGMENT_ID                    NUMBER   (6)
,VERIFY_CODE                   NUMBER   (2)
,INSTIGATOR                    VARCHAR2 (1)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 9M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE NSA_CODE_RENTAL' " " from dual;
create table   GARLAND.NSA_CODE_RENTAL
(
 PARCEL_ID                     VARCHAR2 (12)
,ADDR_NUM                      NUMBER   (22)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (80)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
,ADDRESS                       VARCHAR2 (80)
,CERTIFY_NUM                   NUMBER   (22)
,CERTIFY_DATE                  VARCHAR2 (20)
,OCCUPY_DATE                   VARCHAR2 (20)
,OCCUPY_COUNT                  NUMBER   (22)
,SELF_INSPECT_DATE             VARCHAR2 (20)
,OWNER_ADDRESS                 VARCHAR2 (80)
,OWNER_NAME                    VARCHAR2 (80)
,LICENSE_NUM                   VARCHAR2 (20)
,ISSUE_ST                      VARCHAR2 (20)
,ADDR_UNIT                     VARCHAR2 (5)
,SEGMENT_ID                    NUMBER   (22)
,VERIFY_CODE                   NUMBER   (22)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE NSA_CODE_VIOLATION' " " from dual;
create table   GARLAND.NSA_CODE_VIOLATION
(
 CASE_NUMBER                   NUMBER   (22)
,ADDR_NUM                      NUMBER   (22)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (40)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
,ADDR_CODE                     VARCHAR2 (3)
,ADDR_UNIT                     VARCHAR2 (5)
,INSPECT_DATE                  DATE     
,ISSUE_DATE                    DATE     
,COMPLY_DATE                   DATE     
,VIOLATION                     VARCHAR2 (30)
,ACTION                        NUMBER   (22)
,STATUS                        VARCHAR2 (1)
,COUNCIL_ID                    VARCHAR2 (1)
,SUBDIV_ID                     VARCHAR2 (5)
,INSPECT_AREA                  VARCHAR2 (2)
,LEGAL1                        VARCHAR2 (35)
,LEGAL2                        VARCHAR2 (35)
,PARCEL_ID                     VARCHAR2 (11)
,SEGMENT_ID                    NUMBER   (22)
,VERIFY_CODE                   NUMBER   (22)
,RENTAL_REGISTRATION           NUMBER   (22)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 9M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE NSA_CRIME' " " from dual;
create table   GARLAND.NSA_CRIME
(
 LWMAINID                      NUMBER   (22)
,DATE_OCCU                     DATE     
,PARCEL_ID                     VARCHAR2 (12)
,SEGMENT_ID                    NUMBER   (22)
,VERIFY_ID                     NUMBER   (22)
,UCR_CODE                      VARCHAR2 (4)
,UCR_GROUP                     VARCHAR2 (4)
,UCR_DESC                      VARCHAR2 (60)
,POLICE_BEAT                   VARCHAR2 (3)
,LEGAL1                        VARCHAR2 (60)
,LEGAL2                        VARCHAR2 (60)
,ADDR_NUM                      NUMBER   (22)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (40)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
,ADDR_UNIT                     VARCHAR2 (5)
,XSTR_PFX                      VARCHAR2 (2)
,XSTR_NAME                     VARCHAR2 (40)
,XSTR_TYPE                     VARCHAR2 (4)
,XSTR_SFX                      VARCHAR2 (2)
,DATE_REPT                     DATE     
)
tablespace GIS_DATA   pctfree 40  pctused 59
           initrans 1 maxtrans 255
storage   (initial 18M next 2M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE NSA_DCAD_RES' " " from dual;
create table   GARLAND.NSA_DCAD_RES
(
 SUBDIV_ID                     VARCHAR2 (5)
,NSA_ID                        VARCHAR2 (5)
,PARCEL_ID                     VARCHAR2 (11)
,PARCEL_                       NUMBER   (11)
,ACCT                          VARCHAR2 (17)
,NBHD                          VARCHAR2 (6)
,OLD_RGN                       NUMBER   (2)
,NBHD_CODE                     VARCHAR2 (3)
,PROP_CLASS                    NUMBER   (4)
,BLDG_CLASS                    NUMBER   (4)
,SUB_CLASS1                    VARCHAR2 (1)
,SUB_CLASS2                    VARCHAR2 (1)
,DEED_X_DT                     DATE     
,DEED_CG_DT                    DATE     
,DEED_CHGCD                    VARCHAR2 (1)
,STR_CTY_CD                    VARCHAR2 (2)
,LGL1_DESC                     VARCHAR2 (33)
,LGL2_DESC                     VARCHAR2 (33)
,LGL3_DESC                     VARCHAR2 (33)
,LGL4_DESC                     VARCHAR2 (33)
,LGL5_DESC                     VARCHAR2 (33)
,JNL_ENTRY                     NUMBER   (4)
,MAPSCO_CDS                    VARCHAR2 (5)
,CNTY                          VARCHAR2 (2)
,CITY                          VARCHAR2 (2)
,HOSP                          VARCHAR2 (2)
,COLG                          VARCHAR2 (2)
,ISD                           VARCHAR2 (2)
,TAX_REP                       VARCHAR2 (3)
,MKT_VALUE                     NUMBER   (11)
,IMPV_VALUE                    NUMBER   (9)
,APPSR_DATE                    DATE     
,LNDAREA1FL                    VARCHAR2 (1)
,LAND_AREA1                    NUMBER   (8)
,FRONTAGE1                     NUMBER   (8)
,LAND_DPTH1                    NUMBER   (8)
,LAND1PRCFL                    VARCHAR2 (1)
,LAND1____                     NUMBER   (11)
,ALPS_ADJ_1                    NUMBER   (9)
,LIVING_AR                     NUMBER   (8)
,LIVNG_UNIT                    NUMBER   (2)
,YEAR_BUILT                    NUMBER   (5)
,BLDG_PRICE                    NUMBER   (9)
,BLDG_DEPRE                    NUMBER   (4)
,FRAME_WORK                    VARCHAR2 (2)
,FOUNDATION                    VARCHAR2 (2)
,BASEMENT                      VARCHAR2 (2)
,EXT_WALL_1                    VARCHAR2 (2)
,EXT_WALL_2                    VARCHAR2 (2)
,ROOF_TYPE                     VARCHAR2 (2)
,ROOF_COMP                     VARCHAR2 (2)
,FULL_BATHS                    NUMBER   (4)
,HALF_BATHS                    NUMBER   (4)
,NUM_OF_KIT                    NUMBER   (2)
,AC_TYPE                       VARCHAR2 (2)
,HEAT                          VARCHAR2 (2)
,SV_QTR_AGE                    NUMBER   (4)
,FIREPLACE                     NUMBER   (4)
,POOL_PRICE                    NUMBER   (6)
,NB_CST_FAC                    NUMBER   (4)
,EF_AG_NCRN                    NUMBER   (4)
,RENDITION                     VARCHAR2 (2)
,RENDRD_AMT                    NUMBER   (11)
,PV_CNTRB__                    NUMBER   (9)
,APROCH_FIN                    VARCHAR2 (1)
,LAST_OPER                     VARCHAR2 (3)
,LST_UPD_DT                    DATE     
,ARB_FLAG                      VARCHAR2 (1)
,CRNT_PMTCD                    VARCHAR2 (1)
,CRNT_PMTDT                    DATE     
,CRNT_PMTVL                    NUMBER   (9)
,CRNT_APSR                     VARCHAR2 (3)
,PREV_PMTCD                    VARCHAR2 (1)
,PREV_PMTDT                    DATE     
,PREV_PMTVL                    NUMBER   (9)
,PREV_APSR                     VARCHAR2 (3)
,PRV2_PMTCD                    VARCHAR2 (1)
,PRV2_PMTDT                    DATE     
,PRV2_PMTVL                    NUMBER   (9)
,PRV2_APSR                     VARCHAR2 (3)
,CRNT_SALPR                    NUMBER   (9)
,CRNT_SALDT                    DATE     
,PREV_SALPR                    NUMBER   (9)
,PREV_SALDT                    DATE     
,ALPS_AJ_1                     NUMBER   (3)
,ALPS_SPTB                     VARCHAR2 (3)
,GARAGE_PRT                    VARCHAR2 (1)
,GARGE1_AR                     NUMBER   (6)
,GARGE1_DEP                    NUMBER   (4)
,GARGE1_PRF                    VARCHAR2 (1)
,GARGE1_PRC                    NUMBER   (6)
,GARGE1_LOC                    VARCHAR2 (2)
,GARGE1_MTL                    VARCHAR2 (2)
,GARGE1_FLR                    VARCHAR2 (2)
,GARGE_PRT2                    VARCHAR2 (1)
,GARGE2_AR                     NUMBER   (6)
,GARGE2_DPR                    NUMBER   (4)
,GARGE2_PRF                    VARCHAR2 (1)
,GARGE2_PRC                    NUMBER   (6)
,GARGE2_LOC                    VARCHAR2 (2)
,GARGE2_MTL                    VARCHAR2 (2)
,GARGE2_FLR                    VARCHAR2 (2)
,AC_BLD1_DS                    VARCHAR2 (25)
,AC_BLD1_MN                    NUMBER   (6)
,AC_BLD1_UP                    NUMBER   (6)
,AC_BLD1_FP                    NUMBER   (6)
,AC_BLD1_PC                    NUMBER   (6)
,AC_BLD1_DP                    NUMBER   (4)
,ACCES2_BLD                    VARCHAR2 (1)
,AC_BLD2_DS                    VARCHAR2 (25)
,CUR_SL_TYP                    VARCHAR2 (1)
,DISABL_EX1                    VARCHAR2 (1)
,HMSTD_EX_1                    VARCHAR2 (1)
,OVR_65_EX1                    VARCHAR2 (1)
,WATER_CD                      VARCHAR2 (2)
,WASTE_CD                      VARCHAR2 (2)
,APR_CLKNAM                    VARCHAR2 (17)
,DCAD_EMPLY                    VARCHAR2 (1)
,CONTRB_VAL                    NUMBER   (11)
,AG_INDCATR                    VARCHAR2 (1)
,CNTY_SPLIT                    NUMBER   (3)
,CITY_SPLIT                    NUMBER   (3)
,ISD_SPLIT                     NUMBER   (3)
,HOSP_SPLIT                    NUMBER   (3)
,COLL_SPLIT                    NUMBER   (3)
,SPEC_SPLIT                    NUMBER   (3)
,TAXP_ADDR1                    VARCHAR2 (25)
,TAXP_ADDR2                    VARCHAR2 (25)
,TAXP_ADDR3                    VARCHAR2 (25)
,TAXP_CITY                     VARCHAR2 (23)
,TAXP_STATE                    VARCHAR2 (2)
,TAXP_ZIPCD                    VARCHAR2 (9)
,TXCEL_AMT1                    NUMBER   (10)
,TXCEL_DTE1                    NUMBER   (9)
,CAP_HMSTD1                    NUMBER   (10)
,DEFER_CAP1                    NUMBER   (10)
,REVAL_YEAR                    NUMBER   (5)
,PV_RVAL_YR                    NUMBER   (5)
,CITY_ACCT_                    VARCHAR2 (25)
,CNTY_ACCT_                    VARCHAR2 (17)
,GIS_ACCT_                     VARCHAR2 (17)
,STREET_NAM                    VARCHAR2 (23)
,STREET_TYP                    VARCHAR2 (4)
,STREET_DIR                    VARCHAR2 (2)
,STREET_NUM                    NUMBER   (20)
,STREET_SFX                    VARCHAR2 (50)
,VERIFY_ID                     NUMBER   (4)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 63M next 7M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE NSA_TAX_ALIAS' " " from dual;
create table   GARLAND.NSA_TAX_ALIAS
(
 DCAD_ACCT                     VARCHAR2 (17)
,ADDR_NUM                      NUMBER   (5)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (20)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
,PARCEL_ID                     VARCHAR2 (11)
,VERIFY_ID                     NUMBER   (3)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 6M next 1M pctincrease 0
           minextents 1  maxextents 121
           freelists  1  freelist groups 1)
;

 
select 'CREATE NSA_TAX_CITY' " " from dual;
create table   GARLAND.NSA_TAX_CITY
(
 DCAD_ACCT                     VARCHAR2 (17)
,OWNER_NAME1                   VARCHAR2 (40)
,OWNER_NAME2                   VARCHAR2 (40)
,PARCEL_ID                     VARCHAR2 (11)
,ADDR_NUM                      NUMBER   (5)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (20)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
,UNIT_TYPE                     VARCHAR2 (5)
,UNIT_NUM                      VARCHAR2 (5)
,LEGAL_DESC                    VARCHAR2 (600)
,LEGAL_BLOCK                   VARCHAR2 (3)
,LEGAL_LOT                     VARCHAR2 (3)
,MAIL_ADDR                     VARCHAR2 (40)
,MAIL_CITY                     VARCHAR2 (40)
,MAIL_STATE                    VARCHAR2 (2)
,MAIL_ZIP                      VARCHAR2 (10)
,ASSESS_AMT                    NUMBER   (9,2)
,TAX_AMT                       NUMBER   (9,2)
,PAID_AMT                      NUMBER   (9,2)
,PAYMENT_DATE                  DATE     
,MORTGAGE                      VARCHAR2 (3)
,LENDER                        VARCHAR2 (5)
,AGENT                         VARCHAR2 (3)
,VERIFY_ID                     NUMBER   (3)
,SUBDIV_ID                     VARCHAR2 (5)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 23M next 3M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE NSA_TAX_SUMMARY' " " from dual;
create table   GARLAND.NSA_TAX_SUMMARY
(
 SUBDIV_ID                     VARCHAR2 (5)
,TTL_HOMES                     NUMBER   (22)
,AVG_YEAR_BUILT                NUMBER   (22)
,AVG_MARKEY_VALUE              NUMBER   (22)
,TTL_SQ_FOOTAGE                NUMBER   (22)
,AVG_SQ_FOOTAGE                NUMBER   (22)
,AVG_VALUE_PER_SQFT            NUMBER   (22)
,PCT_SINGLE_FAM_RENTAL         NUMBER   (22)
,TTL_HOMES_SOLD                NUMBER   (22)
,TURNOVER_RATE                 NUMBER   (22)
,TTL_APPRAISE_VALUE            NUMBER   (22)
,AVG_APPRAISE_VALUE            NUMBER   (22)
,AVG_APPRAISE_PER_SQFT         NUMBER   (22)
,AVG_TAXES_PER_HOME            NUMBER   (22)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 4M next 1M pctincrease 0
           minextents 1  maxextents 121
           freelists  1  freelist groups 1)
;

 
select 'CREATE N_PAVE_MAST' " " from dual;
create table   GARLAND.N_PAVE_MAST
(
 CATEGORY                      VARCHAR2 (1) not null
,BRANCH                        NUMBER   (4) not null
,SECTION_NO                    NUMBER   (4) not null
,SEGMENT                       NUMBER   (4)
,LENG                          NUMBER   (5)
,LANES                         NUMBER   (2,1)
,SURF_TYPE                     VARCHAR2 (3)
,REAR_ENTRY                    VARCHAR2 (1)
,CDBG                          VARCHAR2 (1)
,CONST_DATE                    DATE     
,LAST_INSPECT_DATE             DATE     
,NEXT_INSPECT_DATE             DATE     
,PCI                           NUMBER   (5,2)
,CLASS                         VARCHAR2 (10)
,CRACK_SEAL                    VARCHAR2 (1)
,DISTRESSES                    NUMBER   (4)
,POT_HOLE_REQ                  VARCHAR2 (1)
,COUN_DIST                     NUMBER   (2)
,THOR_TYPE                     VARCHAR2 (2)
,ADDR_NUM                      NUMBER   (6)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (40)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
,FROM_ADDR_NUM                 NUMBER   (6)
,FROM_ADDR_PFX                 VARCHAR2 (2)
,FROM_ADDR_NAME                VARCHAR2 (40)
,FROM_ADDR_TYPE                VARCHAR2 (4)
,FROM_ADDR_SFX                 VARCHAR2 (2)
,TO_ADDR_NUM                   NUMBER   (6)
,TO_ADDR_PFX                   VARCHAR2 (2)
,TO_ADDR_NAME                  VARCHAR2 (40)
,TO_ADDR_TYPE                  VARCHAR2 (4)
,TO_ADDR_SFX                   VARCHAR2 (2)
,REMARKS                       VARCHAR2 (40)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 2M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE PARK' " " from dual;
create table   GARLAND.PARK
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,AREA_NAME                     VARCHAR2 (30)
,AREA_TYPE                     VARCHAR2 (20)
,ADDRESS                       VARCHAR2 (30)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE PAVEMENT_MASTER' " " from dual;
create table   GARLAND.PAVEMENT_MASTER
(
 CATEGORY                      VARCHAR2 (1) not null
,BRANCH                        NUMBER   (22) not null
,SECTION                       NUMBER   (22) not null
,MSLINK                        NUMBER   (22)
,LEN                           NUMBER   (5)
,LANES                         NUMBER   (3,1)
,SURFACE                       VARCHAR2 (6)
,REAR_ENTRY                    VARCHAR2 (1)
,COUNCIL_DISTRICT              NUMBER   (2)
,CONST_DATE                    DATE     
,ADDR_NUM                      NUMBER   (6)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (20)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (3)
,FROM_ADDR_NUM                 NUMBER   (6)
,FROM_ADDR_PFX                 VARCHAR2 (2)
,FROM_ADDR_NAME                VARCHAR2 (20)
,FROM_ADDR_TYPE                VARCHAR2 (4)
,FROM_ADDR_SFX                 VARCHAR2 (3)
,TO_ADDR_NUM                   NUMBER   (6)
,TO_ADDR_PFX                   VARCHAR2 (2)
,TO_ADDR_NAME                  VARCHAR2 (20)
,TO_ADDR_TYPE                  VARCHAR2 (4)
,TO_ADDR_SFX                   VARCHAR2 (3)
,CLASS                         VARCHAR2 (10)
,CRACK_SEAL                    VARCHAR2 (1)
,DISTRESSES                    NUMBER   (22)
,LAST_INSPECTION_DATE          DATE     
,NEXT_INSPECTION_DATE          DATE     
,PCI                           NUMBER   (22)
,CDBG                          VARCHAR2 (1)
,THOR_TYPE                     VARCHAR2 (1)
,SEGMENT                       NUMBER   (22)
,POT_HOLE_REQUEST              VARCHAR2 (1)
,INSPECT_STATUS                VARCHAR2 (1)
,REMARKS                       VARCHAR2 (40)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE PAVE_CUST' " " from dual;
create table   GARLAND.PAVE_CUST
(
 PROJ_YEAR                     NUMBER   (4) not null
,PROJ_SEQ                      NUMBER   (4) not null
,NAME_LAST                     VARCHAR2 (20)
,NAME_FIRST                    VARCHAR2 (20)
,NAME_MI                       VARCHAR2 (2)
,SALUTATION                    VARCHAR2 (5)
,ADDR_NUM                      NUMBER   (6)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (20)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
,UNIT_TYPE                     VARCHAR2 (10)
,UNIT_NUM                      VARCHAR2 (20)
,CITY                          VARCHAR2 (12)
,STATE                         VARCHAR2 (2)
,ZIP_CODE                      NUMBER   (5)
,ZIP_PLUS                      NUMBER   (4)
,PHONE1                        VARCHAR2 (7)
,AREA_CODE1                    VARCHAR2 (3)
,PHONE2                        VARCHAR2 (7)
,AREA_CODE2                    VARCHAR2 (3)
,PHONE1_ID                     VARCHAR2 (10)
,PHONE2_ID                     VARCHAR2 (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE PAVE_CUST_ARCH' " " from dual;
create table   GARLAND.PAVE_CUST_ARCH
(
 PROJ_YEAR                     NUMBER   (4)
,PROJ_SEQ                      NUMBER   (4)
,NAME_LAST                     VARCHAR2 (20)
,NAME_FIRST                    VARCHAR2 (20)
,NAME_MI                       VARCHAR2 (2)
,SALUTATION                    VARCHAR2 (5)
,ADDR_NUM                      NUMBER   (6)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (20)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
,UNIT_TYPE                     VARCHAR2 (10)
,UNIT_NUM                      VARCHAR2 (20)
,CITY                          VARCHAR2 (12)
,STATE                         VARCHAR2 (2)
,ZIP_CODE                      NUMBER   (5)
,ZIP_PLUS                      NUMBER   (4)
,PHONE1                        VARCHAR2 (7)
,AREA_CODE1                    VARCHAR2 (3)
,PHONE2                        VARCHAR2 (7)
,AREA_CODE2                    VARCHAR2 (3)
,PHONE1_ID                     VARCHAR2 (10)
,PHONE2_ID                     VARCHAR2 (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE PAVE_MAST' " " from dual;
create table   GARLAND.PAVE_MAST
(
 CATEGORY                      VARCHAR2 (1) not null
,BRANCH                        NUMBER   (4) not null
,SECTION                       NUMBER   (4) not null
,SEGMENT                       NUMBER   (4)
,LENG                          NUMBER   (5)
,LANES                         NUMBER   (2,1)
,SURF_TYPE                     VARCHAR2 (3)
,REAR_ENTRY                    VARCHAR2 (1)
,CDBG                          VARCHAR2 (1)
,CONST_DATE                    DATE     
,LAST_INSPECT_DATE             DATE     
,NEXT_INSPECT_DATE             DATE     
,PCI                           NUMBER   (5,2)
,CLASS                         VARCHAR2 (10)
,CRACK_SEAL                    VARCHAR2 (1)
,DISTRESSES                    NUMBER   (4)
,POT_HOLE_REQ                  VARCHAR2 (1)
,COUN_DIST                     NUMBER   (2)
,THOR_TYPE                     VARCHAR2 (2)
,ADDR_NUM                      NUMBER   (6)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (40)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
,FROM_ADDR_NUM                 NUMBER   (6)
,FROM_ADDR_PFX                 VARCHAR2 (2)
,FROM_ADDR_NAME                VARCHAR2 (40)
,FROM_ADDR_TYPE                VARCHAR2 (4)
,FROM_ADDR_SFX                 VARCHAR2 (2)
,TO_ADDR_NUM                   NUMBER   (6)
,TO_ADDR_PFX                   VARCHAR2 (2)
,TO_ADDR_NAME                  VARCHAR2 (40)
,TO_ADDR_TYPE                  VARCHAR2 (4)
,TO_ADDR_SFX                   VARCHAR2 (2)
,REMARKS                       VARCHAR2 (40)
,MISSING_SDWK                  VARCHAR2 (1)
,THOR_TYPE_NEW                 VARCHAR2 (2)
,CPI_YN                        VARCHAR2 (1)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE PAVE_MAST_TEST' " " from dual;
create table   GARLAND.PAVE_MAST_TEST
(
 CATEGORY                      VARCHAR2 (1) not null
,BRANCH                        NUMBER   (4) not null
,SECTION                       NUMBER   (4) not null
,SEGMENT                       NUMBER   (4)
,LENG                          NUMBER   (5)
,LANES                         NUMBER   (2,1)
,SURF_TYPE                     VARCHAR2 (3)
,REAR_ENTRY                    VARCHAR2 (1)
,CDBG                          VARCHAR2 (1)
,CONST_DATE                    DATE     
,LAST_INSPECT_DATE             DATE     
,NEXT_INSPECT_DATE             DATE     
,PCI                           NUMBER   (5,2)
,CLASS                         VARCHAR2 (10)
,CRACK_SEAL                    VARCHAR2 (1)
,DISTRESSES                    NUMBER   (4)
,POT_HOLE_REQ                  VARCHAR2 (1)
,COUN_DIST                     NUMBER   (2)
,THOR_TYPE                     VARCHAR2 (2)
,ADDR_NUM                      NUMBER   (6)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (40)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
,FROM_ADDR_NUM                 NUMBER   (6)
,FROM_ADDR_PFX                 VARCHAR2 (2)
,FROM_ADDR_NAME                VARCHAR2 (40)
,FROM_ADDR_TYPE                VARCHAR2 (4)
,FROM_ADDR_SFX                 VARCHAR2 (2)
,TO_ADDR_NUM                   NUMBER   (6)
,TO_ADDR_PFX                   VARCHAR2 (2)
,TO_ADDR_NAME                  VARCHAR2 (40)
,TO_ADDR_TYPE                  VARCHAR2 (4)
,TO_ADDR_SFX                   VARCHAR2 (2)
,REMARKS                       VARCHAR2 (40)
,MISSING_SDWK                  VARCHAR2 (1)
,THOR_TYPE_NEW                 VARCHAR2 (2)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 2M next 1M pctincrease 0
           minextents 1  maxextents 121
           freelists  1  freelist groups 1)
;

 
select 'CREATE PAVE_PROJ' " " from dual;
create table   GARLAND.PAVE_PROJ
(
 PROJ_YEAR                     NUMBER   (4) not null
,PROJ_SEQ                      NUMBER   (4) not null
,CATEGORY                      VARCHAR2 (1)
,BRANCH                        NUMBER   (4)
,SECTION                       NUMBER   (4)
,SEGMENT                       NUMBER   (4)
,STATUS                        VARCHAR2 (8)
,RCVD_BY                       VARCHAR2 (10)
,REQ_DATE                      DATE     
,TIMESTAMP                     DATE     
,COUN_DIST                     NUMBER   (2)
,ADDR_NUM                      NUMBER   (6)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (20)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
,XST1_NUM                      NUMBER   (6)
,XST1_PFX                      VARCHAR2 (2)
,XST1_NAME                     VARCHAR2 (20)
,XST1_TYPE                     VARCHAR2 (4)
,XST1_SFX                      VARCHAR2 (2)
,XST2_NUM                      NUMBER   (6)
,XST2_PFX                      VARCHAR2 (2)
,XST2_NAME                     VARCHAR2 (20)
,XST2_TYPE                     VARCHAR2 (4)
,XST2_SFX                      VARCHAR2 (2)
,PLACE_NAME                    VARCHAR2 (80)
,REMARKS                       VARCHAR2 (70)
,SFG_NUMBER                    NUMBER   (4)
,SFG_SEQ                       NUMBER   (4)
,CONTR_FLAG                    VARCHAR2 (1)
,LOCATION                      VARCHAR2 (70)
,DESCRIPTION                   VARCHAR2 (70)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE PAVE_PROJ_APPR' " " from dual;
create table   GARLAND.PAVE_PROJ_APPR
(
 CATEGORY                      VARCHAR2 (1) not null
,BRANCH                        NUMBER   (4) not null
,SECTION                       NUMBER   (4) not null
,SEGMENT                       NUMBER   (4)
,RCVD_BY                       VARCHAR2 (10)
,REQ_DATE                      DATE     
,SFG_NUMBER                    NUMBER   (4) not null
,LOCATION                      VARCHAR2 (70)
,DESCRIPTION                   VARCHAR2 (70)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE PAVE_PROJ_ARCH' " " from dual;
create table   GARLAND.PAVE_PROJ_ARCH
(
 PROJ_YEAR                     NUMBER   (4)
,PROJ_SEQ                      NUMBER   (4)
,CATEGORY                      VARCHAR2 (1)
,BRANCH                        NUMBER   (4)
,SECTION                       NUMBER   (4)
,SEGMENT                       NUMBER   (4)
,STATUS                        VARCHAR2 (8)
,RCVD_BY                       VARCHAR2 (10)
,REQ_DATE                      DATE     
,TIME_STAMP                    DATE     
,REMARKS                       VARCHAR2 (70)
,COUN_DIST                     NUMBER   (2)
,ADDR_NUM                      NUMBER   (6)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (20)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
,XST1_NUM                      NUMBER   (6)
,XST1_PFX                      VARCHAR2 (2)
,XST1_NAME                     VARCHAR2 (20)
,XST1_TYPE                     VARCHAR2 (4)
,XST1_SFX                      VARCHAR2 (2)
,XST2_NUM                      NUMBER   (6)
,XST2_PFX                      VARCHAR2 (2)
,XST2_NAME                     VARCHAR2 (20)
,XST2_TYPE                     VARCHAR2 (4)
,XST2_SFX                      VARCHAR2 (2)
,PLACE_NAME                    VARCHAR2 (80)
,SFG_NUMBER                    NUMBER   (4)
,SFG_SEQ                       NUMBER   (4)
,CONTR_FLAG                    VARCHAR2 (1)
,LOCATION                      VARCHAR2 (70)
,DESCRIPTION                   VARCHAR2 (70)
,TIME_CLOSED                   DATE     
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 2M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE PAVE_SURF_MAST' " " from dual;
create table   GARLAND.PAVE_SURF_MAST
(
 CATEGORY                      VARCHAR2 (1) not null
,SURF_TYPE                     VARCHAR2 (3) not null
,INSPECT_INTERVAL              NUMBER   (2)
,CONT_REPAIR                   NUMBER   (5)
,CONT_REPLACE                  NUMBER   (5)
,IRR_REPAIR                    NUMBER   (5)
,IRR_REPLACE                   NUMBER   (5)
,MAT_REPAIR                    NUMBER   (5)
,MAT_REPLACE                   NUMBER   (5)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE PAVE_TASK' " " from dual;
create table   GARLAND.PAVE_TASK
(
 PROJ_YEAR                     NUMBER   (4) not null
,PROJ_SEQ                      NUMBER   (4) not null
,SUBTASK_SFG_NUM               NUMBER   (22) not null
,TASK_SEQ                      NUMBER   (3)
,EST_START_DATE                DATE     
,ACT_START_DATE                DATE     
,EST_END_DATE                  DATE     
,ACT_END_DATE                  DATE     
,EST_DURATION                  NUMBER   (8,3)
,ACT_DURATION                  NUMBER   (8,3)
,EST_TOTL_UNITS                NUMBER   (8,3)
,ACT_TOTL_UNITS                NUMBER   (8,3)
,PROJ_INFO                     VARCHAR2 (120)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE RANGE_DOMAIN' " " from dual;
create table   GARLAND.RANGE_DOMAIN
(
 RDOMAIN                       NUMBER   (10) not null
,MIN_VALUE                     NUMBER   (22) not null
,MAX_VALUE                     NUMBER   (22) not null
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE RMS_LOMAIN' " " from dual;
create table   GARLAND.RMS_LOMAIN
(
 LOMAINID                      NUMBER   (22)
,ADDR_NUM                      VARCHAR2 (10)
,ADDR_PFX                      VARCHAR2 (10)
,ADDR_NAME                     VARCHAR2 (40)
,ADDR_TYPE                     VARCHAR2 (20)
,ADDR_SFX                      VARCHAR2 (10)
,ADDR_UNIT                     VARCHAR2 (10)
,ROW_ID                        ROWID    
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 5M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE RQST_USER_LOG' " " from dual;
create table   GARLAND.RQST_USER_LOG
(
 USER_NAME                     VARCHAR2 (8) not null
,USER_PWD                      VARCHAR2 (8) not null
,USER_TYPE                     VARCHAR2 (8) not null
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE SANI_ASSET' " " from dual;
create table   GARLAND.SANI_ASSET
(
 REC_KEY                       NUMBER   (22)
,ADDR_NUM                      VARCHAR2 (5)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (30)
,ADDR_TYPE                     VARCHAR2 (4)
,BUSI_NAME                     VARCHAR2 (40)
,BUSI_TYPE                     VARCHAR2 (40)
,PARCEL_ID                     VARCHAR2 (11)
,ADDR_CODE                     VARCHAR2 (6)
,ADDR_UNIT                     VARCHAR2 (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE SANI_COMMERCIAL' " " from dual;
create table   GARLAND.SANI_COMMERCIAL
(
 REC_KEY                       NUMBER   (22)
,ADDR_NUM                      VARCHAR2 (5)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (30)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
,BUSI_NAME                     VARCHAR2 (40)
,BUSI_TYPE                     VARCHAR2 (40)
,PARCEL_ID                     VARCHAR2 (11)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE SNGLFAM_RENTAL' " " from dual;
create table   GARLAND.SNGLFAM_RENTAL
(
 ADDR_NUM                      NUMBER   (10)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (40)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
,TAX_OWNER                     VARCHAR2 (40)
,MAIL_ADDR                     VARCHAR2 (40)
,MAIL_CITY                     VARCHAR2 (30)
,UMS_OCCUPANT                  VARCHAR2 (30)
,LAND_USE_CODE                 VARCHAR2 (4)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 3M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE SURFACE_MASTER' " " from dual;
create table   GARLAND.SURFACE_MASTER
(
 SURFACE_TYPE                  VARCHAR2 (3) not null
,CONT_REPAIR                   NUMBER   (7,2)
,CONT_REPLACE                  NUMBER   (7,2)
,IRR_REPAIR                    NUMBER   (7,2)
,IRR_REPLACE                   NUMBER   (7,2)
,MATERIAL_REPAIR               NUMBER   (7,2)
,MATERIAL_REPLACE              NUMBER   (7,2)
,INSPECTION_INTERVAL           NUMBER   (2)
,CATEGORY                      VARCHAR2 (1) not null
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE TAX_ABSTRACT' " " from dual;
create table   GARLAND.TAX_ABSTRACT
(
 PARCEL_ID                     VARCHAR2 (11) not null
,DCAD_ACCT                     VARCHAR2 (17)
,COG_ACCT                      VARCHAR2 (11)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE TAX_SUBDIV_ID' " " from dual;
create table   GARLAND.TAX_SUBDIV_ID
(
 SUBDIV_ID                     VARCHAR2 (5)
,SUBDIV_NAME                   VARCHAR2 (38)
,NSA_ID                        VARCHAR2 (5)
,NSA_NAME                      VARCHAR2 (38)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 2M next 1M pctincrease 0
           minextents 1  maxextents 121
           freelists  1  freelist groups 1)
;

 
select 'CREATE TAX_UB' " " from dual;
create table   GARLAND.TAX_UB
(
 SUBDIVKEY                     VARCHAR2 (15)
,TAXPAYER_NAME                 VARCHAR2 (40)
,DCAD_ACCOUNT                  VARCHAR2 (17)
,TAXPAYER_ADDRESS2             VARCHAR2 (30)
,TAXPAYER_ADDRESS_CITY         VARCHAR2 (15)
,TAXPAYER_ADDRESS_STATE        VARCHAR2 (2)
,TAXPAYER_ADDRESS_ZIP          VARCHAR2 (10)
,STREET_NUMBER                 NUMBER   (6)
,STREET_PREFIX                 VARCHAR2 (1)
,STREET_NAME                   VARCHAR2 (30)
,STREET_TYPE                   VARCHAR2 (4)
,STREET_SUFFIX                 VARCHAR2 (1)
,PROPERTY_ADDR_ZIP             VARCHAR2 (10)
,BILLAMT                       NUMBER   (22)
,BILLASSD                      NUMBER   (22)
,OCCUPANT_NAME                 VARCHAR2 (30)
,DL                            VARCHAR2 (13)
,SSN                           VARCHAR2 (11)
,PARCEL_ID                     VARCHAR2 (12)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 29M next 3M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE TEST_JOHN' " " from dual;
create table   GARLAND.TEST_JOHN
(
 ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (20)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
,STREET_ID                     NUMBER   (8)
,ADDR_COMPRESS                 VARCHAR2 (20)
,ADDR_COMPACT                  VARCHAR2 (20)
,ADDR_REDUCED                  VARCHAR2 (20)
,ADDR_ENDING                   VARCHAR2 (20)
,ADDR_SOUNDEX                  VARCHAR2 (4)
,ADDR_PERMUTE                  NUMBER   (22)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 2M next 1M pctincrease 0
           minextents 1  maxextents 121
           freelists  1  freelist groups 1)
;

 
select 'CREATE TMP_JOHN' " " from dual;
create table   GARLAND.TMP_JOHN
(
 OTHER                         VARCHAR2 (20)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 11M next 2M pctincrease 0
           minextents 1  maxextents 121
           freelists  1  freelist groups 1)
;

 
select 'CREATE TMP_PARCEL_REGION' " " from dual;
create table   GARLAND.TMP_PARCEL_REGION
(
 PARCEL_ID                     VARCHAR2 (11)
,REGION_ID                     VARCHAR2 (20)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 3M next 1M pctincrease 0
           minextents 1  maxextents 121
           freelists  1  freelist groups 1)
;

 
select 'CREATE TRVEHACL' " " from dual;
create table   GARLAND.TRVEHACL
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,ALLEY_ID                      VARCHAR2 (10)
,BRANCH_NO                     NUMBER   (5)
,SECTION_NO                    NUMBER   (5)
,ALLEY_AREA                    NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE TRVEHALY' " " from dual;
create table   GARLAND.TRVEHALY
(
 BRANCH_NO                     NUMBER   (5) not null
,SECTION_NO                    NUMBER   (5) not null
,COUNCIL_DIST                  NUMBER   (5)
,ALLEY_NAME                    VARCHAR2 (40)
,ST_NAME_FROM                  VARCHAR2 (40)
,ST_NAME_TO                    VARCHAR2 (40)
,REAR_ENTRY                    VARCHAR2 (1)
,SECTION_LENGTH                NUMBER   (22)
,NUM_OF_LANES                  NUMBER   (3,1)
,SEAL_COND                     VARCHAR2 (1)
,DISTRESSES                    NUMBER   (5)
,PCI                           NUMBER   (5)
,SURFACE_TYPE                  VARCHAR2 (20)
,LAST_INSPECTION               NUMBER   (10)
,NEXT_INSPECTION               NUMBER   (10)
,SECTION_CLASS                 VARCHAR2 (10)
,CONT_REPAIR_COST              NUMBER   (12,2)
,CONT_REPLACE_COST             NUMBER   (12,2)
,CITY_REPLACE_COST             NUMBER   (12,2)
,MAT_REPAIR_COST               NUMBER   (12,2)
,MAT_REPLACE_COST              NUMBER   (12,2)
,CONSTR_DATE                   NUMBER   (10)
,CDBG                          VARCHAR2 (1)
,THOR_TYPE                     CHAR     (2)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE TRVEHRCL' " " from dual;
create table   GARLAND.TRVEHRCL
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,CLINE_ID                      NUMBER   (10)
,BRANCH_NO                     NUMBER   (5)
,SECTION_NO                    NUMBER   (5)
,NUM_LANES                     NUMBER   (5)
,FR_COORD                      NUMBER   (22)
,TO_COORD                      NUMBER   (22)
,CLINE_LENGTH                  NUMBER   (22)
,ST_NAME                       VARCHAR2 (40)
,COUNCIL_DISTRICT              NUMBER   (5)
,BOND_PROJ                     VARCHAR2 (16)
,ADDR_NUM                      NUMBER   (22)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (35)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
,ADDR_LEFT_FROM                NUMBER   (6)
,ADDR_LEFT_TO                  NUMBER   (6)
,ADDR_RGHT_FROM                NUMBER   (6)
,ADDR_RGHT_TO                  NUMBER   (6)
,PILOT                         VARCHAR2 (1)
,SOURCE                        VARCHAR2 (1)
,NOTCARRIED                    VARCHAR2 (1)
,ADDR_LO                       NUMBER   (10)
,ADDR_HI                       NUMBER   (10)
,SEGMENT_ID                    NUMBER   (4)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 2M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE TRVEHRCL_REGION' " " from dual;
create table   GARLAND.TRVEHRCL_REGION
(
 SEGMENT_ID                    NUMBER   (22)
,ZIP_CODE                      VARCHAR2 (5)
,SUBDIV_ID                     VARCHAR2 (5)
,COUNCIL_ID                    VARCHAR2 (1)
,POLICE_BEAT                   VARCHAR2 (3)
,FIRE_DISTRICT                 VARCHAR2 (1)
,CODE_INSPECT_AREA             VARCHAR2 (2)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 2M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE TRVEHSTR' " " from dual;
create table   GARLAND.TRVEHSTR
(
 BRANCH_NO                     NUMBER   (5) not null
,SECTION_NO                    NUMBER   (5) not null
,COUNCIL_DIST                  NUMBER   (5)
,ST_NAME                       VARCHAR2 (40)
,ST_NAME_FROM                  VARCHAR2 (40)
,ST_NAME_TO                    VARCHAR2 (40)
,SECTION_LENGTH                NUMBER   (22)
,NUM_OF_LANES                  NUMBER   (3,1)
,SEAL_COND                     VARCHAR2 (1)
,DISTRESSES                    NUMBER   (5)
,PCI                           NUMBER   (5)
,SURFACE_TYPE                  VARCHAR2 (20)
,LAST_INSPECTION               NUMBER   (10)
,NEXT_INSPECTION               NUMBER   (10)
,SECTION_CLASS                 VARCHAR2 (10)
,CONT_REPAIR_COST              NUMBER   (12,2)
,CONT_REPLACE_COST             NUMBER   (12,2)
,CITY_REPLACE_COST             NUMBER   (12,2)
,MAT_REPAIR_COST               NUMBER   (12,2)
,MAT_REPLACE_COST              NUMBER   (12,2)
,CONSTR_DATE                   NUMBER   (10)
,CDBG                          VARCHAR2 (1)
,THOR_TYPE                     CHAR     (2)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE TRVEHUNP' " " from dual;
create table   GARLAND.TRVEHUNP
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,ALLEY_ID                      NUMBER   (10) not null
,ALLEY_TYPE                    VARCHAR2 (6)
,ALLEY_WIDTH                   NUMBER   (22)
,ALLEY_LENGTH                  NUMBER   (22)
,ALLEY_AREA                    NUMBER   (22)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE TRVEH_THOR_INTERSECT' " " from dual;
create table   GARLAND.TRVEH_THOR_INTERSECT
(
 INT_MSLINK                    NUMBER   (10) not null
,TRV_MSLINK                    NUMBER   (10) not null
,TRV_BRANCH                    NUMBER   (10)
,TRV_SECTION                   NUMBER   (10)
,TR_TYPE                       VARCHAR2 (2)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE TST_JOHN' " " from dual;
create table   GARLAND.TST_JOHN
(
 ADDR_NAME                     VARCHAR2 (20) not null
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 6M next 1M pctincrease 0
           minextents 1  maxextents 121
           freelists  1  freelist groups 1)
;

 
select 'CREATE US_STATES' " " from dual;
create table   GARLAND.US_STATES
(
 ABBRV                         VARCHAR2 (2)
,NAME                          VARCHAR2 (20)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE ADRRESULT_WATER' " " from dual;
create table   GARLAND.ADRRESULT_WATER
(
 ADDR_NUM                      VARCHAR2 (20)
,ADDR_PFX                      VARCHAR2 (80)
,ADDR_NAME                     VARCHAR2 (80)
,ADDR_TYPE                     VARCHAR2 (80)
,ADDR_SFX                      VARCHAR2 (80)
,ADDR_CODE1                    VARCHAR2 (80)
,ADDR_UNIT1                    VARCHAR2 (80)
,ADDR_CODE2                    VARCHAR2 (80)
,ADDR_UNIT2                    VARCHAR2 (80)
,VERIFY_CODE                   VARCHAR2 (2)
,DO_PARSE                      VARCHAR2 (30)
,DO_ALIAS                      VARCHAR2 (5)
,DO_NAME                       VARCHAR2 (1)
,DO_QUAL                       VARCHAR2 (20)
,REC_SEQ                       NUMBER   (22)
,REC_ROWID                     ROWID    
,REC_KEY                       VARCHAR2 (20)
,PARCEL_ID                     VARCHAR2 (12)
,SEGMENT_ID                    VARCHAR2 (5)
,FORM_PFX                      VARCHAR2 (80)
,FORM_NAME                     VARCHAR2 (80)
,FORM_TYPE                     VARCHAR2 (80)
,FORM_SFX                      VARCHAR2 (80)
,FORM_CODE1                    VARCHAR2 (80)
,FORM_UNIT1                    VARCHAR2 (80)
,FORM_CODE2                    VARCHAR2 (80)
,FORM_UNIT2                    VARCHAR2 (80)
,APPL_PFX                      VARCHAR2 (80)
,APPL_NAME                     VARCHAR2 (80)
,APPL_TYPE                     VARCHAR2 (80)
,APPL_SFX                      VARCHAR2 (80)
,APPL_CODE1                    VARCHAR2 (80)
,APPL_UNIT1                    VARCHAR2 (80)
,APPL_CODE2                    VARCHAR2 (80)
,APPL_UNIT2                    VARCHAR2 (80)
,APPL_NUM                      VARCHAR2 (20)
)
tablespace GIS_DATA   pctfree 10  pctused 40

           initrans 1 maxtrans 255
storage   (initial 11M next 2M pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;

 
select 'CREATE master' " " from dual;
create table   GARLAND.master
(
 MACCTNO                       CHAR     (25) not null
,MPRPTYP                       CHAR     (1) not null
,MRECTYP                       CHAR     (1) not null
,MSEQNO                        CHAR     (3) not null
,OWNER                         CHAR     (25) not null
,TOTVALUE                      NUMBER   (9) not null
,PROPADDR                      CHAR     (30) not null
,STREET                        CHAR     (18) not null
,DIRECTION                     CHAR     (2) not null
,ANUMBER                       NUMBER   (6) not null
,SFX                           CHAR     (4) not null
,VALLND                        NUMBER   (9) not null
,SPTLND                        CHAR     (3) not null
,LNDAR                         NUMBER   (9) not null
,LNDARCD                       CHAR     (1) not null
,VALLNDH                       NUMBER   (9) not null
,SPTLNDH                       CHAR     (3) not null
,VALPRD                        NUMBER   (9) not null
,MKTPRD                        NUMBER   (9) not null
,MKTPRDH                       NUMBER   (9) not null
,SPTPRD                        CHAR     (3) not null
,PRDAR                         NUMBER   (9) not null
,PRDARCD                       CHAR     (1) not null
,VALPRDH                       NUMBER   (9) not null
,SPTPRDH                       CHAR     (3) not null
,VALIMP                        NUMBER   (9) not null
,SPTIMP                        CHAR     (3) not null
,IMPAR                         NUMBER   (9) not null
,IMPARCD                       CHAR     (1) not null
,VALIMPH                       NUMBER   (9) not null
,SPTIMPH                       CHAR     (3) not null
,VALPER                        NUMBER   (9) not null
,SPTPER                        CHAR     (3) not null
,PERAR                         NUMBER   (9) not null
,PERARCD                       CHAR     (1) not null
,VALPERH                       NUMBER   (9) not null
,SPTPERH                       CHAR     (3) not null
,RENDERED                      NUMBER   (9) not null
,RENDEREDCD                    CHAR     (1) not null
,HSMKT                         NUMBER   (9) not null
,HSCODE                        CHAR     (1) not null
,DVCODE                        NUMBER   (1) not null
,DVAMT                         NUMBER   (5) not null
,EXEMPT                        CHAR     (1) not null
,DESC1                         CHAR     (25) not null
,DESC2                         CHAR     (25) not null
,DESC3                         CHAR     (25) not null
,DESC4                         CHAR     (25) not null
,DESC5                         CHAR     (25) not null
,DESC6                         CHAR     (25) not null
,DESC7                         CHAR     (25) not null
,POWNER1                       CHAR     (12) not null
,POWNER2                       CHAR     (12) not null
,DESC8                         CHAR     (25) not null
,ACRES                         NUMBER   (9,3) not null
,UNDINTEREST                   NUMBER   (8,7) not null
,UNDCODE                       CHAR     (4) not null
,DIVACRES                      NUMBER   (9,3) not null
,DISTCD                        CHAR     (3) not null
,DISTMF                        CHAR     (2) not null
,SCHOOL                        CHAR     (3) not null
,CEILING                       NUMBER   (9,2) not null
,CEILINGYR                     NUMBER   (4) not null
,COUNTY                        CHAR     (3) not null
,JURIS1                        CHAR     (3) not null
,JURIS2                        CHAR     (3) not null
,JURIS3                        CHAR     (3) not null
,JURIS4                        CHAR     (3) not null
,JURIS5                        CHAR     (3) not null
,JURIS6                        CHAR     (3) not null
,JURIS7                        CHAR     (3) not null
,JURIS8                        CHAR     (3) not null
,JURIS9                        CHAR     (3) not null
,JURIS10                       CHAR     (3) not null
,JURIS11                       CHAR     (3) not null
,JURIS12                       CHAR     (3) not null
,JURIS13                       CHAR     (3) not null
,JURIS14                       CHAR     (3) not null
,GEONUM                        NUMBER   (2) not null
,AERIAL                        CHAR     (5) not null
,MAPNUM                        CHAR     (15) not null
,AGENT                         CHAR     (3) not null
,AUSE                          CHAR     (5) not null
,MORTGAGE                      CHAR     (3) not null
,TIFVAL                        NUMBER   (1) not null
,SWEXEM                        NUMBER   (1) not null
,OWNRCHNGDT                    DATE     
,OWNRCHNGOP                    CHAR     (3) not null
,HSCODEH                       CHAR     (1) not null
,DVCODEH                       CHAR     (2) not null
,PARCELID                      CHAR     (8) not null
,RENDEREDCDH                   CHAR     (1) not null
,DEEDVOLUME                    CHAR     (5) not null
,DEEDPAGE                      CHAR     (5) not null
,DEEDMM                        CHAR     (2) not null
,DEEDDD                        CHAR     (2) not null
,DEEDYY                        CHAR     (4) not null
,DOTVOLUME                     CHAR     (5) not null
,DOTPAGE                       CHAR     (5) not null
,DOTDATE                       CHAR     (8) not null
,COMMENT1A                     CHAR     (30) not null
,COMMENT1B                     CHAR     (30) not null
,COMMENT2                      CHAR     (30) not null
,COMMENT3                      CHAR     (30) not null
,COMMENT4                      CHAR     (30) not null
,COMMENT5                      CHAR     (30) not null
,APPRAISOR                     CHAR     (10) not null
,CHECKBY                       CHAR     (10) not null
,APPDATE                       DATE     
,LNDMODIFY                     CHAR     (1) not null
,IMPMODIFY                     CHAR     (1) not null
,PERMODIFY                     CHAR     (1) not null
,HMSTDAMOUNT                   NUMBER   (5) not null
,HMSTDSCHOOL                   NUMBER   (5) not null
,HMSTD65                       NUMBER   (5) not null
,HMSTDDISAB                    NUMBER   (5) not null
,HMSTDAMOUNTHIST               NUMBER   (5) not null
,HMSTDSCHOOLHIST               NUMBER   (5) not null
,HMSTD65HIST                   NUMBER   (5) not null
,HMSTDDISABHIST                NUMBER   (5) not null
,YREXEMPTGRANT                 NUMBER   (4) not null
,YRHSGRANT                     NUMBER   (4) not null
,YRDISGRANT                    NUMBER   (4) not null
,YRDVGRANT                     NUMBER   (4) not null
,YRSCHOOLGRANT                 NUMBER   (4) not null
,HSLAND                        NUMBER   (9) not null
,HSIMPR                        NUMBER   (9) not null
,HSPERS                        NUMBER   (9) not null
,INSCEILING                    NUMBER   (9,2) not null
,NEWIMPRVAL                    NUMBER   (9) not null
,HSMODIFY                      CHAR     (1) not null
,EFFYR                         NUMBER   (4) not null
,SWEXEMYR                      NUMBER   (4) not null
,AGYEARH                       CHAR     (4) not null
,NEWIMPR                       NUMBER   (9) not null
,CHNGDTPROPVAL                 DATE     
,CHNGOPPROPVAL                 CHAR     (8) not null
,CHNGDTLEGAL                   DATE     
,CHNGOPLEGAL                   CHAR     (8) not null
,CHNGDTJURIS                   DATE     
,CHNGOPJURIS                   CHAR     (8) not null
,CHNGDTDEED                    DATE     
,CHNGOPDEED                    CHAR     (8) not null
,CHNGDTACCT                    DATE     
,CHNGOPACCT                    CHAR     (8) not null
,PREVIOUSACCT                  CHAR     (25) not null
,CHNGDTDEL                     DATE     
,CHNGOPDEL                     CHAR     (8) not null
,ADELETE                       CHAR     (1) not null
,CHNGDT                        DATE     
,FILLERCHNGYY                  CHAR     (2) not null
,FILLERCHNGMM                  CHAR     (2) not null
,FILLERCHNGDD                  CHAR     (2) not null
,CHNGOP                        CHAR     (8) not null
,BUSNAME                       CHAR     (40) not null
,BUSAD1                        CHAR     (40) not null
,BUSAD2                        CHAR     (30) not null
,BUSCITY                       CHAR     (15) not null
,BUSST                         CHAR     (2) not null
,BUSZIP                        CHAR     (10) not null
,BUSACCT                       CHAR     (25) not null
,BUSCONTACT                    CHAR     (30) not null
,BUSPHONE                      CHAR     (12) not null
,BUSUNITS                      NUMBER   (8) not null
,SICCODE                       CHAR     (5) not null
,GEOACCT                       CHAR     (25) not null
,SP1                           CHAR     (1) not null
,SP2                           CHAR     (1) not null
,SP3                           CHAR     (1) not null
,SP4                           CHAR     (1) not null
,SP5                           CHAR     (1) not null
,SP6                           CHAR     (1) not null
,SP7                           CHAR     (1) not null
,SP8                           CHAR     (1) not null
,SP9                           CHAR     (1) not null
,SP10                          CHAR     (1) not null
,AGEXPDATE                     CHAR     (8) not null
,AGAUTH                        CHAR     (5) not null
,AGNOT                         CHAR     (2) not null
,PCTLOSSIMP                    NUMBER   (9) not null
,PCTLOSSLND                    NUMBER   (9) not null
,PRORATE                       NUMBER   (3) not null
,PRODTB                        CHAR     (4) not null
,PRODTE                        CHAR     (4) not null
,ALTACCT                       CHAR     (25) not null
,PORTCD                        CHAR     (1) not null
,PORTPCT                       NUMBER   (3,2) not null
,INSPDATE                      DATE     
,LNDMKT                        NUMBER   (9) not null
,IMPMKT                        NUMBER   (9) not null
,PERMKT                        NUMBER   (9) not null
,BYPASS                        CHAR     (1) not null
,BILLONFILE                    CHAR     (1) not null
,ACCTCREATE                    CHAR     (4) not null
,MHID1                         CHAR     (60) not null
,MHID2                         CHAR     (60) not null
,MHID3                         CHAR     (60) not null
,MHID4                         CHAR     (60) not null
,ARB                           CHAR     (3) not null
,ARBDATE                       DATE     
,CHNGDTEXEMP                   DATE     
,CHNGOPEXEMP                   CHAR     (8)
,LOAN                          CHAR     (20)
,LENDER                        CHAR     (5)
,COLLECTAGENT                  CHAR     (3)
,COLLECTMORTGAGE               CHAR     (3)
,COLLECTLOAN                   CHAR     (20)
,COLLECTLENDER                 CHAR     (5)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 7M next 1M pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;

 
select 'CREATE VIEW_CATALOG' " " from dual;
create table   GARLAND.VIEW_CATALOG
(
 ENTITYNUM                     NUMBER   (10) not null
,VIEWNAME                      VARCHAR2 (18)
,VIEWTYPE                      NUMBER   (10) not null
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE VIEW_CONTENT' " " from dual;
create table   GARLAND.VIEW_CONTENT
(
 VIEWNAME                      VARCHAR2 (18) not null
,TABLENAME                     VARCHAR2 (18) not null
,COLUMNNAME                    VARCHAR2 (18) not null
,ALIASNAME                     VARCHAR2 (18) not null
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE VIEW_JOIN' " " from dual;
create table   GARLAND.VIEW_JOIN
(
 VIEWNAME                      VARCHAR2 (18) not null
,JOINID                        NUMBER   (10) not null
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE WORK_MAST' " " from dual;
create table   GARLAND.WORK_MAST
(
 SFG_NUM                       NUMBER   (4) not null
,SUB_TASK_NUM                  NUMBER   (4) not null
,SFG_NAME                      VARCHAR2 (40)
,SFG_UNITS                     VARCHAR2 (4)
,SFG_TIME                      NUMBER   (6,3)
,CATEGORY                      VARCHAR2 (10)
,CREW_SIZE                     NUMBER   (3)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE CDRELSUBDV' " " from dual;
create table   GARLAND.CDRELSUBDV
(
 MSLINK                        NUMBER   (22) not null
,MAPID                         NUMBER   (22)
,SUBDIV_ID                     NUMBER   (22)
,FINAL_PLAT                    VARCHAR2 (40)
,REPLAT                        VARCHAR2 (40)
,BLOCK                         NUMBER   (22)
,LOT_LO                        NUMBER   (22)
,LOT_HI                        NUMBER   (22)
,RESIDENT_LOTS                 NUMBER   (22)
,COMMON_LOTS                   NUMBER   (22)
,VOLUME                        NUMBER   (22)
,PAGE_NO                       NUMBER   (22)
,AREA_SQFT                     NUMBER   (22)
,AREA_ACRE                     NUMBER   (22)
,FILING_DATE                   VARCHAR2 (10)
,LOGIN_DATE                    VARCHAR2 (7)
,PARCEL1                       NUMBER   (22)
,PARCEL2                       NUMBER   (22)
,PARCEL3                       NUMBER   (22)
,PARCEL4                       NUMBER   (22)
,GRID1                         VARCHAR2 (3)
,GRID2                         VARCHAR2 (3)
,GRID3                         VARCHAR2 (3)
,GRID4                         VARCHAR2 (3)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 2M next 1M pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;

 
select 'CREATE INTERSECTION' " " from dual;
create table   GARLAND.INTERSECTION
(
 ADDR1_BLOCK                   NUMBER   (22)
,ADDR1_PFX                     VARCHAR2 (2)
,ADDR1_NAME                    VARCHAR2 (20)
,ADDR1_TYPE                    VARCHAR2 (4)
,ADDR1_SFX                     VARCHAR2 (2)
,ADDR2_BLOCK                   NUMBER   (22)
,ADDR2_PFX                     VARCHAR2 (2)
,ADDR2_NAME                    VARCHAR2 (20)
,ADDR2_TYPE                    VARCHAR2 (4)
,ADDR2_SFX                     VARCHAR2 (2)
,CORNER_COMPASS                VARCHAR2 (2)
,TWIN_COMPASS                  VARCHAR2 (2)
,NODE_ID                       VARCHAR2 (20)
,INTERSECT_ID                  VARCHAR2 (20)
,TAX_ACCT                      VARCHAR2 (17)
,SUBDIV_ID                     VARCHAR2 (5)
,COUNCIL_ID                    VARCHAR2 (1)
,ZIP_CODE                      VARCHAR2 (5)
,CODE_INSPECT_AREA             VARCHAR2 (2)
,FIRE_DISTRICT                 VARCHAR2 (1)
,POLICE_BEAT                   NUMBER   (3)
,POLICE_DISTRICT               VARCHAR2 (3)
,ANIMAL_CONTROL                VARCHAR2 (1)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 7M next 1M pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;

 
select 'CREATE UTWATPIP' " " from dual;
create table   GARLAND.UTWATPIP
(
 PROJECT_NO                    VARCHAR2 (11)
,PROJECT_NAME                  VARCHAR2 (50)
,SUBDIVISION_NAME              VARCHAR2 (50)
,PROJECT_DESC                  VARCHAR2 (50)
,ASBUILT_DATE                  VARCHAR2 (10)
,INSPECTOR_NAME                VARCHAR2 (20)
,CONTRACT_NAME                 VARCHAR2 (20)
,MAP_GRID                      NUMBER   (5)
,MAP_QUAD                      VARCHAR2 (1)
,MSLINK                        NUMBER   (10)
,MAPID                         NUMBER   (10)
,PIPE_DIAMETER                 NUMBER   (5)
,PIPE_LENGTH                   NUMBER   (5)
,PIPE_MATERIAL                 VARCHAR2 (5)
,UP_NODE_ID                    VARCHAR2 (12)
,DN_NODE_ID                    VARCHAR2 (12)
,UP_NODE_ELEV                  NUMBER   (5,2)
,UP_NODE_GRND_ELEV             NUMBER   (5,2)
,DN_NODE_ELEV                  NUMBER   (5,2)
,DN_NODE_GRND_ELEV             NUMBER   (5,2)
,SLOPE                         NUMBER   (22)
,PIPE_CLASS                    VARCHAR2 (5)
,PIPE_MANUFACTURER             VARCHAR2 (20)
,PIPE_USE                      VARCHAR2 (10)
,PIPE_STATUS                   VARCHAR2 (5)
,PIPE_OWNER                    VARCHAR2 (10)
,PIPE_OWNER_STATUS             VARCHAR2 (10)
,CONTRACTOR                    VARCHAR2 (20)
,CONTRACT_NUM                  VARCHAR2 (20)
,LINE_NUM                      VARCHAR2 (10)
,ZONE                          VARCHAR2 (4)
,SUB_BASIN                     VARCHAR2 (5)
,SUB_SUB_BASIN                 VARCHAR2 (5)
,PRESSURE_NORMAL               FLOAT    (22)
,PRESSURE_MAX                  FLOAT    (22)
,PRESSURE_SOURCE               VARCHAR2 (20)
,REPAIR_DATE                   NUMBER   (22)
,WORK_ORDER_NUM                VARCHAR2 (10)
,INSPECT_DATE                  NUMBER   (22)
,FROM_X_COORD                  NUMBER   (22)
,FROM_Y_COORD                  NUMBER   (22)
,TO_X_COORD                    NUMBER   (22)
,TO_Y_COORD                    NUMBER   (22)
,DATA_SOURCE                   VARCHAR2 (20)
,USER_FLAG                     VARCHAR2 (10)
,POST_MODE                     VARCHAR2 (1)
,DATE_ADD                      VARCHAR2 (10)
,PIPE_ID                       VARCHAR2 (12)
,PIPE_NUM                      NUMBER   (5)
,ATS                           NUMBER   (10)
,COMMENTS                      VARCHAR2 (50)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 6M next 1M pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;

 
select 'CREATE GIS_OBJECTS' " " from dual;
create table   GARLAND.GIS_OBJECTS
(
 ITEM01                        VARCHAR2 (1000)
,ITEM02                        VARCHAR2 (2000)
,ITEM03                        VARCHAR2 (2000)
,ITEM04                        VARCHAR2 (2000)
,ITEM05                        VARCHAR2 (2000)
,ITEM06                        VARCHAR2 (2000)
,ITEM07                        VARCHAR2 (2000)
,ITEM08                        VARCHAR2 (2000)
,ITEM09                        VARCHAR2 (2000)
,ITEM10                        VARCHAR2 (2000)
,ITEM11                        VARCHAR2 (2000)
,ITEM12                        VARCHAR2 (2000)
,ITEM13                        VARCHAR2 (2000)
,ITEM14                        VARCHAR2 (2000)
,ITEM15                        VARCHAR2 (2000)
,ITEM16                        VARCHAR2 (2000)
,ITEM17                        VARCHAR2 (2000)
,ITEM18                        VARCHAR2 (2000)
,ITEM19                        VARCHAR2 (2000)
,ITEM20                        VARCHAR2 (2000)
,ITEM21                        VARCHAR2 (2000)
,ITEM22                        VARCHAR2 (2000)
,ITEM23                        VARCHAR2 (2000)
,ITEM24                        VARCHAR2 (2000)
,ITEM25                        VARCHAR2 (2000)
,ITEM26                        VARCHAR2 (2000)
,ITEM27                        VARCHAR2 (2000)
,ITEM28                        VARCHAR2 (2000)
,ITEM29                        VARCHAR2 (2000)
,ITEM30                        VARCHAR2 (2000)
,ITEM31                        VARCHAR2 (2000)
,ITEM32                        VARCHAR2 (2000)
,ITEM33                        VARCHAR2 (2000)
,ITEM34                        VARCHAR2 (2000)
,ITEM35                        VARCHAR2 (2000)
,ITEM36                        VARCHAR2 (2000)
,ITEM37                        VARCHAR2 (2000)
,ITEM38                        VARCHAR2 (2000)
,ITEM39                        VARCHAR2 (2000)
,ITEM40                        VARCHAR2 (2000)
,ITEM41                        VARCHAR2 (2000)
,ITEM42                        VARCHAR2 (2000)
,ITEM43                        VARCHAR2 (2000)
,ITEM44                        VARCHAR2 (2000)
,ITEM45                        VARCHAR2 (2000)
,ITEM46                        VARCHAR2 (2000)
,ITEM47                        VARCHAR2 (2000)
,ITEM48                        VARCHAR2 (2000)
,ITEM49                        VARCHAR2 (2000)
,ITEM50                        VARCHAR2 (2000)
,ITEM51                        VARCHAR2 (2000)
,ITEM52                        VARCHAR2 (2000)
,ITEM53                        VARCHAR2 (2000)
,ITEM54                        VARCHAR2 (2000)
,ITEM55                        VARCHAR2 (2000)
,ITEM56                        VARCHAR2 (2000)
,ITEM57                        VARCHAR2 (2000)
,ITEM58                        VARCHAR2 (2000)
,ITEM59                        VARCHAR2 (2000)
,ITEM60                        VARCHAR2 (2000)
,ITEM61                        VARCHAR2 (2000)
,ITEM62                        VARCHAR2 (2000)
,ITEM63                        VARCHAR2 (2000)
,ITEM64                        VARCHAR2 (2000)
,ITEM65                        VARCHAR2 (2000)
,ITEM66                        VARCHAR2 (2000)
,ITEM67                        VARCHAR2 (2000)
,ITEM68                        VARCHAR2 (2000)
,ITEM69                        VARCHAR2 (2000)
,ITEM70                        VARCHAR2 (2000)
,ITEM71                        VARCHAR2 (2000)
,ITEM72                        VARCHAR2 (2000)
,ITEM73                        VARCHAR2 (2000)
,ITEM74                        VARCHAR2 (2000)
,ITEM75                        VARCHAR2 (2000)
,ITEM76                        VARCHAR2 (2000)
,ITEM77                        VARCHAR2 (2000)
,ITEM78                        VARCHAR2 (2000)
,ITEM79                        VARCHAR2 (2000)
,ITEM80                        VARCHAR2 (2000)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 15M next 2M pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;

 
select 'CREATE NSA_CODE_COMPLAINT' " " from dual;
create table   GARLAND.NSA_CODE_COMPLAINT
(
 CASE_NUMBER                   NUMBER   (22) not null
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;

 
select 'CREATE ADRALIAS' " " from dual;
create table   GARLAND.ADRALIAS
(
 ALIAS_PFX                     VARCHAR2 (10) not null
,ALIAS_NAME                    VARCHAR2 (30) not null
,ALIAS_TYPE                    VARCHAR2 (10) not null
,ALIAS_SFX                     VARCHAR2 (10) not null
,ALIAS_LO                      NUMBER   (22) not null
,ALIAS_HI                      NUMBER   (22)
,ADDR_MIN                      NUMBER   (22)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (30)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
,ALIAS_HOW                     VARCHAR2 (8)
,ALIAS_REDUCED                 VARCHAR2 (30)
,ALIAS_COMPACT                 VARCHAR2 (30)
,ALIAS_COMPRESS                VARCHAR2 (30)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 2M next 1M pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;

 
select 'CREATE NSA_CODE_CITATION' " " from dual;
create table   GARLAND.NSA_CODE_CITATION
(
 CASE_NUMBER                   NUMBER   (22) not null
,CITATION_NUMBER               NUMBER   (22) not null
,CITATION_ISSUE_DATE           DATE     
,CITATION_COMPLY_DATE          DATE     
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;

 
select 'CREATE ESRI_ADDRESS' " " from dual;
create table   GARLAND.ESRI_ADDRESS
(
 KEY                           NUMBER   (22) not null
,MSLINK                        NUMBER   (22)
,PARCEL_ID                     VARCHAR2 (12)
,ADDRESS                       VARCHAR2 (80)
,REGION                        VARCHAR2 (20)
)
tablespace GIS_DATA   pctfree 1  pctused 99
           initrans 1 maxtrans 255
storage   (initial 3M next 1M pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;

 
select 'CREATE ADRRESULT_INPUT' " " from dual;
create table   GARLAND.ADRRESULT_INPUT
(
 ADDR_NUM                      VARCHAR2 (20)
,ADDR_PFX                      VARCHAR2 (80)
,ADDR_NAME                     VARCHAR2 (80)
,ADDR_TYPE                     VARCHAR2 (80)
,ADDR_SFX                      VARCHAR2 (80)
,ADDR_CODE1                    VARCHAR2 (80)
,ADDR_UNIT1                    VARCHAR2 (80)
,ADDR_CODE2                    VARCHAR2 (80)
,ADDR_UNIT2                    VARCHAR2 (80)
,VERIFY_CODE                   VARCHAR2 (2)
,DO_PARSE                      VARCHAR2 (30)
,DO_ALIAS                      VARCHAR2 (5)
,DO_NAME                       VARCHAR2 (1)
,DO_QUAL                       VARCHAR2 (20)
,REC_SEQ                       NUMBER   (22)
,REC_ROWID                     ROWID    
,REC_KEY                       VARCHAR2 (20)
,PARCEL_ID                     VARCHAR2 (12)
,SEGMENT_ID                    VARCHAR2 (5)
,FORM_PFX                      VARCHAR2 (80)
,FORM_NAME                     VARCHAR2 (80)
,FORM_TYPE                     VARCHAR2 (80)
,FORM_SFX                      VARCHAR2 (80)
,FORM_CODE1                    VARCHAR2 (80)
,FORM_UNIT1                    VARCHAR2 (80)
,FORM_CODE2                    VARCHAR2 (80)
,FORM_UNIT2                    VARCHAR2 (80)
,APPL_PFX                      VARCHAR2 (80)
,APPL_NAME                     VARCHAR2 (80)
,APPL_TYPE                     VARCHAR2 (80)
,APPL_SFX                      VARCHAR2 (80)
,APPL_CODE1                    VARCHAR2 (80)
,APPL_UNIT1                    VARCHAR2 (80)
,APPL_CODE2                    VARCHAR2 (80)
,APPL_UNIT2                    VARCHAR2 (80)
,APPL_NUM                      VARCHAR2 (20)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 24M next 3M pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;

 
select 'CREATE GIS_VERIFY_ADDR' " " from dual;
create table   GARLAND.GIS_VERIFY_ADDR
(
 ADDR_NUM                      VARCHAR2 (20)
,ADDR_PFX                      VARCHAR2 (80)
,ADDR_NAME                     VARCHAR2 (80)
,ADDR_TYPE                     VARCHAR2 (80)
,ADDR_SFX                      VARCHAR2 (80)
,ADDR_CODE1                    VARCHAR2 (80)
,ADDR_UNIT1                    VARCHAR2 (80)
,ADDR_CODE2                    VARCHAR2 (80)
,ADDR_UNIT2                    VARCHAR2 (80)
,VERIFY_CODE                   VARCHAR2 (2)
,DO_PARSE                      VARCHAR2 (30)
,DO_ALIAS                      VARCHAR2 (5)
,DO_NAME                       VARCHAR2 (1)
,DO_QUAL                       VARCHAR2 (20)
,REC_SEQ                       NUMBER   (22)
,REC_ROWID                     ROWID    
,REC_KEY                       VARCHAR2 (20)
,PARCEL_ID                     VARCHAR2 (12)
,SEGMENT_ID                    VARCHAR2 (5)
,FORM_PFX                      VARCHAR2 (80)
,FORM_NAME                     VARCHAR2 (80)
,FORM_TYPE                     VARCHAR2 (80)
,FORM_SFX                      VARCHAR2 (80)
,FORM_CODE1                    VARCHAR2 (80)
,FORM_UNIT1                    VARCHAR2 (80)
,FORM_CODE2                    VARCHAR2 (80)
,FORM_UNIT2                    VARCHAR2 (80)
,APPL_PFX                      VARCHAR2 (80)
,APPL_NAME                     VARCHAR2 (80)
,APPL_TYPE                     VARCHAR2 (80)
,APPL_SFX                      VARCHAR2 (80)
,APPL_CODE1                    VARCHAR2 (80)
,APPL_UNIT1                    VARCHAR2 (80)
,APPL_CODE2                    VARCHAR2 (80)
,APPL_UNIT2                    VARCHAR2 (80)
,APPL_NUM                      VARCHAR2 (20)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 42M next 5M pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;

 
select 'CREATE ADRRESULT_EXTRACT' " " from dual;
create table   GARLAND.ADRRESULT_EXTRACT
(
 ADDR_NUM                      VARCHAR2 (20)
,ADDR_PFX                      VARCHAR2 (80)
,ADDR_NAME                     VARCHAR2 (80)
,ADDR_TYPE                     VARCHAR2 (80)
,ADDR_SFX                      VARCHAR2 (80)
,ADDR_CODE1                    VARCHAR2 (80)
,ADDR_UNIT1                    VARCHAR2 (80)
,ADDR_CODE2                    VARCHAR2 (80)
,ADDR_UNIT2                    VARCHAR2 (80)
,VERIFY_CODE                   VARCHAR2 (2)
,DO_PARSE                      VARCHAR2 (30)
,DO_ALIAS                      VARCHAR2 (5)
,DO_NAME                       VARCHAR2 (1)
,DO_QUAL                       VARCHAR2 (20)
,REC_SEQ                       NUMBER   (22)
,REC_ROWID                     ROWID    
,REC_KEY                       VARCHAR2 (20)
,PARCEL_ID                     VARCHAR2 (12)
,SEGMENT_ID                    VARCHAR2 (5)
,FORM_PFX                      VARCHAR2 (80)
,FORM_NAME                     VARCHAR2 (80)
,FORM_TYPE                     VARCHAR2 (80)
,FORM_SFX                      VARCHAR2 (80)
,FORM_CODE1                    VARCHAR2 (6)
,FORM_UNIT1                    VARCHAR2 (80)
,FORM_CODE2                    VARCHAR2 (6)
,FORM_UNIT2                    VARCHAR2 (80)
,APPL_PFX                      VARCHAR2 (80)
,APPL_NAME                     VARCHAR2 (80)
,APPL_TYPE                     VARCHAR2 (80)
,APPL_SFX                      VARCHAR2 (80)
,APPL_CODE1                    VARCHAR2 (10)
,APPL_UNIT1                    VARCHAR2 (80)
,APPL_CODE2                    VARCHAR2 (10)
,APPL_UNIT2                    VARCHAR2 (80)
,APPL_NUM                      VARCHAR2 (20)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 25M next 3M pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;

 
select 'CREATE CDRELPAR_AUDIT' " " from dual;
create table   GARLAND.CDRELPAR_AUDIT
(
 PERSON                        VARCHAR2 (8)
,ACTION                        VARCHAR2 (1)
,TIMESTAMP                     DATE     
,MSLINK_BEF                    NUMBER   (22)
,MSLINK_AFT                    NUMBER   (22)
,PARCEL_BEF                    VARCHAR2 (12)
,PARCEL_AFT                    VARCHAR2 (12)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 2M next 1M pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;

 
select 'CREATE TRVEHRCL_AUDIT' " " from dual;
create table   GARLAND.TRVEHRCL_AUDIT
(
 PERSON                        VARCHAR2 (8)
,ACTION                        VARCHAR2 (1)
,TIMESTAMP                     DATE     
,MSLINK_BEF                    NUMBER   (22)
,MSLINK_AFT                    NUMBER   (22)
,BRANCH_BEF                    NUMBER   (22)
,BRANCH_AFT                    NUMBER   (22)
,SECTION_BEF                   NUMBER   (22)
,SECTION_AFT                   NUMBER   (22)
,PFX_BEF                       VARCHAR2 (2)
,PFX_AFT                       VARCHAR2 (2)
,NAME_BEF                      VARCHAR2 (35)
,NAME_AFT                      VARCHAR2 (35)
,TYPE_BEF                      VARCHAR2 (4)
,TYPE_AFT                      VARCHAR2 (4)
,SFX_BEF                       VARCHAR2 (2)
,SFX_AFT                       VARCHAR2 (2)
,LO_BEF                        NUMBER   (22)
,LO_AFT                        NUMBER   (22)
,HI_BEF                        NUMBER   (22)
,HI_AFT                        NUMBER   (22)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 2M next 1M pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;

 
select 'CREATE CDRELADR_AUDIT' " " from dual;
create table   GARLAND.CDRELADR_AUDIT
(
 PERSON                        VARCHAR2 (8)
,ACTION                        VARCHAR2 (1)
,TIMESTAMP                     DATE     
,PARCEL_BEF                    VARCHAR2 (12)
,PARCEL_AFT                    VARCHAR2 (12)
,NUM_BEF                       NUMBER   (22)
,NUM_AFT                       NUMBER   (22)
,PFX_BEF                       VARCHAR2 (2)
,PFX_AFT                       VARCHAR2 (2)
,NAME_BEF                      VARCHAR2 (20)
,NAME_AFT                      VARCHAR2 (20)
,TYPE_BEF                      VARCHAR2 (4)
,TYPE_AFT                      VARCHAR2 (4)
,SFX_BEF                       VARCHAR2 (2)
,SFX_AFT                       VARCHAR2 (2)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 2M next 1M pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;

 
select 'CREATE UMS_DETAIL' " " from dual;
create table   GARLAND.UMS_DETAIL
(
 LOCATION_NO                   NUMBER   (22)
,ACCOUNT_NO                    NUMBER   (22)
,SERVICE_SEQ                   NUMBER   (22)
,SERVICE_TYPE                  VARCHAR2 (5)
,BILL_DATE                     DATE     
,CONS_AMT                      NUMBER   (19,6)
,DETAIL_AMT                    NUMBER   (15,2)
,ASSET                         VARCHAR2 (10)
,ASSET_NO                      VARCHAR2 (15)
,PARCEL_ID                     VARCHAR2 (12)
)
tablespace GIS_DATA   pctfree 4  pctused 95
           initrans 1 maxtrans 255
storage   (initial 63M next 7M pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;

 
select 'CREATE TMP_APP_ADDRESS' " " from dual;
create table   GARLAND.TMP_APP_ADDRESS
(
 USER_KEY                      VARCHAR2 (40)
,ADDR_NUM                      VARCHAR2 (20)
,ADDR_PFX                      VARCHAR2 (2)
,ADDR_NAME                     VARCHAR2 (100)
,ADDR_TYPE                     VARCHAR2 (4)
,ADDR_SFX                      VARCHAR2 (2)
,VERIFY_ID                     NUMBER   (22)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 3M next 1M pctincrease 0
           minextents 1  maxextents 121
           freelists  1  freelist groups 1)
;

 
select 'CREATE NEW_GIS_VERIFY_ADDR' " " from dual;
create table   GARLAND.NEW_GIS_VERIFY_ADDR
(
 ADDR_NUM                      VARCHAR2 (20)
,ADDR_PFX                      VARCHAR2 (80)
,ADDR_NAME                     VARCHAR2 (80)
,ADDR_TYPE                     VARCHAR2 (80)
,ADDR_SFX                      VARCHAR2 (80)
,ADDR_CODE1                    VARCHAR2 (80)
,ADDR_UNIT1                    VARCHAR2 (80)
,ADDR_CODE2                    VARCHAR2 (80)
,ADDR_UNIT2                    VARCHAR2 (80)
,VERIFY_CODE                   VARCHAR2 (2)
,DO_PARSE                      VARCHAR2 (30)
,DO_ALIAS                      VARCHAR2 (5)
,DO_NAME                       VARCHAR2 (1)
,DO_QUAL                       VARCHAR2 (20)
,REC_SEQ                       NUMBER   (22)
,REC_ROWID                     ROWID    
,REC_KEY                       VARCHAR2 (20)
,PARCEL_ID                     VARCHAR2 (12)
,SEGMENT_ID                    VARCHAR2 (5)
,FORM_PFX                      VARCHAR2 (80)
,FORM_NAME                     VARCHAR2 (80)
,FORM_TYPE                     VARCHAR2 (80)
,FORM_SFX                      VARCHAR2 (80)
,FORM_CODE1                    VARCHAR2 (80)
,FORM_UNIT1                    VARCHAR2 (80)
,FORM_CODE2                    VARCHAR2 (80)
,FORM_UNIT2                    VARCHAR2 (80)
,APPL_PFX                      VARCHAR2 (80)
,APPL_NAME                     VARCHAR2 (80)
,APPL_TYPE                     VARCHAR2 (80)
,APPL_SFX                      VARCHAR2 (80)
,APPL_CODE1                    VARCHAR2 (80)
,APPL_UNIT1                    VARCHAR2 (80)
,APPL_CODE2                    VARCHAR2 (80)
,APPL_UNIT2                    VARCHAR2 (80)
,APPL_NUM                      VARCHAR2 (20)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 20M next 2M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE UTWATSRVLN' " " from dual;
create table   GARLAND.UTWATSRVLN
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,ATS                           NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 121
           freelists  1  freelist groups 1)
;

 
select 'CREATE UTWATPLG' " " from dual;
create table   GARLAND.UTWATPLG
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,ATS                           NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 121
           freelists  1  freelist groups 1)
;

 
select 'CREATE UTWATARW' " " from dual;
create table   GARLAND.UTWATARW
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,ATS                           NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 121
           freelists  1  freelist groups 1)
;

 
select 'CREATE UTSTOSRVLN' " " from dual;
create table   GARLAND.UTSTOSRVLN
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,ATS                           NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 121
           freelists  1  freelist groups 1)
;

 
select 'CREATE UTSTOHDWL' " " from dual;
create table   GARLAND.UTSTOHDWL
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,ATS                           NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 121
           freelists  1  freelist groups 1)
;

 
select 'CREATE UTSTOARW' " " from dual;
create table   GARLAND.UTSTOARW
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,ATS                           NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 121
           freelists  1  freelist groups 1)
;

 
select 'CREATE UTSANSRVLN' " " from dual;
create table   GARLAND.UTSANSRVLN
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,ATS                           NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 121
           freelists  1  freelist groups 1)
;

 
select 'CREATE UTSANARW' " " from dual;
create table   GARLAND.UTSANARW
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,ATS                           NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 121
           freelists  1  freelist groups 1)
;

 
select 'CREATE UTSANPIP_MSLINK_JUNCTION' " " from dual;
create table   GARLAND.UTSANPIP_MSLINK_JUNCTION
(
 OLD_MSLINK                    VARCHAR2 (40)
,NEW_MSLINK                    VARCHAR2 (20)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 121
           freelists  1  freelist groups 1)
;

 
select 'CREATE UTWATTNK' " " from dual;
create table   GARLAND.UTWATTNK
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,TANK_ID                       VARCHAR2 (15)
,TANK_TYPE                     VARCHAR2 (2)
,MAP_GRID                      VARCHAR2 (3)
,MAP_QUAD                      VARCHAR2 (1)
,TANK_NUM                      NUMBER   (5)
,ASBUILT_DATE                  NUMBER   (5)
,ATS                           NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE UTWATPSTA' " " from dual;
create table   GARLAND.UTWATPSTA
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,PUMPSTA_ID                    VARCHAR2 (15)
,PUMPSTA_TYPE                  VARCHAR2 (2)
,MAP_GRID                      VARCHAR2 (3)
,MAP_QUAD                      VARCHAR2 (1)
,PUMPSTA_NUM                   NUMBER   (5)
,ASBUILT_DATE                  NUMBER   (5)
,ATS                           NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE UTWATMTR' " " from dual;
create table   GARLAND.UTWATMTR
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,ATS                           NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE UTSTOMH' " " from dual;
create table   GARLAND.UTSTOMH
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,MANHOLE_ID                    VARCHAR2 (15)
,MAP_GRID                      VARCHAR2 (3)
,MAP_QUAD                      VARCHAR2 (1)
,MANHOLE_NUM                   NUMBER   (5)
,ASBUILT_DATE                  NUMBER   (5)
,ATS                           NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE UTSTOCTY' " " from dual;
create table   GARLAND.UTSTOCTY
(
 DEPARTMENT                    VARCHAR2 (20)
,CUSTOMER                      VARCHAR2 (40)
,ADDR_PFX                      VARCHAR2 (1)
,ADDR_NUM                      NUMBER   (5)
,ADDR_NAME                     VARCHAR2 (40)
,ADDR_TYPE                     VARCHAR2 (4)
,PARCEL_ID                     VARCHAR2 (12) not null
,ACCOUNT                       NUMBER   (10) not null
,POLYAREA                      NUMBER   (10)
,TOT_IMPER                     NUMBER   (10)
,FEE                           NUMBER   (6,2)
,FUND                          VARCHAR2 (1)
,MSLINK                        NUMBER   (10)
,MAPID                         NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE UTSANLST' " " from dual;
create table   GARLAND.UTSANLST
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,LIFTSTA_ID                    VARCHAR2 (15)
,MAP_GRID                      VARCHAR2 (3)
,MAP_QUAD                      VARCHAR2 (1)
,LIFTSTA_NUM                   NUMBER   (5)
,DESCRIPT                      VARCHAR2 (40)
,LIFTSTA_SIZE                  NUMBER   (5)
,BASIN                         VARCHAR2 (20)
,SUB_BASIN                     VARCHAR2 (5)
,SUB_SUBBASIN                  VARCHAR2 (5)
,UPSTREAM_NODE                 VARCHAR2 (15)
,DNSTREAM_NODE                 VARCHAR2 (15)
,ASBUILT_DATE                  NUMBER   (5)
,ATS                           NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE UTSANLAT' " " from dual;
create table   GARLAND.UTSANLAT
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,LATERAL_ID                    VARCHAR2 (15)
,MAP_GRID                      VARCHAR2 (3)
,MAP_QUAD                      VARCHAR2 (1)
,LATERAL_NUM                   NUMBER   (5)
,LATERAL_SIZE                  NUMBER   (5)
,BASIN                         VARCHAR2 (20)
,SUB_BASIN                     VARCHAR2 (5)
,SUB_SUBBASIN                  VARCHAR2 (5)
,UPSTREAM_NODE                 VARCHAR2 (15)
,DNSTREAM_NODE                 VARCHAR2 (15)
,ASBUILT_DATE                  NUMBER   (5)
,ATS                           NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE UTELETVT' " " from dual;
create table   GARLAND.UTELETVT
(
 MSLINK                        NUMBER   (22) not null
,TRANVLT_ID                    VARCHAR2 (20)
,MAPID                         NUMBER   (10)
,META_ID                       VARCHAR2 (20)
,MEDIA_ID                      VARCHAR2 (20)
,COORD_ID                      VARCHAR2 (20) not null
,DISPOSTN_D                    VARCHAR2 (16)
,NO_TRANS                      NUMBER   (5)
,MANUF_ID                      VARCHAR2 (16)
,MODEL_NO                      VARCHAR2 (12)
,SERIAL_NO                     VARCHAR2 (15)
,SUBSTA_ID                     VARCHAR2 (20)
,INSTLN_ID                     VARCHAR2 (20)
,PROJECT_ID                    VARCHAR2 (20)
,EVENT_ID                      VARCHAR2 (20)
,NARRATIVE                     VARCHAR2 (240)
,USER_FLAG                     VARCHAR2 (20)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE UTSANMH' " " from dual;
create table   GARLAND.UTSANMH
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,MANHOLE_ID                    VARCHAR2 (15)
,MAP_GRID                      VARCHAR2 (3)
,MAP_QUAD                      VARCHAR2 (1)
,MANHOLE_NUM                   NUMBER   (5)
,MANHOLE_SIZE                  NUMBER   (5)
,BASIN                         VARCHAR2 (20)
,SUB_BASIN                     VARCHAR2 (5)
,SUB_SUBBASIN                  VARCHAR2 (5)
,UPSTREAM_NODE                 VARCHAR2 (15)
,DNSTREAM_NODE                 VARCHAR2 (15)
,ASBUILT_DATE                  NUMBER   (5)
,ATS                           NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE UTSANFIT' " " from dual;
create table   GARLAND.UTSANFIT
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,FITTING_ID                    VARCHAR2 (15)
,FITTING_CODE                  VARCHAR2 (2)
,MAP_GRID                      VARCHAR2 (3)
,MAP_QUAD                      VARCHAR2 (1)
,FITTING_NUM                   NUMBER   (5)
,FITTING_NAME                  VARCHAR2 (15)
,FITTING_SIZE                  NUMBER   (5)
,BASIN                         VARCHAR2 (20)
,SUB_BASIN                     VARCHAR2 (5)
,SUB_SUBBASIN                  VARCHAR2 (5)
,UPSTREAM_NODE                 VARCHAR2 (15)
,DNSTREAM_NODE                 VARCHAR2 (15)
,ASBUILT_DATE                  NUMBER   (5)
,ATS                           NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE UTWATVLV' " " from dual;
create table   GARLAND.UTWATVLV
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,VALVE_ID                      VARCHAR2 (12)
,VALVE_TYPE                    VARCHAR2 (10)
,VALVE_SIZE                    NUMBER   (5)
,VALVE_USE                     VARCHAR2 (16)
,VALVE_STATUS                  VARCHAR2 (6)
,MAP_GRID                      NUMBER   (5)
,MAP_QUAD                      VARCHAR2 (1)
,VALVE_NUM                     NUMBER   (5)
,X_COORD                       NUMBER   (22)
,Y_COORD                       NUMBER   (22)
,UP_NODE_ID                    VARCHAR2 (12)
,DOWN_NODE_ID                  VARCHAR2 (12)
,STRUCTURE_TYPE                VARCHAR2 (10)
,STRUCTURE_ID                  VARCHAR2 (12)
,FIT_WIDTH                     FLOAT    (21)
,FIT_LENGTH                    FLOAT    (21)
,MANUFACTURER                  VARCHAR2 (20)
,ASBUILT_DATE                  DATE     
,OWNER                         VARCHAR2 (20)
,OWNER_STATUS                  VARCHAR2 (8)
,CONTRACTOR                    VARCHAR2 (20)
,PROJECT_NAME                  VARCHAR2 (20)
,CONTRACT_NUM                  VARCHAR2 (20)
,LINE_NUM                      VARCHAR2 (12)
,ZONE                          VARCHAR2 (4)
,SUB_BASIN                     VARCHAR2 (6)
,SUB_SUBBASIN                  VARCHAR2 (6)
,FLOWLINE_ELEV                 NUMBER   (3,2)
,GROUND_ELEV                   NUMBER   (3,2)
,PRESSURE_NORMAL               FLOAT    (21)
,PRESSURE_MAX                  FLOAT    (21)
,PRESSURE_SOURCE               VARCHAR2 (10)
,REPAIR_DATE                   DATE     
,WORK_ORDER_NUM                VARCHAR2 (10)
,INSPECT_DATE                  DATE     
,DATA_SOURCE                   VARCHAR2 (24)
,USER_FLAG                     NUMBER   (5)
,POST_MODE                     VARCHAR2 (1)
,DATE_ADD                      DATE     
,MATERIAL                      VARCHAR2 (6)
,CLASS                         VARCHAR2 (6)
,ATS                           NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 3M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE UTWATHYD' " " from dual;
create table   GARLAND.UTWATHYD
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,HYDRANT_ID                    VARCHAR2 (12)
,HYDRANT_TYPE                  VARCHAR2 (10)
,HYDRANT_MATERIAL              VARCHAR2 (10)
,MAP_QUAD                      VARCHAR2 (1)
,MAP_GRID                      NUMBER   (5)
,HYDRANT_NUM                   NUMBER   (5)
,X_COORD                       NUMBER   (22)
,Y_COORD                       NUMBER   (22)
,VALVE_ID                      VARCHAR2 (12)
,FLOWLINE_ELEV                 NUMBER   (3,2)
,GROUND_ELEV                   NUMBER   (3,2)
,MANUFACTURER                  VARCHAR2 (20)
,ASBUILT_DATE                  NUMBER   (22)
,HYDRANT_STATUS                VARCHAR2 (10)
,HYDRANT_OWNER                 VARCHAR2 (16)
,OWNER_STATUS                  VARCHAR2 (8)
,CONTRACTOR                    VARCHAR2 (20)
,PROJECT_NAME                  VARCHAR2 (20)
,CONTRACT_NUM                  VARCHAR2 (20)
,LINE_NUM                      VARCHAR2 (12)
,ZONE                          VARCHAR2 (4)
,SUB_BASIN                     VARCHAR2 (6)
,SUB_SUB_BASIN                 VARCHAR2 (6)
,PRESSURE_STATIC               NUMBER   (22)
,PRESSURE_MAX                  NUMBER   (22)
,PRESSURE_FLOWTEST             VARCHAR2 (20)
,PRESSURE_TEST_DATE            DATE     
,REQ_FLOW_RATE                 NUMBER   (22)
,REPAIR_DATE                   DATE     
,WORK_ORDER_NUM                VARCHAR2 (12)
,INSPECT_DATE                  DATE     
,DATA_SOURCE                   VARCHAR2 (24)
,USER_FLAG                     NUMBER   (5)
,POST_MODE                     VARCHAR2 (1)
,DATE_ADD                      DATE     
,LINE_SIZE                     NUMBER   (5)
,ATS                           NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE UTWATFIT' " " from dual;
create table   GARLAND.UTWATFIT
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,FITTING_ID                    VARCHAR2 (12)
,FITTING_TYPE                  VARCHAR2 (10)
,FITTING_SIZE                  NUMBER   (22)
,FITTING_WIDTH                 NUMBER   (22)
,FITTING_LENGTH                NUMBER   (22)
,MATERIAL                      VARCHAR2 (6)
,CLASS                         VARCHAR2 (6)
,STRUCTURE_TYPE                VARCHAR2 (10)
,STRUCTURE_ID                  VARCHAR2 (12)
,FITTING_USE                   VARCHAR2 (16)
,FITTING_STATUS                VARCHAR2 (6)
,MAP_GRID                      NUMBER   (5)
,MAP_QUAD                      VARCHAR2 (1)
,FITTING_NUM                   NUMBER   (5)
,X_COORD                       NUMBER   (22)
,Y_COORD                       NUMBER   (22)
,UP_NODE_ID                    VARCHAR2 (12)
,DOWN_NODE_ID                  VARCHAR2 (12)
,MANUFACTURER                  VARCHAR2 (20)
,ASBUILT_DATE                  DATE     
,OWNER                         VARCHAR2 (20)
,OWNER_STATUS                  VARCHAR2 (8)
,CONTRACTOR                    VARCHAR2 (20)
,CONTRACT_NUM                  VARCHAR2 (20)
,LINE_NUM                      VARCHAR2 (12)
,ZONE                          VARCHAR2 (4)
,SUB_BASIN                     VARCHAR2 (6)
,SUB_SUBBASIN                  VARCHAR2 (6)
,FLOWLINE_ELEV                 NUMBER   (3,2)
,GROUND_ELEV                   NUMBER   (3,2)
,PRESSURE_NORMAL               NUMBER   (22)
,PRESSURE_MAX                  NUMBER   (22)
,PRESSURE_SOURCE               VARCHAR2 (10)
,REPAIR_DATE                   DATE     
,WORK_ORDER_NUM                VARCHAR2 (10)
,INSPECTION_DATE               DATE     
,DATA_SOURCE                   VARCHAR2 (24)
,USER_FLAG                     NUMBER   (5)
,POST_MODE                     VARCHAR2 (1)
,DATE_ADD                      DATE     
,ATS                           NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE UTSTOPIP' " " from dual;
create table   GARLAND.UTSTOPIP
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,PIPE_TYPE                     VARCHAR2 (2)
,PIPE_DESC                     VARCHAR2 (20)
,GENERAL_DESC                  VARCHAR2 (20)
,PIPE_SIZE                     NUMBER   (5)

,PIPE_LENGTH                   NUMBER   (5)
,QUANTITY                      NUMBER   (5)
,BOXWIDE                       NUMBER   (5)
,BOXTALL                       NUMBER   (5)
,YEAR_BLT                      NUMBER   (5)
,FLAG                          NUMBER   (5)
,PIPE_ID                       VARCHAR2 (12)
,MAP_GRID                      NUMBER   (5)
,MAP_QUAD                      VARCHAR2 (1)
,PIPE_NUM                      NUMBER   (5)
,PIPE_LENGTH1                  NUMBER   (8,2)
,ATS                           NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE UTSTOOCH' " " from dual;
create table   GARLAND.UTSTOOCH
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,CHANNEL_TYPE                  VARCHAR2 (2)
,CHANNEL_DESC                  VARCHAR2 (20)
,GENERAL_DESC                  VARCHAR2 (20)
,CHANNEL_SIZE                  NUMBER   (5)
,CHANNEL_LENGTH                NUMBER   (5)
,QUANTITY                      NUMBER   (5)
,BOXWIDE                       NUMBER   (5)
,BOXTALL                       NUMBER   (10)
,YEAR_BLT                      NUMBER   (5)
,FLAG                          NUMBER   (5)
,CHANNEL_ID                    VARCHAR2 (12)
,MAP_GRID                      NUMBER   (5)
,MAP_QUAD                      VARCHAR2 (1)
,CHANNEL_NUM                   NUMBER   (5)
,PIPE_LENGTH1                  FLOAT    (21)
,ATS                           NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE UTSTOMDU' " " from dual;
create table   GARLAND.UTSTOMDU
(
 PARCEL_ID                     VARCHAR2 (12) not null
,ACCOUNT                       NUMBER   (10) not null
,POLYAREA                      FLOAT    (21)
,TOT_IMPER                     FLOAT    (21)
,PER_IMPER                     NUMBER   (5,2)
,IND_IMPER                     FLOAT    (21)
,FEE                           NUMBER   (7,2)
,ADDR_NUM                      VARCHAR2 (14)
,ADDR_PFX                      VARCHAR2 (1)
,ADDR_NAME                     VARCHAR2 (40)
,ADDR_TYPE                     VARCHAR2 (4)
,CUSTOMER                      VARCHAR2 (40)
,MSLINK                        NUMBER   (10)
,MAPID                         NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE UTSTOINL' " " from dual;
create table   GARLAND.UTSTOINL
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,INLET_ID                      VARCHAR2 (12)
,INLET_CODE                    VARCHAR2 (2)
,MAP_GRID                      VARCHAR2 (3)
,MAP_QUAD                      VARCHAR2 (1)
,INLET_NUM                     NUMBER   (5)
,INLET_TYPE                    VARCHAR2 (30)
,INLET_SIZE                    NUMBER   (5,2)
,ASBUILT_DATE                  NUMBER   (5)
,ATS                           NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE UTSTOCOM' " " from dual;
create table   GARLAND.UTSTOCOM
(
 PARCEL_ID                     VARCHAR2 (12) not null
,ACCOUNT                       NUMBER   (10) not null
,POLYAREA                      FLOAT    (21)
,ADDR_NUM                      VARCHAR2 (6)
,ADDR_PFX                      VARCHAR2 (1)
,ADDR_NAME                     VARCHAR2 (40)
,ADDR_TYPE                     VARCHAR2 (4)
,CUSTOMER                      VARCHAR2 (40)
,ZIPCODE                       NUMBER   (10)
,TOT_IMPER                     FLOAT    (21)
,FEE                           NUMBER   (5,2)
,MSLINK                        NUMBER   (10)
,MAPID                         NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE UTSANPIP' " " from dual;
create table   GARLAND.UTSANPIP
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,PIPE_DIAMETER                 NUMBER   (5)
,PIPE_LENGTH                   NUMBER   (5)
,PIPE_MATERIAL                 VARCHAR2 (15)
,PIPE_TYPE                     VARCHAR2 (20)
,PIPE_CLASS                    VARCHAR2 (20)
,PIPE_USE                      VARCHAR2 (8)
,PIPE_MANUFACTURER             VARCHAR2 (20)
,MODELED                       VARCHAR2 (1)
,IDM                           NUMBER   (5,2)
,BASIN                         VARCHAR2 (20)
,SUB_BASIN                     VARCHAR2 (15)
,SUB_SUBBASIN                  VARCHAR2 (15)
,UP_NODE_ID                    VARCHAR2 (15)
,UP_NODE_TYPE                  VARCHAR2 (2)
,DN_NODE_ID                    VARCHAR2 (15)
,DN_NODE_TYPE                  VARCHAR2 (2)
,UP_BASIN_ID                   VARCHAR2 (20)
,UP_SUB_BASIN_ID               VARCHAR2 (20)
,UP_NODE_XCOORD                NUMBER   (11,3)
,UP_NODE_YCOORD                NUMBER   (11,3)
,UP_NODE_ELEV                  NUMBER   (5,2)
,UP_NODE_GRND_ELEV             NUMBER   (5,2)
,DN_BASIN_ID                   VARCHAR2 (20)
,DN_SUB_BASIN_ID               VARCHAR2 (20)
,DN_NODE_XCOORD                NUMBER   (11,3)
,DN_NODE_YCOORD                NUMBER   (11,3)
,DN_NODE_ELEV                  NUMBER   (5,2)
,DN_NODE_GRND_ELEV             NUMBER   (5,2)
,SLOPE                         NUMBER   (5,2)
,ASBUILT_DATE                  NUMBER   (5)
,PIPE_LENGTH1                  FLOAT    (21)
,PIPE_ID                       VARCHAR2 (12)
,MAP_GRID                      NUMBER   (5)
,MAP_QUAD                      VARCHAR2 (1)
,PIPE_NUM                      NUMBER   (5)
,ATS                           NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 4M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE ADRRESULT_UMS_LOCATION' " " from dual;
create table   GARLAND.ADRRESULT_UMS_LOCATION
(
 ADDR_NUM                      VARCHAR2 (20)
,ADDR_PFX                      VARCHAR2 (10)
,ADDR_NAME                     VARCHAR2 (40)
,ADDR_TYPE                     VARCHAR2 (10)
,ADDR_SFX                      VARCHAR2 (10)
,ADDR_CODE1                    VARCHAR2 (10)
,ADDR_UNIT1                    VARCHAR2 (20)
,ADDR_CODE2                    VARCHAR2 (10)
,ADDR_UNIT2                    VARCHAR2 (20)
,VERIFY_CODE                   VARCHAR2 (2)
,DO_PARSE                      VARCHAR2 (30)
,DO_ALIAS                      VARCHAR2 (5)
,DO_NAME                       VARCHAR2 (1)
,DO_QUAL                       VARCHAR2 (20)
,REC_SEQ                       NUMBER   (22)
,REC_ROWID                     ROWID    
,REC_KEY                       VARCHAR2 (20)
,PARCEL_ID                     VARCHAR2 (12)
,SEGMENT_ID                    VARCHAR2 (5)
,FORM_PFX                      VARCHAR2 (2)
,FORM_NAME                     VARCHAR2 (30)
,FORM_TYPE                     VARCHAR2 (4)
,FORM_SFX                      VARCHAR2 (2)
,FORM_CODE1                    VARCHAR2 (6)
,FORM_UNIT1                    VARCHAR2 (20)
,FORM_CODE2                    VARCHAR2 (6)
,FORM_UNIT2                    VARCHAR2 (20)
,APPL_PFX                      VARCHAR2 (10)
,APPL_NAME                     VARCHAR2 (80)
,APPL_TYPE                     VARCHAR2 (10)
,APPL_SFX                      VARCHAR2 (10)
,APPL_CODE1                    VARCHAR2 (10)
,APPL_UNIT1                    VARCHAR2 (20)
,APPL_CODE2                    VARCHAR2 (10)
,APPL_UNIT2                    VARCHAR2 (20)
,APPL_NUM                      VARCHAR2 (20)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 21M next 3M pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;

 
select 'CREATE BLOCK_SIDE' " " from dual;
create table   GARLAND.BLOCK_SIDE
(
 ADDR_PFX                      VARCHAR2 (2) not null
,ADDR_NAME                     VARCHAR2 (30) not null
,ADDR_TYPE                     VARCHAR2 (4) not null
,ADDR_SFX                      VARCHAR2 (2) not null
,ADDR_BLOCK                    NUMBER   (22) not null
,ADDR_PARITY                   NUMBER   (22) not null
,BLOCK_ID                      NUMBER   (22)
,ZIP_CODE                      VARCHAR2 (5)
,SUBDIV_ID                     VARCHAR2 (5)
,COUNCIL_ID                    VARCHAR2 (1)
,CODE_INSPECT_AREA             VARCHAR2 (2)
,FIRE_DISTRICT                 VARCHAR2 (1)
,POLICE_BEAT                   NUMBER   (3)
,POLICE_DISTRICT               VARCHAR2 (3)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 2M next 1M pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;

 
select 'CREATE ADRSTREET_SNAP' " " from dual;
create table   GARLAND.ADRSTREET_SNAP
(
 ADDR_PFX                      VARCHAR2 (2) not null
,ADDR_NAME                     VARCHAR2 (30) not null
,ADDR_TYPE                     VARCHAR2 (4) not null
,ADDR_SFX                      VARCHAR2 (2) not null
,STREET_ID                     NUMBER   (8)
,ADDR_COMPRESS                 VARCHAR2 (30)
,ADDR_COMPACT                  VARCHAR2 (30)
,ADDR_REDUCED                  VARCHAR2 (30)
,ADDR_BEGIN                    VARCHAR2 (30)
,ADDR_ENDING                   VARCHAR2 (30)
,ADDR_SOUNDEX                  VARCHAR2 (20)
,ADDR_PERMUTE                  NUMBER   (22)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 2M next 1M pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;

 
select 'CREATE CDRELPAR' " " from dual;
create table   GARLAND.CDRELPAR
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
,PARCEL_ID                     VARCHAR2 (11) not null
,TAX_ACCT                      VARCHAR2 (17)
,SUBDIV_ID                     VARCHAR2 (5)
,COUNCIL_ID                    VARCHAR2 (1)
,POLICE_BEAT                   NUMBER   (3)
,ZIP_CODE                      VARCHAR2 (5)
,CODE_INSPECT_AREA             VARCHAR2 (2)
,FIRE_DISTRICT                 VARCHAR2 (1)
,ANIMAL_CONTROL                VARCHAR2 (1)
,POLICE_DISTRICT               VARCHAR2 (2)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 7M next 1M pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;

 
select 'CREATE EXCEPTIONS' " " from dual;
create table   GARLAND.EXCEPTIONS
(
 ROW_ID                        ROWID    
,OWNER                         VARCHAR2 (30)
,TABLE_NAME                    VARCHAR2 (30)
,CONSTRAINT                    VARCHAR2 (30)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;

 
select 'CREATE ADDRESS_UNIT' " " from dual;
create table   GARLAND.ADDRESS_UNIT
(
 ADDR_NUM                      NUMBER   (22) not null
,ADDR_PFX                      VARCHAR2 (2) not null
,ADDR_NAME                     VARCHAR2 (20) not null
,ADDR_TYPE                     VARCHAR2 (4) not null
,ADDR_SFX                      VARCHAR2 (2) not null
,ADDR_BLDG1                    VARCHAR2 (10) not null
,ADDR_UNIT1                    VARCHAR2 (10) not null
,ADDR_BLDG2                    VARCHAR2 (10) not null
,ADDR_UNIT2                    VARCHAR2 (10) not null
,X_COORD                       NUMBER   (22)
,Y_COORD                       NUMBER   (22)
,PARCEL_ID                     VARCHAR2 (11)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 2M next 1M pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;

 
select 'CREATE TSSDS' " " from dual;
create table   GARLAND.TSSDS
(
 REC_SEQ                       NUMBER   (22)
,REC_TYPE                      VARCHAR2 (8)
,TABLE_NAME                    VARCHAR2 (8)
,FIELD_NAME                    VARCHAR2 (20)
,FIELD_TYPE                    VARCHAR2 (1)
,FIELD_LENGTH                  NUMBER   (22)
,FIELD_DOMAIN                  VARCHAR2 (20)
,FIELD_KEY                     VARCHAR2 (20)
,FIELD_DESCRIBE                VARCHAR2 (400)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;

 
select 'CREATE GIS_TEMP1' " " from dual;
create table   GARLAND.GIS_TEMP1
(
 ITEM01                        VARCHAR2 (1000)
,ITEM02                        VARCHAR2 (2000)
,ITEM03                        VARCHAR2 (2000)
,ITEM04                        VARCHAR2 (2000)
,ITEM05                        VARCHAR2 (2000)
,ITEM06                        VARCHAR2 (2000)
,ITEM07                        VARCHAR2 (2000)
,ITEM08                        VARCHAR2 (2000)
,ITEM09                        VARCHAR2 (2000)
,ITEM10                        VARCHAR2 (2000)
,ITEM11                        VARCHAR2 (2000)
,ITEM12                        VARCHAR2 (2000)
,ITEM13                        VARCHAR2 (2000)
,ITEM14                        VARCHAR2 (2000)
,ITEM15                        VARCHAR2 (2000)
,ITEM16                        VARCHAR2 (2000)
,ITEM17                        VARCHAR2 (2000)
,ITEM18                        VARCHAR2 (2000)
,ITEM19                        VARCHAR2 (2000)
,ITEM20                        VARCHAR2 (2000)
,ITEM21                        VARCHAR2 (2000)
,ITEM22                        VARCHAR2 (2000)
,ITEM23                        VARCHAR2 (2000)
,ITEM24                        VARCHAR2 (2000)
,ITEM25                        VARCHAR2 (2000)
,ITEM26                        VARCHAR2 (2000)
,ITEM27                        VARCHAR2 (2000)
,ITEM28                        VARCHAR2 (2000)
,ITEM29                        VARCHAR2 (2000)
,ITEM30                        VARCHAR2 (2000)
,ITEM31                        VARCHAR2 (2000)
,ITEM32                        VARCHAR2 (2000)
,ITEM33                        VARCHAR2 (2000)
,ITEM34                        VARCHAR2 (2000)
,ITEM35                        VARCHAR2 (2000)
,ITEM36                        VARCHAR2 (2000)
,ITEM37                        VARCHAR2 (2000)
,ITEM38                        VARCHAR2 (2000)
,ITEM39                        VARCHAR2 (2000)
,ITEM40                        VARCHAR2 (2000)
,ITEM41                        VARCHAR2 (2000)
,ITEM42                        VARCHAR2 (2000)
,ITEM43                        VARCHAR2 (2000)
,ITEM44                        VARCHAR2 (2000)
,ITEM45                        VARCHAR2 (2000)
,ITEM46                        VARCHAR2 (2000)
,ITEM47                        VARCHAR2 (2000)
,ITEM48                        VARCHAR2 (2000)
,ITEM49                        VARCHAR2 (2000)
,ITEM50                        VARCHAR2 (2000)
,ITEM51                        VARCHAR2 (2000)
,ITEM52                        VARCHAR2 (2000)
,ITEM53                        VARCHAR2 (2000)
,ITEM54                        VARCHAR2 (2000)
,ITEM55                        VARCHAR2 (2000)
,ITEM56                        VARCHAR2 (2000)
,ITEM57                        VARCHAR2 (2000)
,ITEM58                        VARCHAR2 (2000)
,ITEM59                        VARCHAR2 (2000)
,ITEM60                        VARCHAR2 (2000)
,ITEM61                        VARCHAR2 (2000)
,ITEM62                        VARCHAR2 (2000)
,ITEM63                        VARCHAR2 (2000)
,ITEM64                        VARCHAR2 (2000)
,ITEM65                        VARCHAR2 (2000)
,ITEM66                        VARCHAR2 (2000)
,ITEM67                        VARCHAR2 (2000)
,ITEM68                        VARCHAR2 (2000)
,ITEM69                        VARCHAR2 (2000)
,ITEM70                        VARCHAR2 (2000)
,ITEM71                        VARCHAR2 (2000)
,ITEM72                        VARCHAR2 (2000)
,ITEM73                        VARCHAR2 (2000)
,ITEM74                        VARCHAR2 (2000)
,ITEM75                        VARCHAR2 (2000)
,ITEM76                        VARCHAR2 (2000)
,ITEM77                        VARCHAR2 (2000)
,ITEM78                        VARCHAR2 (2000)
,ITEM79                        VARCHAR2 (2000)
,ITEM80                        VARCHAR2 (2000)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 11M next 2M pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;

 
select 'CREATE GIS_TEMP2' " " from dual;
create table   GARLAND.GIS_TEMP2
(
 ITEM01                        VARCHAR2 (1000)
,ITEM02                        VARCHAR2 (2000)
,ITEM03                        VARCHAR2 (2000)
,ITEM04                        VARCHAR2 (2000)
,ITEM05                        VARCHAR2 (2000)
,ITEM06                        VARCHAR2 (2000)
,ITEM07                        VARCHAR2 (2000)
,ITEM08                        VARCHAR2 (2000)
,ITEM09                        VARCHAR2 (2000)
,ITEM10                        VARCHAR2 (2000)
,ITEM11                        VARCHAR2 (2000)
,ITEM12                        VARCHAR2 (2000)
,ITEM13                        VARCHAR2 (2000)
,ITEM14                        VARCHAR2 (2000)
,ITEM15                        VARCHAR2 (2000)
,ITEM16                        VARCHAR2 (2000)
,ITEM17                        VARCHAR2 (2000)
,ITEM18                        VARCHAR2 (2000)
,ITEM19                        VARCHAR2 (2000)
,ITEM20                        VARCHAR2 (2000)
,ITEM21                        VARCHAR2 (2000)
,ITEM22                        VARCHAR2 (2000)
,ITEM23                        VARCHAR2 (2000)
,ITEM24                        VARCHAR2 (2000)
,ITEM25                        VARCHAR2 (2000)
,ITEM26                        VARCHAR2 (2000)
,ITEM27                        VARCHAR2 (2000)
,ITEM28                        VARCHAR2 (2000)
,ITEM29                        VARCHAR2 (2000)
,ITEM30                        VARCHAR2 (2000)
,ITEM31                        VARCHAR2 (2000)
,ITEM32                        VARCHAR2 (2000)
,ITEM33                        VARCHAR2 (2000)
,ITEM34                        VARCHAR2 (2000)
,ITEM35                        VARCHAR2 (2000)
,ITEM36                        VARCHAR2 (2000)
,ITEM37                        VARCHAR2 (2000)
,ITEM38                        VARCHAR2 (2000)
,ITEM39                        VARCHAR2 (2000)
,ITEM40                        VARCHAR2 (2000)
,ITEM41                        VARCHAR2 (2000)
,ITEM42                        VARCHAR2 (2000)
,ITEM43                        VARCHAR2 (2000)
,ITEM44                        VARCHAR2 (2000)
,ITEM45                        VARCHAR2 (2000)
,ITEM46                        VARCHAR2 (2000)
,ITEM47                        VARCHAR2 (2000)
,ITEM48                        VARCHAR2 (2000)
,ITEM49                        VARCHAR2 (2000)
,ITEM50                        VARCHAR2 (2000)
,ITEM51                        VARCHAR2 (2000)
,ITEM52                        VARCHAR2 (2000)
,ITEM53                        VARCHAR2 (2000)
,ITEM54                        VARCHAR2 (2000)
,ITEM55                        VARCHAR2 (2000)
,ITEM56                        VARCHAR2 (2000)
,ITEM57                        VARCHAR2 (2000)
,ITEM58                        VARCHAR2 (2000)
,ITEM59                        VARCHAR2 (2000)
,ITEM60                        VARCHAR2 (2000)
,ITEM61                        VARCHAR2 (2000)
,ITEM62                        VARCHAR2 (2000)
,ITEM63                        VARCHAR2 (2000)
,ITEM64                        VARCHAR2 (2000)
,ITEM65                        VARCHAR2 (2000)
,ITEM66                        VARCHAR2 (2000)
,ITEM67                        VARCHAR2 (2000)
,ITEM68                        VARCHAR2 (2000)
,ITEM69                        VARCHAR2 (2000)
,ITEM70                        VARCHAR2 (2000)
,ITEM71                        VARCHAR2 (2000)
,ITEM72                        VARCHAR2 (2000)
,ITEM73                        VARCHAR2 (2000)
,ITEM74                        VARCHAR2 (2000)
,ITEM75                        VARCHAR2 (2000)
,ITEM76                        VARCHAR2 (2000)
,ITEM77                        VARCHAR2 (2000)
,ITEM78                        VARCHAR2 (2000)
,ITEM79                        VARCHAR2 (2000)
,ITEM80                        VARCHAR2 (2000)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 6M next 1M pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;

 
select 'CREATE GIS_TEMP3' " " from dual;
create table   GARLAND.GIS_TEMP3
(
 ITEM01                        VARCHAR2 (1000)
,ITEM02                        VARCHAR2 (2000)
,ITEM03                        VARCHAR2 (2000)
,ITEM04                        VARCHAR2 (2000)
,ITEM05                        VARCHAR2 (2000)
,ITEM06                        VARCHAR2 (2000)
,ITEM07                        VARCHAR2 (2000)
,ITEM08                        VARCHAR2 (2000)
,ITEM09                        VARCHAR2 (2000)
,ITEM10                        VARCHAR2 (2000)
,ITEM11                        VARCHAR2 (2000)
,ITEM12                        VARCHAR2 (2000)
,ITEM13                        VARCHAR2 (2000)
,ITEM14                        VARCHAR2 (2000)
,ITEM15                        VARCHAR2 (2000)
,ITEM16                        VARCHAR2 (2000)
,ITEM17                        VARCHAR2 (2000)
,ITEM18                        VARCHAR2 (2000)
,ITEM19                        VARCHAR2 (2000)
,ITEM20                        VARCHAR2 (2000)
,ITEM21                        VARCHAR2 (2000)
,ITEM22                        VARCHAR2 (2000)
,ITEM23                        VARCHAR2 (2000)
,ITEM24                        VARCHAR2 (2000)
,ITEM25                        VARCHAR2 (2000)
,ITEM26                        VARCHAR2 (2000)
,ITEM27                        VARCHAR2 (2000)
,ITEM28                        VARCHAR2 (2000)
,ITEM29                        VARCHAR2 (2000)
,ITEM30                        VARCHAR2 (2000)
,ITEM31                        VARCHAR2 (2000)
,ITEM32                        VARCHAR2 (2000)
,ITEM33                        VARCHAR2 (2000)
,ITEM34                        VARCHAR2 (2000)
,ITEM35                        VARCHAR2 (2000)
,ITEM36                        VARCHAR2 (2000)
,ITEM37                        VARCHAR2 (2000)
,ITEM38                        VARCHAR2 (2000)
,ITEM39                        VARCHAR2 (2000)
,ITEM40                        VARCHAR2 (2000)
,ITEM41                        VARCHAR2 (2000)
,ITEM42                        VARCHAR2 (2000)
,ITEM43                        VARCHAR2 (2000)
,ITEM44                        VARCHAR2 (2000)
,ITEM45                        VARCHAR2 (2000)
,ITEM46                        VARCHAR2 (2000)
,ITEM47                        VARCHAR2 (2000)
,ITEM48                        VARCHAR2 (2000)
,ITEM49                        VARCHAR2 (2000)
,ITEM50                        VARCHAR2 (2000)
,ITEM51                        VARCHAR2 (2000)
,ITEM52                        VARCHAR2 (2000)
,ITEM53                        VARCHAR2 (2000)
,ITEM54                        VARCHAR2 (2000)
,ITEM55                        VARCHAR2 (2000)
,ITEM56                        VARCHAR2 (2000)
,ITEM57                        VARCHAR2 (2000)
,ITEM58                        VARCHAR2 (2000)
,ITEM59                        VARCHAR2 (2000)
,ITEM60                        VARCHAR2 (2000)
,ITEM61                        VARCHAR2 (2000)
,ITEM62                        VARCHAR2 (2000)
,ITEM63                        VARCHAR2 (2000)
,ITEM64                        VARCHAR2 (2000)
,ITEM65                        VARCHAR2 (2000)
,ITEM66                        VARCHAR2 (2000)
,ITEM67                        VARCHAR2 (2000)
,ITEM68                        VARCHAR2 (2000)
,ITEM69                        VARCHAR2 (2000)
,ITEM70                        VARCHAR2 (2000)
,ITEM71                        VARCHAR2 (2000)
,ITEM72                        VARCHAR2 (2000)
,ITEM73                        VARCHAR2 (2000)
,ITEM74                        VARCHAR2 (2000)
,ITEM75                        VARCHAR2 (2000)
,ITEM76                        VARCHAR2 (2000)
,ITEM77                        VARCHAR2 (2000)
,ITEM78                        VARCHAR2 (2000)
,ITEM79                        VARCHAR2 (2000)
,ITEM80                        VARCHAR2 (2000)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 6M next 1M pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;

 
select 'CREATE GIS_TEMP4' " " from dual;
create table   GARLAND.GIS_TEMP4
(
 ITEM01                        VARCHAR2 (1000)
,ITEM02                        VARCHAR2 (2000)
,ITEM03                        VARCHAR2 (2000)
,ITEM04                        VARCHAR2 (2000)
,ITEM05                        VARCHAR2 (2000)
,ITEM06                        VARCHAR2 (2000)
,ITEM07                        VARCHAR2 (2000)
,ITEM08                        VARCHAR2 (2000)
,ITEM09                        VARCHAR2 (2000)
,ITEM10                        VARCHAR2 (2000)
,ITEM11                        VARCHAR2 (2000)
,ITEM12                        VARCHAR2 (2000)
,ITEM13                        VARCHAR2 (2000)
,ITEM14                        VARCHAR2 (2000)
,ITEM15                        VARCHAR2 (2000)
,ITEM16                        VARCHAR2 (2000)
,ITEM17                        VARCHAR2 (2000)
,ITEM18                        VARCHAR2 (2000)
,ITEM19                        VARCHAR2 (2000)
,ITEM20                        VARCHAR2 (2000)
,ITEM21                        VARCHAR2 (2000)
,ITEM22                        VARCHAR2 (2000)
,ITEM23                        VARCHAR2 (2000)
,ITEM24                        VARCHAR2 (2000)
,ITEM25                        VARCHAR2 (2000)
,ITEM26                        VARCHAR2 (2000)
,ITEM27                        VARCHAR2 (2000)
,ITEM28                        VARCHAR2 (2000)
,ITEM29                        VARCHAR2 (2000)
,ITEM30                        VARCHAR2 (2000)
,ITEM31                        VARCHAR2 (2000)
,ITEM32                        VARCHAR2 (2000)
,ITEM33                        VARCHAR2 (2000)
,ITEM34                        VARCHAR2 (2000)
,ITEM35                        VARCHAR2 (2000)
,ITEM36                        VARCHAR2 (2000)
,ITEM37                        VARCHAR2 (2000)
,ITEM38                        VARCHAR2 (2000)
,ITEM39                        VARCHAR2 (2000)
,ITEM40                        VARCHAR2 (2000)
,ITEM41                        VARCHAR2 (2000)
,ITEM42                        VARCHAR2 (2000)
,ITEM43                        VARCHAR2 (2000)
,ITEM44                        VARCHAR2 (2000)
,ITEM45                        VARCHAR2 (2000)
,ITEM46                        VARCHAR2 (2000)
,ITEM47                        VARCHAR2 (2000)
,ITEM48                        VARCHAR2 (2000)
,ITEM49                        VARCHAR2 (2000)
,ITEM50                        VARCHAR2 (2000)
,ITEM51                        VARCHAR2 (2000)
,ITEM52                        VARCHAR2 (2000)
,ITEM53                        VARCHAR2 (2000)
,ITEM54                        VARCHAR2 (2000)
,ITEM55                        VARCHAR2 (2000)
,ITEM56                        VARCHAR2 (2000)
,ITEM57                        VARCHAR2 (2000)
,ITEM58                        VARCHAR2 (2000)
,ITEM59                        VARCHAR2 (2000)
,ITEM60                        VARCHAR2 (2000)
,ITEM61                        VARCHAR2 (2000)
,ITEM62                        VARCHAR2 (2000)
,ITEM63                        VARCHAR2 (2000)
,ITEM64                        VARCHAR2 (2000)
,ITEM65                        VARCHAR2 (2000)
,ITEM66                        VARCHAR2 (2000)
,ITEM67                        VARCHAR2 (2000)
,ITEM68                        VARCHAR2 (2000)
,ITEM69                        VARCHAR2 (2000)
,ITEM70                        VARCHAR2 (2000)
,ITEM71                        VARCHAR2 (2000)
,ITEM72                        VARCHAR2 (2000)
,ITEM73                        VARCHAR2 (2000)
,ITEM74                        VARCHAR2 (2000)
,ITEM75                        VARCHAR2 (2000)
,ITEM76                        VARCHAR2 (2000)
,ITEM77                        VARCHAR2 (2000)
,ITEM78                        VARCHAR2 (2000)
,ITEM79                        VARCHAR2 (2000)
,ITEM80                        VARCHAR2 (2000)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 6M next 1M pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;


