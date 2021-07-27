select 'ESRI_ADDRESS_PKEY' " "  from dual;
alter table GARLAND.ESRI_ADDRESS
add constraint ESRI_ADDRESS_PKEY
primary key
(
 KEY
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 2M next 1M pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;

select 'NSA_CODE_CITATION_PKEY' " "  from dual;
alter table GARLAND.NSA_CODE_CITATION
add constraint NSA_CODE_CITATION_PKEY
primary key
(
 CITATION_NUMBER
,CASE_NUMBER
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;

select 'NSA_CODE_COMPLAINT_PKEY' " "  from dual;
alter table GARLAND.NSA_CODE_COMPLAINT
add constraint NSA_CODE_COMPLAINT_PKEY
primary key
(
 CASE_NUMBER
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;

select 'ADRALIAS_PKEY' " "  from dual;
alter table GARLAND.ADRALIAS
add constraint ADRALIAS_PKEY
primary key
(
 ALIAS_NAME
,ALIAS_TYPE
,ALIAS_PFX
,ALIAS_SFX
,ALIAS_LO
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 2M next 1M pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;

select 'ADDRESS_UNIT_PKEY' " "  from dual;
alter table GARLAND.ADDRESS_UNIT
add constraint ADDRESS_UNIT_PKEY
primary key
(
 ADDR_NAME
,ADDR_TYPE
,ADDR_PFX
,ADDR_SFX
,ADDR_NUM
,ADDR_BLDG1
,ADDR_UNIT1
,ADDR_BLDG2
,ADDR_UNIT2
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 2M next 1M pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;

select 'WORK_MAST_PK' " "  from dual;
alter table GARLAND.WORK_MAST
add constraint WORK_MAST_PK
primary key
(
 SFG_NUM
,SUB_TASK_NUM
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;

select 'ADRSTREET_PKEY1' " "  from dual;
alter table GARLAND.ADRSTREET_SNAP
add constraint ADRSTREET_PKEY1
primary key
(
 ADDR_NAME
,ADDR_TYPE
,ADDR_PFX
,ADDR_SFX
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 2M next 1M pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;

select 'BLOCK_SIDE_PKEY' " "  from dual;
alter table GARLAND.BLOCK_SIDE
add constraint BLOCK_SIDE_PKEY
primary key
(
 ADDR_NAME
,ADDR_BLOCK
,ADDR_PARITY
,ADDR_TYPE
,ADDR_PFX
,ADDR_SFX
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 2M next 1M pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;

select 'RQST_USER_LOG_PK' " "  from dual;
alter table GARLAND.RQST_USER_LOG
add constraint RQST_USER_LOG_PK
primary key
(
 USER_NAME
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;

select 'PAVE_TASK_PK' " "  from dual;
alter table GARLAND.PAVE_TASK
add constraint PAVE_TASK_PK
primary key
(
 PROJ_YEAR
,PROJ_SEQ
,SUBTASK_SFG_NUM
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;

select 'PAVE_SURF_MAST_PK' " "  from dual;
alter table GARLAND.PAVE_SURF_MAST
add constraint PAVE_SURF_MAST_PK
primary key
(
 CATEGORY
,SURF_TYPE
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;

select 'PAVE_PROJ_APPR_PK' " "  from dual;
alter table GARLAND.PAVE_PROJ_APPR
add constraint PAVE_PROJ_APPR_PK
primary key
(
 CATEGORY
,BRANCH
,SECTION
,SFG_NUMBER
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;

select 'PAVE_PROJ_PK' " "  from dual;
alter table GARLAND.PAVE_PROJ
add constraint PAVE_PROJ_PK
primary key
(
 PROJ_YEAR
,PROJ_SEQ
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;

select 'PAVE_CUST_PK' " "  from dual;
alter table GARLAND.PAVE_CUST
add constraint PAVE_CUST_PK
primary key
(
 PROJ_YEAR
,PROJ_SEQ
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;

select 'PK_PAVEMENT_MASTER' " "  from dual;
alter table GARLAND.PAVEMENT_MASTER
add constraint PK_PAVEMENT_MASTER
primary key
(
 CATEGORY
,BRANCH
,SECTION
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;

select 'PAVE_MAST_KEY' " "  from dual;
alter table GARLAND.PAVE_MAST
add constraint PAVE_MAST_KEY
primary key
(
 CATEGORY
,BRANCH
,SECTION
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 3M next 1M pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;

select 'PK_INSPECTION_MASTER' " "  from dual;
alter table GARLAND.INSPECTION_MASTER
add constraint PK_INSPECTION_MASTER
primary key
(
 CLASS_NAME
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;

select 'CDRELADR_UNQ_MSLINK' " "  from dual;
alter table GARLAND.CDRELADR
add constraint CDRELADR_UNQ_MSLINK
unique
(
 MSLINK
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 3M next 1M pctincrease 0
           minextents 1  maxextents 505
           freelists  1  freelist groups 1)
;

select 'ADRSTREETS_PKEY' " "  from dual;
alter table GARLAND.ADRSTREETS
add constraint ADRSTREETS_PKEY
primary key
(
 ADDR_NAME
,ADDR_TYPE
,ADDR_PFX
,ADDR_SFX
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;

select 'ADRSTREET_PKEY' " "  from dual;
alter table GARLAND.ADRSTREET
add constraint ADRSTREET_PKEY
primary key
(
 ADDR_NAME
,ADDR_TYPE
,ADDR_PFX
,ADDR_SFX
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;

select 'ADRNAME_PKEY' " "  from dual;
alter table GARLAND.ADRNAME
add constraint ADRNAME_PKEY
primary key
(
 ADDR_NAME
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;

select 'ADRALIEN_PKEY' " "  from dual;
alter table GARLAND.ADRALIEN
add constraint ADRALIEN_PKEY
primary key
(
 ALIAS_NAME
,ALIAS_TYPE
,ALIAS_PFX
,ALIAS_SFX
,ALIAS_LO
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 2M next 1M pctincrease 0
           minextents 1  maxextents 2147483645
           freelists  1  freelist groups 1)
;

