--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	400;
set pagesize	9999;
--	=====================================================================

--drop   table GARLAND.PLAN_TABLE;

  create table GARLAND.PLAN_TABLE (
  STATEMENT_ID                      VARCHAR2(30)
 ,TIMESTAMP                         DATE
 ,REMARKS                           VARCHAR2(80)
 ,OPERATION                         VARCHAR2(30)
 ,OPTIONS                           VARCHAR2(255)
 ,OBJECT_NODE                       VARCHAR2(128)
 ,OBJECT_OWNER                      VARCHAR2(30)
 ,OBJECT_NAME                       VARCHAR2(30)
 ,OBJECT_INSTANCE                   NUMBER(22,0)
 ,OBJECT_TYPE                       VARCHAR2(30)
 ,OPTIMIZER                         VARCHAR2(255)
 ,SEARCH_COLUMNS                    NUMBER(22)
 ,ID                                NUMBER(22,0)
 ,PARENT_ID                         NUMBER(22,0)
 ,POSITION                          NUMBER(22,0)
 ,COST                              NUMBER(22,0)
 ,CARDINALITY                       NUMBER(22,0)
 ,BYTES                             NUMBER(22,0)
 ,OTHER_TAG                         VARCHAR2(255)
 ,PARTITION_START                   VARCHAR2(255)
 ,PARTITION_STOP                    VARCHAR2(255)
 ,PARTITION_ID                      NUMBER(22,0)
 ,OTHER                             LONG
 ,DISTRIBUTION                      VARCHAR2(30)
 ,CPU_COST                          NUMBER(22,0)
 ,IO_COST                           NUMBER(22,0)
 ,TEMP_SPACE                        NUMBER(22,0)
 ,ACCESS_PREDICATES                 VARCHAR2(4000)
 ,FILTER_PREDICATES                 VARCHAR2(4000)
  )  tablespace GIS_DATA  nologging
  ;


