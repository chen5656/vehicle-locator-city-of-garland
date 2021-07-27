Echo                            OFF
MGR-00308: no spool file opened
Echo                            OFF
Statement processed.
Statement processed.
19 rows processed.
Statement processed.
5 rows processed.
Statement processed.
1 row processed.
Statement processed.
KEY_                           TYPE_                          SCHEMA_                        PREFIX_                        SUFFIX_                        TABLESPACE_                    INITIAL_                       NEXT_                          PCTFREE_                       PCTUSED_                       MAXEXTENTS_                    MAXTRANS_                      OPTION1_                       OPTION2_                      
------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------
CATEGORY                       table                          GARLAND                        NEW_                                                          GIS_DATA                       32K                            32K                            10                             40                             249                            255                                                                                         
D_ADDR_BASIS                   table                          GARLAND                        NEW_                                                          GIS_DATA                       32K                            32K                            10                             40                             249                            255                                                                                         
D_ADDR_PFX_SFX                 table                          GARLAND                        NEW_                                                          GIS_DATA                       32K                            32K                            10                             40                             249                            255                                                                                         
D_ADDR_STATUS                  table                          GARLAND                        NEW_                                                          GIS_DATA                       32K                            32K                            10                             40                             249                            255                                                                                         
D_ADDR_TYPE                    table                          GARLAND                        NEW_                                                          GIS_DATA                       32K                            32K                            10                             40                             249                            255                                                                                         
D_ZIPCODE                      table                          GARLAND                        NEW_                                                          GIS_DATA                       32K                            32K                            10                             40                             249                            255                                                                                         
GARLAND_WORK_MASTER            table                          GARLAND                        NEW_                                                          GIS_DATA                       32K                            32K                            10                             40                             249                            255                                                                                         
INSPECTION_MASTER              table                          GARLAND                        NEW_                                                          GIS_DATA                       32K                            32K                            10                             40                             249                            255                                                                                         
LABEL                          table                          GARLAND                        NEW_                                                          GIS_DATA                       32K                            32K                            10                             40                             249                            255                                                                                         
LIST_DOMAIN                    table                          GARLAND                        NEW_                                                          GIS_DATA                       32K                            32K                            10                             40                             249                            255                                                                                         
MSFORMS                        table                          GARLAND                        NEW_                                                          GIS_DATA                       32K                            32K                            10                             40                             249                            255                                                                                         
PLAN_TABLE                     table                          GARLAND                        NEW_                                                          GIS_DATA                       32K                            32K                            10                             40                             249                            255                                                                                         
RANGE_DOMAIN                   table                          GARLAND                        NEW_                                                          GIS_DATA                       32K                            32K                            10                             40                             249                            255                                                                                         
RQST_USER_LOG                  table                          GARLAND                        NEW_                                                          GIS_DATA                       32K                            32K                            10                             40                             249                            255                                                                                         
SANI_COM_FL_RATE               table                          GARLAND                        NEW_                                                          GIS_DATA                       32K                            32K                            10                             40                             249                            255                                                                                         
SANI_COM_PICKUP                table                          GARLAND                        NEW_                                                          GIS_DATA                       32K                            32K                            10                             40                             249                            255                                                                                         
SURFACE_MASTER                 table                          GARLAND                        NEW_                                                          GIS_DATA                       32K                            32K                            10                             40                             249                            255                                                                                         
VIEW_CATALOG                   table                          GARLAND                        NEW_                                                          GIS_DATA                       32K                            32K                            10                             40                             249                            255                                                                                         
VIEW_JOIN                      table                          GARLAND                        NEW_                                                          GIS_DATA                       32K                            32K                            10                             40                             249                            255                                                                                         
PK_INSPECTION_MASTER           index                          GARLAND                                                                                      GISINDX                        32K                            32K                            10                             40                             249                            255                                                                                         
PK_SURFACE_MASTER              index                          GARLAND                                                                                      GISINDX                        32K                            32K                            10                             40                             249                            255                                                                                         
RQST_USER_LOG_PK               index                          GARLAND                                                                                      GISINDX                        32K                            32K                            10                             40                             249                            255                                                                                         
SANI_COM_PICKUP_PKEY           index                          GARLAND                                                                                      GISINDX                        32K                            32K                            10                             40                             249                            255                                                                                         
SURFACE_MASTER_PK              index                          GARLAND                                                                                      GISINDX                        32K                            32K                            10                             40                             249                            255                                                                                         
all                            as                             GARLAND                                                                                                                                                                                                                                                                                                                                                                            
25 rows selected.
Echo                            OFF
OWNER        TABLE_NAME                     TABLESPACE          
------------ ------------------------------ --------------------
GARLAND      CATEGORY                       GIS_DATA            
GARLAND      D_ADDR_BASIS                   GIS_DATA            
GARLAND      D_ADDR_PFX_SFX                 GIS_DATA            
GARLAND      D_ADDR_STATUS                  GIS_DATA            
GARLAND      D_ADDR_TYPE                    GIS_DATA            
GARLAND      D_ZIPCODE                      GIS_DATA            
GARLAND      GARLAND_WORK_MASTER            GIS_DATA            
GARLAND      INSPECTION_MASTER              GIS_DATA            
GARLAND      LABEL                          GIS_DATA            
GARLAND      LIST_DOMAIN                    GIS_DATA            
GARLAND      MSFORMS                        GIS_DATA            
GARLAND      PLAN_TABLE                     GIS_DATA            
GARLAND      RANGE_DOMAIN                   GIS_DATA            
GARLAND      RQST_USER_LOG                  GIS_DATA            
GARLAND      SANI_COM_FL_RATE               GIS_DATA            
GARLAND      SANI_COM_PICKUP                GIS_DATA            
GARLAND      SURFACE_MASTER                 GIS_DATA            
GARLAND      VIEW_CATALOG                   GIS_DATA            
GARLAND      VIEW_JOIN                      GIS_DATA            
19 rows selected.
OWNER        INDEX_NAME                     TABLE_NAME                     TABLESPACE           UNIQUENES
------------ ------------------------------ ------------------------------ -------------------- ---------
GARLAND      PK_INSPECTION_MASTER           INSPECTION_MASTER              GISINDX              UNIQUE   
GARLAND      RQST_USER_LOG_PK               RQST_USER_LOG                  GISINDX              UNIQUE   
GARLAND      SANI_COM_PICKUP_PKEY           SANI_COM_PICKUP                GISINDX              UNIQUE   
GARLAND      PK_SURFACE_MASTER              SURFACE_MASTER                 GISINDX              UNIQUE   
GARLAND      SURFACE_MASTER_PK              SURFACE_MASTER                 GISINDX              UNIQUE   
5 rows selected.
OWNER        CONSTRAINT_NAME                TABLE_NAME                     C PARENT_OWNER PARENT_CONSTRAINT             
------------ ------------------------------ ------------------------------ - ------------ ------------------------------
GARLAND      PK_INSPECTION_MASTER           INSPECTION_MASTER              P                                            
GARLAND      RQST_USER_LOG_PK               RQST_USER_LOG                  P                                            
GARLAND      SANI_COM_PICKUP_PKEY           SANI_COM_PICKUP                P                                            
GARLAND      PK_SURFACE_MASTER              SURFACE_MASTER                 P                                            
4 rows selected.
OWNER        TABLE_SEGMENT                  BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      GARLAND_WORK_MASTER                 10240          1      10240      10240 GIS_DATA            
GARLAND      VIEW_JOIN                           10240          1      10240      10240 GIS_DATA            
GARLAND      VIEW_CATALOG                        10240          1      10240      10240 GIS_DATA            
GARLAND      SURFACE_MASTER                      10240          1      10240      10240 GIS_DATA            
GARLAND      SANI_COM_PICKUP                     10240          1      10240      10240 GIS_DATA            
GARLAND      RQST_USER_LOG                       10240          1      10240      10240 GIS_DATA            
GARLAND      LIST_DOMAIN                         12288          1      10240      10240 GIS_DATA            
GARLAND      RANGE_DOMAIN                        10240          1      10240      10240 GIS_DATA            
GARLAND      LABEL                               10240          1      10240      10240 GIS_DATA            
GARLAND      INSPECTION_MASTER                   10240          1      10240      10240 GIS_DATA            
GARLAND      MSFORMS                             10240          1      10240      10240 GIS_DATA            
GARLAND      PLAN_TABLE                          10240          1      10240      10240 GIS_DATA            
GARLAND      D_ADDR_BASIS                        10240          1      10240      10240 GIS_DATA            
GARLAND      D_ADDR_PFX_SFX                      10240          1      10240      10240 GIS_DATA            
GARLAND      D_ADDR_STATUS                       10240          1      10240      10240 GIS_DATA            
GARLAND      D_ADDR_TYPE                         10240          1      10240      10240 GIS_DATA            
GARLAND      CATEGORY                            10240          1      10240      10240 GIS_DATA            
GARLAND      D_ZIPCODE                           10240          1      10240      10240 GIS_DATA            
GARLAND      SANI_COM_FL_RATE                    10240          1      10240      10240 GIS_DATA            
19 rows selected.
OWNER        INDEX_SEGMENT                  BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      PK_INSPECTION_MASTER                10240          1      10240      10240 GISINDX             
GARLAND      PK_SURFACE_MASTER                   10240          1      10240      10240 GISINDX             
GARLAND      RQST_USER_LOG_PK                    10240          1      10240      10240 GISINDX             
GARLAND      SANI_COM_PICKUP_PKEY                10240          1      10240      10240 GISINDX             
GARLAND      SURFACE_MASTER_PK                   10240          1      10240      10240 GISINDX             
5 rows selected.
OWNER        CONSTRAINT_NAME                TABLE_NAME                     C PARENT_OWNER PARENT_CONSTRAINT             
------------ ------------------------------ ------------------------------ - ------------ ------------------------------
0 rows selected.
TABLE_NAME                     TRIGGER_NAME                   TRIGGER_TYPE    
------------------------------ ------------------------------ ----------------
0 rows selected.
TABLE_NAME                     PRIVILEGE                               
------------------------------ ----------------------------------------
0 rows selected.
Echo                            OFF
Charwidth                       100
Echo                            OFF
Server Output                   ON
Charwidth                       100
Statement processed.
select 'CREATE CATEGORY' " " from dual;
create table   GARLAND.NEW_CATEGORY
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.CATEGORY;
select count(*) "CATEGORY" from GARLAND.CATEGORY;
select count(*) " " from GARLAND.NEW_CATEGORY;
;
select 'CREATE D_ADDR_BASIS' " " from dual;
create table   GARLAND.NEW_D_ADDR_BASIS
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.D_ADDR_BASIS;
select count(*) "D_ADDR_BASIS" from GARLAND.D_ADDR_BASIS;
select count(*) " " from GARLAND.NEW_D_ADDR_BASIS;
;
select 'CREATE D_ADDR_PFX_SFX' " " from dual;
create table   GARLAND.NEW_D_ADDR_PFX_SFX
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.D_ADDR_PFX_SFX;
select count(*) "D_ADDR_PFX_SFX" from GARLAND.D_ADDR_PFX_SFX;
select count(*) " " from GARLAND.NEW_D_ADDR_PFX_SFX;
;
select 'CREATE D_ADDR_STATUS' " " from dual;
create table   GARLAND.NEW_D_ADDR_STATUS
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.D_ADDR_STATUS;
select count(*) "D_ADDR_STATUS" from GARLAND.D_ADDR_STATUS;
select count(*) " " from GARLAND.NEW_D_ADDR_STATUS;
;
select 'CREATE D_ADDR_TYPE' " " from dual;
create table   GARLAND.NEW_D_ADDR_TYPE
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.D_ADDR_TYPE;
select count(*) "D_ADDR_TYPE" from GARLAND.D_ADDR_TYPE;
select count(*) " " from GARLAND.NEW_D_ADDR_TYPE;
;
select 'CREATE D_ZIPCODE' " " from dual;
create table   GARLAND.NEW_D_ZIPCODE
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.D_ZIPCODE;
select count(*) "D_ZIPCODE" from GARLAND.D_ZIPCODE;
select count(*) " " from GARLAND.NEW_D_ZIPCODE;
;
select 'CREATE GARLAND_WORK_MASTER' " " from dual;
create table   GARLAND.NEW_GARLAND_WORK_MASTER
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.GARLAND_WORK_MASTER;
select count(*) "GARLAND_WORK_MASTER" from GARLAND.GARLAND_WORK_MASTER;
select count(*) " " from GARLAND.NEW_GARLAND_WORK_MASTER;
;
select 'CREATE INSPECTION_MASTER' " " from dual;
create table   GARLAND.NEW_INSPECTION_MASTER
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.INSPECTION_MASTER;
select count(*) "INSPECTION_MASTER" from GARLAND.INSPECTION_MASTER;
select count(*) " " from GARLAND.NEW_INSPECTION_MASTER;
;
select 'CREATE LABEL' " " from dual;
create table   GARLAND.NEW_LABEL
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.LABEL;
select count(*) "LABEL" from GARLAND.LABEL;
select count(*) " " from GARLAND.NEW_LABEL;
;
select 'CREATE LIST_DOMAIN' " " from dual;
create table   GARLAND.NEW_LIST_DOMAIN
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.LIST_DOMAIN;
select count(*) "LIST_DOMAIN" from GARLAND.LIST_DOMAIN;
select count(*) " " from GARLAND.NEW_LIST_DOMAIN;
;
select 'CREATE MSFORMS' " " from dual;
create table   GARLAND.NEW_MSFORMS
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.MSFORMS;
select count(*) "MSFORMS" from GARLAND.MSFORMS;
select count(*) " " from GARLAND.NEW_MSFORMS;
;
select 'CREATE PLAN_TABLE' " " from dual;
create table   GARLAND.NEW_PLAN_TABLE
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.PLAN_TABLE;
select count(*) "PLAN_TABLE" from GARLAND.PLAN_TABLE;
select count(*) " " from GARLAND.NEW_PLAN_TABLE;
;
select 'CREATE RANGE_DOMAIN' " " from dual;
create table   GARLAND.NEW_RANGE_DOMAIN
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.RANGE_DOMAIN;
select count(*) "RANGE_DOMAIN" from GARLAND.RANGE_DOMAIN;
select count(*) " " from GARLAND.NEW_RANGE_DOMAIN;
;
select 'CREATE RQST_USER_LOG' " " from dual;
create table   GARLAND.NEW_RQST_USER_LOG
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.RQST_USER_LOG;
select count(*) "RQST_USER_LOG" from GARLAND.RQST_USER_LOG;
select count(*) " " from GARLAND.NEW_RQST_USER_LOG;
;
select 'CREATE SANI_COM_FL_RATE' " " from dual;
create table   GARLAND.NEW_SANI_COM_FL_RATE
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.SANI_COM_FL_RATE;
select count(*) "SANI_COM_FL_RATE" from GARLAND.SANI_COM_FL_RATE;
select count(*) " " from GARLAND.NEW_SANI_COM_FL_RATE;
;
select 'CREATE SANI_COM_PICKUP' " " from dual;
create table   GARLAND.NEW_SANI_COM_PICKUP
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.SANI_COM_PICKUP;
select count(*) "SANI_COM_PICKUP" from GARLAND.SANI_COM_PICKUP;
select count(*) " " from GARLAND.NEW_SANI_COM_PICKUP;
;
select 'CREATE SURFACE_MASTER' " " from dual;
create table   GARLAND.NEW_SURFACE_MASTER
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.SURFACE_MASTER;
select count(*) "SURFACE_MASTER" from GARLAND.SURFACE_MASTER;
select count(*) " " from GARLAND.NEW_SURFACE_MASTER;
;
select 'CREATE VIEW_CATALOG' " " from dual;
create table   GARLAND.NEW_VIEW_CATALOG
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.VIEW_CATALOG;
select count(*) "VIEW_CATALOG" from GARLAND.VIEW_CATALOG;
select count(*) " " from GARLAND.NEW_VIEW_CATALOG;
;
select 'CREATE VIEW_JOIN' " " from dual;
create table   GARLAND.NEW_VIEW_JOIN
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.VIEW_JOIN;
select count(*) "VIEW_JOIN" from GARLAND.VIEW_JOIN;
select count(*) " " from GARLAND.NEW_VIEW_JOIN;
;
Echo                            OFF
Timing                          OFF
Echo                            OFF
Server Output                   ON
Charwidth                       100
Statement processed.
select 'SURFACE_MASTER_PK' " " from dual;
create unique index   GARLAND.SURFACE_MASTER_PK
       on      GARLAND.SURFACE_MASTER
(
 CATEGORY
,SURFACE_TYPE
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;
Echo                            OFF
Server Output                   ON
Charwidth                       100
Statement processed.
select 'PK_INSPECTION_MASTER' " "  from dual;
alter table    GARLAND.INSPECTION_MASTER
add constraint PK_INSPECTION_MASTER   primary key
(
 CLASS_NAME
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;
select 'PK_SURFACE_MASTER' " "  from dual;
alter table    GARLAND.SURFACE_MASTER
add constraint PK_SURFACE_MASTER   primary key
(
 SURFACE_TYPE
,CATEGORY
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;
select 'RQST_USER_LOG_PK' " "  from dual;
alter table    GARLAND.RQST_USER_LOG
add constraint RQST_USER_LOG_PK   primary key
(
 USER_NAME
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;
select 'SANI_COM_PICKUP_PKEY' " "  from dual;
alter table    GARLAND.SANI_COM_PICKUP
add constraint SANI_COM_PICKUP_PKEY   primary key
(
 PICKUP_CODE
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;
Echo                            OFF
Server Output                   ON
Charwidth                       100
Statement processed.
Echo                            OFF
Server Output                   ON
Charwidth                       100
Statement processed.
Echo                            OFF
Server Output                   ON
Statement processed.
                                                                     
---------------------------------------------------------------------
	drop table CATEGORY;   --  cascade constraints                      
	drop table D_ADDR_BASIS;   --  cascade constraints                  
	drop table D_ADDR_PFX_SFX;   --  cascade constraints                
	drop table D_ADDR_STATUS;   --  cascade constraints                 
	drop table D_ADDR_TYPE;   --  cascade constraints                   
	drop table D_ZIPCODE;   --  cascade constraints                     
	drop table GARLAND_WORK_MASTER;   --  cascade constraints           
	drop table INSPECTION_MASTER;   --  cascade constraints             
	drop table LABEL;   --  cascade constraints                         
	drop table LIST_DOMAIN;   --  cascade constraints                   
	drop table MSFORMS;   --  cascade constraints                       
	drop table PLAN_TABLE;   --  cascade constraints                    
	drop table RANGE_DOMAIN;   --  cascade constraints                  
	drop table RQST_USER_LOG;   --  cascade constraints                 
	drop table SANI_COM_FL_RATE;   --  cascade constraints              
	drop table SANI_COM_PICKUP;   --  cascade constraints               
	drop table SURFACE_MASTER;   --  cascade constraints                
	drop table VIEW_CATALOG;   --  cascade constraints                  
	drop table VIEW_JOIN;   --  cascade constraints                     
19 rows selected.
                                                                                                    
----------------------------------------------------------------------------------------------------
	rename NEW_CATEGORY  to  CATEGORY;                                                                 
	rename NEW_D_ADDR_BASIS  to  D_ADDR_BASIS;                                                         
	rename NEW_D_ADDR_PFX_SFX  to  D_ADDR_PFX_SFX;                                                     
	rename NEW_D_ADDR_STATUS  to  D_ADDR_STATUS;                                                       
	rename NEW_D_ADDR_TYPE  to  D_ADDR_TYPE;                                                           
	rename NEW_D_ZIPCODE  to  D_ZIPCODE;                                                               
	rename NEW_GARLAND_WORK_MASTER  to  GARLAND_WORK_MASTER;                                           
	rename NEW_INSPECTION_MASTER  to  INSPECTION_MASTER;                                               
	rename NEW_LABEL  to  LABEL;                                                                       
	rename NEW_LIST_DOMAIN  to  LIST_DOMAIN;                                                           
	rename NEW_MSFORMS  to  MSFORMS;                                                                   
	rename NEW_PLAN_TABLE  to  PLAN_TABLE;                                                             
	rename NEW_RANGE_DOMAIN  to  RANGE_DOMAIN;                                                         
	rename NEW_RQST_USER_LOG  to  RQST_USER_LOG;                                                       
	rename NEW_SANI_COM_FL_RATE  to  SANI_COM_FL_RATE;                                                 
	rename NEW_SANI_COM_PICKUP  to  SANI_COM_PICKUP;                                                   
	rename NEW_SURFACE_MASTER  to  SURFACE_MASTER;                                                     
	rename NEW_VIEW_CATALOG  to  VIEW_CATALOG;                                                         
	rename NEW_VIEW_JOIN  to  VIEW_JOIN;                                                               
19 rows selected.
                                                                                                 
-------------------------------------------------------------------------------------------------
analyze table GARLAND.CATEGORY   compute statistics;                                             
analyze table GARLAND.D_ADDR_BASIS   compute statistics;                                         
analyze table GARLAND.D_ADDR_PFX_SFX   compute statistics;                                       
analyze table GARLAND.D_ADDR_STATUS   compute statistics;                                        
analyze table GARLAND.D_ADDR_TYPE   compute statistics;                                          
analyze table GARLAND.D_ZIPCODE   compute statistics;                                            
analyze table GARLAND.GARLAND_WORK_MASTER   compute statistics;                                  
analyze table GARLAND.INSPECTION_MASTER   compute statistics;                                    
analyze table GARLAND.LABEL   compute statistics;                                                
analyze table GARLAND.LIST_DOMAIN   compute statistics;                                          
analyze table GARLAND.MSFORMS   compute statistics;                                              
analyze table GARLAND.PLAN_TABLE   compute statistics;                                           
analyze table GARLAND.RANGE_DOMAIN   compute statistics;                                         
analyze table GARLAND.RQST_USER_LOG   compute statistics;                                        
analyze table GARLAND.SANI_COM_FL_RATE   compute statistics;                                     
analyze table GARLAND.SANI_COM_PICKUP   compute statistics;                                      
analyze table GARLAND.SURFACE_MASTER   compute statistics;                                       
analyze table GARLAND.VIEW_CATALOG   compute statistics;                                         
analyze table GARLAND.VIEW_JOIN   compute statistics;                                            
19 rows selected.

               
---------------
CREATE CATEGORY
1 row selected.
Statement processed.
CATEGORY  
----------
        27
1 row selected.
          
----------
        27
1 row selected.
                   
-------------------
CREATE D_ADDR_BASIS
1 row selected.
Statement processed.
D_ADDR_BAS
----------
        44
1 row selected.
          
----------
        44
1 row selected.
                     
---------------------
CREATE D_ADDR_PFX_SFX
1 row selected.
Statement processed.
D_ADDR_PFX
----------
         5
1 row selected.
          
----------
         5
1 row selected.
                    
--------------------
CREATE D_ADDR_STATUS
1 row selected.
Statement processed.
D_ADDR_STA
----------
         2
1 row selected.
          
----------
         2
1 row selected.
                  
------------------
CREATE D_ADDR_TYPE
1 row selected.
Statement processed.
D_ADDR_TYP
----------
        19
1 row selected.
          
----------
        19
1 row selected.
                
----------------
CREATE D_ZIPCODE
1 row selected.
Statement processed.
D_ZIPCODE 
----------
         6
1 row selected.
          
----------
         6
1 row selected.
                          
--------------------------
CREATE GARLAND_WORK_MASTER
1 row selected.
Statement processed.
GARLAND_WO
----------
        25
1 row selected.
          
----------
        25
1 row selected.
                        
------------------------
CREATE INSPECTION_MASTER
1 row selected.
Statement processed.
INSPECTION
----------
         5
1 row selected.
          
----------
         5
1 row selected.
            
------------
CREATE LABEL
1 row selected.
Statement processed.
LABEL     
----------
        42
1 row selected.
          
----------
        42
1 row selected.
                  
------------------
CREATE LIST_DOMAIN
1 row selected.
Statement processed.
LIST_DOMAI
----------
         0
1 row selected.
          
----------
         0
1 row selected.
              
--------------
CREATE MSFORMS
1 row selected.
Statement processed.
MSFORMS   
----------
         1
1 row selected.
          
----------
         1
1 row selected.
                 
-----------------
CREATE PLAN_TABLE
1 row selected.
as select * from GARLAND.PLAN_TABLE
          *
ORA-00997: illegal use of LONG datatype
PLAN_TABLE
----------
        20
1 row selected.
select count(*) " " from GARLAND.NEW_PLAN_TABLE
                                 *
ORA-00942: table or view does not exist
                   
-------------------
CREATE RANGE_DOMAIN
1 row selected.
Statement processed.
RANGE_DOMA
----------
         0
1 row selected.
          
----------
         0
1 row selected.
                    
--------------------
CREATE RQST_USER_LOG
1 row selected.
Statement processed.
RQST_USER_
----------
         8
1 row selected.
          
----------
         8
1 row selected.
                       
-----------------------
CREATE SANI_COM_FL_RATE
1 row selected.
Statement processed.
SANI_COM_F
----------
        12
1 row selected.
          
----------
        12
1 row selected.
                      
----------------------
CREATE SANI_COM_PICKUP
1 row selected.
Statement processed.
SANI_COM_P
----------
        23
1 row selected.
          
----------
        23
1 row selected.
                     
---------------------
CREATE SURFACE_MASTER
1 row selected.
Statement processed.
SURFACE_MA
----------
         6
1 row selected.
          
----------
         6
1 row selected.
                   
-------------------
CREATE VIEW_CATALOG
1 row selected.
Statement processed.
VIEW_CATAL
----------
        40
1 row selected.
          
----------
        40
1 row selected.
                
----------------
CREATE VIEW_JOIN
1 row selected.
Statement processed.
VIEW_JOIN 
----------
        36
1 row selected.
          
----------
        36
1 row selected.
ORIGINALS 
----------
        19
1 row selected.
COPIES    
----------
        19
1 row selected.
MISSING COPIES                
------------------------------
PLAN_TABLE                    
1 row selected.
SEGMENT TYPE      SEGMENT NAME                   EXTENTS    INITIAL    NEXT       SIZE      
----------------- ------------------------------ ---------- ---------- ---------- ----------
TABLE             CATEGORY                                1      10240      10240      10240
TABLE             D_ADDR_BASIS                            1      10240      10240      10240
TABLE             D_ADDR_PFX_SFX                          1      10240      10240      10240
TABLE             D_ADDR_STATUS                           1      10240      10240      10240
TABLE             D_ADDR_TYPE                             1      10240      10240      10240
TABLE             D_ZIPCODE                               1      10240      10240      10240
TABLE             GARLAND_WORK_MASTER                     1      10240      10240      10240
TABLE             INSPECTION_MASTER                       1      10240      10240      10240
TABLE             LABEL                                   1      10240      10240      10240
TABLE             LIST_DOMAIN                             1      10240      10240      12288
TABLE             MSFORMS                                 1      10240      10240      10240
TABLE             PLAN_TABLE                              1      10240      10240      10240
TABLE             RANGE_DOMAIN                            1      10240      10240      10240
TABLE             RQST_USER_LOG                           1      10240      10240      10240
TABLE             SANI_COM_FL_RATE                        1      10240      10240      10240
TABLE             SANI_COM_PICKUP                         1      10240      10240      10240
TABLE             SURFACE_MASTER                          1      10240      10240      10240
TABLE             VIEW_CATALOG                            1      10240      10240      10240
TABLE             VIEW_JOIN                               1      10240      10240      10240
INDEX             PK_INSPECTION_MASTER                    1      10240      10240      10240
INDEX             PK_SURFACE_MASTER                       1      10240      10240      10240
INDEX             RQST_USER_LOG_PK                        1      10240      10240      10240
INDEX             SANI_COM_PICKUP_PKEY                    1      10240      10240      10240
INDEX             SURFACE_MASTER_PK                       1      10240      10240      10240
24 rows selected.
Echo                            OFF



SQLWKS> --	=========================================================================
SQLWKS> --	DROP ORIGINAL TABLE
SQLWKS> 
SQLWKS> 	@c:\deacutis\scripts\ora_create\SCRIPT_DROP.sql;
SQLWKS>                                                                      
SQLWKS> ---------------------------------------------------------------------
SQLWKS> 	drop table CATEGORY;   --  cascade constraints                      
Statement processed.
SQLWKS> 	drop table D_ADDR_BASIS;   --  cascade constraints                  
Statement processed.
SQLWKS> 	drop table D_ADDR_PFX_SFX;   --  cascade constraints                
Statement processed.
SQLWKS> 	drop table D_ADDR_STATUS;   --  cascade constraints                 
Statement processed.
SQLWKS> 	drop table D_ADDR_TYPE;   --  cascade constraints                   
Statement processed.
SQLWKS> 	drop table D_ZIPCODE;   --  cascade constraints                     
Statement processed.
SQLWKS> 	drop table GARLAND_WORK_MASTER;   --  cascade constraints           
Statement processed.
SQLWKS> 	drop table INSPECTION_MASTER;   --  cascade constraints             
Statement processed.
SQLWKS> 	drop table LABEL;   --  cascade constraints                         
Statement processed.
SQLWKS> 	drop table LIST_DOMAIN;   --  cascade constraints                   
Statement processed.
SQLWKS> 	drop table MSFORMS;   --  cascade constraints                       
Statement processed.
SQLWKS> 	drop table RANGE_DOMAIN;   --  cascade constraints                  
Statement processed.
SQLWKS> 	drop table RQST_USER_LOG;   --  cascade constraints                 
Statement processed.
SQLWKS> 	drop table SANI_COM_FL_RATE;   --  cascade constraints              
Statement processed.
SQLWKS> 	drop table SANI_COM_PICKUP;   --  cascade constraints               
Statement processed.
SQLWKS> 	drop table SURFACE_MASTER;   --  cascade constraints                
Statement processed.
SQLWKS> 	drop table VIEW_CATALOG;   --  cascade constraints                  
Statement processed.
SQLWKS> 	drop table VIEW_JOIN;   --  cascade constraints                     
Statement processed.
SQLWKS> 
SQLWKS> --	@d:\scripts\ora_create\SCRIPT_DROP.sql;
SQLWKS> 
SQLWKS> --	=========================================================================
SQLWKS> --	RENAME TO ORIGINAL TABLE
SQLWKS> 
SQLWKS> 	@c:\deacutis\scripts\ora_create\SCRIPT_RENAME.sql;
SQLWKS>                                                                                                     
SQLWKS> ----------------------------------------------------------------------------------------------------
SQLWKS> 	rename NEW_CATEGORY  to  CATEGORY;                                                                 
Statement processed.
SQLWKS> 	rename NEW_D_ADDR_BASIS  to  D_ADDR_BASIS;                                                         
Statement processed.
SQLWKS> 	rename NEW_D_ADDR_PFX_SFX  to  D_ADDR_PFX_SFX;                                                     
Statement processed.
SQLWKS> 	rename NEW_D_ADDR_STATUS  to  D_ADDR_STATUS;                                                       
Statement processed.
SQLWKS> 	rename NEW_D_ADDR_TYPE  to  D_ADDR_TYPE;                                                           
Statement processed.
SQLWKS> 	rename NEW_D_ZIPCODE  to  D_ZIPCODE;                                                               
Statement processed.
SQLWKS> 	rename NEW_GARLAND_WORK_MASTER  to  GARLAND_WORK_MASTER;                                           
Statement processed.
SQLWKS> 	rename NEW_INSPECTION_MASTER  to  INSPECTION_MASTER;                                               
Statement processed.
SQLWKS> 	rename NEW_LABEL  to  LABEL;                                                                       
Statement processed.
SQLWKS> 	rename NEW_LIST_DOMAIN  to  LIST_DOMAIN;                                                           
Statement processed.
SQLWKS> 	rename NEW_MSFORMS  to  MSFORMS;                                                                   
Statement processed.
SQLWKS> 	rename NEW_RANGE_DOMAIN  to  RANGE_DOMAIN;                                                         
Statement processed.
SQLWKS> 	rename NEW_RQST_USER_LOG  to  RQST_USER_LOG;                                                       
Statement processed.
SQLWKS> 	rename NEW_SANI_COM_FL_RATE  to  SANI_COM_FL_RATE;                                                 
Statement processed.
SQLWKS> 	rename NEW_SANI_COM_PICKUP  to  SANI_COM_PICKUP;                                                   
Statement processed.
SQLWKS> 	rename NEW_SURFACE_MASTER  to  SURFACE_MASTER;                                                     
Statement processed.
SQLWKS> 	rename NEW_VIEW_CATALOG  to  VIEW_CATALOG;                                                         
Statement processed.
SQLWKS> 	rename NEW_VIEW_JOIN  to  VIEW_JOIN;                                                               
Statement processed.
SQLWKS> 
SQLWKS> --	@d:\scripts\ora_create\SCRIPT_RENAME.sql;
SQLWKS> 
SQLWKS> 
SQLWKS> 
SQLWKS> 	set echo off;
Echo                            OFF
                 
-----------------
SURFACE_MASTER_PK
1 row selected.
Statement processed.
                    
--------------------
PK_INSPECTION_MASTER
1 row selected.
Statement processed.
                 
-----------------
PK_SURFACE_MASTER
1 row selected.
Statement processed.
                
----------------
RQST_USER_LOG_PK
1 row selected.
Statement processed.
                    
--------------------
SANI_COM_PICKUP_PKEY
1 row selected.
Statement processed.
Echo                            ON
SQLWKS> 
SQLWKS> --	================================================================================
SQLWKS> --	ANALYZE TABLES
SQLWKS> 
SQLWKS> 	@c:\deacutis\scripts\ora_create\Script_Analyze.sql;
SQLWKS>                                                                                                  
SQLWKS> -------------------------------------------------------------------------------------------------
SQLWKS> analyze table GARLAND.CATEGORY   compute statistics;                                             
Statement processed.
SQLWKS> analyze table GARLAND.D_ADDR_BASIS   compute statistics;                                         
Statement processed.
SQLWKS> analyze table GARLAND.D_ADDR_PFX_SFX   compute statistics;                                       
Statement processed.
SQLWKS> analyze table GARLAND.D_ADDR_STATUS   compute statistics;                                        
Statement processed.
SQLWKS> analyze table GARLAND.D_ADDR_TYPE   compute statistics;                                          
Statement processed.
SQLWKS> analyze table GARLAND.D_ZIPCODE   compute statistics;                                            
Statement processed.
SQLWKS> analyze table GARLAND.GARLAND_WORK_MASTER   compute statistics;                                  
Statement processed.
SQLWKS> analyze table GARLAND.INSPECTION_MASTER   compute statistics;                                    
Statement processed.
SQLWKS> analyze table GARLAND.LABEL   compute statistics;                                                
Statement processed.
SQLWKS> analyze table GARLAND.LIST_DOMAIN   compute statistics;                                          
Statement processed.
SQLWKS> analyze table GARLAND.MSFORMS   compute statistics;                                              
Statement processed.
SQLWKS> analyze table GARLAND.PLAN_TABLE   compute statistics;                                           
Statement processed.
SQLWKS> analyze table GARLAND.RANGE_DOMAIN   compute statistics;                                         
Statement processed.
SQLWKS> analyze table GARLAND.RQST_USER_LOG   compute statistics;                                        
Statement processed.
SQLWKS> analyze table GARLAND.SANI_COM_FL_RATE   compute statistics;                                     
Statement processed.
SQLWKS> analyze table GARLAND.SANI_COM_PICKUP   compute statistics;                                      
Statement processed.

SQLWKS> analyze table GARLAND.SURFACE_MASTER   compute statistics;                                       
Statement processed.
SQLWKS> analyze table GARLAND.VIEW_CATALOG   compute statistics;                                         
Statement processed.
SQLWKS> analyze table GARLAND.VIEW_JOIN   compute statistics;                                            
Statement processed.
SQLWKS> 
SQLWKS> --	@d:\scripts\ora_create\Script_Analyze.sql;
SQLWKS> 
SQLWKS> --	================================================================================
SQLWKS> 
SQLWKS> 
SQLWKS> 	
SQLWKS> 	
SQLWKS> 
SQLWKS> 
SQLWKS> 
SQLWKS> 	@c:\deacutis\scripts\ora_create\09_SUMMARY.sql;		--	display data dictionary info
SQLWKS> 	set echo off;
Echo                            OFF
OWNER        TABLE_NAME                     TABLESPACE          
------------ ------------------------------ --------------------
GARLAND      CATEGORY                       GIS_DATA            
GARLAND      D_ADDR_BASIS                   GIS_DATA            
GARLAND      D_ADDR_PFX_SFX                 GIS_DATA            
GARLAND      D_ADDR_STATUS                  GIS_DATA            
GARLAND      D_ADDR_TYPE                    GIS_DATA            
GARLAND      D_ZIPCODE                      GIS_DATA            
GARLAND      GARLAND_WORK_MASTER            GIS_DATA            
GARLAND      INSPECTION_MASTER              GIS_DATA            
GARLAND      LABEL                          GIS_DATA            
GARLAND      LIST_DOMAIN                    GIS_DATA            
GARLAND      MSFORMS                        GIS_DATA            
GARLAND      PLAN_TABLE                     GIS_DATA            
GARLAND      RANGE_DOMAIN                   GIS_DATA            
GARLAND      RQST_USER_LOG                  GIS_DATA            
GARLAND      SANI_COM_FL_RATE               GIS_DATA            
GARLAND      SANI_COM_PICKUP                GIS_DATA            
GARLAND      SURFACE_MASTER                 GIS_DATA            
GARLAND      VIEW_CATALOG                   GIS_DATA            
GARLAND      VIEW_JOIN                      GIS_DATA            
19 rows selected.
OWNER        INDEX_NAME                     TABLE_NAME                     TABLESPACE           UNIQUENES
------------ ------------------------------ ------------------------------ -------------------- ---------
GARLAND      PK_INSPECTION_MASTER           INSPECTION_MASTER              GISINDX              UNIQUE   
GARLAND      RQST_USER_LOG_PK               RQST_USER_LOG                  GISINDX              UNIQUE   
GARLAND      SANI_COM_PICKUP_PKEY           SANI_COM_PICKUP                GISINDX              UNIQUE   
GARLAND      PK_SURFACE_MASTER              SURFACE_MASTER                 GISINDX              UNIQUE   
GARLAND      SURFACE_MASTER_PK              SURFACE_MASTER                 GISINDX              UNIQUE   
5 rows selected.
OWNER        CONSTRAINT_NAME                TABLE_NAME                     C PARENT_OWNER PARENT_CONSTRAINT             
------------ ------------------------------ ------------------------------ - ------------ ------------------------------
GARLAND      PK_INSPECTION_MASTER           INSPECTION_MASTER              P                                            
GARLAND      RQST_USER_LOG_PK               RQST_USER_LOG                  P                                            
GARLAND      SANI_COM_PICKUP_PKEY           SANI_COM_PICKUP                P                                            
GARLAND      PK_SURFACE_MASTER              SURFACE_MASTER                 P                                            
4 rows selected.
OWNER        TABLE_SEGMENT                  BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      RQST_USER_LOG                       40960          1      32768      32768 GIS_DATA            
GARLAND      SANI_COM_FL_RATE                    40960          1      32768      32768 GIS_DATA            
GARLAND      LIST_DOMAIN                         40960          1      32768      32768 GIS_DATA            
GARLAND      MSFORMS                             40960          1      32768      32768 GIS_DATA            
GARLAND      CATEGORY                            40960          1      32768      32768 GIS_DATA            
GARLAND      D_ADDR_BASIS                        40960          1      32768      32768 GIS_DATA            
GARLAND      D_ADDR_PFX_SFX                      40960          1      32768      32768 GIS_DATA            
GARLAND      D_ADDR_STATUS                       40960          1      32768      32768 GIS_DATA            
GARLAND      D_ADDR_TYPE                         40960          1      32768      32768 GIS_DATA            
GARLAND      INSPECTION_MASTER                   40960          1      32768      32768 GIS_DATA            
GARLAND      LABEL                               40960          1      32768      32768 GIS_DATA            
GARLAND      SANI_COM_PICKUP                     40960          1      32768      32768 GIS_DATA            
GARLAND      SURFACE_MASTER                      40960          1      32768      32768 GIS_DATA            
GARLAND      VIEW_CATALOG                        40960          1      32768      32768 GIS_DATA            
GARLAND      VIEW_JOIN                           40960          1      32768      32768 GIS_DATA            
GARLAND      PLAN_TABLE                          10240          1      10240      10240 GIS_DATA            
GARLAND      D_ZIPCODE                           40960          1      32768      32768 GIS_DATA            
GARLAND      GARLAND_WORK_MASTER                 40960          1      32768      32768 GIS_DATA            
GARLAND      RANGE_DOMAIN                        40960          1      32768      32768 GIS_DATA            
19 rows selected.
OWNER        INDEX_SEGMENT                  BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      PK_INSPECTION_MASTER                40960          1      32768      32768 GISINDX             
GARLAND      PK_SURFACE_MASTER                   40960          1      32768      32768 GISINDX             
GARLAND      RQST_USER_LOG_PK                    40960          1      32768      32768 GISINDX             
GARLAND      SANI_COM_PICKUP_PKEY                40960          1      32768      32768 GISINDX             
GARLAND      SURFACE_MASTER_PK                   40960          1      32768      32768 GISINDX             
5 rows selected.
OWNER        CONSTRAINT_NAME                TABLE_NAME                     C PARENT_OWNER PARENT_CONSTRAINT             
------------ ------------------------------ ------------------------------ - ------------ ------------------------------
0 rows selected.
TABLE_NAME                     TRIGGER_NAME                   TRIGGER_TYPE    
------------------------------ ------------------------------ ----------------
0 rows selected.
TABLE_NAME                     PRIVILEGE                               
------------------------------ ----------------------------------------
0 rows selected.

