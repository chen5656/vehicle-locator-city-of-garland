

 
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

 
select 'CREATE UTSANCLN' " " from dual;
create table   GARLAND.UTSANCLN
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 505
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
           minextents 1  maxextents 505
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

 
select 'CREATE UTSTOJUN' " " from dual;
create table   GARLAND.UTSTOJUN
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 505
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

 
select 'CREATE UTSTOOUT' " " from dual;
create table   GARLAND.UTSTOOUT
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 505
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

 
select 'CREATE UTSTOPON' " " from dual;
create table   GARLAND.UTSTOPON
(
 MSLINK                        NUMBER   (10) not null
,MAPID                         NUMBER   (10)
)
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1M next 1M pctincrease 0
           minextents 1  maxextents 505
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


