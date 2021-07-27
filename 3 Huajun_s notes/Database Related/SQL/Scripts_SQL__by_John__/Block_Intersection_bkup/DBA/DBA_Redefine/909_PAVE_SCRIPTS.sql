Echo                            OFF
MGR-00308: no spool file opened
Echo                            OFF
Statement processed.
Statement processed.
10 rows processed.
Statement processed.
7 rows processed.
Statement processed.
1 row processed.
Statement processed.
KEY_                           TYPE_                          SCHEMA_                        PREFIX_                        SUFFIX_                        TABLESPACE_                    INITIAL_                       NEXT_                          PCTFREE_                       PCTUSED_                       MAXEXTENTS_                    MAXTRANS_                      OPTION1_                       OPTION2_                      
------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------
N_PAVE_MAST                    table                          GARLAND                        NEW_                                                          GIS_DATA                       992K                           32K                            10                             40                             249                            255                                                                                         
PAVEMENT_MASTER                table                          GARLAND                        NEW_                                                          GIS_DATA                       128K                           32K                            10                             40                             249                            255                                                                                         
PAVE_CUST                      table                          GARLAND                        NEW_                                                          GIS_DATA                       32K                            32K                            10                             40                             249                            255                                                                                         
PAVE_CUST_ARCH                 table                          GARLAND                        NEW_                                                          GIS_DATA                       416K                           32K                            10                             40                             249                            255                                                                                         
PAVE_MAST                      table                          GARLAND                        NEW_                                                          GIS_DATA                       928K                           32K                            10                             40                             249                            255                                                                                         
PAVE_PROJ                      table                          GARLAND                        NEW_                                                          GIS_DATA                       128K                           32K                            10                             40                             249                            255                                                                                         
PAVE_PROJ_APPR                 table                          GARLAND                        NEW_                                                          GIS_DATA                       32K                            32K                            10                             40                             249                            255                                                                                         
PAVE_PROJ_ARCH                 table                          GARLAND                        NEW_                                                          GIS_DATA                       1344K                          32K                            10                             40                             249                            255                                                                                         
PAVE_SURF_MAST                 table                          GARLAND                        NEW_                                                          GIS_DATA                       32K                            32K                            10                             40                             249                            255                                                                                         
PAVE_TASK                      table                          GARLAND                        NEW_                                                          GIS_DATA                       32K                            32K                            10                             40                             249                            255                                                                                         
PAVE_CUST_PK                   index                          GARLAND                                                                                      GISINDX                        32K                            32K                            10                             40                             249                            255                                                                                         
PAVE_MAST_PK                   index                          GARLAND                                                                                      GISINDX                        224K                           32K                            10                             40                             249                            255                                                                                         
PAVE_PROJ_APPR_PK              index                          GARLAND                                                                                      GISINDX                        32K                            32K                            10                             40                             249                            255                                                                                         
PAVE_PROJ_PK                   index                          GARLAND                                                                                      GISINDX                        64K                            32K                            10                             40                             249                            255                                                                                         
PAVE_SURF_MAST_PK              index                          GARLAND                                                                                      GISINDX                        32K                            32K                            10                             40                             249                            255                                                                                         
PAVE_TASK_PK                   index                          GARLAND                                                                                      GISINDX                        32K                            32K                            10                             40                             249                            255                                                                                         
PK_PAVEMENT_MASTER             index                          GARLAND                                                                                      GISINDX                        32K                            32K                            10                             40                             249                            255                                                                                         
all                            as                             GARLAND                                                                                                                                                                                                                                                                                                                                                                            
18 rows selected.
Echo                            OFF
OWNER        TABLE_NAME                     TABLESPACE          
------------ ------------------------------ --------------------
GARLAND      N_PAVE_MAST                    GIS_DATA            
GARLAND      PAVEMENT_MASTER                GIS_DATA            
GARLAND      PAVE_CUST                      GIS_DATA            
GARLAND      PAVE_CUST_ARCH                 GIS_DATA            
GARLAND      PAVE_MAST                      GIS_DATA            
GARLAND      PAVE_PROJ                      GIS_DATA            
GARLAND      PAVE_PROJ_APPR                 GIS_DATA            
GARLAND      PAVE_PROJ_ARCH                 GIS_DATA            
GARLAND      PAVE_SURF_MAST                 GIS_DATA            
GARLAND      PAVE_TASK                      GIS_DATA            
10 rows selected.
OWNER        INDEX_NAME                     TABLE_NAME                     TABLESPACE           UNIQUENES
------------ ------------------------------ ------------------------------ -------------------- ---------
GARLAND      PK_PAVEMENT_MASTER             PAVEMENT_MASTER                GISINDX              UNIQUE   
GARLAND      PAVE_CUST_PK                   PAVE_CUST                      GISINDX              UNIQUE   
GARLAND      PAVE_MAST_PK                   PAVE_MAST                      GISINDX              UNIQUE   
GARLAND      PAVE_PROJ_PK                   PAVE_PROJ                      GISINDX              UNIQUE   
GARLAND      PAVE_PROJ_APPR_PK              PAVE_PROJ_APPR                 GISINDX              UNIQUE   
GARLAND      PAVE_SURF_MAST_PK              PAVE_SURF_MAST                 GISINDX              UNIQUE   
GARLAND      PAVE_TASK_PK                   PAVE_TASK                      GISINDX              UNIQUE   
7 rows selected.
OWNER        CONSTRAINT_NAME                TABLE_NAME                     C PARENT_OWNER PARENT_CONSTRAINT             
------------ ------------------------------ ------------------------------ - ------------ ------------------------------
GARLAND      PK_PAVEMENT_MASTER             PAVEMENT_MASTER                P                                            
GARLAND      PAVE_CUST_PK                   PAVE_CUST                      P                                            
GARLAND      PAVE_MAST_PK                   PAVE_MAST                      P                                            
GARLAND      PAVE_PROJ_PK                   PAVE_PROJ                      P                                            
GARLAND      PAVE_PROJ_APPR_PK              PAVE_PROJ_APPR                 P                                            
GARLAND      PAVE_SURF_MAST_PK              PAVE_SURF_MAST                 P                                            
GARLAND      PAVE_TASK_PK                   PAVE_TASK                      P                                            
7 rows selected.
OWNER        TABLE_SEGMENT                  BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      PAVE_MAST                          901120         10      10240     430080 GIS_DATA            
GARLAND      PAVE_PROJ                          112640          5      10240      55296 GIS_DATA            
GARLAND      PAVEMENT_MASTER                    112640          5      10240      55296 GIS_DATA            
GARLAND      PAVE_CUST                           30720          2      10240      16384 GIS_DATA            
GARLAND      PAVE_PROJ_ARCH                    1320960         11      10240     645120 GIS_DATA            
GARLAND      PAVE_CUST_ARCH                     399360          8      10240     190464 GIS_DATA            
GARLAND      N_PAVE_MAST                        983040          2      10240    1454080 GIS_DATA            
GARLAND      PAVE_SURF_MAST                      10240          1      10240      10240 GIS_DATA            
GARLAND      PAVE_PROJ_APPR                      20480          2      10240      16384 GIS_DATA            
GARLAND      PAVE_TASK                           10240          1      10240      10240 GIS_DATA            
10 rows selected.
OWNER        INDEX_SEGMENT                  BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      PAVE_CUST_PK                        10240          1      10240      16384 GISINDX             
GARLAND      PAVE_MAST_PK                       194560          3      10240      83968 GISINDX             
GARLAND      PAVE_PROJ_APPR_PK                   10240          1      10240      10240 GISINDX             
GARLAND      PAVE_PROJ_PK                        40960          2      10240      24576 GISINDX             
GARLAND      PAVE_SURF_MAST_PK                   10240          1      10240      10240 GISINDX             
GARLAND      PAVE_TASK_PK                        10240          1      10240      10240 GISINDX             
GARLAND      PK_PAVEMENT_MASTER                  30720          2      10240      16384 GISINDX             
7 rows selected.
Echo                            OFF
Charwidth                       100
Echo                            OFF
Server Output                   ON
Charwidth                       100
Statement processed.
select 'CREATE N_PAVE_MAST' " " from dual;
create table   GARLAND.NEW_N_PAVE_MAST
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 992K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.N_PAVE_MAST;
select count(*) "N_PAVE_MAST" from GARLAND.N_PAVE_MAST;
select count(*) " " from GARLAND.NEW_N_PAVE_MAST;
;
select 'CREATE PAVEMENT_MASTER' " " from dual;
create table   GARLAND.NEW_PAVEMENT_MASTER
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 128K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.PAVEMENT_MASTER;
select count(*) "PAVEMENT_MASTER" from GARLAND.PAVEMENT_MASTER;
select count(*) " " from GARLAND.NEW_PAVEMENT_MASTER;
;
select 'CREATE PAVE_CUST' " " from dual;
create table   GARLAND.NEW_PAVE_CUST
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.PAVE_CUST;
select count(*) "PAVE_CUST" from GARLAND.PAVE_CUST;
select count(*) " " from GARLAND.NEW_PAVE_CUST;
;
select 'CREATE PAVE_CUST_ARCH' " " from dual;
create table   GARLAND.NEW_PAVE_CUST_ARCH
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 416K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.PAVE_CUST_ARCH;
select count(*) "PAVE_CUST_ARCH" from GARLAND.PAVE_CUST_ARCH;
select count(*) " " from GARLAND.NEW_PAVE_CUST_ARCH;
;
select 'CREATE PAVE_MAST' " " from dual;
create table   GARLAND.NEW_PAVE_MAST
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 928K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.PAVE_MAST;
select count(*) "PAVE_MAST" from GARLAND.PAVE_MAST;
select count(*) " " from GARLAND.NEW_PAVE_MAST;
;
select 'CREATE PAVE_PROJ' " " from dual;
create table   GARLAND.NEW_PAVE_PROJ
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 128K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.PAVE_PROJ;
select count(*) "PAVE_PROJ" from GARLAND.PAVE_PROJ;
select count(*) " " from GARLAND.NEW_PAVE_PROJ;
;
select 'CREATE PAVE_PROJ_APPR' " " from dual;
create table   GARLAND.NEW_PAVE_PROJ_APPR
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.PAVE_PROJ_APPR;
select count(*) "PAVE_PROJ_APPR" from GARLAND.PAVE_PROJ_APPR;
select count(*) " " from GARLAND.NEW_PAVE_PROJ_APPR;
;
select 'CREATE PAVE_PROJ_ARCH' " " from dual;
create table   GARLAND.NEW_PAVE_PROJ_ARCH
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1344K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.PAVE_PROJ_ARCH;
select count(*) "PAVE_PROJ_ARCH" from GARLAND.PAVE_PROJ_ARCH;
select count(*) " " from GARLAND.NEW_PAVE_PROJ_ARCH;
;
select 'CREATE PAVE_SURF_MAST' " " from dual;
create table   GARLAND.NEW_PAVE_SURF_MAST
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.PAVE_SURF_MAST;
select count(*) "PAVE_SURF_MAST" from GARLAND.PAVE_SURF_MAST;
select count(*) " " from GARLAND.NEW_PAVE_SURF_MAST;
;
select 'CREATE PAVE_TASK' " " from dual;
create table   GARLAND.NEW_PAVE_TASK
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.PAVE_TASK;
select count(*) "PAVE_TASK" from GARLAND.PAVE_TASK;
select count(*) " " from GARLAND.NEW_PAVE_TASK;
;
Echo                            OFF
Timing                          OFF
Echo                            OFF
Server Output                   ON
Charwidth                       100
Statement processed.
Echo                            OFF
Server Output                   ON
Charwidth                       100
Statement processed.
select 'PAVE_CUST_PK' " "  from dual;
alter table    GARLAND.PAVE_CUST
add constraint PAVE_CUST_PK   primary key
(
 PROJ_YEAR
,PROJ_SEQ
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;
select 'PAVE_MAST_PK' " "  from dual;
alter table    GARLAND.PAVE_MAST
add constraint PAVE_MAST_PK   primary key
(
 CATEGORY
,BRANCH
,SECTION
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 224K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;
select 'PAVE_PROJ_APPR_PK' " "  from dual;
alter table    GARLAND.PAVE_PROJ_APPR
add constraint PAVE_PROJ_APPR_PK   primary key
(
 CATEGORY
,BRANCH
,SECTION
,SFG_NUMBER
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;
select 'PAVE_PROJ_PK' " "  from dual;
alter table    GARLAND.PAVE_PROJ
add constraint PAVE_PROJ_PK   primary key
(
 PROJ_YEAR
,PROJ_SEQ
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 64K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;
select 'PAVE_SURF_MAST_PK' " "  from dual;
alter table    GARLAND.PAVE_SURF_MAST
add constraint PAVE_SURF_MAST_PK   primary key
(
 CATEGORY
,SURF_TYPE
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;
select 'PAVE_TASK_PK' " "  from dual;
alter table    GARLAND.PAVE_TASK
add constraint PAVE_TASK_PK   primary key
(
 PROJ_YEAR
,PROJ_SEQ
,SUBTASK_SFG_NUM
)
using index
tablespace GISINDX      initrans 2  maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;
select 'PK_PAVEMENT_MASTER' " "  from dual;
alter table    GARLAND.PAVEMENT_MASTER
add constraint PK_PAVEMENT_MASTER   primary key
(
 CATEGORY
,BRANCH
,SECTION
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
create or replace trigger GARLAND.INSP_ARCH
BEFORE 
UPDATE
of ADDR_NAME
,ADDR_NUM
,ADDR_PFX
,ADDR_SFX
,ADDR_TYPE
,BRANCH
,CATEGORY
,CDBG
,CLASS
,CONST_DATE
,COUN_DIST
,CRACK_SEAL
,DISTRESSES
,FROM_ADDR_NAME
,FROM_ADDR_NUM
,FROM_ADDR_PFX
,FROM_ADDR_SFX
,FROM_ADDR_TYPE
,LANES
,LAST_INSPECT_DATE
,LENG
,MISSING_SDWK
,NEXT_INSPECT_DATE
,PCI
,POT_HOLE_REQ
,REAR_ENTRY
,REMARKS
,SECTION
,SEGMENT
,SURF_TYPE
,THOR_TYPE
,TO_ADDR_NAME
,TO_ADDR_NUM
,TO_ADDR_PFX
,TO_ADDR_SFX
,TO_ADDR_TYPE
on GARLAND.PAVE_MAST
REFERENCING NEW AS NEW OLD AS OLD
for each row 
BEGIN 
insert into insp_arch(
     CATEGORY,
    
BRANCH,
     SECTION,
     SEGMENT,
     LENG,
  
  LANES,
     SURF_TYPE,
     REAR_ENTRY,
     CDBG,

    CONST_DATE,
     LAST_INSPECT_DATE,
     NEXT_INSPECT_DATE,

    PCI,
     CLASS,
     CRACK_SEAL,
     DISTRESSES,

    POT_HOLE_REQ,
     COUN_DIST,
     THOR_TYPE,

    ADDR_NUM,
     ADDR_PFX,
     ADDR_NAME,
    
ADDR_TYPE,
     ADDR_SFX,
     FROM_ADDR_NUM,
   
 FROM_ADDR_PFX,
     FROM_ADDR_NAME,
     FROM_ADDR_TYPE,

    FROM_ADDR_SFX,
     TO_ADDR_NUM,
     TO_ADDR_PFX,

    TO_ADDR_NAME,
     TO_ADDR_TYPE,
     TO_ADDR_SFX,

    REMARKS) 
values(
     :old.CATEGORY,
     :old.BRANCH,

    :old.SECTION,
     :old.SEGMENT,
     :old.LENG,

    :old.LANES,
     :old.SURF_TYPE,
     :old.REAR_ENTRY,

    :old.CDBG,
     :old.CONST_DATE,
     :old.LAST_INSPECT_DATE,

    :old.NEXT_INSPECT_DATE,
     :old.PCI,
     :old.CLASS,

    :old.CRACK_SEAL,
     :old.DISTRESSES,
     :old.POT_HOLE_REQ,

    :old.COUN_DIST,
     :old.THOR_TYPE,
     :old.ADDR_NUM,

    :old.ADDR_PFX,
     :old.ADDR_NAME,
     :old.ADDR_TYPE,

    :old.ADDR_SFX,
     :old.FROM_ADDR_NUM,
     :old.FROM_ADDR_PFX,

    :old.FROM_ADDR_NAME,
     :old.FROM_ADDR_TYPE,

    :old.FROM_ADDR_SFX,
     :old.TO_ADDR_NUM,
  
  :old.TO_ADDR_PFX,
     :old.TO_ADDR_NAME,
     :old.TO_ADDR_TYPE,

    :old.TO_ADDR_SFX,
     :old.REMARKS);
end;

Echo                            OFF
Server Output                   ON
Statement processed.
                                                                     
---------------------------------------------------------------------
	drop table N_PAVE_MAST;   --  cascade constraints                   
	drop table PAVEMENT_MASTER;   --  cascade constraints               
	drop table PAVE_CUST;   --  cascade constraints                     
	drop table PAVE_CUST_ARCH;   --  cascade constraints                
	drop table PAVE_MAST;   --  cascade constraints                     
	drop table PAVE_PROJ;   --  cascade constraints                     
	drop table PAVE_PROJ_APPR;   --  cascade constraints                
	drop table PAVE_PROJ_ARCH;   --  cascade constraints                
	drop table PAVE_SURF_MAST;   --  cascade constraints                
	drop table PAVE_TASK;   --  cascade constraints                     
10 rows selected.
                                                                                                    
----------------------------------------------------------------------------------------------------
	rename NEW_N_PAVE_MAST  to  N_PAVE_MAST;                                                           
	rename NEW_PAVEMENT_MASTER  to  PAVEMENT_MASTER;                                                   
	rename NEW_PAVE_CUST  to  PAVE_CUST;                                                               
	rename NEW_PAVE_CUST_ARCH  to  PAVE_CUST_ARCH;                                                     
	rename NEW_PAVE_MAST  to  PAVE_MAST;                                                               
	rename NEW_PAVE_PROJ  to  PAVE_PROJ;                                                               
	rename NEW_PAVE_PROJ_APPR  to  PAVE_PROJ_APPR;                                                     
	rename NEW_PAVE_PROJ_ARCH  to  PAVE_PROJ_ARCH;                                                     
	rename NEW_PAVE_SURF_MAST  to  PAVE_SURF_MAST;                                                     
	rename NEW_PAVE_TASK  to  PAVE_TASK;                                                               
10 rows selected.
                                                                                                 
-------------------------------------------------------------------------------------------------
analyze table GARLAND.N_PAVE_MAST   compute statistics;                                          
analyze table GARLAND.PAVEMENT_MASTER   compute statistics;                                      
analyze table GARLAND.PAVE_CUST   compute statistics;                                            
analyze table GARLAND.PAVE_CUST_ARCH   compute statistics;                                       
analyze table GARLAND.PAVE_MAST   compute statistics;                                            
analyze table GARLAND.PAVE_PROJ   compute statistics;                                            
analyze table GARLAND.PAVE_PROJ_APPR   compute statistics;                                       
analyze table GARLAND.PAVE_PROJ_ARCH   compute statistics;                                       
analyze table GARLAND.PAVE_SURF_MAST   compute statistics;                                       
analyze table GARLAND.PAVE_TASK   compute statistics;                                            
10 rows selected.


Echo                            OFF
Echo                            OFF
                  
------------------
CREATE N_PAVE_MAST
1 row selected.
Statement processed.
N_PAVE_MAS
----------
      3199
1 row selected.
          
----------
      3199
1 row selected.
                      
----------------------
CREATE PAVEMENT_MASTER
1 row selected.
Statement processed.
PAVEMENT_M
----------
       728
1 row selected.
          
----------
       728
1 row selected.
                
----------------
CREATE PAVE_CUST
1 row selected.
Statement processed.
PAVE_CUST 
----------
       222
1 row selected.
          
----------
       222
1 row selected.
                     
---------------------
CREATE PAVE_CUST_ARCH
1 row selected.
Statement processed.
PAVE_CUST_
----------
      5955
1 row selected.
          
----------
      5955
1 row selected.
                
----------------
CREATE PAVE_MAST
1 row selected.
create table   GARLAND.NEW_PAVE_MAST
                       *
ORA-00955: name is already used by an existing object
PAVE_MAST 
----------
      5387
1 row selected.
          
----------
      5387
1 row selected.
                
----------------
CREATE PAVE_PROJ
1 row selected.
Statement processed.
PAVE_PROJ 
----------
       339
1 row selected.
          
----------
       339
1 row selected.
                     
---------------------
CREATE PAVE_PROJ_APPR
1 row selected.
Statement processed.
PAVE_PROJ_
----------
        48
1 row selected.
          
----------
        48
1 row selected.
                     
---------------------
CREATE PAVE_PROJ_ARCH
1 row selected.
Statement processed.
PAVE_PROJ_
----------
      7530
1 row selected.
          
----------
      7530
1 row selected.
                     
---------------------
CREATE PAVE_SURF_MAST
1 row selected.
Statement processed.
PAVE_SURF_
----------
         6
1 row selected.
          
----------
         6
1 row selected.
                
----------------
CREATE PAVE_TASK
1 row selected.
Statement processed.
PAVE_TASK 
----------
       128
1 row selected.
          
----------
       128
1 row selected.
ORIGINALS 
----------
        10
1 row selected.
COPIES    
----------
        10
1 row selected.
MISSING COPIES                
------------------------------
0 rows selected.
SEGMENT TYPE      SEGMENT NAME                   EXTENTS    INITIAL    NEXT       SIZE      
----------------- ------------------------------ ---------- ---------- ---------- ----------
TABLE             NEW_N_PAVE_MAST                         1    1015808      32768    1024000
TABLE             NEW_N_PAVE_MAST                         1    1015808      32768    1024000
TABLE             NEW_PAVEMENT_MASTER                     1     131072      32768     133120
TABLE             NEW_PAVE_CUST                           1      32768      32768      40960
TABLE             NEW_PAVE_CUST_ARCH                      1     425984      32768     430080
TABLE             NEW_PAVE_MAST                           1     950272      32768     952320
TABLE             NEW_PAVE_PROJ                           1     131072      32768     133120
TABLE             NEW_PAVE_PROJ_APPR                      1      32768      32768      40960
TABLE             NEW_PAVE_PROJ_ARCH                      1    1376256      32768    1382400
TABLE             NEW_PAVE_SURF_MAST                      1      32768      32768      40960
TABLE             NEW_PAVE_TASK                           1      32768      32768      40960
TABLE             N_PAVE_MAST                             2      10240    1454080     983040
TABLE             N_PAVE_MAST                             2      10240    1454080     983040
TABLE             PAVEMENT_MASTER                         5      10240      55296     112640
TABLE             PAVE_CUST                               2      10240      16384      30720
TABLE             PAVE_CUST_ARCH                          8      10240     190464     399360
TABLE             PAVE_MAST                              10      10240     430080     901120
TABLE             PAVE_PROJ                               5      10240      55296     112640
TABLE             PAVE_PROJ_APPR                          2      10240      16384      20480
TABLE             PAVE_PROJ_ARCH                         11      10240     645120    1320960
TABLE             PAVE_SURF_MAST                          1      10240      10240      10240
TABLE             PAVE_TASK                               1      10240      10240      10240
INDEX             PAVE_CUST_PK                            1      10240      16384      10240
INDEX             PAVE_MAST_PK                            3      10240      83968     194560
INDEX             PAVE_PROJ_APPR_PK                       1      10240      10240      10240
INDEX             PAVE_PROJ_PK                            2      10240      24576      40960
INDEX             PAVE_SURF_MAST_PK                       1      10240      10240      10240
INDEX             PAVE_TASK_PK                            1      10240      10240      10240
INDEX             PK_PAVEMENT_MASTER                      2      10240      16384      30720
INDEX             PK_PAVEMENT_MASTER                      2      10240      16384      30720
30 rows selected.


Echo                            OFF
Echo                            ON
SQLWKS> 
SQLWKS> --	=========================================================================
SQLWKS> --	DROP ORIGINAL TABLE
SQLWKS> 
SQLWKS> 	@c:\deacutis\scripts\ora_create\SCRIPT_DROP.sql;
SQLWKS>                                                                      
SQLWKS> ---------------------------------------------------------------------
SQLWKS> 	drop table N_PAVE_MAST;   --  cascade constraints                   
Statement processed.
SQLWKS> 	drop table PAVEMENT_MASTER;   --  cascade constraints               
Statement processed.
SQLWKS> 	drop table PAVE_CUST;   --  cascade constraints                     
Statement processed.
SQLWKS> 	drop table PAVE_CUST_ARCH;   --  cascade constraints                
Statement processed.
SQLWKS> 	drop table PAVE_MAST;   --  cascade constraints                     
Statement processed.
SQLWKS> 	drop table PAVE_PROJ;   --  cascade constraints                     
Statement processed.
SQLWKS> 	drop table PAVE_PROJ_APPR;   --  cascade constraints                
Statement processed.
SQLWKS> 	drop table PAVE_PROJ_ARCH;   --  cascade constraints                
Statement processed.
SQLWKS> 	drop table PAVE_SURF_MAST;   --  cascade constraints                
Statement processed.
SQLWKS> 	drop table PAVE_TASK;   --  cascade constraints                     
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
SQLWKS> 	rename NEW_N_PAVE_MAST  to  N_PAVE_MAST;                                                           
Statement processed.
SQLWKS> 	rename NEW_PAVEMENT_MASTER  to  PAVEMENT_MASTER;                                                   
Statement processed.
SQLWKS> 	rename NEW_PAVE_CUST  to  PAVE_CUST;                                                               
Statement processed.
SQLWKS> 	rename NEW_PAVE_CUST_ARCH  to  PAVE_CUST_ARCH;                                                     
Statement processed.
SQLWKS> 	rename NEW_PAVE_MAST  to  PAVE_MAST;                                                               
Statement processed.
SQLWKS> 	rename NEW_PAVE_PROJ  to  PAVE_PROJ;                                                               
Statement processed.
SQLWKS> 	rename NEW_PAVE_PROJ_APPR  to  PAVE_PROJ_APPR;                                                     
Statement processed.
SQLWKS> 	rename NEW_PAVE_PROJ_ARCH  to  PAVE_PROJ_ARCH;                                                     
Statement processed.
SQLWKS> 	rename NEW_PAVE_SURF_MAST  to  PAVE_SURF_MAST;                                                     
Statement processed.
SQLWKS> 	rename NEW_PAVE_TASK  to  PAVE_TASK;                                                               
Statement processed.
SQLWKS> 
SQLWKS> --	@d:\scripts\ora_create\SCRIPT_RENAME.sql;
SQLWKS> 
SQLWKS> 
SQLWKS> 
SQLWKS> 	set echo off;
Echo                            OFF
            
------------
PAVE_CUST_PK
1 row selected.
Statement processed.
            
------------
PAVE_MAST_PK
1 row selected.
Statement processed.
                 
-----------------
PAVE_PROJ_APPR_PK
1 row selected.
Statement processed.
            
------------
PAVE_PROJ_PK
1 row selected.
Statement processed.
                 
-----------------
PAVE_SURF_MAST_PK
1 row selected.
Statement processed.
            
------------
PAVE_TASK_PK
1 row selected.
Statement processed.
                  
------------------
PK_PAVEMENT_MASTER
1 row selected.
Statement processed.
Statement processed.
Echo                            ON
SQLWKS> 
SQLWKS> --	================================================================================
SQLWKS> --	ANALYZE TABLES
SQLWKS> 
SQLWKS> 	@c:\deacutis\scripts\ora_create\Script_Analyze.sql;
SQLWKS>                                                                                                  
SQLWKS> -------------------------------------------------------------------------------------------------
SQLWKS> analyze table GARLAND.N_PAVE_MAST   compute statistics;                                          
Statement processed.
SQLWKS> analyze table GARLAND.PAVEMENT_MASTER   compute statistics;                                      
Statement processed.
SQLWKS> analyze table GARLAND.PAVE_CUST   compute statistics;                                            
Statement processed.
SQLWKS> analyze table GARLAND.PAVE_CUST_ARCH   compute statistics;                                       
Statement processed.
SQLWKS> analyze table GARLAND.PAVE_MAST   compute statistics;                                            
Statement processed.
SQLWKS> analyze table GARLAND.PAVE_PROJ   compute statistics;                                            
Statement processed.
SQLWKS> analyze table GARLAND.PAVE_PROJ_APPR   compute statistics;                                       
Statement processed.
SQLWKS> analyze table GARLAND.PAVE_PROJ_ARCH   compute statistics;                                       
Statement processed.
SQLWKS> analyze table GARLAND.PAVE_SURF_MAST   compute statistics;                                       
Statement processed.
SQLWKS> analyze table GARLAND.PAVE_TASK   compute statistics;                                            
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
GARLAND      N_PAVE_MAST                    GIS_DATA            
GARLAND      PAVEMENT_MASTER                GIS_DATA            
GARLAND      PAVE_CUST                      GIS_DATA            
GARLAND      PAVE_CUST_ARCH                 GIS_DATA            
GARLAND      PAVE_MAST                      GIS_DATA            
GARLAND      PAVE_PROJ                      GIS_DATA            
GARLAND      PAVE_PROJ_APPR                 GIS_DATA            
GARLAND      PAVE_PROJ_ARCH                 GIS_DATA            
GARLAND      PAVE_SURF_MAST                 GIS_DATA            
GARLAND      PAVE_TASK                      GIS_DATA            
10 rows selected.
OWNER        INDEX_NAME                     TABLE_NAME                     TABLESPACE           UNIQUENES
------------ ------------------------------ ------------------------------ -------------------- ---------
GARLAND      PK_PAVEMENT_MASTER             PAVEMENT_MASTER                GISINDX              UNIQUE   
GARLAND      PAVE_CUST_PK                   PAVE_CUST                      GISINDX              UNIQUE   
GARLAND      PAVE_MAST_PK                   PAVE_MAST                      GISINDX              UNIQUE   
GARLAND      PAVE_PROJ_PK                   PAVE_PROJ                      GISINDX              UNIQUE   
GARLAND      PAVE_PROJ_APPR_PK              PAVE_PROJ_APPR                 GISINDX              UNIQUE   
GARLAND      PAVE_SURF_MAST_PK              PAVE_SURF_MAST                 GISINDX              UNIQUE   
GARLAND      PAVE_TASK_PK                   PAVE_TASK                      GISINDX              UNIQUE   
7 rows selected.
OWNER        CONSTRAINT_NAME                TABLE_NAME                     C PARENT_OWNER PARENT_CONSTRAINT             
------------ ------------------------------ ------------------------------ - ------------ ------------------------------
GARLAND      PK_PAVEMENT_MASTER             PAVEMENT_MASTER                P                                            
GARLAND      PAVE_CUST_PK                   PAVE_CUST                      P                                            
GARLAND      PAVE_MAST_PK                   PAVE_MAST                      P                                            
GARLAND      PAVE_PROJ_PK                   PAVE_PROJ                      P                                            
GARLAND      PAVE_PROJ_APPR_PK              PAVE_PROJ_APPR                 P                                            
GARLAND      PAVE_SURF_MAST_PK              PAVE_SURF_MAST                 P                                            
GARLAND      PAVE_TASK_PK                   PAVE_TASK                      P                                            
7 rows selected.
OWNER        TABLE_SEGMENT                  BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      PAVE_SURF_MAST                      40960          1      32768      32768 GIS_DATA            
GARLAND      PAVE_TASK                           40960          1      32768      32768 GIS_DATA            
GARLAND      PAVE_CUST                           40960          1      32768      32768 GIS_DATA            
GARLAND      PAVE_CUST_ARCH                     430080          1     425984      32768 GIS_DATA            
GARLAND      PAVEMENT_MASTER                    133120          1     131072      32768 GIS_DATA            
GARLAND      PAVE_MAST                          952320          1     950272      32768 GIS_DATA            
GARLAND      PAVE_PROJ_APPR                      40960          1      32768      32768 GIS_DATA            
GARLAND      PAVE_PROJ_ARCH                    1382400          1    1376256      32768 GIS_DATA            
GARLAND      N_PAVE_MAST                       1024000          1    1015808      32768 GIS_DATA            
GARLAND      PAVE_PROJ                          133120          1     131072      32768 GIS_DATA            
10 rows selected.
OWNER        INDEX_SEGMENT                  BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      PAVE_CUST_PK                        40960          1      32768      32768 GISINDX             
GARLAND      PAVE_MAST_PK                       235520          1     229376      32768 GISINDX             
GARLAND      PAVE_PROJ_APPR_PK                   40960          1      32768      32768 GISINDX             
GARLAND      PAVE_PROJ_PK                        71680          1      65536      32768 GISINDX             
GARLAND      PAVE_SURF_MAST_PK                   40960          1      32768      32768 GISINDX             
GARLAND      PAVE_TASK_PK                        40960          1      32768      32768 GISINDX             
GARLAND      PK_PAVEMENT_MASTER                  40960          1      32768      32768 GISINDX             
7 rows selected.
TRIGGER_NAME                   TRIGGER_TYPE     TRIGGERING_EVENT           TABLE_OWNER                    TABLE_NAME                     REFERENCING_NAMES                                                                       WHEN_CLAUSE                                                                                          STATUS   DESCRIPTION                                                                                          TRIGGER_BODY                                                                    
------------------------------ ---------------- -------------------------- ------------------------------ ------------------------------ --------------------------------------------------------------------------------------- ---------------------------------------------------------------------------------------------------- -------- ---------------------------------------------------------------------------------------------------- --------------------------------------------------------------------------------
INSP_ARCH                      BEFORE EACH ROW  UPDATE                     GARLAND                        PAVE_MAST                      REFERENCING NEW AS NEW OLD AS OLD                                                                                                                                                            ENABLED  GARLAND.INSP_ARCH
BEFORE 
UPDATE
of ADDR_NAME
,ADDR_NUM
,ADDR_PFX
,ADDR_SFX
,ADDR_TYPE
,BRANCH
,CATE BEGIN 
insert into insp_arch(
     CATEGORY,
    
BRANCH,
     SECTION,
     SEG
1 row selected.
