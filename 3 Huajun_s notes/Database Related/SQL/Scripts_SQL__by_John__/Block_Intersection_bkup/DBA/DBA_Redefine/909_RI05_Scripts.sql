Echo                            OFF
MGR-00308: no spool file opened
Echo                            OFF
Statement processed.
Statement processed.
5 rows processed.
Statement processed.
12 rows processed.
Statement processed.
1 row processed.
Statement processed.
KEY_                           TYPE_                          SCHEMA_                        PREFIX_                        SUFFIX_                        TABLESPACE_                    INITIAL_                       NEXT_                          PCTFREE_                       PCTUSED_                       MAXEXTENTS_                    MAXTRANS_                      OPTION1_                       OPTION2_                      
------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------
RI05_T02                       table                          GARLAND                        NEW_                                                          GIS_DATA                       128K                           32K                            10                             40                             249                            255                                                                                         
RI05_T03                       table                          GARLAND                        NEW_                                                          GIS_DATA                       1312K                          32K                            10                             40                             249                            255                                                                                         
RI05_T04                       table                          GARLAND                        NEW_                                                          GIS_DATA                       128K                           32K                            10                             40                             249                            255                                                                                         
RI05_T05                       table                          GARLAND                        NEW_                                                          GIS_DATA                       1312K                          32K                            10                             40                             249                            255                                                                                         
RI05_T08                       table                          GARLAND                        NEW_                                                          GIS_DATA                       128K                           32K                            10                             40                             249                            255                                                                                         
RISXXX_COL1                    index                          GARLAND                                                                                      GISINDX                        320K                           32K                            10                             40                             249                            255                                                                                         
RISXXX_IDXCOLA1                index                          GARLAND                                                                                      GISINDX                        32K                            32K                            10                             40                             249                            255                                                                                         
RISXXX_IDXCOLB1                index                          GARLAND                                                                                      GISINDX                        32K                            32K                            10                             40                             249                            255                                                                                         
RISXXX_PRIVA1                  index                          GARLAND                                                                                      GISINDX                        224K                           32K                            10                             40                             249                            255                                                                                         
RISXXX_PRIVB1                  index                          GARLAND                                                                                      GISINDX                        448K                           32K                            10                             40                             249                            255                                                                                         
RISXXX_PRIVC1                  index                          GARLAND                                                                                      GISINDX                        320K                           32K                            10                             40                             249                            255                                                                                         
RISXXX_PRIVD1                  index                          GARLAND                                                                                      GISINDX                        448K                           32K                            10                             40                             249                            255                                                                                         
RISXXX_PRIVE1                  index                          GARLAND                                                                                      GISINDX                        448K                           32K                            10                             40                             249                            255                                                                                         
RISXXX_TABA1                   index                          GARLAND                                                                                      GISINDX                        64K                            32K                            10                             40                             249                            255                                                                                         
RISXXX_TABB1                   index                          GARLAND                                                                                      GISINDX                        32K                            32K                            10                             40                             249                            255                                                                                         
RISXXX_TABC1                   index                          GARLAND                                                                                      GISINDX                        64K                            32K                            10                             40                             249                            255                                                                                         
RISXXX_VIEW1                   index                          GARLAND                                                                                      GISINDX                        64K                            32K                            10                             40                             249                            255                                                                                         
all                            as                             GARLAND                                                                                                                                                                                                                                                                                                                                                                            
18 rows selected.
Echo                            OFF
OWNER        TABLE_NAME                     TABLESPACE          
------------ ------------------------------ --------------------
GARLAND      RI05_T02                       GIS_DATA            
GARLAND      RI05_T03                       GIS_DATA            
GARLAND      RI05_T04                       GIS_DATA            
GARLAND      RI05_T05                       GIS_DATA            
GARLAND      RI05_T08                       GIS_DATA            
5 rows selected.
OWNER        INDEX_NAME                     TABLE_NAME                     TABLESPACE           UNIQUENES
------------ ------------------------------ ------------------------------ -------------------- ---------
GARLAND      RISXXX_TABA1                   RI05_T02                       GISINDX              UNIQUE   
GARLAND      RISXXX_TABB1                   RI05_T02                       GISINDX              UNIQUE   
GARLAND      RISXXX_TABC1                   RI05_T02                       GISINDX              UNIQUE   
GARLAND      RISXXX_COL1                    RI05_T03                       GISINDX              UNIQUE   
GARLAND      RISXXX_IDXCOLA1                RI05_T04                       GISINDX              UNIQUE   
GARLAND      RISXXX_IDXCOLB1                RI05_T04                       GISINDX              NONUNIQUE
GARLAND      RISXXX_PRIVA1                  RI05_T05                       GISINDX              NONUNIQUE
GARLAND      RISXXX_PRIVB1                  RI05_T05                       GISINDX              UNIQUE   
GARLAND      RISXXX_PRIVC1                  RI05_T05                       GISINDX              NONUNIQUE
GARLAND      RISXXX_PRIVD1                  RI05_T05                       GISINDX              NONUNIQUE
GARLAND      RISXXX_PRIVE1                  RI05_T05                       GISINDX              NONUNIQUE
GARLAND      RISXXX_VIEW1                   RI05_T08                       GISINDX              UNIQUE   
12 rows selected.
OWNER        CONSTRAINT_NAME                TABLE_NAME                     C PARENT_OWNER PARENT_CONSTRAINT             
------------ ------------------------------ ------------------------------ - ------------ ------------------------------
0 rows selected.
OWNER        TABLE_SEGMENT                  BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      RI05_T08                           112640          5      10240      55296 GIS_DATA            
GARLAND      RI05_T02                           112640          5      10240      55296 GIS_DATA            
GARLAND      RI05_T03                          1310720         11      10240     645120 GIS_DATA            
GARLAND      RI05_T04                           112640          5      10240      55296 GIS_DATA            
GARLAND      RI05_T05                          1310720         11      10240     645120 GIS_DATA            
5 rows selected.
OWNER        INDEX_SEGMENT                  BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      RISXXX_COL1                        296960          2      10240     286720 GISINDX             
GARLAND      RISXXX_IDXCOLA1                     10240          1      10240      36864 GISINDX             
GARLAND      RISXXX_IDXCOLB1                     10240          1      10240      24576 GISINDX             
GARLAND      RISXXX_PRIVA1                      204800          2      10240     190464 GISINDX             
GARLAND      RISXXX_PRIVB1                      440320          2      10240     430080 GISINDX             
GARLAND      RISXXX_PRIVC1                      296960          2      10240     286720 GISINDX             
GARLAND      RISXXX_PRIVD1                      440320          2      10240     430080 GISINDX             
GARLAND      RISXXX_PRIVE1                      440320          2      10240     430080 GISINDX             
GARLAND      RISXXX_TABA1                        40960          2      10240      24576 GISINDX             
GARLAND      RISXXX_TABB1                        10240          1      10240      24576 GISINDX             
GARLAND      RISXXX_TABC1                        51200          2      10240      36864 GISINDX             
GARLAND      RISXXX_VIEW1                        40960          2      10240      24576 GISINDX             
12 rows selected.
Echo                            OFF
Charwidth                       100
Echo                            OFF
Server Output                   ON
Charwidth                       100
Statement processed.
select 'CREATE RI05_T02' " " from dual;
create table   GARLAND.NEW_RI05_T02
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 128K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.RI05_T02;
select count(*) "RI05_T02" from GARLAND.RI05_T02;
select count(*) " " from GARLAND.NEW_RI05_T02;
;
select 'CREATE RI05_T03' " " from dual;
create table   GARLAND.NEW_RI05_T03
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1312K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.RI05_T03;
select count(*) "RI05_T03" from GARLAND.RI05_T03;
select count(*) " " from GARLAND.NEW_RI05_T03;
;
select 'CREATE RI05_T04' " " from dual;
create table   GARLAND.NEW_RI05_T04
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 128K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.RI05_T04;
select count(*) "RI05_T04" from GARLAND.RI05_T04;
select count(*) " " from GARLAND.NEW_RI05_T04;
;
select 'CREATE RI05_T05' " " from dual;
create table   GARLAND.NEW_RI05_T05
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1312K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.RI05_T05;
select count(*) "RI05_T05" from GARLAND.RI05_T05;
select count(*) " " from GARLAND.NEW_RI05_T05;
;
select 'CREATE RI05_T08' " " from dual;
create table   GARLAND.NEW_RI05_T08
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 128K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.RI05_T08;
select count(*) "RI05_T08" from GARLAND.RI05_T08;
select count(*) " " from GARLAND.NEW_RI05_T08;
;
Echo                            OFF
Timing                          OFF
Echo                            OFF
Server Output                   ON
Charwidth                       100
Statement processed.
select 'RISXXX_COL1' " " from dual;
create unique index   GARLAND.RISXXX_COL1
       on      GARLAND.RI05_T03
(
 TABLE_ID
,COLUMN_NAME
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 320K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;
select 'RISXXX_IDXCOLA1' " " from dual;
create unique index   GARLAND.RISXXX_IDXCOLA1
       on      GARLAND.RI05_T04
(
 TABLE_ID
,INDEX_NAME
,POSITION
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;
select 'RISXXX_IDXCOLB1' " " from dual;
create index   GARLAND.RISXXX_IDXCOLB1
       on      GARLAND.RI05_T04
(
 INDEX_NAME
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;
select 'RISXXX_PRIVA1' " " from dual;
create index   GARLAND.RISXXX_PRIVA1
       on      GARLAND.RI05_T05
(
 GRANTEE
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 224K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;
select 'RISXXX_PRIVB1' " " from dual;
create unique index   GARLAND.RISXXX_PRIVB1
       on      GARLAND.RI05_T05
(
 TABLE_ID
,COLUMN_NAME
,GRANTOR
,GRANTEE
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 448K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;
select 'RISXXX_PRIVC1' " " from dual;
create index   GARLAND.RISXXX_PRIVC1
       on      GARLAND.RI05_T05
(
 TABLE_ID
,GRANTEE
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 320K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;
select 'RISXXX_PRIVD1' " " from dual;
create index   GARLAND.RISXXX_PRIVD1
       on      GARLAND.RI05_T05
(
 COLUMN_NAME
,GRANTOR
,GRANTEE
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 448K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;
select 'RISXXX_PRIVE1' " " from dual;
create index   GARLAND.RISXXX_PRIVE1
       on      GARLAND.RI05_T05
(
 TABLE_ID
,COLUMN_NAME
,GRANTOR
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 448K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;
select 'RISXXX_TABA1' " " from dual;
create unique index   GARLAND.RISXXX_TABA1
       on      GARLAND.RI05_T02
(
 SCHEMA_NAME
,TABLE_NAME
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 64K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;
select 'RISXXX_TABB1' " " from dual;
create unique index   GARLAND.RISXXX_TABB1
       on      GARLAND.RI05_T02
(
 TABLE_ID
,SCHEMA_NAME
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 32K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;
select 'RISXXX_TABC1' " " from dual;
create unique index   GARLAND.RISXXX_TABC1
       on      GARLAND.RI05_T02
(
 EXT_TABLE_NAME
,DBMS_OWNER
,SCHEMA_NAME
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 64K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;
select 'RISXXX_VIEW1' " " from dual;
create unique index   GARLAND.RISXXX_VIEW1
       on      GARLAND.RI05_T08
(
 TABLE_ID
,SEQUENCE_ID
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 64K next 32K pctincrease 0
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
Charwidth                       100
Statement processed.
Echo                            OFF
Server Output                   ON
Statement processed.
                                                                     
---------------------------------------------------------------------
	drop table RI05_T02;   --  cascade constraints                      
	drop table RI05_T03;   --  cascade constraints                      
	drop table RI05_T04;   --  cascade constraints                      
	drop table RI05_T05;   --  cascade constraints                      
	drop table RI05_T08;   --  cascade constraints                      
5 rows selected.
                                                                                                    
----------------------------------------------------------------------------------------------------
	rename NEW_RI05_T02  to  RI05_T02;                                                                 
	rename NEW_RI05_T03  to  RI05_T03;                                                                 
	rename NEW_RI05_T04  to  RI05_T04;                                                                 
	rename NEW_RI05_T05  to  RI05_T05;                                                                 
	rename NEW_RI05_T08  to  RI05_T08;                                                                 
5 rows selected.
                                                                                                 
-------------------------------------------------------------------------------------------------
analyze table GARLAND.RI05_T02   compute statistics;                                             
analyze table GARLAND.RI05_T03   compute statistics;                                             
analyze table GARLAND.RI05_T04   compute statistics;                                             
analyze table GARLAND.RI05_T05   compute statistics;                                             
analyze table GARLAND.RI05_T08   compute statistics;                                             
5 rows selected.
                                                                                                    
----------------------------------------------------------------------------------------------------
alter VIEW GARLAND.ADRRESOLVE_VIEW compile;                                                         
alter PROCEDURE GARLAND.ADR_RESOLVE_ADDRESS compile;                                                
alter PROCEDURE GARLAND.CHANGES_CUSTOMER_ID compile;                                                
alter PROCEDURE GARLAND.DELETE_ROWS compile;                                                        
alter FUNCTION GARLAND.DT_ADDUSEROBJECT compile;                                                    
alter PROCEDURE GARLAND.DT_DROPUSEROBJECTBYID compile;                                              
alter PROCEDURE GARLAND.DT_SETPROPERTYBYID compile;                                                 
alter PROCEDURE GARLAND.TST_RESOLVE_ADDRESS compile;                                                
8 rows selected.
Echo                            OFF
Echo                            OFF
               
---------------
CREATE RI05_T02
1 row selected.
Statement processed.
RI05_T02  
----------
       164
1 row selected.
          
----------
       164
1 row selected.
               
---------------
CREATE RI05_T03
1 row selected.
Statement processed.
RI05_T03  
----------
      2377
1 row selected.
          
----------
      2377
1 row selected.
               
---------------
CREATE RI05_T04
1 row selected.
Statement processed.
RI05_T04  
----------
        42
1 row selected.
          
----------
        42
1 row selected.
               
---------------
CREATE RI05_T05
1 row selected.
Statement processed.
RI05_T05  
----------
      2349
1 row selected.
          
----------
      2349
1 row selected.
               
---------------
CREATE RI05_T08
1 row selected.
Statement processed.
RI05_T08  
----------
       365
1 row selected.
          
----------
       365
1 row selected.
ORIGINALS 
----------
         5
1 row selected.
COPIES    
----------
         5
1 row selected.
MISSING COPIES                
------------------------------
0 rows selected.
SEGMENT TYPE      SEGMENT NAME                   EXTENTS    INITIAL    NEXT       SIZE      
----------------- ------------------------------ ---------- ---------- ---------- ----------
TABLE             NEW_RI05_T02                            1     131072      32768     133120
TABLE             NEW_RI05_T03                            1    1343488      32768    1351680
TABLE             NEW_RI05_T04                            1     131072      32768     133120
TABLE             NEW_RI05_T05                            1    1343488      32768    1351680
TABLE             NEW_RI05_T08                            1     131072      32768     133120
TABLE             RI05_T02                                5      10240      55296     112640
TABLE             RI05_T03                               11      10240     645120    1310720
TABLE             RI05_T04                                5      10240      55296     112640
TABLE             RI05_T05                               11      10240     645120    1310720
TABLE             RI05_T08                                5      10240      55296     112640
INDEX             RISXXX_COL1                             2      10240     286720     296960
INDEX             RISXXX_IDXCOLA1                         1      10240      36864      10240
INDEX             RISXXX_IDXCOLB1                         1      10240      24576      10240
INDEX             RISXXX_PRIVA1                           2      10240     190464     204800
INDEX             RISXXX_PRIVB1                           2      10240     430080     440320
INDEX             RISXXX_PRIVC1                           2      10240     286720     296960
INDEX             RISXXX_PRIVD1                           2      10240     430080     440320
INDEX             RISXXX_PRIVE1                           2      10240     430080     440320
INDEX             RISXXX_TABA1                            2      10240      24576      40960
INDEX             RISXXX_TABB1                            1      10240      24576      10240
INDEX             RISXXX_TABC1                            2      10240      36864      51200
INDEX             RISXXX_VIEW1                            2      10240      24576      40960
22 rows selected.
SQLWKS> 
SQLWKS> --	=========================================================================
SQLWKS> --	DROP ORIGINAL TABLE
SQLWKS> 
SQLWKS> 	@c:\deacutis\scripts\ora_create\SCRIPT_DROP.sql;
SQLWKS>                                                                      
SQLWKS> ---------------------------------------------------------------------
SQLWKS> 	drop table RI05_T02;   --  cascade constraints                      
Statement processed.
SQLWKS> 	drop table RI05_T03;   --  cascade constraints                      
Statement processed.
SQLWKS> 	drop table RI05_T04;   --  cascade constraints                      
Statement processed.
SQLWKS> 	drop table RI05_T05;   --  cascade constraints                      
Statement processed.
SQLWKS> 	drop table RI05_T08;   --  cascade constraints                      
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
SQLWKS> 	rename NEW_RI05_T02  to  RI05_T02;                                                                 
Statement processed.
SQLWKS> 	rename NEW_RI05_T03  to  RI05_T03;                                                                 
Statement processed.
SQLWKS> 	rename NEW_RI05_T04  to  RI05_T04;                                                                 
Statement processed.
SQLWKS> 	rename NEW_RI05_T05  to  RI05_T05;                                                                 
Statement processed.
SQLWKS> 	rename NEW_RI05_T08  to  RI05_T08;                                                                 
Statement processed.
SQLWKS>  
SQLWKS> 
SQLWKS> --	@d:\scripts\ora_create\SCRIPT_RENAME.sql;
SQLWKS> 
SQLWKS> 
SQLWKS> 
SQLWKS> 	set echo off;
Echo                            OFF
           
-----------
RISXXX_COL1
1 row selected.
Statement processed.
               
---------------
RISXXX_IDXCOLA1
1 row selected.
Statement processed.
               
---------------
RISXXX_IDXCOLB1
1 row selected.
Statement processed.
             
-------------
RISXXX_PRIVA1
1 row selected.
Statement processed.
             
-------------
RISXXX_PRIVB1
1 row selected.
Statement processed.
             
-------------
RISXXX_PRIVC1
1 row selected.
Statement processed.
             
-------------
RISXXX_PRIVD1
1 row selected.
Statement processed.
             
-------------
RISXXX_PRIVE1
1 row selected.
Statement processed.
            
------------
RISXXX_TABA1
1 row selected.
Statement processed.
            
------------
RISXXX_TABB1
1 row selected.
Statement processed.
            
------------
RISXXX_TABC1
1 row selected.
Statement processed.
            
------------
RISXXX_VIEW1
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
SQLWKS> analyze table GARLAND.RI05_T02   compute statistics;                                             
Statement processed.
SQLWKS> analyze table GARLAND.RI05_T03   compute statistics;                                             
Statement processed.
SQLWKS> analyze table GARLAND.RI05_T04   compute statistics;                                             
Statement processed.
SQLWKS> analyze table GARLAND.RI05_T05   compute statistics;                                             
Statement processed.
SQLWKS> analyze table GARLAND.RI05_T08   compute statistics;                                             
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
GARLAND      RI05_T02                       GIS_DATA            
GARLAND      RI05_T03                       GIS_DATA            
GARLAND      RI05_T04                       GIS_DATA            
GARLAND      RI05_T05                       GIS_DATA            
GARLAND      RI05_T08                       GIS_DATA            
5 rows selected.
OWNER        INDEX_NAME                     TABLE_NAME                     TABLESPACE           UNIQUENES
------------ ------------------------------ ------------------------------ -------------------- ---------
GARLAND      RISXXX_TABA1                   RI05_T02                       GISINDX              UNIQUE   
GARLAND      RISXXX_TABB1                   RI05_T02                       GISINDX              UNIQUE   
GARLAND      RISXXX_TABC1                   RI05_T02                       GISINDX              UNIQUE   
GARLAND      RISXXX_COL1                    RI05_T03                       GISINDX              UNIQUE   
GARLAND      RISXXX_IDXCOLA1                RI05_T04                       GISINDX              UNIQUE   
GARLAND      RISXXX_IDXCOLB1                RI05_T04                       GISINDX              NONUNIQUE
GARLAND      RISXXX_PRIVA1                  RI05_T05                       GISINDX              NONUNIQUE
GARLAND      RISXXX_PRIVB1                  RI05_T05                       GISINDX              UNIQUE   
GARLAND      RISXXX_PRIVC1                  RI05_T05                       GISINDX              NONUNIQUE
GARLAND      RISXXX_PRIVD1                  RI05_T05                       GISINDX              NONUNIQUE
GARLAND      RISXXX_PRIVE1                  RI05_T05                       GISINDX              NONUNIQUE
GARLAND      RISXXX_VIEW1                   RI05_T08                       GISINDX              UNIQUE   
12 rows selected.
OWNER        CONSTRAINT_NAME                TABLE_NAME                     C PARENT_OWNER PARENT_CONSTRAINT             
------------ ------------------------------ ------------------------------ - ------------ ------------------------------
0 rows selected.
OWNER        TABLE_SEGMENT                  BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      RI05_T04                           133120          1     131072      32768 GIS_DATA            
GARLAND      RI05_T05                          1351680          1    1343488      32768 GIS_DATA            
GARLAND      RI05_T08                           133120          1     131072      32768 GIS_DATA            
GARLAND      RI05_T02                           133120          1     131072      32768 GIS_DATA            
GARLAND      RI05_T03                          1351680          1    1343488      32768 GIS_DATA            
5 rows selected.
OWNER        INDEX_SEGMENT                  BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      RISXXX_COL1                        327680          1     327680      32768 GISINDX             
GARLAND      RISXXX_IDXCOLA1                     40960          1      32768      32768 GISINDX             
GARLAND      RISXXX_IDXCOLB1                     40960          1      32768      32768 GISINDX             
GARLAND      RISXXX_PRIVA1                      235520          1     229376      32768 GISINDX             
GARLAND      RISXXX_PRIVB1                      460800          1     458752      32768 GISINDX             
GARLAND      RISXXX_PRIVC1                      327680          1     327680      32768 GISINDX             
GARLAND      RISXXX_PRIVD1                      460800          1     458752      32768 GISINDX             
GARLAND      RISXXX_PRIVE1                      460800          1     458752      32768 GISINDX             
GARLAND      RISXXX_TABA1                        71680          1      65536      32768 GISINDX             
GARLAND      RISXXX_TABB1                        40960          1      32768      32768 GISINDX             
GARLAND      RISXXX_TABC1                        71680          1      65536      32768 GISINDX             
GARLAND      RISXXX_VIEW1                        71680          1      65536      32768 GISINDX             
12 rows selected.


