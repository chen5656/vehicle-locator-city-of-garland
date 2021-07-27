


SQLWKS> 	desc UTSANFITT;                                                                
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(8)
MAPID                                   NUMBER(8)
PROJECT_NUM                             VARCHAR2(11)
SCAN_NUM                                VARCHAR2(20)
FITTING_ID                              VARCHAR2(14)
MAP_GRID                                VARCHAR2(3)
MAP_QUAD                                VARCHAR2(1)
FITTING_NUM                             NUMBER(8)
PARENT_ID                               VARCHAR2(12)
FITTING_TYPE      ***                      VARCHAR2(16)
FITTING_SIZE                            NUMBER
BASIN                                   VARCHAR2(20)
SUB_BASIN                               VARCHAR2(20)
SUB_SUBBASIN                            VARCHAR2(20)
GENERAL_COMMENTS                        VARCHAR2(40)
OWNERSHIP                               VARCHAR2(10)
ASBUILT_DATE                            VARCHAR2(10)


SQLWKS> 	desc UTSANLATR;                                                                
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(8)
MAPID                                   NUMBER(8)
PROJECT_NUM                             VARCHAR2(11)
SCAN_NUM                                VARCHAR2(20)
LATERAL_ID                              VARCHAR2(14)
MAP_GRID                                VARCHAR2(3)
MAP_QUAD                                VARCHAR2(1)
LATERAL_NUM                             NUMBER(8)
PARENT_ID                               VARCHAR2(12)
LATERAL_SIZE     ***                       NUMBER
UPSTR_NODE                              VARCHAR2(12)
DNSTR_NODE                              VARCHAR2(12)
BASIN                                   VARCHAR2(20)
SUB_BASIN                               VARCHAR2(20)
SUB_SUBBASIN                            VARCHAR2(20)
GENERAL_COMMENTS                        VARCHAR2(40)
OWNERSHIP                               VARCHAR2(10)
ASBUILT_DATE                            VARCHAR2(10)


SQLWKS> 	desc UTSANLIFT;                                                                
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(8)
MAPID                                   NUMBER(8)
PROJECT_NUM                             VARCHAR2(11)
SCAN_NUM                                VARCHAR2(20)
LIFTSTA_ID                              VARCHAR2(14)
MAP_GRID                                VARCHAR2(3)
MAP_QUAD                                VARCHAR2(1)
LIFTSTA_NUM                             NUMBER(8)
PARENT_ID                               VARCHAR2(12)
LIFTSTA_DESC                            VARCHAR2(25)
LIFTSTA_SIZE                            NUMBER
LIFTSTA_STATUS                          VARCHAR2(15)
LIFTSTA_NAME                            VARCHAR2(20)
UPSTR_NODE                              VARCHAR2(12)
DNSTR_NODE                              VARCHAR2(12)
UPSTR_MANHOLE_NODE                      VARCHAR2(12)
DNSTR_MANHOLE_NODE                      VARCHAR2(12)
PUMP_TYPE             ***                  VARCHAR2(12)
PUMP_CAP                                NUMBER
WET_WELL_CAP                            NUMBER
STANDBY_GEN                             VARCHAR2(1)
BASIN                                   VARCHAR2(20)
SUB_BASIN                               VARCHAR2(20)
SUB_SUBBASIN                            VARCHAR2(20)
GENERAL_COMMENTS                        VARCHAR2(40)
OWNERSHIP                               VARCHAR2(10)
ASBUILT_DATE                            VARCHAR2(10)


SQLWKS> 	desc UTSANMANH;                                                                
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(8)
MAPID                                   NUMBER(8)
PROJECT_NUM                             VARCHAR2(11)
SCAN_NUM                                VARCHAR2(20)
MANHOLE_ID                              VARCHAR2(14)
MAP_GRID                                VARCHAR2(3)
MAP_QUAD                                VARCHAR2(1)
MANHOLE_NUM                             NUMBER(8)
PARENT_ID                               VARCHAR2(12)
GPS_X                                   NUMBER
GPS_Y                                   NUMBER
MANHOLE_SIZE            ****                NUMBER
UPSTR_MANHOLE_NODE                      VARCHAR2(12)
DNSTR_MANHOLE_NODE                      VARCHAR2(12)
CONSTRUCT_DATE                          VARCHAR2(10)
BASIN                                   VARCHAR2(20)
SUB_BASIN                               VARCHAR2(20)
SUB_SUBBASIN                            VARCHAR2(20)
GENERAL_COMMENTS                        VARCHAR2(40)
OWNERSHIP                               VARCHAR2(10)
ASBUILT_DATE                            VARCHAR2(10)

SQLWKS> 	desc UTSANPIPE;                                                                
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(8)
MAPID                                   NUMBER(8)
PROJECT_NUM                             VARCHAR2(11)
SCAN_NUM                                VARCHAR2(20)
PIPE_ID                                 VARCHAR2(14)
MAP_GRID                                VARCHAR2(3)
MAP_QUAD                                VARCHAR2(1)
PIPE_NUM                                NUMBER(8)
PARENT_ID                               VARCHAR2(12)
PIPE_DIAMETER                           NUMBER
PIPE_LENGTH                             NUMBER
PIPE_TYPE         ****                      VARCHAR2(10)
PIPE_CLASS                              VARCHAR2(10)
PIPE_MATERIAL                           VARCHAR2(10)
SLOPE                                   NUMBER
UPSTR_NODE                              VARCHAR2(12)
UPSTR_NODE_TYPE                         VARCHAR2(2)
UPSTR_BASIN                             VARCHAR2(5)
UPSTR_SUB_BASIN                         VARCHAR2(5)
UPSTR_NODE_SUB_BASIN                    VARCHAR2(5)
UPSTR_NODE_ELEV                         NUMBER
UPSTR_NODE_GRND_ELEV                    NUMBER
DNSTR_NODE                              VARCHAR2(12)
DNSTR_NODE_TYPE                         VARCHAR2(2)
DNSTR_BASIN                             VARCHAR2(5)
DNSTR_SUB_BASIN                         VARCHAR2(5)
DNSTR_NODE_SUB_BASIN                    VARCHAR2(5)
DNSTR_NODE_ELEV                         NUMBER
DNSTR_NODE_GRND_ELEV                    NUMBER
BASIN                                   VARCHAR2(20)
SUB_BASIN                               VARCHAR2(20)
SUB_SUBBASIN                            VARCHAR2(20)
MODELED                                 VARCHAR2(1)
IDM                                     NUMBER
MANUFACTURER                            VARCHAR2(15)
GENERAL_COMMENTS                        VARCHAR2(40)
OWNERSHIP                               VARCHAR2(10)
ASBUILT_DATE                            VARCHAR2(10)


SQLWKS> 	desc UTSTOHWAL;                                                                
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(8)
MAPID                                   NUMBER(8)
PROJECT_NUM                             VARCHAR2(11)
SCAN_NUM                                VARCHAR2(20)
HEADWALL_ID                             VARCHAR2(14)
MAP_GRID                                VARCHAR2(3)
MAP_QUAD                                VARCHAR2(1)
HEADWALL_NUM                            NUMBER(8)
PARENT_ID                               VARCHAR2(12)
HEADWALL_DIAMETER                       NUMBER
HEADWALL_TYPE        ****                   VARCHAR2(10)
BOXTALL                                 NUMBER
BOXWIDE                                 NUMBER
QUANTITY                                NUMBER
INSPECT_DATE                            VARCHAR2(10)
HEADWALL_COND                           VARCHAR2(40)
GENERAL_COMMENTS                        VARCHAR2(40)
OWNERSHIP                               VARCHAR2(10)
ASBUILT_DATE                            VARCHAR2(10)



SQLWKS> 	desc UTSTOINLT;                                                                
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(8)
MAPID                                   NUMBER(8)
PROJECT_NUM                             VARCHAR2(11)
SCAN_NUM                                VARCHAR2(20)
INLET_ID                                VARCHAR2(14)
MAP_GRID                                VARCHAR2(3)
MAP_QUAD                                VARCHAR2(1)
INLET_NUM                               NUMBER(8)
PARENT_ID                               VARCHAR2(12)
INLET_SIZE                              VARCHAR2(10)
INLET_TYPE           ****                   VARCHAR2(20)
INLET_CODE                              VARCHAR2(2)
EPA_TAG                                 VARCHAR2(10)
INSPECT_DATE                            VARCHAR2(10)
BASIN                                   VARCHAR2(20)
SUB_BASIN                               VARCHAR2(20)
INLET_COND                              VARCHAR2(40)
GENERAL_COMMENTS                        VARCHAR2(40)
INLET_QUANTITY                          NUMBER(10)
OWNERSHIP                               VARCHAR2(10)
ASBUILT_DATE                            VARCHAR2(10)


SQLWKS> 	desc UTSTOJUNC;                                                                
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(8)
MAPID                                   NUMBER(8)
PROJECT_NUM                             VARCHAR2(11)
SCAN_NUM                                VARCHAR2(20)
JUNCTION_ID                             VARCHAR2(14)
MAP_GRID                                VARCHAR2(3)
MAP_QUAD                                VARCHAR2(1)
JUNCTION_NUM                            NUMBER(8)
PARENT_ID                               VARCHAR2(12)
JUNCTION_DIAMETER                       NUMBER
JUNCTION_TYPE         ****                  VARCHAR2(10)
JUNCTION_MATERIAL                       VARCHAR2(10)
UPSTR_NODE_ELEV                         NUMBER
DNSTR_NODE_ELEV                         NUMBER
UPSTR_HYD_GRADE                         NUMBER
DNSTR_HYD_GRADE                         NUMBER
INSPECT_DATE                            VARCHAR2(10)
BASIN                                   VARCHAR2(20)
SUB_BASIN                               VARCHAR2(20)
JUNCTION_COND                           VARCHAR2(40)
GENERAL_COMMENTS                        VARCHAR2(40)
OWNERSHIP                               VARCHAR2(10)


SQLWKS> 	desc UTSTOMANH;                                                                
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(8)
MAPID                                   NUMBER(8)
PROJECT_NUM                             VARCHAR2(11)
SCAN_NUM                                VARCHAR2(20)
MANHOLE_ID                              VARCHAR2(14)
MAP_GRID                                VARCHAR2(3)
MAP_QUAD                                VARCHAR2(1)
MANHOLE_NUM                             NUMBER(8)
PARENT_ID                               VARCHAR2(12)
LATITUDE                                NUMBER
LONGITUDE                               NUMBER
INSPECT_DATE                            VARCHAR2(10)
CONSTRUCT_DATE                          VARCHAR2(10)
BASIN                                   VARCHAR2(20)
SUB_BASIN                               VARCHAR2(20)
MANHOLE_COND                            VARCHAR2(40)
GENERAL_COMMENTS                        VARCHAR2(40)
OWNERSHIP                               VARCHAR2(10)
MH_TYPE             ****                    VARCHAR2(5)
ASBUILT_DATE                            VARCHAR2(10)


SQLWKS> 	desc UTSTOCHAN;                                                                
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(8)
MAPID                                   NUMBER(8)
PROJECT_NUM                             VARCHAR2(11)
SCAN_NUM                                VARCHAR2(20)
CHANNEL_ID                              VARCHAR2(14)
MAP_GRID                                VARCHAR2(3)
MAP_QUAD                                VARCHAR2(1)
CHANNEL_NUM                             NUMBER(8)
PARENT_ID                               VARCHAR2(12)
CHANNEL_DESC                            VARCHAR2(25)
CHANNEL_LENGTH                          NUMBER
CHANNEL_SIZE                            NUMBER
CHANNEL_TYPE        ****                    VARCHAR2(5)
INSPECT_DATE                            VARCHAR2(10)
CLEAN_DATE                              VARCHAR2(10)
MAINT_RESP                              VARCHAR2(10)
BASIN                                   VARCHAR2(20)
SUB_BASIN                               VARCHAR2(20)
CHANNEL_COND                            VARCHAR2(40)
GENERAL_COMMENTS                        VARCHAR2(40)
OWNERSHIP                               VARCHAR2(10)
ASBUILT_DATE                            VARCHAR2(10)


SQLWKS> 	desc UTSTOOUTF;                                                                
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(8)
MAPID                                   NUMBER(8)
PROJECT_NUM                             VARCHAR2(11)
SCAN_NUM                                VARCHAR2(20)
OUTFALL_ID                              VARCHAR2(14)
MAP_GRID                                VARCHAR2(3)
MAP_QUAD                                VARCHAR2(1)
OUTFALL_NUM                             NUMBER(8)
PARENT_ID                               VARCHAR2(12)
LATITUDE                                NUMBER
LONGITUDE                               NUMBER
ACCESS_INSTRUCTION                      VARCHAR2(40)
OUTFALL_DIMENSION                       NUMBER
OUTFALL_TYPE         ****                   VARCHAR2(12)
OUTFALL_MATERIAL                        VARCHAR2(10)
QUANTITY                                NUMBER
DISCHARGE                               VARCHAR2(5)
RECV_SUB_BASIN                          VARCHAR2(5)
EPA_TOTAL_SCORE                         NUMBER
INSPECT_DATE                            VARCHAR2(10)
BASIN                                   VARCHAR2(20)
SUB_BASIN                               VARCHAR2(20)
OUTFALL_COND                            VARCHAR2(40)
GENERAL_COMMENTS                        VARCHAR2(40)
OWNERSHIP                               VARCHAR2(10)
OUTFALL_YEAR                            VARCHAR2(4)


SQLWKS> 	desc UTSTOPIPE;                                                                
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(8)
MAPID                                   NUMBER(8)
PROJECT_NUM                             VARCHAR2(11)
SCAN_NUM                                VARCHAR2(20)
PIPE_ID                                 VARCHAR2(14)
MAP_GRID                                VARCHAR2(3)
MAP_QUAD                                VARCHAR2(1)
PIPE_NUM                                NUMBER(8)
PARENT_ID                               VARCHAR2(12)
PIPE_DIAMETER                           NUMBER
PIPE_LENGTH                             NUMBER
PIPE_TYPE             ****                  VARCHAR2(4)
PIPE_MATERIAL                           VARCHAR2(10)
BOXTALL                                 NUMBER
BOXWIDE                                 NUMBER
QUANTITY                                NUMBER
SLOPE                                   NUMBER
UPSTR_NODE_ELEV                         NUMBER
DNSTR_NODE_ELEV                         NUMBER
UPSTR_HYD_GRADE                         NUMBER
DNSTR_HYD_GRADE                         NUMBER
INSPECT_DATE                            VARCHAR2(10)
BASIN                                   VARCHAR2(20)
SUB_BASIN                               VARCHAR2(20)
PIPE_COND                               VARCHAR2(40)
GENERAL_DESC                            VARCHAR2(40)
GENERAL_COMMENTS                        VARCHAR2(40)
OWNERSHIP                               VARCHAR2(10)
ASBUILT_DATE                            VARCHAR2(10)


SQLWKS> 	desc UTSTOPOND;                                                                
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(8)
MAPID                                   NUMBER(8)
PROJECT_NUM                             VARCHAR2(11)
SCAN_NUM                                VARCHAR2(20)
POND_ID                                 VARCHAR2(14)
MAP_GRID                                VARCHAR2(3)
MAP_QUAD                                VARCHAR2(1)
POND_NUM                                NUMBER(8)
PARENT_ID                               VARCHAR2(12)
DCAD_ID                                 VARCHAR2(17)
LATITUDE                                NUMBER
LONGITUDE                               NUMBER
ACCESS_INSTRUCTION                      VARCHAR2(40)
POND_SIZE                               NUMBER
POND_TYPE              ****                 VARCHAR2(10)
INSPECT_DATE                            VARCHAR2(10)
BASIN                                   VARCHAR2(20)
SUB_BASIN                               VARCHAR2(20)
POND_COND                               VARCHAR2(40)
GENERAL_COMMENTS                        VARCHAR2(40)


OWNERSHIP                               VARCHAR2(10)
SQLWKS> 	desc UTWATFITT;                                                                
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(8)
MAPID                                   NUMBER(8)
PROJECT_NUM                             VARCHAR2(11)
SCAN_NUM                                VARCHAR2(20)
FITTING_ID                              VARCHAR2(14)
MAP_GRID                                VARCHAR2(3)
MAP_QUAD                                VARCHAR2(1)
FITTING_NUM                             NUMBER(8)
PARENT_ID                               VARCHAR2(12)
FITTING_SIZE                            VARCHAR2(11)
FITTING_TYPE            ****                VARCHAR2(10)
PRESSURE_NORMAL                         NUMBER
PRESSURE_SOURCE                         VARCHAR2(10)
ZONE                                    VARCHAR2(4)
MANUFACTURER                            VARCHAR2(20)
WORK_ORDER_NUM                          VARCHAR2(10)
GENERAL_COMMENTS                        VARCHAR2(40)
OWNERSHIP                               VARCHAR2(10)
ASBUILT_DATE                            VARCHAR2(10)


SQLWKS> 	desc UTWATHYDR;                                                                
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(8)
MAPID                                   NUMBER(8)
PROJECT_NUM                             VARCHAR2(11)
SCAN_NUM                                VARCHAR2(20)
HYDRANT_ID                              VARCHAR2(14)
MAP_GRID                                VARCHAR2(3)
MAP_QUAD                                VARCHAR2(1)
HYDRANT_NUM                             NUMBER(8)
PARENT_ID                               VARCHAR2(12)
PRESSURE_STATIC                         NUMBER
PRESSURE_RESIDUAL                       NUMBER
PRESSURE_FLOW_TEST                      NUMBER
PRESSURE_TEST_DATE                      VARCHAR2(10)
HYDRANT_STATUS                          VARCHAR2(15)
HYDRANT_OWNER                           VARCHAR2(10)
ZONE                                    VARCHAR2(4)
MANUFACTURER                            VARCHAR2(20)
WORK_ORDER_NUM                          VARCHAR2(10)
GENERAL_COMMENTS                        VARCHAR2(40)
ASBUILT_DATE                            VARCHAR2(10)


SQLWKS> 	desc UTWATMETR;                                                                
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(8)
MAPID                                   NUMBER(8)
PROJECT_NUM                             VARCHAR2(11)
SCAN_NUM                                VARCHAR2(20)
METER_ID                                VARCHAR2(14)
MAP_GRID                                VARCHAR2(3)
MAP_QUAD                                VARCHAR2(1)
METER_NUM                               NUMBER(8)
PARENT_ID                               VARCHAR2(12)
METER_SIZE                              NUMBER
METER_TYPE              ****                VARCHAR2(20)
ZONE                                    VARCHAR2(4)
MANUFACTURER                            VARCHAR2(20)
SERIAL_NUM                              NUMBER
BILLING_CLASS                           VARCHAR2(12)
ACCOUNT_NUM                             VARCHAR2(10)
WORK_ORDER_NUM                          VARCHAR2(10)
GENERAL_COMMENTS                        VARCHAR2(40)
OWNERSHIP                               VARCHAR2(10)


SQLWKS> 	desc UTWATPIPE;                                                                
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(8)
MAPID                                   NUMBER(8)
PROJECT_NUM                             VARCHAR2(11)
SCAN_NUM                                VARCHAR2(20)
PIPE_ID                                 VARCHAR2(14)
MAP_GRID                                VARCHAR2(3)
MAP_QUAD                                VARCHAR2(1)
PIPE_NUM                                NUMBER(8)
PARENT_ID                               VARCHAR2(12)
PIPE_DIAMETER                           NUMBER
PIPE_LENGTH                             NUMBER
PIPE_MATERIAL       ****                    VARCHAR2(10)
PRESSURE_NORMAL                         NUMBER
ZONE                                    VARCHAR2(4)
MANUFACTURER                            VARCHAR2(20)
WORK_ORDER_NUM                          VARCHAR2(10)
GENERAL_COMMENTS                        VARCHAR2(40)
OWNERSHIP                               VARCHAR2(10)
ASBUILT_DATE                            VARCHAR2(10)


SQLWKS> 	desc UTWATPUMP;                                                                
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(8)
MAPID                                   NUMBER(8)
PROJECT_NUM                             VARCHAR2(11)
SCAN_NUM                                VARCHAR2(20)
PUMPSTA_ID                              VARCHAR2(14)
MAP_GRID                                VARCHAR2(3)
MAP_QUAD                                VARCHAR2(1)
PUMPSTA_NUM                             NUMBER(8)
PARENT_ID                               VARCHAR2(12)
PUMPSTA_TYPE                            VARCHAR2(10)
PUMP_TYPE            ****                   VARCHAR2(10)
QUANTITY                                NUMBER
CAPACITY                                NUMBER
STANDBY_GEN                             VARCHAR2(1)
ZONE                                    VARCHAR2(4)
ADDRESS                                 VARCHAR2(40)
WORK_ORDER_NUM                          VARCHAR2(10)
GENERAL_COMMENTS                        VARCHAR2(40)
OWNERSHIP                               VARCHAR2(10)
ASBUILT_DATE                            VARCHAR2(10)


SQLWKS> 	desc UTWATTANK;                                                                
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(8)
MAPID                                   NUMBER(8)
PROJECT_NUM                             VARCHAR2(11)
SCAN_NUM                                VARCHAR2(20)
TANK_ID                                 VARCHAR2(14)
MAP_GRID                                VARCHAR2(3)
MAP_QUAD                                VARCHAR2(1)
TANK_NUM                                NUMBER(8)
PARENT_ID                               VARCHAR2(12)
TANK_DIAMETER                           NUMBER
TANK_HEIGHT                             NUMBER
TANK_TYPE             ****                  VARCHAR2(2)
TANK_MATERIAL                           VARCHAR2(10)
TANK_STATUS                             VARCHAR2(15)
CAPACITY                                NUMBER
OVERFLOW_ELEV                           NUMBER
ALARM_LEVEL_HIGH                        NUMBER
ALARM_LEVEL_LOW                         NUMBER
ZONE                                    VARCHAR2(4)
WORK_ORDER_NUM                          VARCHAR2(10)
GENERAL_COMMENTS                        VARCHAR2(40)
OWNERSHIP                               VARCHAR2(10)
ASBUILT_DATE                            VARCHAR2(10)

SQLWKS> 	desc UTWATVALV;                                                                
Column Name                    Null?    Type
------------------------------ -------- ----
MSLINK                         NOT NULL NUMBER(8)
MAPID                                   NUMBER(8)
PROJECT_NUM                             VARCHAR2(11)
SCAN_NUM                                VARCHAR2(20)
VALVE_ID                                VARCHAR2(14)
MAP_GRID                                VARCHAR2(3)
MAP_QUAD                                VARCHAR2(1)
VALVE_NUM                               NUMBER(8)
PARENT_ID                               VARCHAR2(12)
VALVE_SIZE                              NUMBER
VALVE_TYPE             ****                 VARCHAR2(12)
PRESSURE_NORMAL                         NUMBER
VALVE_STATUS                            VARCHAR2(6)
ZONE                                    VARCHAR2(4)
MANUFACTURER                            VARCHAR2(20)
WORK_ORDER_NUM                          VARCHAR2(10)
GENERAL_COMMENTS                        VARCHAR2(40)
OWNERSHIP                               VARCHAR2(10)
ASBUILT_DATE                            VARCHAR2(10)
