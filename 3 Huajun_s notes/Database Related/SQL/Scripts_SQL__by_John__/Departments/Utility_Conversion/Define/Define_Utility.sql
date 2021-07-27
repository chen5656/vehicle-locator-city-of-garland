 
     select 'CREATE UTSANARW' " " from dual;
     drop   table   GARLAND.UTSANARW;
     create table   GARLAND.UTSANARW
   (
     MSLINK                        NUMBER   (8,0) not null
    ,MAPID                         NUMBER   (8,0)
   )
     tablespace GIS_DATA   pctfree 20  pctused 40
                initrans 1 maxtrans 255
     storage   (initial 50K next 50K pctincrease 0
                minextents 1  maxextents 505
                freelists  1  freelist groups 1)
     ;


      select 'CREATE UTSANFIT' " " from dual;
      drop   table   GARLAND.UTSANFIT;
	Create table   GARLAND.UTSANFIT
(
	 mslink			number(8,0)	not null
	,mapid			number(8,0)
	,project_num		varchar2(11)
	,fitting_id			varchar2(12)
	,map_grid			varchar2(03)
	,map_quad			varchar2(01)
	,fitting_num		number(8,0)

	,fitting_size		number

	,basin			varchar2(10)
	,sub_basin			varchar2(10)
	,sub_subbasin		varchar2(10)
)
	nologging
	pctfree	20
	tablespace			gis_data
	storage			(initial 50K  next 50K  pctincrease 0);



 
     select 'CREATE UTSANCLEN' " " from dual;
     drop   table   GARLAND.UTSANCLEN;
     create table   GARLAND.UTSANCLEN
   (
     MSLINK                        NUMBER   (8,0) not null
    ,MAPID                         NUMBER   (8,0)
    ,PROJECT_NUM                   VARCHAR2 (11)
    ,CLEAN_ID                      VARCHAR2 (12)
    ,MAP_GRID                      VARCHAR2 (3)
    ,MAP_QUAD                      VARCHAR2 (1)
    ,CLEAN_NUM                     NUMBER   (8,0)

    ,CLEAN_SIZE                    NUMBER   (22)

    ,BASIN                         VARCHAR2 (10)
    ,SUB_BASIN                     VARCHAR2 (10)
    ,SUB_SUBBASIN                  VARCHAR2 (10)
   )
     tablespace GIS_DATA   pctfree 20  pctused 40
                initrans 1 maxtrans 255
     storage   (initial 50K next 50K pctincrease 0
                minextents 1  maxextents 505
                freelists  1  freelist groups 1)
     ;

 
     select 'CREATE UTSANLATR' " " from dual;
     drop   table   GARLAND.UTSANLATR;
     create table   GARLAND.UTSANLATR
   (
     MSLINK                        NUMBER   (8,0) not null
    ,MAPID                         NUMBER   (8,0)
    ,PROJECT_NUM                   VARCHAR2 (11)
    ,LATERAL_ID                    VARCHAR2 (12)
    ,MAP_GRID                      VARCHAR2 (3)
    ,MAP_QUAD                      VARCHAR2 (1)
    ,LATERAL_NUM                   NUMBER   (8,0)

    ,LATERAL_SIZE                  NUMBER   (22)
    ,BASIN                         VARCHAR2 (10)
    ,SUB_BASIN                     VARCHAR2 (10)
    ,SUB_SUBBASIN                  VARCHAR2 (10)
    ,UP_NODE_ID                    VARCHAR2 (12)
    ,DN_NODE_ID                    VARCHAR2 (12)
   )
     tablespace GIS_DATA   pctfree 20  pctused 40
                initrans 1 maxtrans 255
     storage   (initial 50K next 50K pctincrease 0
                minextents 1  maxextents 505
                freelists  1  freelist groups 1)
     ;

 
     select 'CREATE UTSANLSTA' " " from dual;
     drop   table   GARLAND.UTSANLSTA;
     create table   GARLAND.UTSANLSTA
   (
     MSLINK                        NUMBER   (8,0) not null
    ,MAPID                         NUMBER   (8,0)
    ,PROJECT_NUM                   VARCHAR2 (11)
    ,LIFTSTA_ID                    VARCHAR2 (12)
    ,MAP_GRID                      VARCHAR2 (3)
    ,MAP_QUAD                      VARCHAR2 (1)
    ,LIFTSTA_NUM                   NUMBER   (8,0)

    ,LIFTSTA_SIZE                  NUMBER   (22)
    ,LIFTSTA_NAME                  VARCHAR2 (20)
    ,LIFTSTA_STATUS                VARCHAR2 (15)
    ,DESCRIPTION                   VARCHAR2 (20)
    ,BASIN                         VARCHAR2 (10)
    ,SUB_BASIN                     VARCHAR2 (10)
    ,SUB_SUBBASIN                  VARCHAR2 (10)
    ,UP_NODE_ID                    VARCHAR2 (12)
    ,DN_NODE_ID                    VARCHAR2 (12)
    ,PUMP_TYPE                     VARCHAR2 (12)
    ,PUMP_CAP                      NUMBER   (22)
    ,WET_WELL_CAP                  NUMBER   (22)
    ,STANDBY_GEN                   VARCHAR2 (1)
   )
     tablespace GIS_DATA   pctfree 20  pctused 40
                initrans 1 maxtrans 255
     storage   (initial 50K next 50K pctincrease 0
                minextents 1  maxextents 505
                freelists  1  freelist groups 1)
     ;

 
     select 'CREATE UTSANMAIN' " " from dual;
     drop   table   GARLAND.UTSANMAIN;
     create table   GARLAND.UTSANMAIN
   (
     MSLINK                        NUMBER   (8,0) not null
    ,MAPID                         NUMBER   (8,0)
    ,PROJECT_NUM                   VARCHAR2 (11)
    ,PIPE_ID                       VARCHAR2 (12)
    ,MAP_GRID                      VARCHAR2 (3)
    ,MAP_QUAD                      VARCHAR2 (1)
    ,PIPE_NUM                      NUMBER   (8,0)

    ,PIPE_TYPE                     VARCHAR2 (10)
    ,PIPE_CLASS                    VARCHAR2 (10)
    ,PIPE_DIAMETER                 NUMBER   (22)
    ,PIPE_LENGTH                   NUMBER   (22)
    ,PIPE_MATERIAL                 VARCHAR2 (10)
    ,MANUFACTURER                  VARCHAR2 (15)
    ,MODELED                       VARCHAR2 (1)
    ,IDM                           NUMBER   (22)
    ,SLOPE                         NUMBER   (22)
    ,BASIN                         VARCHAR2 (10)
    ,SUB_BASIN                     VARCHAR2 (10)
    ,SUB_SUBBASIN                  VARCHAR2 (10)
    ,UP_BASIN_ID                   VARCHAR2 (10)
    ,UP_SUB_BASIN_ID               VARCHAR2 (10)
    ,UP_NODE_SUB_BASIN_ID          VARCHAR2 (10)
    ,UP_NODE_ID                    VARCHAR2 (12)
    ,UP_NODE_TYPE                  VARCHAR2 (2)
    ,UP_NODE_ELEV                  NUMBER   (22)
    ,UP_NODE_GRND_ELEV             NUMBER   (22)
    ,DN_BASIN_ID                   VARCHAR2 (10)
    ,DN_SUB_BASIN_ID               VARCHAR2 (10)
    ,DN_NODE_SUB_BASIN_ID          VARCHAR2 (10)
    ,DN_NODE_ID                    VARCHAR2 (12)
    ,DN_NODE_TYPE                  VARCHAR2 (2)
    ,DN_NODE_ELEV                  NUMBER   (22)
    ,DN_NODE_GRND_ELEV             NUMBER   (22)
   )
     tablespace GIS_DATA   pctfree 20  pctused 40
                initrans 1 maxtrans 255
     storage   (initial 50K next 50K pctincrease 0
                minextents 1  maxextents 505
                freelists  1  freelist groups 1)
     ;

 
     select 'CREATE UTSANMANH' " " from dual;
     drop   table   GARLAND.UTSANMANH;
     create table   GARLAND.UTSANMANH
   (
     MSLINK                        NUMBER   (8,0) not null
    ,MAPID                         NUMBER   (8,0)
    ,PROJECT_NUM                   VARCHAR2 (11)
    ,MANHOLE_ID                    VARCHAR2 (12)
    ,MAP_GRID                      VARCHAR2 (3)
    ,MAP_QUAD                      VARCHAR2 (1)
    ,MANHOLE_NUM                   NUMBER   (8,0)

    ,BASIN                         VARCHAR2 (10)
    ,SUB_BASIN                     VARCHAR2 (10)
    ,SUB_SUBBASIN                  VARCHAR2 (10)
    ,GPS_X                         NUMBER   (22)
    ,GPS_Y                         NUMBER   (22)
   )
     tablespace GIS_DATA   pctfree 20  pctused 40
                initrans 1 maxtrans 255
     storage   (initial 50K next 50K pctincrease 0
                minextents 1  maxextents 505
                freelists  1  freelist groups 1)
     ;

 
     select 'CREATE UTSTOCHAN' " " from dual;
     drop   table   GARLAND.UTSTOCHAN;
     create table   GARLAND.UTSTOCHAN
   (
     MSLINK                        NUMBER   (8,0) not null
    ,MAPID                         NUMBER   (8,0)
    ,PROJECT_NUM                   VARCHAR2 (11)
    ,CHANNEL_ID                    VARCHAR2 (12)
    ,MAP_GRID                      VARCHAR2 (3)
    ,MAP_QUAD                      VARCHAR2 (1)
    ,CHANNEL_NUM                   NUMBER   (8,0)

    ,CHANNEL_TYPE                  VARCHAR2 (5)
    ,CHANNEL_LENGTH                NUMBER   (22)
    ,INSPECT_DATE                  VARCHAR2 (10)
    ,CLEAN_DATE                    VARCHAR2 (10)
    ,MAINT_RESP                    VARCHAR2 (10)
    ,CHANNEL_DESC                  VARCHAR2 (40)
    ,GENERAL_COMMENTS              VARCHAR2 (40)
   )
     tablespace GIS_DATA   pctfree 20  pctused 40
                initrans 1 maxtrans 255
     storage   (initial 50K next 50K pctincrease 0
                minextents 1  maxextents 505
                freelists  1  freelist groups 1)
     ;

 
     select 'CREATE UTSTOHDWL' " " from dual;
     drop   table   GARLAND.UTSTOHDWL;
     create table   GARLAND.UTSTOHDWL
   (
     MSLINK                        NUMBER   (8,0) not null
    ,MAPID                         NUMBER   (8,0)
    ,PROJECT_NUM                   VARCHAR2 (11)
    ,HWALL_ID                      VARCHAR2 (12)
    ,MAP_GRID                      VARCHAR2 (3)
    ,MAP_QUAD                      VARCHAR2 (1)
    ,HWALL_NUM                     NUMBER   (8,0)

    ,HWALL_TYPE                    VARCHAR2 (1)
    ,HWALL_DIAMETER                NUMBER   (22)
    ,BOXTALL                       NUMBER   (22)
    ,BOXWIDE                       NUMBER   (22)
    ,QUANTITY                      NUMBER   (22)
    ,INSPECT_DATE                  VARCHAR2 (10)
    ,GENERAL_COMMENTS              VARCHAR2 (40)
    ,HWALL_CONDITION               VARCHAR2 (40)
   )
     tablespace GIS_DATA   pctfree 40  pctused 40
                initrans 1 maxtrans 255
     storage   (initial 50K next 50K pctincrease 0
                minextents 1  maxextents 505
                freelists  1  freelist groups 1)
     ;

 
     select 'CREATE UTSTOINLT' " " from dual;
     drop   table   GARLAND.UTSTOINLT;
     create table   GARLAND.UTSTOINLT
   (
     MSLINK                        NUMBER   (8,0) not null
    ,MAPID                         NUMBER   (8,0)
    ,PROJECT_NUM                   VARCHAR2 (11)
    ,INLET_ID                      VARCHAR2 (12)
    ,MAP_GRID                      VARCHAR2 (3)
    ,MAP_QUAD                      VARCHAR2 (1)
    ,INLET_NUM                     NUMBER   (8,0)

    ,INLET_SIZE                    NUMBER   (22)
    ,INLET_TYPE                    VARCHAR2 (20)
    ,INLET_CODE                    VARCHAR2 (2)
    ,ENVIRON_TAG                   VARCHAR2 (10)
   )
     tablespace GIS_DATA   pctfree 20  pctused 40
                initrans 1 maxtrans 255
     storage   (initial 50K next 50K pctincrease 0
                minextents 1  maxextents 505
                freelists  1  freelist groups 1)
     ;

 
     select 'CREATE UTSTOJUNC' " " from dual;
     drop   table   GARLAND.UTSTOJUNC;
     create table   GARLAND.UTSTOJUNC
   (
     MSLINK                        NUMBER   (8,0) not null
    ,MAPID                         NUMBER   (8,0)
    ,PROJECT_NUM                   VARCHAR2 (11)
    ,JUNC_ID                       VARCHAR2 (12)
    ,MAP_GRID                      VARCHAR2 (3)
    ,MAP_QUAD                      VARCHAR2 (1)
    ,JUNC_NUM                      NUMBER   (8,0)

    ,JUNC_TYPE                     VARCHAR2 (2)
    ,JUNC_MATERIAL                 VARCHAR2 (5)
    ,JUNC_DIAMETER                 NUMBER   (22)
    ,UP_NODE_ELEV                  NUMBER   (22)
    ,DN_NODE_ELEV                  NUMBER   (22)
    ,UP_NODE_HYD_GRADE             NUMBER   (22)
    ,DN_NODE_HYD_GRADE             NUMBER   (22)
    ,GENERAL_COMMENTS              VARCHAR2 (40)
    ,JUNC_CONDITION                VARCHAR2 (40)
   )
     tablespace GIS_DATA   pctfree 20  pctused 40
                initrans 1 maxtrans 255
     storage   (initial 50K next 50K pctincrease 0
                minextents 1  maxextents 505
                freelists  1  freelist groups 1)
     ;

 
     select 'CREATE UTSTOMANH' " " from dual;
     drop   table   GARLAND.UTSTOMANH;
     create table   GARLAND.UTSTOMANH
   (
     MSLINK                        NUMBER   (8,0) not null
    ,MAPID                         NUMBER   (8,0)
    ,PROJECT_NUM                   VARCHAR2 (11)
    ,MANHOLE_ID                    VARCHAR2 (12)
    ,MAP_GRID                      VARCHAR2 (3)
    ,MAP_QUAD                      VARCHAR2 (1)
    ,MANHOLE_NUM                   NUMBER   (8,0)

    ,LATITUDE                      NUMBER   (22)
    ,LONGITUDE                     NUMBER   (22)
   )
     tablespace GIS_DATA   pctfree 40  pctused 40
                initrans 1 maxtrans 255
     storage   (initial 50K next 50K pctincrease 0
                minextents 1  maxextents 505
                freelists  1  freelist groups 1)
     ;

 
     select 'CREATE UTSTOOUT' " " from dual;
     drop   table   GARLAND.UTSTOOUT;
     create table   GARLAND.UTSTOOUT
   (
     MSLINK                        NUMBER   (8,0) not null
    ,MAPID                         NUMBER   (8,0)
    ,PROJECT_NUM                   VARCHAR2 (11)
    ,OUTFALL_ID                    VARCHAR2 (12)
    ,MAP_GRID                      VARCHAR2 (3)
    ,MAP_QUAD                      VARCHAR2 (1)
    ,OUTFALL_NUM                   NUMBER   (8,0)

    ,OUTFALL_TYPE                  VARCHAR2 (12)
    ,OUTFALL_MATERIAL              VARCHAR2 (10)
    ,RECEIVING_SUB_BASIN           VARCHAR2 (10)
    ,DISCHARGE                     VARCHAR2 (5)
    ,OUTFALL_DIMENSIONS            NUMBER   (22)
    ,QUANTITY                      NUMBER   (22)
    ,EPA_TOTAL_SCORE               NUMBER   (22)
    ,LATITUDE                      NUMBER   (22)
    ,LONGITUDE                     NUMBER   (22)
    ,INSPECT_DATE                  VARCHAR2 (10)
    ,OUTFALL_CONDITION             VARCHAR2 (40)
    ,GENERAL_COMMENTS              VARCHAR2 (40)
    ,ACCESS_INSTRUCTION            VARCHAR2 (40)
   )
     tablespace GIS_DATA   pctfree 20  pctused 40
                initrans 1 maxtrans 255
     storage   (initial 50K next 50K pctincrease 0
                minextents 1  maxextents 505
                freelists  1  freelist groups 1)
     ;

 
     select 'CREATE UTSTOPIPE' " " from dual;
     drop   table   GARLAND.UTSTOPIPE;
     create table   GARLAND.UTSTOPIPE
   (
     MSLINK                        NUMBER   (8,0) not null
    ,MAPID                         NUMBER   (8,0)
    ,PROJECT_NUM                   VARCHAR2 (11)
    ,PIPE_ID                       VARCHAR2 (12)
    ,MAP_GRID                      VARCHAR2 (3)
    ,MAP_QUAD                      VARCHAR2 (1)
    ,PIPE_NUM                      NUMBER   (8,0)

    ,PIPE_TYPE                     VARCHAR2 (2)
    ,PIPE_MATERIAL                 VARCHAR2 (5)
    ,BOXTALL                       NUMBER   (22)
    ,BOXWIDE                       NUMBER   (22)
    ,PIPE_LENGTH                   NUMBER   (22)
    ,PIPE_DIAMETER                 NUMBER   (22)
    ,QUANTITY                      NUMBER   (22)
    ,SLOPE                         NUMBER   (22)
    ,UP_NODE_ELEV        	     NUMBER   (22)
    ,DN_NODE_ELEV                  NUMBER   (22)
    ,UP_NODE_HYD_GRADE             NUMBER   (22)
    ,DN_NODE_HYD_GRADE             NUMBER   (22)
    ,INSPECT_DATE                  VARCHAR2 (10)
    ,GENERAL_DESC                  VARCHAR2 (40)
    ,GENERAL_COMMENTS              VARCHAR2 (40)
    ,PIPE_CONDITION                VARCHAR2 (40)
   )
     tablespace GIS_DATA   pctfree 20  pctused 40
                initrans 1 maxtrans 255
     storage   (initial 50K next 50K pctincrease 0
                minextents 1  maxextents 505
                freelists  1  freelist groups 1)
     ;

 
     select 'CREATE UTSTOPOND' " " from dual;
     drop   table   GARLAND.UTSTOPOND;
     create table   GARLAND.UTSTOPOND
   (
     MSLINK                        NUMBER   (8,0) not null
    ,MAPID                         NUMBER   (8,0)
    ,PROJECT_NUM                   VARCHAR2 (11)
    ,POND_ID                       VARCHAR2 (12)
    ,MAP_GRID                      VARCHAR2 (3)
    ,MAP_QUAD                      VARCHAR2 (1)
    ,POND_NUM                      NUMBER   (8,0)

    ,POND_TYPE                     VARCHAR2 (10)
    ,DCAD_ID                       VARCHAR2 (17)
    ,POND_SIZE                     NUMBER   (22)
    ,LATITUDE                      NUMBER   (22)
    ,LONGITUDE                     NUMBER   (22)
    ,INSPECT_DATE                  VARCHAR2 (10)
    ,GENERAL_COMMENTS              VARCHAR2 (40)
    ,ACCESS_INSTRUCTION            VARCHAR2 (40)
   )
     tablespace GIS_DATA   pctfree 20  pctused 40
                initrans 1 maxtrans 255
     storage   (initial 50K next 50K pctincrease 0
                minextents 1  maxextents 505
                freelists  1  freelist groups 1)
     ;

 
     select 'CREATE UTWATFIT' " " from dual;
     drop   table   GARLAND.UTWATFIT;
     create table   GARLAND.UTWATFIT
   (
     MSLINK                        NUMBER   (8,0)
    ,MAPID                         NUMBER   (8,0)
    ,PROJECT_NUM                   VARCHAR2 (11)
    ,FITTING_ID                    VARCHAR2 (12)
    ,MAP_GRID                      VARCHAR2 (3)
    ,MAP_QUAD                      VARCHAR2 (1)
    ,FITTING_NUM                   NUMBER   (8,0)

    ,FITTING_TYPE                  VARCHAR2 (10)
    ,FITTING_SIZE                  NUMBER   (22)
    ,PRESSURE_NORMAL               NUMBER   (22)
    ,PRESSURE_SOURCE               VARCHAR2 (10)
    ,ZONE                          VARCHAR2 (4)
    ,MANUFACTURER                  VARCHAR2 (20)
    ,WORK_ORDER_NUM                VARCHAR2 (10)
   )
     tablespace GIS_DATA   pctfree 40  pctused 40
                initrans 1 maxtrans 255
     storage   (initial 50K next 50K pctincrease 0
                minextents 1  maxextents 505
                freelists  1  freelist groups 1)
     ;

 
     select 'CREATE UTWATHYDR' " " from dual;
     drop   table   GARLAND.UTWATHYDR;
     create table   GARLAND.UTWATHYDR
   (
     MSLINK                        NUMBER   (8,0) not null
    ,MAPID                         NUMBER   (8,0)
    ,PROJECT_NUM                   VARCHAR2 (11)
    ,HYDRANT_ID                    VARCHAR2 (12)
    ,MAP_GRID                      VARCHAR2 (3)
    ,MAP_QUAD                      VARCHAR2 (1)
    ,HYDRANT_NUM                   NUMBER   (8,0)

    ,PRESSURE_STATIC               NUMBER   (22)
    ,PRESSURE_RESIDUAL             NUMBER   (22)
    ,PRESSURE_FLOW_TEST            NUMBER   (22)
    ,PRESSURE_TEST_DATE            VARCHAR2 (10)
    ,MANUFACTURER                  VARCHAR2 (20)
    ,ZONE                          VARCHAR2 (4)
    ,HYDRANT_STATUS                VARCHAR2 (15)
    ,HYDRANT_OWNER                 VARCHAR2 (10)
    ,WORK_ORDER_NUM                VARCHAR2 (10)
   )
     tablespace GIS_DATA   pctfree 10  pctused 40
                initrans 1 maxtrans 255
     storage   (initial 50K next 50K pctincrease 0
                minextents 1  maxextents 505
                freelists  1  freelist groups 1)
     ;

 
     select 'CREATE UTWATMETR' " " from dual;
     drop   table   GARLAND.UTWATMETR;
     create table   GARLAND.UTWATMETR
   (
     MSLINK                        NUMBER   (8,0) not null
    ,MAPID                         NUMBER   (8,0)
    ,PROJECT_NUM                   VARCHAR2 (11)
    ,METER_ID                      VARCHAR2 (12)
    ,MAP_GRID                      VARCHAR2 (3)
    ,MAP_QUAD                      VARCHAR2 (1)
    ,METER_NUM                     NUMBER   (8,0)

    ,METER_TYPE                    VARCHAR2 (20)
    ,METER_SIZE                    NUMBER   (22)
    ,SERIAL_NUM                    NUMBER   (22)
    ,MANUFACTURER                  VARCHAR2 (20)
    ,ZONE                          VARCHAR2 (4)
    ,BILLING_CLASS                 VARCHAR2 (12)
    ,ACCOUNT_NUM                   VARCHAR2 (10)
    ,WORK_ORDER_NUM                VARCHAR2 (10)
   )
     tablespace GIS_DATA   pctfree 60  pctused 40
                initrans 1 maxtrans 255
     storage   (initial 50K next 50K pctincrease 0
                minextents 1  maxextents 505
                freelists  1  freelist groups 1)
     ;

 
     select 'CREATE UTWATPIPE' " " from dual;
     drop   table   GARLAND.UTWATPIPE;
     create table   GARLAND.UTWATPIPE
   (
     MSLINK                        NUMBER   (8,0) not null
    ,MAPID                         NUMBER   (8,0)
    ,PROJECT_NUM                   VARCHAR2 (11)
    ,PIPE_ID                       VARCHAR2 (12)
    ,MAP_GRID                      VARCHAR2 (3)
    ,MAP_QUAD                      VARCHAR2 (1)
    ,PIPE_NUM                      NUMBER   (8,0)

    ,PIPE_MATERIAL                 VARCHAR2 (4)
    ,PIPE_DIAMETER                 NUMBER   (22)
    ,PIPE_LENGTH                   NUMBER   (22)
    ,PRESSURE_NORMAL               NUMBER   (22)
    ,MANUFACTURER                  VARCHAR2 (20)
    ,ZONE                          VARCHAR2 (4)
    ,WORK_ORDER_NUM                VARCHAR2 (10)
   )
     tablespace GIS_DATA   pctfree 40  pctused 40
                initrans 1 maxtrans 255
     storage   (initial 50K next 50K pctincrease 0
                minextents 1  maxextents 505
                freelists  1  freelist groups 1)
     ;

 
     select 'CREATE UTWATPSTA' " " from dual;
     drop   table   GARLAND.UTWATPSTA;
     create table   GARLAND.UTWATPSTA
   (
     MSLINK                        NUMBER   (8,0) not null
    ,MAPID                         NUMBER   (8,0)
    ,PROJECT_NUM                   VARCHAR2 (11)
    ,PUMPSTA_ID                    VARCHAR2 (12)
    ,MAP_GRID                      VARCHAR2 (3)
    ,MAP_QUAD                      VARCHAR2 (1)
    ,PUMPSTA_NUM                   NUMBER   (8,0)

    ,PUMPSTA_TYPE                  VARCHAR2 (10)
    ,PUMP_TYPE                     VARCHAR2 (10)
    ,CAPACITY                      NUMBER   (22)
    ,QUANTITY                      NUMBER   (22)
    ,ZONE                          VARCHAR2 (4)
    ,STANDBY_GEN                   VARCHAR2 (1)
    ,ADDRESS                       VARCHAR2 (20)
    ,WORK_ORDER_NUM                VARCHAR2 (10)
   )
     tablespace GIS_DATA   pctfree 20  pctused 40
                initrans 1 maxtrans 255
     storage   (initial 50K next 50K pctincrease 0
                minextents 1  maxextents 505
                freelists  1  freelist groups 1)
     ;

 
     select 'CREATE UTWATTANK' " " from dual;
     drop   table   GARLAND.UTWATTANK;
     create table   GARLAND.UTWATTANK
   (
     MSLINK                        NUMBER   (8,0) not null
    ,MAPID                         NUMBER   (8,0)
    ,PROJECT_NUM                   VARCHAR2 (11)
    ,TANK_ID                       VARCHAR2 (12)
    ,MAP_GRID                      VARCHAR2 (3)
    ,MAP_QUAD                      VARCHAR2 (1)
    ,TANK_NUM                      NUMBER   (8,0)

    ,TANK_TYPE                     VARCHAR2 (2)
    ,TANK_MATERIAL                 VARCHAR2 (10)
    ,TANK_DIAMETER                 NUMBER   (22)
    ,TANK_HEIGHT                   NUMBER   (22)
    ,CAPACITY                      NUMBER   (22)
    ,ALARM_LEVEL_HIGH              NUMBER   (22)
    ,ALARM_LEVEL_LOW               NUMBER   (22)
    ,OVERFLOW_ELEV                 NUMBER   (22)
    ,TANK_STATUS                   VARCHAR2 (15)
    ,ZONE                          VARCHAR2 (4)
    ,WORK_ORDER_NUM                VARCHAR2 (10)
   )
     tablespace GIS_DATA   pctfree 30  pctused 40
                initrans 1 maxtrans 255
     storage   (initial 50K next 50K pctincrease 0
                minextents 1  maxextents 505
                freelists  1  freelist groups 1)
     ;

 
     select 'CREATE UTWATVALV' " " from dual;
     drop   table   GARLAND.UTWATVALV;
     create table   GARLAND.UTWATVALV
   (
     MSLINK                        NUMBER   (8,0) not null
    ,MAPID                         NUMBER   (8,0)
    ,PROJECT_NUM                   VARCHAR2 (11)
    ,VALVE_ID                      VARCHAR2 (12)
    ,MAP_GRID                      VARCHAR2 (3)
    ,MAP_QUAD                      VARCHAR2 (1)
    ,VALVE_NUM                     NUMBER   (8,0)

    ,VALVE_TYPE                    VARCHAR2 (10)
    ,VALVE_STATUS                  VARCHAR2 (6)
    ,VALVE_SIZE                    NUMBER   (22)
    ,PRESSURE_NORMAL               NUMBER   (22)
    ,MANUFACTURER                  VARCHAR2 (20)
    ,ZONE                          VARCHAR2 (4)
    ,WORK_ORDER_NUM                VARCHAR2 (10)
   )
     tablespace GIS_DATA   pctfree 40  pctused 40
                initrans 1 maxtrans 255
     storage   (initial 50K next 50K pctincrease 0
                minextents 1  maxextents 505
                freelists  1  freelist groups 1)
     ;


