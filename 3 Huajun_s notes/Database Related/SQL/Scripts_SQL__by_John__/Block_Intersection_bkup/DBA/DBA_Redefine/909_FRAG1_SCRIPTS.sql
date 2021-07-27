Echo                            OFF
MGR-00308: no spool file opened
Echo                            OFF
Statement processed.
Statement processed.
12 rows processed.
Statement processed.
5 rows processed.
Statement processed.
1 row processed.
Statement processed.
KEY_                           TYPE_                          SCHEMA_                        PREFIX_                        SUFFIX_                        TABLESPACE_                    INITIAL_                       NEXT_                          PCTFREE_                       PCTUSED_                       MAXEXTENTS_                    MAXTRANS_                      OPTION1_                       OPTION2_                      
------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------
ATTRIBUTE_CATALOG              table                          GARLAND                        NEW_                                                          GIS_DATA                       192K                           32K                            10                             40                             249                            255                                                                                         
CDRELTAX                       table                          GARLAND                        NEW_                                                          GIS_DATA                       15776K                         32K                            10                             40                             249                            255                                                                                         
DOMAIN_CATALOG                 table                          GARLAND                        NEW_                                                          GIS_DATA                       64K                            32K                            10                             40                             249                            255                                                                                         
FEATURE                        table                          GARLAND                        NEW_                                                          GIS_DATA                       96K                            32K                            10                             40                             249                            255                                                                                         
INSP_ARCH                      table                          GARLAND                        NEW_                                                          GIS_DATA                       1984K                          32K                            10                             40                             249                            255                                                                                         
JOB_DISTINCT_STREET            table                          GARLAND                        NEW_                                                          GIS_DATA                       64K                            32K                            10                             40                             249                            255                                                                                         
JOIN_CATALOG                   table                          GARLAND                        NEW_                                                          GIS_DATA                       192K                           32K                            10                             40                             249                            255                                                                                         
MAPS                           table                          GARLAND                        NEW_                                                          GIS_DATA                       64K                            32K                            10                             40                             249                            255                                                                                         
MSCATALOG                      table                          GARLAND                        NEW_                                                          GIS_DATA                       64K                            32K                            10                             40                             249                            255                                                                                         
SANI_COM_FL                    table                          GARLAND                        NEW_                                                          GIS_DATA                       256K                           32K                            10                             40                             249                            255                                                                                         
UTSANMH                        table                          GARLAND                        NEW_                                                          GIS_DATA                       672K                           32K                            10                             40                             249                            255                                                                                         
VIEW_CONTENT                   table                          GARLAND                        NEW_                                                          GIS_DATA                       96K                            32K                            10                             40                             249                            255                                                                                         
CDRELTAX_X_PID                 index                          GARLAND                                                                                      GISINDX                        3264K                          32K                            10                             40                             249                            255                                                                                         
FEA_GARLAND_USE                index                          GARLAND                                                                                      GISINDX                        32K                            32K                            10                             40                             249                            255                                                                                         
MSCATALOG_I                    index                          GARLAND                                                                                      GISINDX                        32K                            32K                            10                             40                             249                            255                                                                                         
SANI_COM_FL_X_ACCOUNT          index                          GARLAND                                                                                      GISINDX                        1056K                          32K                            10                             40                             249                            255                                                                                         
SANI_COM_FL_X_NAMNUM           index                          GARLAND                                                                                      GISINDX                        1056K                          32K                            10                             40                             249                            255                                                                                         
all                            as                             GARLAND                                                                                                                                                                                                                                                                                                                                                                            
18 rows selected.
Echo                            OFF
OWNER        TABLE_NAME                     TABLESPACE          
------------ ------------------------------ --------------------
GARLAND      ATTRIBUTE_CATALOG              GIS_DATA            
GARLAND      CDRELTAX                       GIS_DATA            
GARLAND      DOMAIN_CATALOG                 GIS_DATA            
GARLAND      FEATURE                        GIS_DATA            
GARLAND      INSP_ARCH                      GIS_DATA            
GARLAND      JOB_DISTINCT_STREET            GIS_DATA            
GARLAND      JOIN_CATALOG                   GIS_DATA            
GARLAND      MAPS                           GIS_DATA            
GARLAND      MSCATALOG                      GIS_DATA            
GARLAND      SANI_COM_FL                    GIS_DATA            
GARLAND      UTSANMH                        GIS_DATA            
GARLAND      VIEW_CONTENT                   GIS_DATA            
12 rows selected.
OWNER        INDEX_NAME                     TABLE_NAME                     TABLESPACE           UNIQUENES
------------ ------------------------------ ------------------------------ -------------------- ---------
GARLAND      CDRELTAX_X_PID                 CDRELTAX                       GISINDX              NONUNIQUE
GARLAND      FEA_GARLAND_USE                FEATURE                        GISINDX              NONUNIQUE
GARLAND      MSCATALOG_I                    MSCATALOG                      GISINDX              UNIQUE   
GARLAND      SANI_COM_FL_X_ACCOUNT          SANI_COM_FL                    GISINDX              NONUNIQUE
GARLAND      SANI_COM_FL_X_NAMNUM           SANI_COM_FL                    GISINDX              NONUNIQUE
5 rows selected.
OWNER        CONSTRAINT_NAME                TABLE_NAME                     C PARENT_OWNER PARENT_CONSTRAINT             
------------ ------------------------------ ------------------------------ - ------------ ------------------------------
GARLAND      SANI_COM_FL_FKEY_PICKUP        SANI_COM_FL                    R GARLAND      SANI_COM_PICKUP_PKEY          
1 row selected.
OWNER        TABLE_SEGMENT                  BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      VIEW_CONTENT                        71680          4      10240      36864 GIS_DATA            
GARLAND      SANI_COM_FL                        235520         21      10240      10240 GIS_DATA            
GARLAND      CDRELTAX                         15759360         16   15138816      32768 GIS_DATA            
GARLAND      UTSANMH                            665600          2     622592      32768 GIS_DATA            
GARLAND      JOIN_CATALOG                       174080          6      10240      83968 GIS_DATA            
GARLAND      INSP_ARCH                         1955840         12      10240     968704 GIS_DATA            
GARLAND      MAPS                                40960          3      10240      24576 GIS_DATA            
GARLAND      MSCATALOG                           40960          3      10240      24576 GIS_DATA            
GARLAND      FEATURE                             71680          4      10240      36864 GIS_DATA            
GARLAND      DOMAIN_CATALOG                      40960          3      10240      24576 GIS_DATA            
GARLAND      ATTRIBUTE_CATALOG                  174080          6      10240      83968 GIS_DATA            
GARLAND      JOB_DISTINCT_STREET                 61440          6      10240      10240 GIS_DATA            
12 rows selected.
OWNER        INDEX_SEGMENT                  BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      CDRELTAX_X_PID                    3246080          1    3244032      32768 GISINDX             
GARLAND      FEA_GARLAND_USE                     10240          1      10240      10240 GISINDX             
GARLAND      MSCATALOG_I                         10240          1      10240      24576 GISINDX             
GARLAND      SANI_COM_FL_X_ACCOUNT             1054720          1    1048576    1048576 GISINDX             
GARLAND      SANI_COM_FL_X_NAMNUM              1054720          1    1048576    1048576 GISINDX             
5 rows selected.
OWNER        CONSTRAINT_NAME                TABLE_NAME                     C PARENT_OWNER PARENT_CONSTRAINT             
------------ ------------------------------ ------------------------------ - ------------ ------------------------------
GARLAND      SANI_COM_FL_FKEY_PICKUP        SANI_COM_FL                    R GARLAND      SANI_COM_PICKUP_PKEY          
1 row selected.
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
select 'CREATE ATTRIBUTE_CATALOG' " " from dual;
create table   GARLAND.NEW_ATTRIBUTE_CATALOG
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 192K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.ATTRIBUTE_CATALOG;
select count(*) "ATTRIBUTE_CATALOG" from GARLAND.ATTRIBUTE_CATALOG;
select count(*) " " from GARLAND.NEW_ATTRIBUTE_CATALOG;
;
select 'CREATE CDRELTAX' " " from dual;
create table   GARLAND.NEW_CDRELTAX
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 15776K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.CDRELTAX;
select count(*) "CDRELTAX" from GARLAND.CDRELTAX;
select count(*) " " from GARLAND.NEW_CDRELTAX;
;
select 'CREATE DOMAIN_CATALOG' " " from dual;
create table   GARLAND.NEW_DOMAIN_CATALOG
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 64K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.DOMAIN_CATALOG;
select count(*) "DOMAIN_CATALOG" from GARLAND.DOMAIN_CATALOG;
select count(*) " " from GARLAND.NEW_DOMAIN_CATALOG;
;
select 'CREATE FEATURE' " " from dual;
create table   GARLAND.NEW_FEATURE
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 96K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.FEATURE;
select count(*) "FEATURE" from GARLAND.FEATURE;
select count(*) " " from GARLAND.NEW_FEATURE;
;
select 'CREATE INSP_ARCH' " " from dual;
create table   GARLAND.NEW_INSP_ARCH
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1984K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.INSP_ARCH;
select count(*) "INSP_ARCH" from GARLAND.INSP_ARCH;
select count(*) " " from GARLAND.NEW_INSP_ARCH;
;
select 'CREATE JOB_DISTINCT_STREET' " " from dual;
create table   GARLAND.NEW_JOB_DISTINCT_STREET
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 64K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.JOB_DISTINCT_STREET;
select count(*) "JOB_DISTINCT_STREET" from GARLAND.JOB_DISTINCT_STREET;
select count(*) " " from GARLAND.NEW_JOB_DISTINCT_STREET;
;
select 'CREATE JOIN_CATALOG' " " from dual;
create table   GARLAND.NEW_JOIN_CATALOG
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 192K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.JOIN_CATALOG;
select count(*) "JOIN_CATALOG" from GARLAND.JOIN_CATALOG;
select count(*) " " from GARLAND.NEW_JOIN_CATALOG;
;
select 'CREATE MAPS' " " from dual;
create table   GARLAND.NEW_MAPS
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 64K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.MAPS;
select count(*) "MAPS" from GARLAND.MAPS;
select count(*) " " from GARLAND.NEW_MAPS;
;
select 'CREATE MSCATALOG' " " from dual;
create table   GARLAND.NEW_MSCATALOG
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 64K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.MSCATALOG;
select count(*) "MSCATALOG" from GARLAND.MSCATALOG;
select count(*) " " from GARLAND.NEW_MSCATALOG;
;
select 'CREATE SANI_COM_FL' " " from dual;
create table   GARLAND.NEW_SANI_COM_FL
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 256K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.SANI_COM_FL;
select count(*) "SANI_COM_FL" from GARLAND.SANI_COM_FL;
select count(*) " " from GARLAND.NEW_SANI_COM_FL;
;
select 'CREATE UTSANMH' " " from dual;
create table   GARLAND.NEW_UTSANMH
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 672K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.UTSANMH;
select count(*) "UTSANMH" from GARLAND.UTSANMH;
select count(*) " " from GARLAND.NEW_UTSANMH;
;
select 'CREATE VIEW_CONTENT' " " from dual;
create table   GARLAND.NEW_VIEW_CONTENT
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 96K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.VIEW_CONTENT;
select count(*) "VIEW_CONTENT" from GARLAND.VIEW_CONTENT;
select count(*) " " from GARLAND.NEW_VIEW_CONTENT;
;
Echo                            OFF
Timing                          OFF
Echo                            OFF
Server Output                   ON
Charwidth                       100
Statement processed.
select 'CDRELTAX_X_PID' " " from dual;
create index   GARLAND.CDRELTAX_X_PID
       on      GARLAND.CDRELTAX
(
 PARCEL_ID
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 3264K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;
select 'FEA_GARLAND_USE' " " from dual;
create index   GARLAND.FEA_GARLAND_USE
       on      GARLAND.FEATURE
(
 GARLAND_INUSE
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;
select 'MSCATALOG_I' " " from dual;
create unique index   GARLAND.MSCATALOG_I
       on      GARLAND.MSCATALOG
(
 ENTITYNUM
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;
select 'SANI_COM_FL_X_ACCOUNT' " " from dual;
create index   GARLAND.SANI_COM_FL_X_ACCOUNT
       on      GARLAND.SANI_COM_FL
(
 ACCOUNT_NO
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 1056K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;
select 'SANI_COM_FL_X_NAMNUM' " " from dual;
create index   GARLAND.SANI_COM_FL_X_NAMNUM
       on      GARLAND.SANI_COM_FL
(
 ADDR_NAME
,ADDR_NUM
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 1056K next 32K pctincrease 0
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
select 'FOREIGN SANI_COM_FL_FKEY_PICKUP' " " from dual;
alter table    GARLAND.SANI_COM_FL
add constraint SANI_COM_FL_FKEY_PICKUP     foreign key 
(
 PICKUP_CODE
)
references GARLAND.SANI_COM_PICKUP_PKEY
;
Echo                            OFF
Server Output                   ON
Charwidth                       100
Statement processed.
Echo                            OFF
Server Output                   ON
Statement processed.
                                                                     
---------------------------------------------------------------------
	drop table ATTRIBUTE_CATALOG;   --  cascade constraints             
	drop table CDRELTAX;   --  cascade constraints                      
	drop table DOMAIN_CATALOG;   --  cascade constraints                
	drop table FEATURE;   --  cascade constraints                       
	drop table INSP_ARCH;   --  cascade constraints                     
	drop table JOB_DISTINCT_STREET;   --  cascade constraints           
	drop table JOIN_CATALOG;   --  cascade constraints                  
	drop table MAPS;   --  cascade constraints                          
	drop table MSCATALOG;   --  cascade constraints                     
	drop table SANI_COM_FL;   --  cascade constraints                   
	drop table UTSANMH;   --  cascade constraints                       
	drop table VIEW_CONTENT;   --  cascade constraints                  
12 rows selected.
                                                                                                    
----------------------------------------------------------------------------------------------------
	rename NEW_ATTRIBUTE_CATALOG  to  ATTRIBUTE_CATALOG;                                               
	rename NEW_CDRELTAX  to  CDRELTAX;                                                                 
	rename NEW_DOMAIN_CATALOG  to  DOMAIN_CATALOG;                                                     
	rename NEW_FEATURE  to  FEATURE;                                                                   
	rename NEW_INSP_ARCH  to  INSP_ARCH;                                                               
	rename NEW_JOB_DISTINCT_STREET  to  JOB_DISTINCT_STREET;                                           
	rename NEW_JOIN_CATALOG  to  JOIN_CATALOG;                                                         
	rename NEW_MAPS  to  MAPS;                                                                         
	rename NEW_MSCATALOG  to  MSCATALOG;                                                               
	rename NEW_SANI_COM_FL  to  SANI_COM_FL;                                                           
	rename NEW_UTSANMH  to  UTSANMH;                                                                   
	rename NEW_VIEW_CONTENT  to  VIEW_CONTENT;                                                         
12 rows selected.
                                                                                                 
-------------------------------------------------------------------------------------------------
analyze table GARLAND.ATTRIBUTE_CATALOG   compute statistics;                                    
analyze table GARLAND.CDRELTAX   compute statistics;                                             
analyze table GARLAND.DOMAIN_CATALOG   compute statistics;                                       
analyze table GARLAND.FEATURE   compute statistics;                                              
analyze table GARLAND.INSP_ARCH   compute statistics;                                            
analyze table GARLAND.JOB_DISTINCT_STREET   compute statistics;                                  
analyze table GARLAND.JOIN_CATALOG   compute statistics;                                         
analyze table GARLAND.MAPS   compute statistics;                                                 
analyze table GARLAND.MSCATALOG   compute statistics;                                            
analyze table GARLAND.SANI_COM_FL   compute statistics;                                          
analyze table GARLAND.UTSANMH   compute statistics;                                              
analyze table GARLAND.VIEW_CONTENT   compute statistics;                                         
12 rows selected.



Statement processed.
ATTRIBUTE_
----------
      1247
1 row selected.
          
----------
      1247
1 row selected.
               
---------------
CREATE CDRELTAX
1 row selected.
Statement processed.
CDRELTAX  
----------
     64346
1 row selected.
          
----------
     64346
1 row selected.
                     
---------------------
CREATE DOMAIN_CATALOG
1 row selected.
Statement processed.
DOMAIN_CAT
----------
         5
1 row selected.
          
----------
         5
1 row selected.
              
--------------
CREATE FEATURE
1 row selected.
Statement processed.
FEATURE   
----------
       183
1 row selected.
          
----------
       183
1 row selected.
                
----------------
CREATE INSP_ARCH
1 row selected.
Statement processed.
INSP_ARCH 
----------
     13912
1 row selected.
          
----------
     13912
1 row selected.
                          
--------------------------
CREATE JOB_DISTINCT_STREET
1 row selected.
Statement processed.
JOB_DISTIN
----------
      2085
1 row selected.
          
----------
      2085
1 row selected.
                   
-------------------
CREATE JOIN_CATALOG
1 row selected.
Statement processed.
JOIN_CATAL
----------
        31
1 row selected.
          
----------
        31
1 row selected.
           
-----------
CREATE MAPS
1 row selected.
Statement processed.
MAPS      
----------
       719
1 row selected.
          
----------
       719
1 row selected.
                
----------------
CREATE MSCATALOG
1 row selected.
Statement processed.
MSCATALOG 
----------
       166
1 row selected.
          
----------
       166
1 row selected.
                  
------------------
CREATE SANI_COM_FL
1 row selected.
create table   GARLAND.NEW_SANI_COM_FL
                       *
ORA-00955: name is already used by an existing object
SANI_COM_F
----------
      1585
1 row selected.
          
----------
      1585
1 row selected.
              
--------------
CREATE UTSANMH
1 row selected.
Statement processed.
UTSANMH   
----------
      9171
1 row selected.
          
----------
      9171
1 row selected.
                   
-------------------
CREATE VIEW_CONTENT
1 row selected.
Statement processed.
VIEW_CONTE
----------
       576
1 row selected.
          
----------
       576
1 row selected.
ORIGINALS 
----------
        12
1 row selected.
COPIES    
----------
        12
1 row selected.
MISSING COPIES                
------------------------------
0 rows selected.


SQLWKS> 
SQLWKS> --	=========================================================================
SQLWKS> --	DROP ORIGINAL TABLE
SQLWKS> 
SQLWKS> 	@c:\deacutis\scripts\ora_create\SCRIPT_DROP.sql;
SQLWKS>                                                                      
SQLWKS> ---------------------------------------------------------------------
SQLWKS> 	drop table ATTRIBUTE_CATALOG;   --  cascade constraints             
Statement processed.
SQLWKS> 	drop table CDRELTAX;   --  cascade constraints                      
Statement processed.
SQLWKS> 	drop table DOMAIN_CATALOG;   --  cascade constraints                
Statement processed.
SQLWKS> 	drop table FEATURE;   --  cascade constraints                       
Statement processed.
SQLWKS> 	drop table INSP_ARCH;   --  cascade constraints                     
Statement processed.
SQLWKS> 	drop table JOB_DISTINCT_STREET;   --  cascade constraints           
Statement processed.
SQLWKS> 	drop table JOIN_CATALOG;   --  cascade constraints                  
Statement processed.
SQLWKS> 	drop table MAPS;   --  cascade constraints                          
Statement processed.
SQLWKS> 	drop table MSCATALOG;   --  cascade constraints                     
Statement processed.
SQLWKS> 	drop table SANI_COM_FL;   --  cascade constraints                   
Statement processed.
SQLWKS> 	drop table UTSANMH;   --  cascade constraints                       
Statement processed.
SQLWKS> 	drop table VIEW_CONTENT;   --  cascade constraints                  
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
SQLWKS> 	rename NEW_ATTRIBUTE_CATALOG  to  ATTRIBUTE_CATALOG;                                               
Statement processed.
SQLWKS> 	rename NEW_CDRELTAX  to  CDRELTAX;                                                                 
Statement processed.
SQLWKS> 	rename NEW_DOMAIN_CATALOG  to  DOMAIN_CATALOG;                                                     
Statement processed.
SQLWKS> 	rename NEW_FEATURE  to  FEATURE;                                                                   
Statement processed.
SQLWKS> 	rename NEW_INSP_ARCH  to  INSP_ARCH;                                                               
Statement processed.
SQLWKS> 	rename NEW_JOB_DISTINCT_STREET  to  JOB_DISTINCT_STREET;                                           
Statement processed.
SQLWKS> 	rename NEW_JOIN_CATALOG  to  JOIN_CATALOG;                                                         
Statement processed.
SQLWKS> 	rename NEW_MAPS  to  MAPS;                                                                         
Statement processed.
SQLWKS> 	rename NEW_MSCATALOG  to  MSCATALOG;                                                               
Statement processed.
SQLWKS> 	rename NEW_SANI_COM_FL  to  SANI_COM_FL;                                                           
Statement processed.
SQLWKS> 	rename NEW_UTSANMH  to  UTSANMH;                                                                   
Statement processed.
SQLWKS> 	rename NEW_VIEW_CONTENT  to  VIEW_CONTENT;                                                         
Statement processed.
SQLWKS> 
SQLWKS> --	@d:\scripts\ora_create\SCRIPT_RENAME.sql;
SQLWKS> 
SQLWKS> 
SQLWKS> 
SQLWKS> 	set echo off;
Echo                            OFF
              
--------------
CDRELTAX_X_PID
1 row selected.
Statement processed.
               
---------------
FEA_GARLAND_USE
1 row selected.
Statement processed.
           
-----------
MSCATALOG_I
1 row selected.
Statement processed.
                     
---------------------
SANI_COM_FL_X_ACCOUNT
1 row selected.
Statement processed.
                    
--------------------
SANI_COM_FL_X_NAMNUM
1 row selected.
Statement processed.
                               
-------------------------------
FOREIGN SANI_COM_FL_FKEY_PICKUP
1 row selected.
 PICKUP_CODE
 *
ORA-00904: invalid column name
Echo                            ON
SQLWKS> 
SQLWKS> --	================================================================================
SQLWKS> --	ANALYZE TABLES
SQLWKS> 
SQLWKS> 	@c:\deacutis\scripts\ora_create\Script_Analyze.sql;
SQLWKS>                                                                                                  
SQLWKS> -------------------------------------------------------------------------------------------------
SQLWKS> analyze table GARLAND.ATTRIBUTE_CATALOG   compute statistics;                                    
Statement processed.
SQLWKS> analyze table GARLAND.CDRELTAX   compute statistics;                                             
Statement processed.
SQLWKS> analyze table GARLAND.DOMAIN_CATALOG   compute statistics;                                       
Statement processed.
SQLWKS> analyze table GARLAND.FEATURE   compute statistics;                                              
Statement processed.
SQLWKS> analyze table GARLAND.INSP_ARCH   compute statistics;                                            
Statement processed.
SQLWKS> analyze table GARLAND.JOB_DISTINCT_STREET   compute statistics;                                  
Statement processed.
SQLWKS> analyze table GARLAND.JOIN_CATALOG   compute statistics;                                         
Statement processed.
SQLWKS> analyze table GARLAND.MAPS   compute statistics;                                                 
Statement processed.
SQLWKS> analyze table GARLAND.MSCATALOG   compute statistics;                                            
Statement processed.
SQLWKS> analyze table GARLAND.SANI_COM_FL   compute statistics;                                          
Statement processed.
SQLWKS> analyze table GARLAND.UTSANMH   compute statistics;                                              
Statement processed.
SQLWKS> analyze table GARLAND.VIEW_CONTENT   compute statistics;                                         
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
GARLAND      ATTRIBUTE_CATALOG              GIS_DATA            
GARLAND      CDRELTAX                       GIS_DATA            
GARLAND      DOMAIN_CATALOG                 GIS_DATA            
GARLAND      FEATURE                        GIS_DATA            
GARLAND      INSP_ARCH                      GIS_DATA            
GARLAND      JOB_DISTINCT_STREET            GIS_DATA            
GARLAND      JOIN_CATALOG                   GIS_DATA            
GARLAND      MAPS                           GIS_DATA            
GARLAND      MSCATALOG                      GIS_DATA            
GARLAND      SANI_COM_FL                    GIS_DATA            
GARLAND      UTSANMH                        GIS_DATA            
GARLAND      VIEW_CONTENT                   GIS_DATA            
12 rows selected.
OWNER        INDEX_NAME                     TABLE_NAME                     TABLESPACE           UNIQUENES
------------ ------------------------------ ------------------------------ -------------------- ---------
GARLAND      CDRELTAX_X_PID                 CDRELTAX                       GISINDX              NONUNIQUE
GARLAND      FEA_GARLAND_USE                FEATURE                        GISINDX              NONUNIQUE
GARLAND      MSCATALOG_I                    MSCATALOG                      GISINDX              UNIQUE   
GARLAND      SANI_COM_FL_X_ACCOUNT          SANI_COM_FL                    GISINDX              NONUNIQUE
GARLAND      SANI_COM_FL_X_NAMNUM           SANI_COM_FL                    GISINDX              NONUNIQUE
5 rows selected.
OWNER        CONSTRAINT_NAME                TABLE_NAME                     C PARENT_OWNER PARENT_CONSTRAINT             
------------ ------------------------------ ------------------------------ - ------------ ------------------------------
0 rows selected.
OWNER        TABLE_SEGMENT                  BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      JOB_DISTINCT_STREET                 71680          1      65536      32768 GIS_DATA            
GARLAND      MAPS                                71680          1      65536      32768 GIS_DATA            
GARLAND      CDRELTAX                         16158720          1   16154624      32768 GIS_DATA            
GARLAND      INSP_ARCH                         2037760          1    2031616      32768 GIS_DATA            
GARLAND      ATTRIBUTE_CATALOG                  204800          1     196608      32768 GIS_DATA            
GARLAND      VIEW_CONTENT                       102400          1      98304      32768 GIS_DATA            
GARLAND      JOIN_CATALOG                       204800          1     196608      32768 GIS_DATA            
GARLAND      MSCATALOG                           71680          1      65536      32768 GIS_DATA            
GARLAND      UTSANMH                            696320          1     688128      32768 GIS_DATA            
GARLAND      SANI_COM_FL                        266240          1     262144      32768 GIS_DATA            
GARLAND      DOMAIN_CATALOG                      71680          1      65536      32768 GIS_DATA            
GARLAND      FEATURE                            102400          1      98304      32768 GIS_DATA            
12 rows selected.
OWNER        INDEX_SEGMENT                  BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      CDRELTAX_X_PID                    3348480          1    3342336      32768 GISINDX             
GARLAND      FEA_GARLAND_USE                     40960          1      32768      32768 GISINDX             
GARLAND      MSCATALOG_I                         40960          1      32768      32768 GISINDX             
GARLAND      SANI_COM_FL_X_ACCOUNT             1085440          1    1081344      32768 GISINDX             
GARLAND      SANI_COM_FL_X_NAMNUM              1085440          1    1081344      32768 GISINDX             
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

