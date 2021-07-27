Echo                            OFF
Timing                          ON
Charwidth                       100
Echo                            OFF
Timing                          OFF
Statement processed.
1 row processed.
1 row processed.
Statement processed.
12 rows processed.
Statement processed.
Echo                            OFF
OWNER        TABLE_NAME                     TABLESPACE          
------------ ------------------------------ --------------------
GARLAND      INDSTL                         GIS_DATA            
GARLAND      INDUSTRY                       GIS_DATA            
GARLAND      INSP_ARCH_BKUP                 GIS_DATA            
GARLAND      SECTION8                       GIS_DATA            
GARLAND      SWPIPE                         GIS_DATA            
GARLAND      TAX_ABSTRACT                   GIS_DATA            
GARLAND      TAX_UB                         GIS_DATA            
GARLAND      TEMP_MULTIMPER                 GIS_DATA            
GARLAND      TMP_BECKY_BECK                 GIS_DATA            
GARLAND      TMP_INDUSTRY                   GIS_DATA            
GARLAND      TMP_SECTION8                   GIS_DATA            
GARLAND      XXX_PAVE_MAST_SAV              GIS_DATA            
12 rows selected.
OWNER        INDEX_NAME                     TABLE_NAME                     TABLESPACE           UNIQUENES
------------ ------------------------------ ------------------------------ -------------------- ---------
GARLAND      TAX_UB_ADDR_NAME_IDX           TAX_UB                         GISINDX              NONUNIQUE
GARLAND      TAX_UB_PID_IDX                 TAX_UB                         GISINDX              NONUNIQUE
2 rows selected.
OWNER        CONSTRAINT_NAME                TABLE_NAME                     C PARENT_OWNER PARENT_CONSTRAINT             
------------ ------------------------------ ------------------------------ - ------------ ------------------------------
0 rows selected.
OWNER        TABLE_SEGMENT                  BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      INDSTL                              40960          2      10240      36864 GIS_DATA            
GARLAND      INDUSTRY                            40960          3      10240      24576 GIS_DATA            
GARLAND      INSP_ARCH_BKUP                    2109440          2    1048576    1048576 GIS_DATA            
GARLAND      SECTION8                            40960          3      10240      24576 GIS_DATA            
GARLAND      SWPIPE                            5468160          3      10240    4909056 GIS_DATA            
GARLAND      TAX_ABSTRACT                        40960          3      10240      24576 GIS_DATA            
GARLAND      TAX_UB                           27637760          3      10240   24856576 GIS_DATA            
GARLAND      TEMP_MULTIMPER                      71680          4      10240      36864 GIS_DATA            
GARLAND      TMP_BECKY_BECK                      77824          4      10240      36864 GIS_DATA            
GARLAND      TMP_INDUSTRY                        81920          4      10240      36864 GIS_DATA            
GARLAND      TMP_SECTION8                        51200          3      10240      24576 GIS_DATA            
GARLAND      XXX_PAVE_MAST_SAV                 1085440          3      10240     968704 GIS_DATA            
12 rows selected.
OWNER        INDEX_SSEGMENT                 BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      TAX_UB_ADDR_NAME_IDX              1955840          3      10240     968704 GISINDX             
GARLAND      TAX_UB_PID_IDX                    1955840          3      10240     968704 GISINDX             
2 rows selected.
Charwidth                       100
Echo                            OFF
Timing                          OFF
1 row processed.
Statement processed.
Echo                            OFF
Timing                          OFF
Echo                            OFF
Statement processed.
Statement processed.
Statement processed.
120 rows processed.
Statement processed.
Statement processed.
Timing                          OFF
                                                                      
----------------------------------------------------------------------
create table   GARLAND.NEW_INDSTL                                     
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 64K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.INDSTL;                                      
select count(*) "INDSTL" from INDSTL;                                 
select count(*) " " from NEW_INDSTL;                                  
;                                                                     
create table   GARLAND.NEW_INDUSTRY                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 64K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.INDUSTRY;                                    
select count(*) "INDUSTRY" from INDUSTRY;                             
select count(*) " " from NEW_INDUSTRY;                                
;                                                                     
create table   GARLAND.NEW_INSP_ARCH_BKUP                             
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 2112K next 32K pctincrease 0                       
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.INSP_ARCH_BKUP;                              
select count(*) "INSP_ARCH_BKUP" from INSP_ARCH_BKUP;                 
select count(*) " " from NEW_INSP_ARCH_BKUP;                          
;                                                                     
create table   GARLAND.NEW_SECTION8                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 64K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.SECTION8;                                    
select count(*) "SECTION8" from SECTION8;                             
select count(*) " " from NEW_SECTION8;                                
;                                                                     
create table   GARLAND.NEW_SWPIPE                                     
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 5472K next 32K pctincrease 0                       
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.SWPIPE;                                      
select count(*) "SWPIPE" from SWPIPE;                                 
select count(*) " " from NEW_SWPIPE;                                  
;                                                                     
create table   GARLAND.NEW_TAX_ABSTRACT                               
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 64K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.TAX_ABSTRACT;                                
select count(*) "TAX_ABSTRACT" from TAX_ABSTRACT;                     
select count(*) " " from NEW_TAX_ABSTRACT;                            
;                                                                     
create table   GARLAND.NEW_TAX_UB                                     
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 27648K next 32K pctincrease 0                      
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.TAX_UB;                                      
select count(*) "TAX_UB" from TAX_UB;                                 
select count(*) " " from NEW_TAX_UB;                                  
;                                                                     
create table   GARLAND.NEW_TEMP_MULTIMPER                             
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 96K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.TEMP_MULTIMPER;                              
select count(*) "TEMP_MULTIMPER" from TEMP_MULTIMPER;                 
select count(*) " " from NEW_TEMP_MULTIMPER;                          
;                                                                     
create table   GARLAND.NEW_TMP_BECKY_BECK                             
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 96K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.TMP_BECKY_BECK;                              
select count(*) "TMP_BECKY_BECK" from TMP_BECKY_BECK;                 
select count(*) " " from NEW_TMP_BECKY_BECK;                          
;                                                                     
create table   GARLAND.NEW_TMP_INDUSTRY                               
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 96K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.TMP_INDUSTRY;                                
select count(*) "TMP_INDUSTRY" from TMP_INDUSTRY;                     
select count(*) " " from NEW_TMP_INDUSTRY;                            
;                                                                     
create table   GARLAND.NEW_TMP_SECTION8                               
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 64K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.TMP_SECTION8;                                
select count(*) "TMP_SECTION8" from TMP_SECTION8;                     
select count(*) " " from NEW_TMP_SECTION8;                            
;                                                                     
create table   GARLAND.NEW_XXX_PAVE_MAST_SAV                          
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 1088K next 32K pctincrease 0                       
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.XXX_PAVE_MAST_SAV;                           
select count(*) "XXX_PAVE_MAST_SAV" from XXX_PAVE_MAST_SAV;           
select count(*) " " from NEW_XXX_PAVE_MAST_SAV;                       
;                                                                     
120 rows selected.
1 row processed.
Statement processed.
Echo                            OFF
Timing                          OFF
Echo                            OFF
Timing                          OFF
Statement processed.
Statement processed.
Statement processed.
22 rows processed.
Statement processed.
Statement processed.
Timing                          OFF
                                                                      
----------------------------------------------------------------------
select 'TAX_UB_ADDR_NAME_IDX' " " from dual;                          
create index   GARLAND.TAX_UB_ADDR_NAME_IDX                           
       on      GARLAND.TAX_UB                                         
(                                                                     
 STREET_NAME                                                          
)                                                                     
tablespace GISINDX                                                    
storage   (initial 1984K next 32K pctincrease 0                       
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
;                                                                     
select 'TAX_UB_PID_IDX' " " from dual;                                
create index   GARLAND.TAX_UB_PID_IDX                                 
       on      GARLAND.TAX_UB                                         
(                                                                     
 PARCEL_ID                                                            
)                                                                     
tablespace GISINDX                                                    
storage   (initial 1984K next 32K pctincrease 0                       
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
;                                                                     
22 rows selected.
Echo                            OFF
Timing                          ON
Statement processed.
Parse             0.11 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.01 (Elapsed)     0.00 (CPU)
Total             0.12               0.00
Statement processed.
Parse             0.04 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.04               0.00
Statement processed.
Parse             0.00 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.00               0.00
0 rows processed.
Parse             0.35 (Elapsed)     0.00 (CPU)
Execute/Fetch     3.48 (Elapsed)     0.00 (CPU)
Total             3.83               0.00
Statement processed.
Parse             0.01 (Elapsed)     0.01 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.01               0.01
Statement processed.
Parse             0.02 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.02               0.00
Timing                          OFF
                                                                      
----------------------------------------------------------------------
0 rows selected.
1 row processed.
Statement processed.
Echo                            OFF
Timing                          OFF
Echo                            OFF
Timing                          OFF
                                                                                                    
----------------------------------------------------------------------------------------------------
	drop table INDSTL;   --  cascade constraints                                                       
	drop table INDUSTRY;   --  cascade constraints                                                     
	drop table INSP_ARCH_BKUP;   --  cascade constraints                                               
	drop table SECTION8;   --  cascade constraints                                                     
	drop table SWPIPE;   --  cascade constraints                                                       
	drop table TAX_ABSTRACT;   --  cascade constraints                                                 
	drop table TAX_UB;   --  cascade constraints                                                       
	drop table TEMP_MULTIMPER;   --  cascade constraints                                               
	drop table TMP_BECKY_BECK;   --  cascade constraints                                               
	drop table TMP_INDUSTRY;   --  cascade constraints                                                 
	drop table TMP_SECTION8;   --  cascade constraints                                                 
	drop table XXX_PAVE_MAST_SAV;   --  cascade constraints                                            
12 rows selected.
Echo                            ON
SQLWKS> 
SQLWKS> --	========================================================================
SQLWKS> 
SQLWKS> 
SQLWKS> 
SQLWKS> --	================================================================================
SQLWKS> 
SQLWKS> 	update tmp_view set name_append = 'NEW_',	tablespace_ = 'GIS_DATA'	
     2> 	where key_ = 'TABLE SPECS';	
1 row processed.
SQLWKS> 	commit;
Statement processed.
SQLWKS> 
SQLWKS> 	@c:\deacutis\scripts\ora_create\4_RENAMES.sql;
SQLWKS> 
SQLWKS> 	set echo 		off;
Echo                            OFF
Timing                          OFF
Echo                            OFF
Timing                          OFF
                                                                                                    
----------------------------------------------------------------------------------------------------
	rename NEW_INDSTL  to  INDSTL;                                                                     
	rename NEW_INDUSTRY  to  INDUSTRY;                                                                 
	rename NEW_INSP_ARCH_BKUP  to  INSP_ARCH_BKUP;                                                     
	rename NEW_SECTION8  to  SECTION8;                                                                 
	rename NEW_SWPIPE  to  SWPIPE;                                                                     
	rename NEW_TAX_ABSTRACT  to  TAX_ABSTRACT;                                                         
	rename NEW_TAX_UB  to  TAX_UB;                                                                     
	rename NEW_TEMP_MULTIMPER  to  TEMP_MULTIMPER;                                                     
	rename NEW_TMP_BECKY_BECK  to  TMP_BECKY_BECK;                                                     
	rename NEW_TMP_INDUSTRY  to  TMP_INDUSTRY;                                                         
	rename NEW_TMP_SECTION8  to  TMP_SECTION8;                                                         
	rename NEW_XXX_PAVE_MAST_SAV  to  XXX_PAVE_MAST_SAV;                                               
12 rows selected.
Echo                            ON
SQLWKS> 
SQLWKS>  
SQLWKS> 
SQLWKS> --	========================================================================
SQLWKS> 
SQLWKS> 
SQLWKS> 
SQLWKS> 
SQLWKS> --	================================================================================
SQLWKS> 	set echo off;
Echo                            OFF
                                                                                                    
----------------------------------------------------------------------------------------------------
analyze table GARLAND.INDSTL   compute statistics;                                                  
analyze table GARLAND.INDUSTRY   compute statistics;                                                
analyze table GARLAND.INSP_ARCH_BKUP   compute statistics;                                          
analyze table GARLAND.SECTION8   compute statistics;                                                
analyze table GARLAND.SWPIPE   compute statistics;                                                  
analyze table GARLAND.TAX_ABSTRACT   compute statistics;                                            
analyze table GARLAND.TAX_UB   compute statistics;                                                  
analyze table GARLAND.TEMP_MULTIMPER   compute statistics;                                          
analyze table GARLAND.TMP_BECKY_BECK   compute statistics;                                          
analyze table GARLAND.TMP_INDUSTRY   compute statistics;                                            
analyze table GARLAND.TMP_SECTION8   compute statistics;                                            
analyze table GARLAND.XXX_PAVE_MAST_SAV   compute statistics;                                       
12 rows selected.
Echo                            OFF
                                                                                                    
----------------------------------------------------------------------------------------------------
alter VIEW GARLAND.ADRRESOLVE_VIEW compile;                                                         
alter PROCEDURE GARLAND.ADR_RESOLVE_ADDRESS compile;                                                
alter PROCEDURE GARLAND.CHANGES_CUSTOMER_ID compile;                                                
alter PROCEDURE GARLAND.DELETE_ROWS compile;                                                        
alter FUNCTION GARLAND.DT_ADDUSEROBJECT compile;                                                    
alter PROCEDURE GARLAND.DT_DROPUSEROBJECTBYID compile;                                              
alter PROCEDURE GARLAND.DT_SETPROPERTYBYID compile;                                                 
alter VIEW GARLAND.PID_ADDR_TAX_VW compile;                                                         
alter VIEW GARLAND.PID_ADDR_TAX_VW1 compile;                                                        
alter VIEW GARLAND.PID_ADR_TAX_VW compile;                                                          
alter VIEW GARLAND.SNGLFAM_RENTAL_VW compile;                                                       
alter VIEW GARLAND.TAX_CODE_VW compile;                                                             
alter VIEW GARLAND.TAX_VW compile;                                                                  
alter PROCEDURE GARLAND.TST_RESOLVE_ADDRESS compile;                                                
14 rows selected.
Echo                            ON
SQLWKS> 	set timing 	off;
Timing                          OFF
SQLWKS> 


SQLWKS> 
SQLWKS> 	set echo	off;
Echo                            OFF
Timing                          ON
Echo                            OFF
Timing                          OFF
Statement processed.
INDSTL    
----------
       419
1 row selected.
          
----------
       419
1 row selected.
Statement processed.
INDUSTRY  
----------
       349
1 row selected.
          
----------
       349
1 row selected.
Statement processed.
INSP_ARCH_
----------
     12661
1 row selected.
          
----------
     12661
1 row selected.
Statement processed.
SECTION8  
----------
       475
1 row selected.
          
----------
       475
1 row selected.
Statement processed.
SWPIPE    
----------
     11917
1 row selected.
          
----------
     11917
1 row selected.
Statement processed.
TAX_ABSTRA
----------
       924
1 row selected.
          
----------
       924
1 row selected.
Statement processed.
TAX_UB    
----------
     66343
1 row selected.
          
----------
     66343
1 row selected.
Statement processed.
TEMP_MULTI
----------
       719
1 row selected.
          
----------
       719
1 row selected.
Statement processed.
TMP_BECKY_
----------
       616
1 row selected.
          
----------
       616
1 row selected.
Statement processed.
TMP_INDUST
----------
       481
1 row selected.
          
----------
       481
1 row selected.
Statement processed.
TMP_SECTIO
----------
       731
1 row selected.
          
----------
       731
1 row selected.
Statement processed.
XXX_PAVE_M
----------
      5330
1 row selected.
          
----------
      5330
1 row selected.
Echo                            OFF
original  
----------
        12
1 row selected.
new copy  
----------
        12
1 row selected.
Missing                                                                         
--------------------------------------------------------------------------------
0 rows selected.
Echo                            ON
SQLWKS> 	set timing 	off;
Timing                          OFF
SQLWKS> 


SQLWKS> 
SQLWKS> 	set echo	off;
Echo                            OFF
Timing                          OFF
Echo                            OFF
Timing                          OFF
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
                    
--------------------
TAX_UB_ADDR_NAME_IDX
1 row selected.
Statement processed.
              
--------------
TAX_UB_PID_IDX
1 row selected.
Statement processed.
Echo                            OFF
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Echo                            OFF
Statement processed.
MGR-00073: Warning: PROCEDURE GARLAND.ADR_RESOLVE_ADDRESS created with compilation errors.
MGR-00073: Warning: PROCEDURE GARLAND.CHANGES_CUSTOMER_ID created with compilation errors.
MGR-00073: Warning: PROCEDURE GARLAND.DELETE_ROWS created with compilation errors.
MGR-00073: Warning: FUNCTION GARLAND.DT_ADDUSEROBJECT created with compilation errors.
MGR-00073: Warning: PROCEDURE GARLAND.DT_DROPUSEROBJECTBYID created with compilation errors.
MGR-00073: Warning: PROCEDURE GARLAND.DT_SETPROPERTYBYID created with compilation errors.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
Statement processed.
MGR-00073: Warning: PROCEDURE GARLAND.TST_RESOLVE_ADDRESS created with compilation errors.
Echo                            OFF
OWNER        TABLE_NAME                     TABLESPACE          
------------ ------------------------------ --------------------
GARLAND      INDSTL                         GIS_DATA            
GARLAND      INDUSTRY                       GIS_DATA            
GARLAND      INSP_ARCH_BKUP                 GIS_DATA            
GARLAND      SECTION8                       GIS_DATA            
GARLAND      SWPIPE                         GIS_DATA            
GARLAND      TAX_ABSTRACT                   GIS_DATA            
GARLAND      TAX_UB                         GIS_DATA            
GARLAND      TEMP_MULTIMPER                 GIS_DATA            
GARLAND      TMP_BECKY_BECK                 GIS_DATA            
GARLAND      TMP_INDUSTRY                   GIS_DATA            
GARLAND      TMP_SECTION8                   GIS_DATA            
GARLAND      XXX_PAVE_MAST_SAV              GIS_DATA            
12 rows selected.
OWNER        INDEX_NAME                     TABLE_NAME                     TABLESPACE           UNIQUENES
------------ ------------------------------ ------------------------------ -------------------- ---------
GARLAND      TAX_UB_ADDR_NAME_IDX           TAX_UB                         GISINDX              NONUNIQUE
GARLAND      TAX_UB_PID_IDX                 TAX_UB                         GISINDX              NONUNIQUE
2 rows selected.
OWNER        CONSTRAINT_NAME                TABLE_NAME                     C PARENT_OWNER PARENT_CONSTRAINT             
------------ ------------------------------ ------------------------------ - ------------ ------------------------------
0 rows selected.
OWNER        TABLE_SEGMENT                  BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      INDSTL                              71680          1      65536      32768 GIS_DATA            
GARLAND      INDUSTRY                            71680          1      65536      32768 GIS_DATA            
GARLAND      INSP_ARCH_BKUP                    2170880          1    2162688      32768 GIS_DATA            
GARLAND      SECTION8                            71680          1      65536      32768 GIS_DATA            
GARLAND      SWPIPE                            5611520          1    5603328      32768 GIS_DATA            
GARLAND      TAX_ABSTRACT                        71680          1      65536      32768 GIS_DATA            
GARLAND      TAX_UB                           28313600          1   28311552      32768 GIS_DATA            
GARLAND      TEMP_MULTIMPER                     102400          1      98304      32768 GIS_DATA            
GARLAND      TMP_BECKY_BECK                     102400          1      98304      32768 GIS_DATA            
GARLAND      TMP_INDUSTRY                       102400          1      98304      32768 GIS_DATA            
GARLAND      TMP_SECTION8                        71680          1      65536      32768 GIS_DATA            
GARLAND      XXX_PAVE_MAST_SAV                 1116160          1    1114112      32768 GIS_DATA            
12 rows selected.
OWNER        INDEX_SSEGMENT                 BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      TAX_UB_ADDR_NAME_IDX              2037760          1    2031616      32768 GISINDX             
GARLAND      TAX_UB_PID_IDX                    2037760          1    2031616      32768 GISINDX             
2 rows selected.
Echo                            ON
SQLWKS> 	set timing 	off;
Timing                          OFF
SQLWKS> 
SQLWKS> 
