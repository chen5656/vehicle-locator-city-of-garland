SQLWKS> 
SQLWKS> 	set echo	off;
Echo                            OFF
Timing                          ON
Charwidth                       100
Echo                            OFF
Timing                          OFF
Statement processed.
1 row processed.
1 row processed.
Statement processed.
13 rows processed.
Statement processed.
Echo                            OFF
OWNER        TABLE_NAME                     TABLESPACE          
------------ ------------------------------ --------------------
GARLAND      UTSANFIT                       GIS_DATA            
GARLAND      UTSANMH                        GIS_DATA            
GARLAND      UTSANPIP                       GIS_DATA            
GARLAND      UTSANPIP_ORIGINAL              GIS_DATA            
GARLAND      UTSTOCOM                       GIS_DATA            
GARLAND      UTSTOINL                       GIS_DATA            
GARLAND      UTSTOMDU                       GIS_DATA            
GARLAND      UTSTOOCH                       GIS_DATA            
GARLAND      UTSTOPIP                       GIS_DATA            
GARLAND      UTWATFIT                       GIS_DATA            
GARLAND      UTWATHYD                       GIS_DATA            
GARLAND      UTWATPIP                       GIS_DATA            
GARLAND      UTWATVLV                       GIS_DATA            
13 rows selected.
OWNER        INDEX_NAME                     TABLE_NAME                     TABLESPACE           UNIQUENES
------------ ------------------------------ ------------------------------ -------------------- ---------
GARLAND      I_SANPIP_MSL                   UTSANPIP                       GIS_DATA             UNIQUE   
GARLAND      UTSTOOCH_X_MSLINK              UTSTOOCH                       GIS_DATA             UNIQUE   
GARLAND      UTSTOPIP_X_MSLINK              UTSTOPIP                       GIS_DATA             UNIQUE   
GARLAND      I_MSLINK                       UTWATPIP                       GISINDX              NONUNIQUE
GARLAND      I_PIPEDIA                      UTWATPIP                       GISINDX              NONUNIQUE
5 rows selected.
OWNER        CONSTRAINT_NAME                TABLE_NAME                     C PARENT_OWNER PARENT_CONSTRAINT             
------------ ------------------------------ ------------------------------ - ------------ ------------------------------
0 rows selected.
OWNER        TABLE_SEGMENT                  BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      UTSANFIT                           276480          7      10240     126976 GIS_DATA            
GARLAND      UTSANMH                            593920          9      10240     286720 GIS_DATA            
GARLAND      UTSANPIP                          2928640         13      10240    1454080 GIS_DATA            
GARLAND      UTSANPIP_ORIGINAL                 4198400          2    2097152    2097152 GIS_DATA            
GARLAND      UTSTOCOM                           276480          7      10240     126976 GIS_DATA            
GARLAND      UTSTOINL                           593920          9      10240     286720 GIS_DATA            
GARLAND      UTSTOMDU                           112640          5      10240      55296 GIS_DATA            
GARLAND      UTSTOOCH                            40960          3      10240      24576 GIS_DATA            
GARLAND      UTSTOPIP                           266240          7      10240     126976 GIS_DATA            
GARLAND      UTWATFIT                           880640         10      10240     430080 GIS_DATA            
GARLAND      UTWATHYD                           890880         10      10240     430080 GIS_DATA            
GARLAND      UTWATPIP                           880640         10      10240     430080 GIS_DATA            
GARLAND      UTWATVLV                          1955840         12      10240     968704 GIS_DATA            
13 rows selected.
OWNER        INDEX_SSEGMENT                 BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      I_MSLINK                           296960          2      10240     286720 GISINDX             
GARLAND      I_PIPEDIA                          296960          2      10240     286720 GISINDX             
GARLAND      I_SANPIP_MSL                       194560         19      10240      10240 GIS_DATA            
GARLAND      UTSTOOCH_X_MSLINK                 5242880          1    5242880    5242880 GIS_DATA            
GARLAND      UTSTOPIP_X_MSLINK                 5242880          1    5242880    5242880 GIS_DATA            
5 rows selected.
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
130 rows processed.
Statement processed.
Statement processed.
Timing                          OFF
                                                                      
----------------------------------------------------------------------
create table   GARLAND.NEW_UTSANFIT                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 288K next 32K pctincrease 0                        
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.UTSANFIT;                                    
select count(*) "UTSANFIT" from UTSANFIT;                             
select count(*) " " from NEW_UTSANFIT;                                
;                                                                     
create table   GARLAND.NEW_UTSANMH                                    
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 608K next 32K pctincrease 0                        
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.UTSANMH;                                     
select count(*) "UTSANMH" from UTSANMH;                               
select count(*) " " from NEW_UTSANMH;                                 
;                                                                     
create table   GARLAND.NEW_UTSANPIP                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 2944K next 32K pctincrease 0                       
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.UTSANPIP;                                    
select count(*) "UTSANPIP" from UTSANPIP;                             
select count(*) " " from NEW_UTSANPIP;                                
;                                                                     
create table   GARLAND.NEW_UTSANPIP_ORIGINAL                          
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 4224K next 32K pctincrease 0                       
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.UTSANPIP_ORIGINAL;                           
select count(*) "UTSANPIP_ORIGINAL" from UTSANPIP_ORIGINAL;           
select count(*) " " from NEW_UTSANPIP_ORIGINAL;                       
;                                                                     
create table   GARLAND.NEW_UTSTOCOM                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 288K next 32K pctincrease 0                        
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.UTSTOCOM;                                    
select count(*) "UTSTOCOM" from UTSTOCOM;                             
select count(*) " " from NEW_UTSTOCOM;                                
;                                                                     
create table   GARLAND.NEW_UTSTOINL                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 608K next 32K pctincrease 0                        
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.UTSTOINL;                                    
select count(*) "UTSTOINL" from UTSTOINL;                             
select count(*) " " from NEW_UTSTOINL;                                
;                                                                     
create table   GARLAND.NEW_UTSTOMDU                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 128K next 32K pctincrease 0                        
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.UTSTOMDU;                                    
select count(*) "UTSTOMDU" from UTSTOMDU;                             
select count(*) " " from NEW_UTSTOMDU;                                
;                                                                     
create table   GARLAND.NEW_UTSTOOCH                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 64K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.UTSTOOCH;                                    
select count(*) "UTSTOOCH" from UTSTOOCH;                             
select count(*) " " from NEW_UTSTOOCH;                                
;                                                                     
create table   GARLAND.NEW_UTSTOPIP                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 288K next 32K pctincrease 0                        
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.UTSTOPIP;                                    
select count(*) "UTSTOPIP" from UTSTOPIP;                             
select count(*) " " from NEW_UTSTOPIP;                                
;                                                                     
create table   GARLAND.NEW_UTWATFIT                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 896K next 32K pctincrease 0                        
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.UTWATFIT;                                    
select count(*) "UTWATFIT" from UTWATFIT;                             
select count(*) " " from NEW_UTWATFIT;                                
;                                                                     
create table   GARLAND.NEW_UTWATHYD                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 896K next 32K pctincrease 0                        
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.UTWATHYD;                                    
select count(*) "UTWATHYD" from UTWATHYD;                             
select count(*) " " from NEW_UTWATHYD;                                
;                                                                     
create table   GARLAND.NEW_UTWATPIP                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 896K next 32K pctincrease 0                        
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.UTWATPIP;                                    
select count(*) "UTWATPIP" from UTWATPIP;                             
select count(*) " " from NEW_UTWATPIP;                                
;                                                                     
create table   GARLAND.NEW_UTWATVLV                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 1984K next 32K pctincrease 0                       
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.UTWATVLV;                                    
select count(*) "UTWATVLV" from UTWATVLV;                             
select count(*) " " from NEW_UTWATVLV;                                
;                                                                     
130 rows selected.
1 row processed.
Statement processed.
Echo                            OFF
Timing                          OFF
Echo                            OFF
Timing                          OFF
Statement processed.
Statement processed.
Statement processed.
55 rows processed.
Statement processed.
Statement processed.
Timing                          OFF
                                                                      
----------------------------------------------------------------------
select 'I_SANPIP_MSL' " " from dual;                                  
create unique index   GARLAND.I_SANPIP_MSL                            
       on      GARLAND.UTSANPIP                                       
(                                                                     
 MSLINK                                                               
)                                                                     
tablespace GISINDX                                                    
storage   (initial 224K next 32K pctincrease 0                        
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
;                                                                     
select 'UTSTOOCH_X_MSLINK' " " from dual;                             
create unique index   GARLAND.UTSTOOCH_X_MSLINK                       
       on      GARLAND.UTSTOOCH                                       
(                                                                     
 MSLINK                                                               
)                                                                     
tablespace GISINDX                                                    
storage   (initial 5248K next 32K pctincrease 0                       
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
;                                                                     
select 'UTSTOPIP_X_MSLINK' " " from dual;                             
create unique index   GARLAND.UTSTOPIP_X_MSLINK                       
       on      GARLAND.UTSTOPIP                                       
(                                                                     
 MSLINK                                                               
)                                                                     
tablespace GISINDX                                                    
storage   (initial 5248K next 32K pctincrease 0                       
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
;                                                                     
select 'I_MSLINK' " " from dual;                                      
create index   GARLAND.I_MSLINK                                       
       on      GARLAND.UTWATPIP                                       
(                                                                     
 MSLINK                                                               
)                                                                     
tablespace GISINDX                                                    
storage   (initial 320K next 32K pctincrease 0                        
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
;                                                                     
select 'I_PIPEDIA' " " from dual;                                     
create index   GARLAND.I_PIPEDIA                                      
       on      GARLAND.UTWATPIP                                       
(                                                                     
 PIPE_DIAMETER                                                        
)                                                                     
tablespace GISINDX                                                    
storage   (initial 320K next 32K pctincrease 0                        
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
;                                                                     
55 rows selected.
Echo                            OFF
Timing                          ON
Statement processed.
Parse             0.14 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.14               0.00
Statement processed.
Parse             0.03 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.03               0.00
Statement processed.
Parse             0.01 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.01               0.00
0 rows processed.
Parse             0.37 (Elapsed)     0.00 (CPU)
Execute/Fetch     4.07 (Elapsed)     0.00 (CPU)
Total             4.44               0.00
Statement processed.
Parse             0.01 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.01               0.00
Statement processed.
Parse             0.03 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.03               0.00
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
	drop table UTSANFIT;   --  cascade constraints                                                     
	drop table UTSANMH;   --  cascade constraints                                                      
	drop table UTSANPIP;   --  cascade constraints                                                     
	drop table UTSANPIP_ORIGINAL;   --  cascade constraints                                            
	drop table UTSTOCOM;   --  cascade constraints                                                     
	drop table UTSTOINL;   --  cascade constraints                                                     
	drop table UTSTOMDU;   --  cascade constraints                                                     
	drop table UTSTOOCH;   --  cascade constraints                                                     
	drop table UTSTOPIP;   --  cascade constraints                                                     
	drop table UTWATFIT;   --  cascade constraints                                                     
	drop table UTWATHYD;   --  cascade constraints                                                     
	drop table UTWATPIP;   --  cascade constraints                                                     
	drop table UTWATVLV;   --  cascade constraints                                                     
13 rows selected.
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
	rename NEW_UTSANFIT  to  UTSANFIT;                                                                 
	rename NEW_UTSANMH  to  UTSANMH;                                                                   
	rename NEW_UTSANPIP  to  UTSANPIP;                                                                 
	rename NEW_UTSANPIP_ORIGINAL  to  UTSANPIP_ORIGINAL;                                               
	rename NEW_UTSTOCOM  to  UTSTOCOM;                                                                 
	rename NEW_UTSTOINL  to  UTSTOINL;                                                                 
	rename NEW_UTSTOMDU  to  UTSTOMDU;                                                                 
	rename NEW_UTSTOOCH  to  UTSTOOCH;                                                                 
	rename NEW_UTSTOPIP  to  UTSTOPIP;                                                                 
	rename NEW_UTWATFIT  to  UTWATFIT;                                                                 
	rename NEW_UTWATHYD  to  UTWATHYD;                                                                 
	rename NEW_UTWATPIP  to  UTWATPIP;                                                                 
	rename NEW_UTWATVLV  to  UTWATVLV;                                                                 
13 rows selected.
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
analyze table GARLAND.UTSANFIT   compute statistics;                                                
analyze table GARLAND.UTSANMH   compute statistics;                                                 
analyze table GARLAND.UTSANPIP   compute statistics;                                                
analyze table GARLAND.UTSANPIP_ORIGINAL   compute statistics;                                       
analyze table GARLAND.UTSTOCOM   compute statistics;                                                
analyze table GARLAND.UTSTOINL   compute statistics;                                                
analyze table GARLAND.UTSTOMDU   compute statistics;                                                
analyze table GARLAND.UTSTOOCH   compute statistics;                                                
analyze table GARLAND.UTSTOPIP   compute statistics;                                                
analyze table GARLAND.UTWATFIT   compute statistics;                                                
analyze table GARLAND.UTWATHYD   compute statistics;                                                
analyze table GARLAND.UTWATPIP   compute statistics;                                                
analyze table GARLAND.UTWATVLV   compute statistics;                                                
13 rows selected.
Echo                            OFF
                                                                                                    
----------------------------------------------------------------------------------------------------
alter VIEW GARLAND.ADDR_INDUSTRY_VW compile;                                                        
alter VIEW GARLAND.ADRRESOLVE_VIEW compile;                                                         
alter PROCEDURE GARLAND.ADR_RESOLVE_ADDRESS compile;                                                
alter PROCEDURE GARLAND.CHANGES_CUSTOMER_ID compile;                                                
alter PROCEDURE GARLAND.DELETE_ROWS compile;                                                        
alter FUNCTION GARLAND.DT_ADDUSEROBJECT compile;                                                    
alter PROCEDURE GARLAND.DT_DROPUSEROBJECTBYID compile;                                              
alter PROCEDURE GARLAND.DT_SETPROPERTYBYID compile;                                                 
alter VIEW GARLAND.INDSTL_VW compile;                                                               
alter VIEW GARLAND.PID_INDUSTRY_VW compile;                                                         
alter VIEW GARLAND.SECT8_VW compile;                                                                
alter VIEW GARLAND.SHOW_TMP_TABLE_VW compile;                                                       
alter PROCEDURE GARLAND.TST_RESOLVE_ADDRESS compile;                                                
13 rows selected.
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
UTSANFIT  
----------
      2477
1 row selected.
          
----------
      2477
1 row selected.
Statement processed.
UTSANMH   
----------
      9171
1 row selected.
          
----------
      9171
1 row selected.
Statement processed.
UTSANPIP  
----------
     11923
1 row selected.
          
----------
     11923
1 row selected.
Statement processed.
UTSANPIP_O
----------
     11917
1 row selected.
          
----------
     11917
1 row selected.
Statement processed.
UTSTOCOM  
----------
      2286
1 row selected.
          
----------
      2286
1 row selected.
Statement processed.
UTSTOINL  
----------
      9139
1 row selected.
          
----------
      9139
1 row selected.
Statement processed.
UTSTOMDU  
----------
       704
1 row selected.
          
----------
       704
1 row selected.
Statement processed.
UTSTOOCH  
----------
       352
1 row selected.
          
----------
       352
1 row selected.
Statement processed.
UTSTOPIP  
----------
      5519
1 row selected.
          
----------
      5519
1 row selected.
Statement processed.
UTWATFIT  
----------
      6951
1 row selected.
          
----------
      6951
1 row selected.
Statement processed.
UTWATHYD  
----------
      6369
1 row selected.
          
----------
      6369
1 row selected.
Statement processed.
UTWATPIP  
----------
     10162
1 row selected.
          
----------
     10162
1 row selected.
Statement processed.
UTWATVLV  
----------
     15696
1 row selected.
          
----------
     15696
1 row selected.
130 rows selected.
*

Echo                            OFF
original  
----------
        13
1 row selected.
new copy  
----------
        13
1 row selected.
Missing                                                                         
--------------------------------------------------------------------------------
0 rows selected.
Echo                            ON
SQLWKS> 	set timing 	off;
Timing                          OFF
SQLWKS> 


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
Statement processed.
Statement processed.
            
------------
I_SANPIP_MSL
1 row selected.
Statement processed.
                 
-----------------
UTSTOOCH_X_MSLINK
1 row selected.
Statement processed.
                 
-----------------
UTSTOPIP_X_MSLINK
1 row selected.
Statement processed.
        
--------
I_MSLINK
1 row selected.
Statement processed.
         
---------
I_PIPEDIA
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
Statement processed.
Echo                            OFF
Statement processed.
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
MGR-00073: Warning: PROCEDURE GARLAND.TST_RESOLVE_ADDRESS created with compilation errors.
Echo                            OFF
OWNER        TABLE_NAME                     TABLESPACE          
------------ ------------------------------ --------------------
GARLAND      UTSANFIT                       GIS_DATA            
GARLAND      UTSANMH                        GIS_DATA            
GARLAND      UTSANPIP                       GIS_DATA            
GARLAND      UTSANPIP_ORIGINAL              GIS_DATA            
GARLAND      UTSTOCOM                       GIS_DATA            
GARLAND      UTSTOINL                       GIS_DATA            
GARLAND      UTSTOMDU                       GIS_DATA            
GARLAND      UTSTOOCH                       GIS_DATA            
GARLAND      UTSTOPIP                       GIS_DATA            
GARLAND      UTWATFIT                       GIS_DATA            
GARLAND      UTWATHYD                       GIS_DATA            
GARLAND      UTWATPIP                       GIS_DATA            
GARLAND      UTWATVLV                       GIS_DATA            
13 rows selected.
OWNER        INDEX_NAME                     TABLE_NAME                     TABLESPACE           UNIQUENES
------------ ------------------------------ ------------------------------ -------------------- ---------
GARLAND      I_SANPIP_MSL                   UTSANPIP                       GISINDX              UNIQUE   
GARLAND      UTSTOOCH_X_MSLINK              UTSTOOCH                       GISINDX              UNIQUE   
GARLAND      UTSTOPIP_X_MSLINK              UTSTOPIP                       GISINDX              UNIQUE   
GARLAND      I_MSLINK                       UTWATPIP                       GISINDX              NONUNIQUE
GARLAND      I_PIPEDIA                      UTWATPIP                       GISINDX              NONUNIQUE
5 rows selected.
OWNER        CONSTRAINT_NAME                TABLE_NAME                     C PARENT_OWNER PARENT_CONSTRAINT             
------------ ------------------------------ ------------------------------ - ------------ ------------------------------
0 rows selected.
OWNER        TABLE_SEGMENT                  BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      UTSANFIT                           296960          1     294912      32768 GIS_DATA            
GARLAND      UTSANMH                            665600          2     622592      32768 GIS_DATA            
GARLAND      UTSANPIP                          3020800          1    3014656      32768 GIS_DATA            
GARLAND      UTSANPIP_ORIGINAL                 4331520          1    4325376      32768 GIS_DATA            
GARLAND      UTSTOCOM                           296960          1     294912      32768 GIS_DATA            
GARLAND      UTSTOINL                           624640          1     622592      32768 GIS_DATA            
GARLAND      UTSTOMDU                           133120          1     131072      32768 GIS_DATA            
GARLAND      UTSTOOCH                            71680          1      65536      32768 GIS_DATA            
GARLAND      UTSTOPIP                           296960          1     294912      32768 GIS_DATA            
GARLAND      UTWATFIT                           921600          1     917504      32768 GIS_DATA            
GARLAND      UTWATHYD                           921600          1     917504      32768 GIS_DATA            
GARLAND      UTWATPIP                           921600          1     917504      32768 GIS_DATA            
GARLAND      UTWATVLV                          2037760          1    2031616      32768 GIS_DATA            
13 rows selected.
OWNER        INDEX_SSEGMENT                 BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      I_MSLINK                           327680          1     327680      32768 GISINDX             
GARLAND      I_PIPEDIA                          327680          1     327680      32768 GISINDX             
GARLAND      I_SANPIP_MSL                       235520          1     229376      32768 GISINDX             
GARLAND      UTSTOOCH_X_MSLINK                 5376000          1    5373952      32768 GISINDX             
GARLAND      UTSTOPIP_X_MSLINK                 5376000          1    5373952      32768 GISINDX             
5 rows selected.
Echo                            ON
SQLWKS> 	set timing 	off;
Timing                          OFF
SQLWKS> 
SQLWKS> 
