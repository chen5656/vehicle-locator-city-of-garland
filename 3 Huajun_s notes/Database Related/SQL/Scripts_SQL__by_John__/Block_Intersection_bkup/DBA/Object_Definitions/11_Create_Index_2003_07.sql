
 
select 'GIS_TEMP4_ITEM01' " " from dual;
create index   GARLAND.GIS_TEMP4_ITEM01
       on      GARLAND.GIS_TEMP4
(
 ITEM01
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 5M next 1M   pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;
 
 
select 'GIS_TEMP3_ITEM01' " " from dual;
create index   GARLAND.GIS_TEMP3_ITEM01
       on      GARLAND.GIS_TEMP3
(
 ITEM01
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 2M next 1M   pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;
 
 
select 'GIS_TEMP2_ITEM01' " " from dual;
create index   GARLAND.GIS_TEMP2_ITEM01
       on      GARLAND.GIS_TEMP2
(
 ITEM01
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 2M next 1M   pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;
 
 
select 'GIS_TEMP1_ITEM01' " " from dual;
create index   GARLAND.GIS_TEMP1_ITEM01
       on      GARLAND.GIS_TEMP1
(
 ITEM01
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 3M next 1M   pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;
 
 
select 'UTWAPIP_MSLINK' " " from dual;
create index   GARLAND.UTWAPIP_MSLINK
       on      GARLAND.UTWATPIP
(
 MSLINK
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 2M next 1M   pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;
 
 
select 'GIS_OBJECTS_X_KEY' " " from dual;
create index   GARLAND.GIS_OBJECTS_X_KEY
       on      GARLAND.GIS_OBJECTS
(
 ITEM01
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 9M next 1M   pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;
 
 
select 'TSSDS_TABLE_NAME' " " from dual;
create index   GARLAND.TSSDS_TABLE_NAME
       on      GARLAND.TSSDS
(
 TABLE_NAME
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 1M next 1M   pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;
 
 
select 'CDRELPAR_PID' " " from dual;
create index   GARLAND.CDRELPAR_PID
       on      GARLAND.CDRELPAR
(
 PARCEL_ID
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 5M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'CDRELADR_X_NAMNUM' " " from dual;
create index   GARLAND.CDRELADR_X_NAMNUM
       on      GARLAND.CDRELADR
(
 ADDR_NAME
,ADDR_NUM
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 5M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'CDRELADR_IDX_PID' " " from dual;
create index   GARLAND.CDRELADR_IDX_PID
       on      GARLAND.CDRELADR
(
 PARCEL_ID
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 5M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'CDRELADR_X_NUM' " " from dual;
create index   GARLAND.CDRELADR_X_NUM
       on      GARLAND.CDRELADR
(
 ADDR_NUM
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 4M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'NSA_TAX_CITY_X_SUBDIV' " " from dual;
create index   GARLAND.NSA_TAX_CITY_X_SUBDIV
       on      GARLAND.NSA_TAX_CITY
(
 SUBDIV_ID
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 3M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'NSA_TAX_CITY_X_ACCT' " " from dual;
create index   GARLAND.NSA_TAX_CITY_X_ACCT
       on      GARLAND.NSA_TAX_CITY
(
 DCAD_ACCT
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 4M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'NSA_TAX_CITY_X_PARCEL' " " from dual;
create index   GARLAND.NSA_TAX_CITY_X_PARCEL
       on      GARLAND.NSA_TAX_CITY
(
 PARCEL_ID
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 3M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'ADRRESULT_UMS_LOCATION' " " from dual;
create index   GARLAND.ADRRESULT_UMS_LOCATION
       on      GARLAND.ADRRESULT_UMS_LOCATION
(
 REC_KEY
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 5M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'UTSTOPIP_X_MSLINK' " " from dual;
create unique index   GARLAND.UTSTOPIP_X_MSLINK
       on      GARLAND.UTSTOPIP
(
 MSLINK
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 6M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'UTSTOOCH_X_MSLINK' " " from dual;
create unique index   GARLAND.UTSTOOCH_X_MSLINK
       on      GARLAND.UTSTOOCH
(
 MSLINK
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 6M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'I_SANPIP_MSL' " " from dual;
create unique index   GARLAND.I_SANPIP_MSL
       on      GARLAND.UTSANPIP
(
 MSLINK
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 1M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'GIS_VERIFY_ADDR_KEY' " " from dual;
create index   GARLAND.GIS_VERIFY_ADDR_KEY
       on      GARLAND.GIS_VERIFY_ADDR
(
 REC_KEY
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 11M next 2M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'ADRRESULT_EXTRACT_SEQ' " " from dual;
create index   GARLAND.ADRRESULT_EXTRACT_SEQ
       on      GARLAND.ADRRESULT_EXTRACT
(
 REC_SEQ
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 4M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'ADRRESULT_INPUT_SEQ' " " from dual;
create index   GARLAND.ADRRESULT_INPUT_SEQ
       on      GARLAND.ADRRESULT_INPUT
(
 REC_SEQ
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 4M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'ADRALIAS_COMPACT' " " from dual;
create index   GARLAND.ADRALIAS_COMPACT
       on      GARLAND.ADRALIAS
(
 ALIAS_COMPACT
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 2M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'GIS_VERIFY_ADDR_SEQ' " " from dual;
create index   GARLAND.GIS_VERIFY_ADDR_SEQ
       on      GARLAND.GIS_VERIFY_ADDR
(
 REC_SEQ
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 7M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'INTERSECTION_NAME' " " from dual;
create index   GARLAND.INTERSECTION_NAME
       on      GARLAND.INTERSECTION
(
 ADDR1_NAME
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 6M next 1M   pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;
 
 
select 'INTERSECTION_NAME2' " " from dual;
create index   GARLAND.INTERSECTION_NAME2
       on      GARLAND.INTERSECTION
(
 ADDR2_NAME
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 7M next 1M   pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;
 
 
select 'ADRALIAS_COMPRESS' " " from dual;
create index   GARLAND.ADRALIAS_COMPRESS
       on      GARLAND.ADRALIAS
(
 ALIAS_HOW
,ALIAS_COMPRESS
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 2M next 1M   pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;
 
 
select 'TRVEHRCL_REGION_IDX' " " from dual;
create index   GARLAND.TRVEHRCL_REGION_IDX
       on      GARLAND.TRVEHRCL_REGION
(
 SEGMENT_ID
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 2M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'TRVEHRCL_X_NAME_NUM' " " from dual;
create index   GARLAND.TRVEHRCL_X_NAME_NUM
       on      GARLAND.TRVEHRCL
(
 ADDR_NAME
,ADDR_LO
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 2M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'TRVEHRCL_X_BRANCH_SECTION' " " from dual;
create index   GARLAND.TRVEHRCL_X_BRANCH_SECTION
       on      GARLAND.TRVEHRCL
(
 BRANCH_NO
,SECTION_NO
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 2M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'TRVEHRCL_U_MSLINK' " " from dual;
create unique index   GARLAND.TRVEHRCL_U_MSLINK
       on      GARLAND.TRVEHRCL
(
 MSLINK
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 2M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'TMP_PARCEL_REGION_X_PID' " " from dual;
create index   GARLAND.TMP_PARCEL_REGION_X_PID
       on      GARLAND.TMP_PARCEL_REGION
(
 PARCEL_ID
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 5M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'TAX_UB_PID_IDX' " " from dual;
create index   GARLAND.TAX_UB_PID_IDX
       on      GARLAND.TAX_UB
(
 PARCEL_ID
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 3M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'TAX_UB_ADDR_NAME_IDX' " " from dual;
create index   GARLAND.TAX_UB_ADDR_NAME_IDX
       on      GARLAND.TAX_UB
(
 STREET_NAME
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 3M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'SURFACE_MASTER_PK' " " from dual;
create unique index   GARLAND.SURFACE_MASTER_PK
       on      GARLAND.SURFACE_MASTER
(
 CATEGORY
,SURFACE_TYPE
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 1M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'RENT_OWN_I' " " from dual;
create index   GARLAND.RENT_OWN_I
       on      GARLAND.SNGLFAM_RENTAL
(
 TAX_OWNER
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 1M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'NSA_TAX_SUMMARY_X_SUBDIV' " " from dual;
create index   GARLAND.NSA_TAX_SUMMARY_X_SUBDIV
       on      GARLAND.NSA_TAX_SUMMARY
(
 SUBDIV_ID
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 2M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'NSA_TAX_ALIAS_X_DCAD' " " from dual;
create index   GARLAND.NSA_TAX_ALIAS_X_DCAD
       on      GARLAND.NSA_TAX_ALIAS
(
 DCAD_ACCT
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 6M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'NSA_DCAD_RES_X_PARCEL' " " from dual;
create index   GARLAND.NSA_DCAD_RES_X_PARCEL
       on      GARLAND.NSA_DCAD_RES
(
 PARCEL_ID
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 3M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'MSCATALOG_I' " " from dual;
create unique index   GARLAND.MSCATALOG_I
       on      GARLAND.MSCATALOG
(
 ENTITYNUM
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 1M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'MSLINK1' " " from dual;
create unique index   GARLAND.MSLINK1
       on      GARLAND.GPLSRVA
(
 MSLINK
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 1M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'CDRELPAR_MSLINK' " " from dual;
create index   GARLAND.CDRELPAR_MSLINK
       on      GARLAND.CDRELPAR
(
 MSLINK
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 3M next 1M   pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;
 
 
select 'FEA_GARLAND_USE' " " from dual;
create index   GARLAND.FEA_GARLAND_USE
       on      GARLAND.FEATURE
(
 GARLAND_INUSE
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 1M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'ADRSTREETS_X_SOUNDEX' " " from dual;
create index   GARLAND.ADRSTREETS_X_SOUNDEX
       on      GARLAND.ADRSTREETS
(
 ADDR_SOUNDEX
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 1M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'ADRSTREETS_X_REDUCED' " " from dual;
create index   GARLAND.ADRSTREETS_X_REDUCED
       on      GARLAND.ADRSTREETS
(
 ADDR_REDUCED
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 1M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'ADRSTREETS_X_COMPACT' " " from dual;
create index   GARLAND.ADRSTREETS_X_COMPACT
       on      GARLAND.ADRSTREETS
(
 ADDR_COMPACT
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 1M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'ADRSTREETS_X_COMPRESS' " " from dual;
create index   GARLAND.ADRSTREETS_X_COMPRESS
       on      GARLAND.ADRSTREETS
(
 ADDR_COMPRESS
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 1M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'ADRSTREET_X_SOUNDEX' " " from dual;
create index   GARLAND.ADRSTREET_X_SOUNDEX
       on      GARLAND.ADRSTREET
(
 ADDR_SOUNDEX
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 1M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'ADRSTREET_X_REDUCED' " " from dual;
create index   GARLAND.ADRSTREET_X_REDUCED
       on      GARLAND.ADRSTREET
(
 ADDR_REDUCED
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 1M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'ADRSTREET_X_COMPACT' " " from dual;
create index   GARLAND.ADRSTREET_X_COMPACT
       on      GARLAND.ADRSTREET
(
 ADDR_COMPACT
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 1M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'ADRSTREET_X_COMPRESS' " " from dual;
create index   GARLAND.ADRSTREET_X_COMPRESS
       on      GARLAND.ADRSTREET
(
 ADDR_COMPRESS
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 1M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'ADRPERMUTE_X_PERMUTE' " " from dual;
create index   GARLAND.ADRPERMUTE_X_PERMUTE
       on      GARLAND.ADRPERMUTE
(
 ADDR_PERMUTE
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 3M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'ADRNAME_X_SOUNDEX' " " from dual;
create index   GARLAND.ADRNAME_X_SOUNDEX
       on      GARLAND.ADRNAME
(
 ADDR_SOUNDEX
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 1M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'ADRNAME_X_COMPRESS' " " from dual;
create index   GARLAND.ADRNAME_X_COMPRESS
       on      GARLAND.ADRNAME
(
 ADDR_COMPRESS
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 1M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'ADRNAME_X_COMPACT' " " from dual;
create index   GARLAND.ADRNAME_X_COMPACT
       on      GARLAND.ADRNAME
(
 ADDR_COMPACT
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 1M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'ADRNAME_X_PERMUTE' " " from dual;
create index   GARLAND.ADRNAME_X_PERMUTE
       on      GARLAND.ADRNAME
(
 ADDR_PERMUTE
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 1M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'ADRGAP_X_NAME' " " from dual;
create index   GARLAND.ADRGAP_X_NAME
       on      GARLAND.ADRGAP
(
 ADDR_NAME
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 2M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 
 
select 'ADDRVRFY_X' " " from dual;
create unique index   GARLAND.ADDRVRFY_X
       on      GARLAND.ADDRVRFY
(
 COG_TAX_ID
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 5M next 1M   pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;
 

