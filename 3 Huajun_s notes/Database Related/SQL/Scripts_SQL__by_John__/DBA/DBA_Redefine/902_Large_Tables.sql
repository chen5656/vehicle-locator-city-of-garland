Echo                            OFF
Timing                          ON
Charwidth                       100
Echo                            OFF
Timing                          OFF
Statement processed.
1 row processed.
1 row processed.
Statement processed.
18 rows processed.
Statement processed.
Echo                            OFF
OWNER        TABLE_NAME                     TABLESPACE          
------------ ------------------------------ --------------------
GARLAND      ADRNAME                        GIS_DATA            
GARLAND      CDBGPAR                        GIS_DATA            
GARLAND      CDBG_INSPECTION                GIS_DATA            
GARLAND      CDRELTAX                       GIS_DATA            
GARLAND      CDTAXUMS                       GIS_DATA            
GARLAND      COM_IMPERVIOUS                 GIS_DATA            
GARLAND      DCAD_TAX_UB                    GIS_DATA            
GARLAND      EDGE_TBL2                      GIS_DATA            
GARLAND      JOB_DISTINCT_STREET            GIS_DATA            
GARLAND      MAPCOADDRESS                   GIS_DATA            
GARLAND      MAPCOGRID                      GIS_DATA            
GARLAND      NODE_TBL2                      GIS_DATA            
GARLAND      NSA_DCAD_RES                   GIS_DATA            
GARLAND      NSA_TAX_CITY                   GIS_DATA            
GARLAND      SNGLFAM_RENTAL                 GIS_DATA            
GARLAND      SOGENSMP                       GIS_DATA            
GARLAND      SOGENUNT                       GIS_DATA            
GARLAND      TRVEH_THOR_INTERSECT           GIS_DATA            
18 rows selected.
OWNER        INDEX_NAME                     TABLE_NAME                     TABLESPACE           UNIQUENES
------------ ------------------------------ ------------------------------ -------------------- ---------
GARLAND      ADRNAME_PKEY                   ADRNAME                        GIS_DATA             UNIQUE   
GARLAND      ADRNAME_X_COMPACT              ADRNAME                        GIS_DATA             NONUNIQUE
GARLAND      ADRNAME_X_COMPRESS             ADRNAME                        GIS_DATA             NONUNIQUE
GARLAND      ADRNAME_X_PERMUTE              ADRNAME                        GIS_DATA             NONUNIQUE
GARLAND      ADRNAME_X_SOUNDEX              ADRNAME                        GIS_DATA             NONUNIQUE
GARLAND      CDRELTAX_X_PID                 CDRELTAX                       GISINDX              NONUNIQUE
GARLAND      NSA_DCAD_RES_X_PARCEL          NSA_DCAD_RES                   GISINDX              NONUNIQUE
GARLAND      NSA_TAX_CITY_X_PARCEL          NSA_TAX_CITY                   GISINDX              NONUNIQUE
GARLAND      RENT_OWN_I                     SNGLFAM_RENTAL                 GISINDX              NONUNIQUE
GARLAND      ISOGENSMPA                     SOGENSMP                       GISINDX              UNIQUE   
GARLAND      ISOGENSMPB                     SOGENSMP                       GISINDX              NONUNIQUE
GARLAND      ISOGENUNTA                     SOGENUNT                       GISINDX              UNIQUE   
GARLAND      ISOGENUNTB                     SOGENUNT                       GISINDX              NONUNIQUE
13 rows selected.
OWNER        CONSTRAINT_NAME                TABLE_NAME                     C PARENT_OWNER PARENT_CONSTRAINT             
------------ ------------------------------ ------------------------------ - ------------ ------------------------------
GARLAND      ADRNAME_PKEY                   ADRNAME                        P                                            
1 row selected.
OWNER        TABLE_SEGMENT                  BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      ADRNAME                            143360         14      10240      10240 GIS_DATA            
GARLAND      CDBGPAR                            593920          9      10240     286720 GIS_DATA            
GARLAND      CDBG_INSPECTION                    174080          6      10240      83968 GIS_DATA            
GARLAND      CDRELTAX                         14755840         17      10240    7364608 GIS_DATA            
GARLAND      CDTAXUMS                         14755840         17      10240    7364608 GIS_DATA            
GARLAND      COM_IMPERVIOUS                     399360          8      10240     190464 GIS_DATA            
GARLAND      DCAD_TAX_UB                      14755840         17      10240    7364608 GIS_DATA            
GARLAND      EDGE_TBL2                          593920          9      10240     286720 GIS_DATA            
GARLAND      JOB_DISTINCT_STREET                 61440          6      10240      10240 GIS_DATA            
GARLAND      MAPCOADDRESS                       880640         10      10240     430080 GIS_DATA            
GARLAND      MAPCOGRID                          174080          6      10240      83968 GIS_DATA            
GARLAND      NODE_TBL2                          184320          6      10240      83968 GIS_DATA            
GARLAND      NSA_DCAD_RES                     60866560         25   10485760    2097152 GIS_DATA            
GARLAND      NSA_TAX_CITY                     18913280          6   13631488    1048576 GIS_DATA            
GARLAND      SNGLFAM_RENTAL                    1955840         12      10240     968704 GIS_DATA            
GARLAND      SOGENSMP                           112640          5      10240      55296 GIS_DATA            
GARLAND      SOGENUNT                           174080          6      10240      83968 GIS_DATA            
GARLAND      TRVEH_THOR_INTERSECT               266240          7      10240     126976 GIS_DATA            
18 rows selected.
OWNER        INDEX_SSEGMENT                 BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      ADRNAME_PKEY                        51200          5      10240      10240 GIS_DATA            
GARLAND      ADRNAME_X_COMPACT                   51200          5      10240      10240 GIS_DATA            
GARLAND      ADRNAME_X_COMPRESS                  51200          5      10240      10240 GIS_DATA            
GARLAND      ADRNAME_X_PERMUTE                   51200          5      10240      10240 GIS_DATA            
GARLAND      ADRNAME_X_SOUNDEX                   40960          4      10240      10240 GIS_DATA            
GARLAND      CDRELTAX_X_PID                    3153920          1    3145728    1048576 GISINDX             
GARLAND      ISOGENSMPA                         133120          3      10240      55296 GISINDX             
GARLAND      ISOGENSMPB                          10240          1      10240      10240 GISINDX             
GARLAND      ISOGENUNTA                          40960          2      10240      24576 GISINDX             
GARLAND      ISOGENUNTB                          10240          1      10240      10240 GISINDX             
GARLAND      NSA_DCAD_RES_X_PARCEL             2109440          2    1048576    1048576 GISINDX             
GARLAND      NSA_TAX_CITY_X_PARCEL             2099200          1    2097152    1048576 GISINDX             
GARLAND      RENT_OWN_I                         583680          3      10240     286720 GISINDX             
13 rows selected.
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
180 rows processed.
Statement processed.
Statement processed.
Timing                          OFF
                                                                      
----------------------------------------------------------------------
create table   GARLAND.NEW_ADRNAME                                    
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 160K next 32K pctincrease 0                        
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.ADRNAME;                                     
select count(*) "ADRNAME" from GARLAND.ADRNAME;                       
select count(*) " " from GARLAND.NEW_ADRNAME;                         
;                                                                     
create table   GARLAND.NEW_CDBGPAR                                    
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 608K next 32K pctincrease 0                        
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.CDBGPAR;                                     
select count(*) "CDBGPAR" from GARLAND.CDBGPAR;                       
select count(*) " " from GARLAND.NEW_CDBGPAR;                         
;                                                                     
create table   GARLAND.NEW_CDBG_INSPECTION                            
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 192K next 32K pctincrease 0                        
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.CDBG_INSPECTION;                             
select count(*) "CDBG_INSPECTION" from GARLAND.CDBG_INSPECTION;       
select count(*) " " from GARLAND.NEW_CDBG_INSPECTION;                 
;                                                                     
create table   GARLAND.NEW_CDRELTAX                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 14784K next 32K pctincrease 0                      
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.CDRELTAX;                                    
select count(*) "CDRELTAX" from GARLAND.CDRELTAX;                     
select count(*) " " from GARLAND.NEW_CDRELTAX;                        
;                                                                     
create table   GARLAND.NEW_CDTAXUMS                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 14784K next 32K pctincrease 0                      
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.CDTAXUMS;                                    
select count(*) "CDTAXUMS" from GARLAND.CDTAXUMS;                     
select count(*) " " from GARLAND.NEW_CDTAXUMS;                        
;                                                                     
create table   GARLAND.NEW_COM_IMPERVIOUS                             
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 416K next 32K pctincrease 0                        
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.COM_IMPERVIOUS;                              
select count(*) "COM_IMPERVIOUS" from GARLAND.COM_IMPERVIOUS;         
select count(*) " " from GARLAND.NEW_COM_IMPERVIOUS;                  
;                                                                     
create table   GARLAND.NEW_DCAD_TAX_UB                                
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 14784K next 32K pctincrease 0                      
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.DCAD_TAX_UB;                                 
select count(*) "DCAD_TAX_UB" from GARLAND.DCAD_TAX_UB;               
select count(*) " " from GARLAND.NEW_DCAD_TAX_UB;                     
;                                                                     
create table   GARLAND.NEW_EDGE_TBL2                                  
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 608K next 32K pctincrease 0                        
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.EDGE_TBL2;                                   
select count(*) "EDGE_TBL2" from GARLAND.EDGE_TBL2;                   
select count(*) " " from GARLAND.NEW_EDGE_TBL2;                       
;                                                                     
create table   GARLAND.NEW_JOB_DISTINCT_STREET                        
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 64K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.JOB_DISTINCT_STREET;                         
select count(*) "JOB_DISTINCT_STREET" from GARLAND.JOB_DISTINCT_STREET
select count(*) " " from GARLAND.NEW_JOB_DISTINCT_STREET;             
;                                                                     
create table   GARLAND.NEW_MAPCOADDRESS                               
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 896K next 32K pctincrease 0                        
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MAPCOADDRESS;                                
select count(*) "MAPCOADDRESS" from GARLAND.MAPCOADDRESS;             
select count(*) " " from GARLAND.NEW_MAPCOADDRESS;                    
;                                                                     
create table   GARLAND.NEW_MAPCOGRID                                  
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 192K next 32K pctincrease 0                        
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MAPCOGRID;                                   
select count(*) "MAPCOGRID" from GARLAND.MAPCOGRID;                   
select count(*) " " from GARLAND.NEW_MAPCOGRID;                       
;                                                                     
create table   GARLAND.NEW_NODE_TBL2                                  
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 192K next 32K pctincrease 0                        
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.NODE_TBL2;                                   
select count(*) "NODE_TBL2" from GARLAND.NODE_TBL2;                   
select count(*) " " from GARLAND.NEW_NODE_TBL2;                       
;                                                                     
create table   GARLAND.NEW_NSA_DCAD_RES                               
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 60896K next 32K pctincrease 0                      
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.NSA_DCAD_RES;                                
select count(*) "NSA_DCAD_RES" from GARLAND.NSA_DCAD_RES;             
select count(*) " " from GARLAND.NEW_NSA_DCAD_RES;                    
;                                                                     
create table   GARLAND.NEW_NSA_TAX_CITY                               
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 18944K next 32K pctincrease 0                      
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.NSA_TAX_CITY;                                
select count(*) "NSA_TAX_CITY" from GARLAND.NSA_TAX_CITY;             
select count(*) " " from GARLAND.NEW_NSA_TAX_CITY;                    
;                                                                     
create table   GARLAND.NEW_SNGLFAM_RENTAL                             
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 1984K next 32K pctincrease 0                       
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.SNGLFAM_RENTAL;                              
select count(*) "SNGLFAM_RENTAL" from GARLAND.SNGLFAM_RENTAL;         
select count(*) " " from GARLAND.NEW_SNGLFAM_RENTAL;                  
;                                                                     
create table   GARLAND.NEW_SOGENSMP                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 128K next 32K pctincrease 0                        
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.SOGENSMP;                                    
select count(*) "SOGENSMP" from GARLAND.SOGENSMP;                     
select count(*) " " from GARLAND.NEW_SOGENSMP;                        
;                                                                     
create table   GARLAND.NEW_SOGENUNT                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 192K next 32K pctincrease 0                        
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.SOGENUNT;                                    
select count(*) "SOGENUNT" from GARLAND.SOGENUNT;                     
select count(*) " " from GARLAND.NEW_SOGENUNT;                        
;                                                                     
create table   GARLAND.NEW_TRVEH_THOR_INTERSECT                       
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 288K next 32K pctincrease 0                        
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.TRVEH_THOR_INTERSECT;                        
select count(*) "TRVEH_THOR_INTERSECT" from GARLAND.TRVEH_THOR_INTERSE
select count(*) " " from GARLAND.NEW_TRVEH_THOR_INTERSECT;            
;                                                                     
180 rows selected.
1 row processed.
Statement processed.
Echo                            OFF
Timing                          OFF
Echo                            OFF
Timing                          OFF
Statement processed.
Statement processed.
Statement processed.
132 rows processed.
Statement processed.
Statement processed.
Timing                          OFF
                                                                      
----------------------------------------------------------------------
select 'ADRNAME_X_COMPACT' " " from dual;                             
create index   GARLAND.ADRNAME_X_COMPACT                              
       on      GARLAND.ADRNAME                                        
(                                                                     
 ADDR_COMPACT                                                         
)                                                                     
tablespace GISINDX                                                    
storage   (initial 64K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
;                                                                     
select 'ADRNAME_X_COMPRESS' " " from dual;                            
create index   GARLAND.ADRNAME_X_COMPRESS                             
       on      GARLAND.ADRNAME                                        
(                                                                     
 ADDR_COMPRESS                                                        
)                                                                     
tablespace GISINDX                                                    
storage   (initial 64K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
;                                                                     
select 'ADRNAME_X_PERMUTE' " " from dual;                             
create index   GARLAND.ADRNAME_X_PERMUTE                              
       on      GARLAND.ADRNAME                                        
(                                                                     
 ADDR_PERMUTE                                                         
)                                                                     
tablespace GISINDX                                                    
storage   (initial 64K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
;                                                                     
select 'ADRNAME_X_SOUNDEX' " " from dual;                             
create index   GARLAND.ADRNAME_X_SOUNDEX                              
       on      GARLAND.ADRNAME                                        
(                                                                     
 ADDR_SOUNDEX                                                         
)                                                                     
tablespace GISINDX                                                    
storage   (initial 64K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
;                                                                     
select 'CDRELTAX_X_PID' " " from dual;                                
create index   GARLAND.CDRELTAX_X_PID                                 
       on      GARLAND.CDRELTAX                                       
(                                                                     
 PARCEL_ID                                                            
)                                                                     
tablespace GISINDX                                                    
storage   (initial 3168K next 32K pctincrease 0                       
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
;                                                                     
select 'NSA_DCAD_RES_X_PARCEL' " " from dual;                         
create index   GARLAND.NSA_DCAD_RES_X_PARCEL                          
       on      GARLAND.NSA_DCAD_RES                                   
(                                                                     
 PARCEL_ID                                                            
)                                                                     
tablespace GISINDX                                                    
storage   (initial 2112K next 32K pctincrease 0                       
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
;                                                                     
select 'NSA_TAX_CITY_X_PARCEL' " " from dual;                         
create index   GARLAND.NSA_TAX_CITY_X_PARCEL                          
       on      GARLAND.NSA_TAX_CITY                                   
(                                                                     
 PARCEL_ID                                                            
)                                                                     
tablespace GISINDX                                                    
storage   (initial 2112K next 32K pctincrease 0                       
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
;                                                                     
select 'RENT_OWN_I' " " from dual;                                    
create index   GARLAND.RENT_OWN_I                                     
       on      GARLAND.SNGLFAM_RENTAL                                 
(                                                                     
 TAX_OWNER                                                            
)                                                                     
tablespace GISINDX                                                    
storage   (initial 608K next 32K pctincrease 0                        
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
;                                                                     
select 'ISOGENSMPA' " " from dual;                                    
create unique index   GARLAND.ISOGENSMPA                              
       on      GARLAND.SOGENSMP                                       
(                                                                     
 MSLINK                                                               
)                                                                     
tablespace GISINDX                                                    
storage   (initial 160K next 32K pctincrease 0                        
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
;                                                                     
select 'ISOGENSMPB' " " from dual;                                    
create index   GARLAND.ISOGENSMPB                                     
       on      GARLAND.SOGENSMP                                       
(                                                                     
 SOILSMP_ID                                                           
)                                                                     
tablespace GISINDX                                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
;                                                                     
select 'ISOGENUNTA' " " from dual;                                    
create unique index   GARLAND.ISOGENUNTA                              
       on      GARLAND.SOGENUNT                                       
(                                                                     
 MSLINK                                                               
)                                                                     
tablespace GISINDX                                                    
storage   (initial 64K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
;                                                                     
select 'ISOGENUNTB' " " from dual;                                    
create index   GARLAND.ISOGENUNTB                                     
       on      GARLAND.SOGENUNT                                       
(                                                                     
 SOIL_ID                                                              
)                                                                     
tablespace GISINDX                                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
;                                                                     
132 rows selected.
Echo                            OFF
Timing                          ON
Statement processed.
Parse             0.26 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.26               0.00
Statement processed.
Parse             0.03 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.03               0.00
Statement processed.
Parse             0.00 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.00               0.00
12 rows processed.
Parse             0.34 (Elapsed)     0.00 (CPU)
Execute/Fetch     5.06 (Elapsed)     0.00 (CPU)
Total             5.40               0.00
Statement processed.
Parse             0.00 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.05 (Elapsed)     0.00 (CPU)
Total             0.05               0.00
Statement processed.
Parse             0.02 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.02               0.00
Timing                          OFF
                                                                      
----------------------------------------------------------------------
select 'ADRNAME / ADRNAME_PKEY' " "  from dual;                       
alter table    GARLAND.ADRNAME                                        
add constraint ADRNAME_PKEY   primary key                             
(                                                                     
 ADDR_NAME                                                            
)                                                                     
using index                                                           
tablespace GISINDX                                                    
storage (initial 160K next 32K pctincrease 0                          
         minextents 1  maxextents 249                                 
         freelists 1   freelist groups 1)                             
;                                                                     
12 rows selected.
1 row processed.
Statement processed.
Echo                            OFF
Timing                          OFF
Echo                            OFF
Timing                          OFF
                                                                                                    
----------------------------------------------------------------------------------------------------
	drop table ADRNAME;   --  cascade constraints                                                      
	drop table CDBGPAR;   --  cascade constraints                                                      
	drop table CDBG_INSPECTION;   --  cascade constraints                                              
	drop table CDRELTAX;   --  cascade constraints                                                     
	drop table CDTAXUMS;   --  cascade constraints                                                     
	drop table COM_IMPERVIOUS;   --  cascade constraints                                               
	drop table DCAD_TAX_UB;   --  cascade constraints                                                  
	drop table EDGE_TBL2;   --  cascade constraints                                                    
	drop table JOB_DISTINCT_STREET;   --  cascade constraints                                          
	drop table MAPCOADDRESS;   --  cascade constraints                                                 
	drop table MAPCOGRID;   --  cascade constraints                                                    
	drop table NODE_TBL2;   --  cascade constraints                                                    
	drop table NSA_DCAD_RES;   --  cascade constraints                                                 
	drop table NSA_TAX_CITY;   --  cascade constraints                                                 
	drop table SNGLFAM_RENTAL;   --  cascade constraints                                               
	drop table SOGENSMP;   --  cascade constraints                                                     
	drop table SOGENUNT;   --  cascade constraints                                                     
	drop table TRVEH_THOR_INTERSECT;   --  cascade constraints                                         
18 rows selected.
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
	rename NEW_ADRNAME  to  ADRNAME;                                                                   
	rename NEW_CDBGPAR  to  CDBGPAR;                                                                   
	rename NEW_CDBG_INSPECTION  to  CDBG_INSPECTION;                                                   
	rename NEW_CDRELTAX  to  CDRELTAX;                                                                 
	rename NEW_CDTAXUMS  to  CDTAXUMS;                                                                 
	rename NEW_COM_IMPERVIOUS  to  COM_IMPERVIOUS;                                                     
	rename NEW_DCAD_TAX_UB  to  DCAD_TAX_UB;                                                           
	rename NEW_EDGE_TBL2  to  EDGE_TBL2;                                                               
	rename NEW_JOB_DISTINCT_STREET  to  JOB_DISTINCT_STREET;                                           
	rename NEW_MAPCOADDRESS  to  MAPCOADDRESS;                                                         
	rename NEW_MAPCOGRID  to  MAPCOGRID;                                                               
	rename NEW_NODE_TBL2  to  NODE_TBL2;                                                               
	rename NEW_NSA_DCAD_RES  to  NSA_DCAD_RES;                                                         
	rename NEW_NSA_TAX_CITY  to  NSA_TAX_CITY;                                                         
	rename NEW_SNGLFAM_RENTAL  to  SNGLFAM_RENTAL;                                                     
	rename NEW_SOGENSMP  to  SOGENSMP;                                                                 
	rename NEW_SOGENUNT  to  SOGENUNT;                                                                 
	rename NEW_TRVEH_THOR_INTERSECT  to  TRVEH_THOR_INTERSECT;                                         
18 rows selected.
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
analyze table GARLAND.ADRNAME   compute statistics;                                                 
analyze table GARLAND.CDBGPAR   compute statistics;                                                 
analyze table GARLAND.CDBG_INSPECTION   compute statistics;                                         
analyze table GARLAND.CDRELTAX   compute statistics;                                                
analyze table GARLAND.CDTAXUMS   compute statistics;                                                
analyze table GARLAND.COM_IMPERVIOUS   compute statistics;                                          
analyze table GARLAND.DCAD_TAX_UB   compute statistics;                                             
analyze table GARLAND.EDGE_TBL2   compute statistics;                                               
analyze table GARLAND.JOB_DISTINCT_STREET   compute statistics;                                     
analyze table GARLAND.MAPCOADDRESS   compute statistics;                                            
analyze table GARLAND.MAPCOGRID   compute statistics;                                               
analyze table GARLAND.NODE_TBL2   compute statistics;                                               
analyze table GARLAND.NSA_DCAD_RES   compute statistics;                                            
analyze table GARLAND.NSA_TAX_CITY   compute statistics;                                            
analyze table GARLAND.SNGLFAM_RENTAL   compute statistics;                                          
analyze table GARLAND.SOGENSMP   compute statistics;                                                
analyze table GARLAND.SOGENUNT   compute statistics;                                                
analyze table GARLAND.TRVEH_THOR_INTERSECT   compute statistics;                                    
18 rows selected.
Echo                            OFF
                                                                                                    
----------------------------------------------------------------------------------------------------
alter VIEW GARLAND.ADRRESOLVE_VIEW compile;                                                         
alter PROCEDURE GARLAND.ADR_RESOLVE_ADDRESS compile;                                                
alter PROCEDURE GARLAND.CHANGES_CUSTOMER_ID compile;                                                
alter PROCEDURE GARLAND.DELETE_ROWS compile;                                                        
alter FUNCTION GARLAND.DT_ADDUSEROBJECT compile;                                                    
alter PROCEDURE GARLAND.DT_DROPUSEROBJECTBYID compile;                                              
alter PROCEDURE GARLAND.DT_SETPROPERTYBYID compile;                                                 
alter VIEW GARLAND.POPCN_BGRINCVW compile;                                                          
alter VIEW GARLAND.POPCN_BGR_AGE_VW compile;                                                        
alter VIEW GARLAND.POPCN_BGR_BASIC_VW compile;                                                      
alter VIEW GARLAND.POPCN_BGR_EDUC_VW compile;                                                       
alter VIEW GARLAND.POPCN_BGR_EMPLY_VW compile;                                                      
alter VIEW GARLAND.POPCN_BGR_HSNG_VW compile;                                                       
alter VIEW GARLAND.POPCN_BGR_INCM_VW compile;                                                       
alter VIEW GARLAND.POPCN_BGR_POP_VW compile;                                                        
alter VIEW GARLAND.POPCN_BLK_HOCCR_VW compile;                                                      
alter VIEW GARLAND.POPCN_TOTPOPBR compile;                                                          
alter PROCEDURE GARLAND.TST_RESOLVE_ADDRESS compile;                                                
18 rows selected.
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
ADRNAME   
----------
      1850
1 row selected.
          
----------
      1850
1 row selected.
Statement processed.
CDBGPAR   
----------
      8681
1 row selected.
          
----------
      8681
1 row selected.
Statement processed.
CDBG_INSPE
----------
      6098
1 row selected.
          
----------
      6098
1 row selected.
Statement processed.
CDRELTAX  
----------
     64346
1 row selected.
          
----------
     64346
1 row selected.
Statement processed.
CDTAXUMS  
----------
     64161
1 row selected.
          
----------
     64161
1 row selected.
Statement processed.
COM_IMPERV
----------
      2973
1 row selected.
          
----------
      2973
1 row selected.
Statement processed.
DCAD_TAX_U
----------
     65527
1 row selected.
          
----------
     65527
1 row selected.
Statement processed.
EDGE_TBL2 
----------
      6982
1 row selected.
          
----------
      6982
1 row selected.
Statement processed.
select count(*) " " from GARLAND.NEW_JOB_DISTINCT_STREET
*
ORA-00933: SQL command not properly ended
Statement processed.
MAPCOADDRE
----------
     12537
1 row selected.
          
----------
     12537
1 row selected.
Statement processed.
MAPCOGRID 
----------
      5653
1 row selected.
          
----------
      5653
1 row selected.
Statement processed.
NODE_TBL2 
----------
      4951
1 row selected.
          
----------
      4951
1 row selected.
Statement processed.
NSA_DCAD_R
----------
     59558
1 row selected.
          
----------
     59558
1 row selected.
Statement processed.
NSA_TAX_CI
----------
     64266
1 row selected.
          
----------
     64266
1 row selected.
Statement processed.
SNGLFAM_RE
----------
     13305
1 row selected.
          
----------
     13305
1 row selected.
Statement processed.
SOGENSMP  
----------
      6604
1 row selected.
          
----------
      6604
1 row selected.
Statement processed.
SOGENUNT  
----------
      1215
1 row selected.
          
----------
      1215
1 row selected.
Statement processed.
select count(*) " " from GARLAND.NEW_TRVEH_THOR_INTERSECT
*
ORA-00933: SQL command not properly ended
Echo                            ON
SQLWKS> 	set timing 	off;
Timing                          OFF
SQLWKS> 


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
                 
-----------------
ADRNAME_X_COMPACT
1 row selected.
Statement processed.
                  
------------------
ADRNAME_X_COMPRESS
1 row selected.
Statement processed.
                 
-----------------
ADRNAME_X_PERMUTE
1 row selected.
Statement processed.
                 
-----------------
ADRNAME_X_SOUNDEX
1 row selected.
Statement processed.
              
--------------
CDRELTAX_X_PID
1 row selected.
Statement processed.
                     
---------------------
NSA_DCAD_RES_X_PARCEL
1 row selected.
Statement processed.
                     
---------------------
NSA_TAX_CITY_X_PARCEL
1 row selected.
Statement processed.
          
----------
RENT_OWN_I
1 row selected.
Statement processed.
          
----------
ISOGENSMPA
1 row selected.
Statement processed.
          
----------
ISOGENSMPB
1 row selected.
Statement processed.
          
----------
ISOGENUNTA
1 row selected.
Statement processed.
          
----------
ISOGENUNTB
1 row selected.
Statement processed.
                      
----------------------
ADRNAME / ADRNAME_PKEY
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
Statement processed.
Statement processed.
Statement processed.
Statement processed.
MGR-00073: Warning: PROCEDURE GARLAND.TST_RESOLVE_ADDRESS created with compilation errors.
Echo                            OFF
OWNER        TABLE_NAME                     TABLESPACE          
------------ ------------------------------ --------------------
GARLAND      ADRNAME                        GIS_DATA            
GARLAND      CDBGPAR                        GIS_DATA            
GARLAND      CDBG_INSPECTION                GIS_DATA            
GARLAND      CDRELTAX                       GIS_DATA            
GARLAND      CDTAXUMS                       GIS_DATA            
GARLAND      COM_IMPERVIOUS                 GIS_DATA            
GARLAND      DCAD_TAX_UB                    GIS_DATA            
GARLAND      EDGE_TBL2                      GIS_DATA            
GARLAND      JOB_DISTINCT_STREET            GIS_DATA            
GARLAND      MAPCOADDRESS                   GIS_DATA            
GARLAND      MAPCOGRID                      GIS_DATA            
GARLAND      NODE_TBL2                      GIS_DATA            
GARLAND      NSA_DCAD_RES                   GIS_DATA            
GARLAND      NSA_TAX_CITY                   GIS_DATA            
GARLAND      SNGLFAM_RENTAL                 GIS_DATA            
GARLAND      SOGENSMP                       GIS_DATA            
GARLAND      SOGENUNT                       GIS_DATA            
GARLAND      TRVEH_THOR_INTERSECT           GIS_DATA            
18 rows selected.
OWNER        INDEX_NAME                     TABLE_NAME                     TABLESPACE           UNIQUENES
------------ ------------------------------ ------------------------------ -------------------- ---------
GARLAND      ADRNAME_PKEY                   ADRNAME                        GISINDX              UNIQUE   
GARLAND      ADRNAME_X_COMPACT              ADRNAME                        GISINDX              NONUNIQUE
GARLAND      ADRNAME_X_COMPRESS             ADRNAME                        GISINDX              NONUNIQUE
GARLAND      ADRNAME_X_PERMUTE              ADRNAME                        GISINDX              NONUNIQUE
GARLAND      ADRNAME_X_SOUNDEX              ADRNAME                        GISINDX              NONUNIQUE
GARLAND      CDRELTAX_X_PID                 CDRELTAX                       GISINDX              NONUNIQUE
GARLAND      NSA_DCAD_RES_X_PARCEL          NSA_DCAD_RES                   GISINDX              NONUNIQUE
GARLAND      NSA_TAX_CITY_X_PARCEL          NSA_TAX_CITY                   GISINDX              NONUNIQUE
GARLAND      RENT_OWN_I                     SNGLFAM_RENTAL                 GISINDX              NONUNIQUE
GARLAND      ISOGENSMPA                     SOGENSMP                       GISINDX              UNIQUE   
GARLAND      ISOGENSMPB                     SOGENSMP                       GISINDX              NONUNIQUE
GARLAND      ISOGENUNTA                     SOGENUNT                       GISINDX              UNIQUE   
GARLAND      ISOGENUNTB                     SOGENUNT                       GISINDX              NONUNIQUE
13 rows selected.
OWNER        CONSTRAINT_NAME                TABLE_NAME                     C PARENT_OWNER PARENT_CONSTRAINT             
------------ ------------------------------ ------------------------------ - ------------ ------------------------------
GARLAND      ADRNAME_PKEY                   ADRNAME                        P                                            
1 row selected.
OWNER        TABLE_SEGMENT                  BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      ADRNAME                            163840          1     163840      32768 GIS_DATA            
GARLAND      CDBGPAR                            624640          1     622592      32768 GIS_DATA            
GARLAND      CDBG_INSPECTION                    204800          1     196608      32768 GIS_DATA            
GARLAND      CDRELTAX                         15759360         16   15138816      32768 GIS_DATA            
GARLAND      CDTAXUMS                         15144960          1   15138816      32768 GIS_DATA            
GARLAND      COM_IMPERVIOUS                     430080          1     425984      32768 GIS_DATA            
GARLAND      DCAD_TAX_UB                      15144960          1   15138816      32768 GIS_DATA            
GARLAND      EDGE_TBL2                          624640          1     622592      32768 GIS_DATA            
GARLAND      JOB_DISTINCT_STREET                 71680          1      65536      32768 GIS_DATA            
GARLAND      MAPCOADDRESS                       921600          1     917504      32768 GIS_DATA            
GARLAND      MAPCOGRID                          204800          1     196608      32768 GIS_DATA            
GARLAND      NODE_TBL2                          204800          1     196608      32768 GIS_DATA            
GARLAND      NSA_DCAD_RES                     62361600          1   62357504      32768 GIS_DATA            
GARLAND      NSA_TAX_CITY                     21708800         57   19398656      32768 GIS_DATA            
GARLAND      SNGLFAM_RENTAL                    2037760          1    2031616      32768 GIS_DATA            
GARLAND      SOGENSMP                           133120          1     131072      32768 GIS_DATA            
GARLAND      SOGENUNT                           204800          1     196608      32768 GIS_DATA            
GARLAND      TRVEH_THOR_INTERSECT               296960          1     294912      32768 GIS_DATA            
18 rows selected.
OWNER        INDEX_SSEGMENT                 BYTES      EXTENTS    INITIAL_EX NEXT_EXTEN TABLESPACE          
------------ ------------------------------ ---------- ---------- ---------- ---------- --------------------
GARLAND      ADRNAME_PKEY                       163840          1     163840      32768 GISINDX             
GARLAND      ADRNAME_X_COMPACT                   71680          1      65536      32768 GISINDX             
GARLAND      ADRNAME_X_COMPRESS                  71680          1      65536      32768 GISINDX             
GARLAND      ADRNAME_X_PERMUTE                   71680          1      65536      32768 GISINDX             
GARLAND      ADRNAME_X_SOUNDEX                   71680          1      65536      32768 GISINDX             
GARLAND      CDRELTAX_X_PID                    3246080          1    3244032      32768 GISINDX             
GARLAND      ISOGENSMPA                         163840          1     163840      32768 GISINDX             
GARLAND      ISOGENSMPB                          40960          1      32768      32768 GISINDX             
GARLAND      ISOGENUNTA                          71680          1      65536      32768 GISINDX             
GARLAND      ISOGENUNTB                          40960          1      32768      32768 GISINDX             
GARLAND      NSA_DCAD_RES_X_PARCEL             2170880          1    2162688      32768 GISINDX             
GARLAND      NSA_TAX_CITY_X_PARCEL             2170880          1    2162688      32768 GISINDX             
GARLAND      RENT_OWN_I                         624640          1     622592      32768 GISINDX             
13 rows selected.
Echo                            ON
SQLWKS> 	set timing 	off;
Timing                          OFF
SQLWKS> 
SQLWKS> 
