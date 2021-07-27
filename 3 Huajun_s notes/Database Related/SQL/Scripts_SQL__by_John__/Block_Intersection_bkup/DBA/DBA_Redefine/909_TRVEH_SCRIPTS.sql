Echo                            OFF
MGR-00308: no spool file opened
Echo                            OFF
Statement processed.
Statement processed.
5 rows processed.
Statement processed.
2 rows processed.
Statement processed.
1 row processed.
Statement processed.
KEY_                           TYPE_                          SCHEMA_                        PREFIX_                        SUFFIX_                        TABLESPACE_                    INITIAL_                       NEXT_                          PCTFREE_                       PCTUSED_                       MAXEXTENTS_                    MAXTRANS_                      OPTION1_                       OPTION2_                      
------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------ ------------------------------
TRVEHACL                       table                          GARLAND                        NEW_                                                          GIS_DATA                       96K                            32K                            10                             40                             249                            255                                                                                         
TRVEHALY                       table                          GARLAND                        NEW_                                                          GIS_DATA                       416K                           32K                            10                             40                             249                            255                                                                                         
TRVEHRCL                       table                          GARLAND                        NEW_                                                          GIS_DATA                       1632K                          32K                            10                             40                             249                            255                                                                                         
TRVEHSTR                       table                          GARLAND                        NEW_                                                          GIS_DATA                       608K                           32K                            10                             40                             249                            255                                                                                         
TRVEHUNP                       table                          GARLAND                        NEW_                                                          GIS_DATA                       96K                            32K                            10                             40                             249                            255                                                                                         
TRVEHRCL_U_MSLINK              index                          GARLAND                                                                                      GISINDX                        1056K                          32K                            10                             40                             249                            255                                                                                         
TRVEHRCL_X_NAME                index                          GARLAND                                                                                      GISINDX                        1056K                          32K                            10                             40                             249                            255                                                                                         
all                            as                             GARLAND                                                                                                                                                                                                                                                                                                                                                                            
8 rows selected.
Echo                            OFF
OWNER        TABLE_NAME                     TABLESPACE          
------------ ------------------------------ --------------------
GARLAND      TRVEHACL                       GIS_DATA            
GARLAND      TRVEHALY                       GIS_DATA            
GARLAND      TRVEHRCL                       GIS_DATA            
GARLAND      TRVEHSTR                       GIS_DATA            
GARLAND      TRVEHUNP                       GIS_DATA            
5 rows selected.
OWNER        INDEX_NAME                     TABLE_NAME                     TABLESPACE           UNIQUENES
------------ ------------------------------ ------------------------------ -------------------- ---------
GARLAND      TRVEHRCL_U_MSLINK              TRVEHRCL                       GISINDX              UNIQUE   
GARLAND      TRVEHRCL_X_NAME                TRVEHRCL                       GISINDX              NONUNIQUE
2 rows selected.
OWNER        CONSTRAINT_NAME                TABLE_NAME                     C PARENT_OWNER PARENT_CONSTRAINT             
------------ ------------------------------ ------------------------------ - ------------ ------------------------------
0 rows selected.
OWNER        TABLE_SEGMENT                  BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      TRVEHSTR                           593920          9      10240     286720 GIS_DATA            
GARLAND      TRVEHRCL                          1628160          3      10240    1454080 GIS_DATA            
GARLAND      TRVEHALY                           399360          8      10240     190464 GIS_DATA            
GARLAND      TRVEHUNP                            71680          4      10240      36864 GIS_DATA            
GARLAND      TRVEHACL                            71680          4      10240      36864 GIS_DATA            
5 rows selected.
OWNER        INDEX_SEGMENT                  BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      TRVEHRCL_U_MSLINK                 1054720          1    1048576    1048576 GISINDX             
GARLAND      TRVEHRCL_X_NAME                   1054720          1    1048576    1048576 GISINDX             
2 rows selected.
Echo                            OFF
Charwidth                       100
Echo                            OFF
Server Output                   ON
Charwidth                       100
Statement processed.
select 'CREATE TRVEHACL' " " from dual;
create table   GARLAND.NEW_TRVEHACL
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 96K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.TRVEHACL;
select count(*) "TRVEHACL" from GARLAND.TRVEHACL;
select count(*) " " from GARLAND.NEW_TRVEHACL;
;
select 'CREATE TRVEHALY' " " from dual;
create table   GARLAND.NEW_TRVEHALY
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 416K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.TRVEHALY;
select count(*) "TRVEHALY" from GARLAND.TRVEHALY;
select count(*) " " from GARLAND.NEW_TRVEHALY;
;
select 'CREATE TRVEHRCL' " " from dual;
create table   GARLAND.NEW_TRVEHRCL
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 1632K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.TRVEHRCL;
select count(*) "TRVEHRCL" from GARLAND.TRVEHRCL;
select count(*) " " from GARLAND.NEW_TRVEHRCL;
;
select 'CREATE TRVEHSTR' " " from dual;
create table   GARLAND.NEW_TRVEHSTR
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 608K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.TRVEHSTR;
select count(*) "TRVEHSTR" from GARLAND.TRVEHSTR;
select count(*) " " from GARLAND.NEW_TRVEHSTR;
;
select 'CREATE TRVEHUNP' " " from dual;
create table   GARLAND.NEW_TRVEHUNP
tablespace GIS_DATA   pctfree 10  pctused 40
           initrans 1 maxtrans 255
storage   (initial 96K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
as select * from GARLAND.TRVEHUNP;
select count(*) "TRVEHUNP" from GARLAND.TRVEHUNP;
select count(*) " " from GARLAND.NEW_TRVEHUNP;
;
Echo                            OFF
Timing                          OFF
Echo                            OFF
Server Output                   ON
Charwidth                       100
Statement processed.
select 'TRVEHRCL_U_MSLINK' " " from dual;
create unique index   GARLAND.TRVEHRCL_U_MSLINK
       on      GARLAND.TRVEHRCL
(
 MSLINK
)
tablespace GISINDX       initrans 2  maxtrans 255
storage   (initial 1056K next 32K pctincrease 0
           minextents 1  maxextents 249
           freelists  1  freelist groups 1)
;
select 'TRVEHRCL_X_NAME' " " from dual;
create index   GARLAND.TRVEHRCL_X_NAME
       on      GARLAND.TRVEHRCL
(
 ADDR_NAME
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
Echo                            OFF
Server Output                   ON
Charwidth                       100
Statement processed.
Echo                            OFF
Server Output                   ON
Statement processed.
                                                                     
---------------------------------------------------------------------
	drop table TRVEHACL;   --  cascade constraints                      
	drop table TRVEHALY;   --  cascade constraints                      
	drop table TRVEHRCL;   --  cascade constraints                      
	drop table TRVEHSTR;   --  cascade constraints                      
	drop table TRVEHUNP;   --  cascade constraints                      
5 rows selected.
                                                                                                    
----------------------------------------------------------------------------------------------------
	rename NEW_TRVEHACL  to  TRVEHACL;                                                                 
	rename NEW_TRVEHALY  to  TRVEHALY;                                                                 
	rename NEW_TRVEHRCL  to  TRVEHRCL;                                                                 
	rename NEW_TRVEHSTR  to  TRVEHSTR;                                                                 
	rename NEW_TRVEHUNP  to  TRVEHUNP;                                                                 
5 rows selected.
                                                                                                 
-------------------------------------------------------------------------------------------------
analyze table GARLAND.TRVEHACL   compute statistics;                                             
analyze table GARLAND.TRVEHALY   compute statistics;                                             
analyze table GARLAND.TRVEHRCL   compute statistics;                                             
analyze table GARLAND.TRVEHSTR   compute statistics;                                             
analyze table GARLAND.TRVEHUNP   compute statistics;                                             
5 rows selected.
                                                                                                    

               
---------------
CREATE TRVEHACL
1 row selected.
Statement processed.
TRVEHACL  
----------
      2029
1 row selected.
          
----------
      2029
1 row selected.
               
---------------
CREATE TRVEHALY
1 row selected.
Statement processed.
TRVEHALY  
----------
      2046
1 row selected.
          
----------
      2046
1 row selected.
               
---------------
CREATE TRVEHRCL
1 row selected.
Statement processed.
TRVEHRCL  
----------
      7091
1 row selected.
          
----------
      7091
1 row selected.
               
---------------
CREATE TRVEHSTR
1 row selected.
Statement processed.
TRVEHSTR  
----------
      3024
1 row selected.
          
----------
      3024
1 row selected.
               
---------------
CREATE TRVEHUNP
1 row selected.
Statement processed.
TRVEHUNP  
----------
       727
1 row selected.
          
----------
       727
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
TABLE             NEW_TRVEHACL                            1      98304      32768     102400
TABLE             NEW_TRVEHALY                            1     425984      32768     430080
TABLE             NEW_TRVEHRCL                            1    1671168      32768    1679360
TABLE             NEW_TRVEHSTR                            1     622592      32768     634880
TABLE             NEW_TRVEHUNP                            1      98304      32768     102400
TABLE             TRVEHACL                                4      10240      36864      71680
TABLE             TRVEHALY                                8      10240     190464     399360
TABLE             TRVEHRCL                                3      10240    1454080    1628160
TABLE             TRVEHSTR                                9      10240     286720     593920
TABLE             TRVEHUNP                                4      10240      36864      71680
INDEX             TRVEHRCL_U_MSLINK                       1    1048576    1048576    1054720
INDEX             TRVEHRCL_X_NAME                         1    1048576    1048576    1054720
12 rows selected.

SQLWKS> 
SQLWKS> --	=========================================================================
SQLWKS> --	DROP ORIGINAL TABLE
SQLWKS> 
SQLWKS> 	@c:\deacutis\scripts\ora_create\SCRIPT_DROP.sql;
SQLWKS>                                                                      
SQLWKS> ---------------------------------------------------------------------
SQLWKS> 	drop table TRVEHACL;   --  cascade constraints                      
Statement processed.
SQLWKS> 	drop table TRVEHALY;   --  cascade constraints                      
Statement processed.
SQLWKS> 	drop table TRVEHRCL;   --  cascade constraints                      
Statement processed.
SQLWKS> 	drop table TRVEHSTR;   --  cascade constraints                      
Statement processed.
SQLWKS> 	drop table TRVEHUNP;   --  cascade constraints                      
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
SQLWKS> 	rename NEW_TRVEHACL  to  TRVEHACL;                                                                 
Statement processed.
SQLWKS> 	rename NEW_TRVEHALY  to  TRVEHALY;                                                                 
Statement processed.
SQLWKS> 	rename NEW_TRVEHRCL  to  TRVEHRCL;                                                                 
Statement processed.
SQLWKS> 	rename NEW_TRVEHSTR  to  TRVEHSTR;                                                                 
Statement processed.
SQLWKS> 	rename NEW_TRVEHUNP  to  TRVEHUNP;                                                                 
Statement processed.
SQLWKS> 
SQLWKS> --	@d:\scripts\ora_create\SCRIPT_RENAME.sql;
SQLWKS> 
SQLWKS> 
SQLWKS> 
SQLWKS> 	set echo off;
Echo                            OFF
                 
-----------------
TRVEHRCL_U_MSLINK
1 row selected.
Statement processed.
               
---------------
TRVEHRCL_X_NAME
1 row selected.
Statement processed.
Statement processed.
*
ORA-00900: invalid SQL statement
Echo                            ON
SQLWKS> 
SQLWKS> --	================================================================================
SQLWKS> --	ANALYZE TABLES
SQLWKS> 
SQLWKS> 	@c:\deacutis\scripts\ora_create\Script_Analyze.sql;
SQLWKS>                                                                                                  
SQLWKS> -------------------------------------------------------------------------------------------------
SQLWKS> analyze table GARLAND.TRVEHACL   compute statistics;                                             
Statement processed.
SQLWKS> analyze table GARLAND.TRVEHALY   compute statistics;                                             
Statement processed.
SQLWKS> analyze table GARLAND.TRVEHRCL   compute statistics;                                             
Statement processed.
SQLWKS> analyze table GARLAND.TRVEHSTR   compute statistics;                                             
Statement processed.
SQLWKS> analyze table GARLAND.TRVEHUNP   compute statistics;                                             
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
GARLAND      TRVEHACL                       GIS_DATA            
GARLAND      TRVEHALY                       GIS_DATA            
GARLAND      TRVEHRCL                       GIS_DATA            
GARLAND      TRVEHSTR                       GIS_DATA            
GARLAND      TRVEHUNP                       GIS_DATA            
5 rows selected.
OWNER        INDEX_NAME                     TABLE_NAME                     TABLESPACE           UNIQUENES
------------ ------------------------------ ------------------------------ -------------------- ---------
GARLAND      TRVEHRCL_U_MSLINK              TRVEHRCL                       GISINDX              UNIQUE   
GARLAND      TRVEHRCL_X_NAME                TRVEHRCL                       GISINDX              NONUNIQUE
2 rows selected.
OWNER        CONSTRAINT_NAME                TABLE_NAME                     C PARENT_OWNER PARENT_CONSTRAINT             
------------ ------------------------------ ------------------------------ - ------------ ------------------------------
0 rows selected.
OWNER        TABLE_SEGMENT                  BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      TRVEHRCL                          1679360          1    1671168      32768 GIS_DATA            
GARLAND      TRVEHSTR                           634880          1     622592      32768 GIS_DATA            
GARLAND      TRVEHACL                           102400          1      98304      32768 GIS_DATA            
GARLAND      TRVEHALY                           430080          1     425984      32768 GIS_DATA            
GARLAND      TRVEHUNP                           102400          1      98304      32768 GIS_DATA            
5 rows selected.
OWNER        INDEX_SEGMENT                  BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      TRVEHRCL_U_MSLINK                 1085440          1    1081344      32768 GISINDX             
GARLAND      TRVEHRCL_X_NAME                   1085440          1    1081344      32768 GISINDX             
2 rows selected.

