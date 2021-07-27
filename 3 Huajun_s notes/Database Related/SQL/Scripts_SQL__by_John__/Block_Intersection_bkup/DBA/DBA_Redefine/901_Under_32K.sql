                                                                      
----------------------------------------------------------------------
select 'CREATE ADRDEBUG' " " from dual;                               
drop   table   GARLAND.NEW_ADRDEBUG;                                  
create table   GARLAND.NEW_ADRDEBUG                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.ADRDEBUG;                                    
select lpad (count(*),20) "ADRDEBUG" from GARLAND.ADRDEBUG;           
select lpad (count(*),20) "NEW_ADRDEBUG" from GARLAND.NEW_ADRDEBUG;   
;                                                                     
select 'CREATE BDJURBEAT' " " from dual;                              
drop   table   GARLAND.NEW_BDJURBEAT;                                 
create table   GARLAND.NEW_BDJURBEAT                                  
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.BDJURBEAT;                                   
select lpad (count(*),20) "BDJURBEAT" from GARLAND.BDJURBEAT;         
select lpad (count(*),20) "NEW_BDJURBEAT" from GARLAND.NEW_BDJURBEAT; 
;                                                                     
select 'CREATE BDJURCODEDIST' " " from dual;                          
drop   table   GARLAND.NEW_BDJURCODEDIST;                             
create table   GARLAND.NEW_BDJURCODEDIST                              
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.BDJURCODEDIST;                               
select lpad (count(*),20) "BDJURCODEDIST" from GARLAND.BDJURCODEDIST; 
select lpad (count(*),20) "NEW_BDJURCODEDIST" from GARLAND.NEW_BDJURCO
;                                                                     
select 'CREATE BDJURDST' " " from dual;                               
drop   table   GARLAND.NEW_BDJURDST;                                  
create table   GARLAND.NEW_BDJURDST                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.BDJURDST;                                    
select lpad (count(*),20) "BDJURDST" from GARLAND.BDJURDST;           
select lpad (count(*),20) "NEW_BDJURDST" from GARLAND.NEW_BDJURDST;   
;                                                                     
select 'CREATE BDJURPOLDIST' " " from dual;                           
drop   table   GARLAND.NEW_BDJURPOLDIST;                              
create table   GARLAND.NEW_BDJURPOLDIST                               
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.BDJURPOLDIST;                                
select lpad (count(*),20) "BDJURPOLDIST" from GARLAND.BDJURPOLDIST;   
select lpad (count(*),20) "NEW_BDJURPOLDIST" from GARLAND.NEW_BDJURPOL
;                                                                     
select 'CREATE BDJURSECTOR' " " from dual;                            
drop   table   GARLAND.NEW_BDJURSECTOR;                               
create table   GARLAND.NEW_BDJURSECTOR                                
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.BDJURSECTOR;                                 
select lpad (count(*),20) "BDJURSECTOR" from GARLAND.BDJURSECTOR;     
select lpad (count(*),20) "NEW_BDJURSECTOR" from GARLAND.NEW_BDJURSECT
;                                                                     
select 'CREATE BUILDING' " " from dual;                               
drop   table   GARLAND.NEW_BUILDING;                                  
create table   GARLAND.NEW_BUILDING                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.BUILDING;                                    
select lpad (count(*),20) "BUILDING" from GARLAND.BUILDING;           
select lpad (count(*),20) "NEW_BUILDING" from GARLAND.NEW_BUILDING;   
;                                                                     
select 'CREATE CDBG' " " from dual;                                   
drop   table   GARLAND.NEW_CDBG;                                      
create table   GARLAND.NEW_CDBG                                       
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.CDBG;                                        
select lpad (count(*),20) "CDBG" from GARLAND.CDBG;                   
select lpad (count(*),20) "NEW_CDBG" from GARLAND.NEW_CDBG;           
;                                                                     
select 'CREATE CDRELSUBDV' " " from dual;                             
drop   table   GARLAND.NEW_CDRELSUBDV;                                
create table   GARLAND.NEW_CDRELSUBDV                                 
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.CDRELSUBDV;                                  
select lpad (count(*),20) "CDRELSUBDV" from GARLAND.CDRELSUBDV;       
select lpad (count(*),20) "NEW_CDRELSUBDV" from GARLAND.NEW_CDRELSUBDV
;                                                                     
select 'CREATE ESZ_FIRE' " " from dual;                               
drop   table   GARLAND.NEW_ESZ_FIRE;                                  
create table   GARLAND.NEW_ESZ_FIRE                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.ESZ_FIRE;                                    
select lpad (count(*),20) "ESZ_FIRE" from GARLAND.ESZ_FIRE;           
select lpad (count(*),20) "NEW_ESZ_FIRE" from GARLAND.NEW_ESZ_FIRE;   
;                                                                     
select 'CREATE EXCEPT_TABLE' " " from dual;                           
drop   table   GARLAND.NEW_EXCEPT_TABLE;                              
create table   GARLAND.NEW_EXCEPT_TABLE                               
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.EXCEPT_TABLE;                                
select lpad (count(*),20) "EXCEPT_TABLE" from GARLAND.EXCEPT_TABLE;   
select lpad (count(*),20) "NEW_EXCEPT_TABLE" from GARLAND.NEW_EXCEPT_T
;                                                                     
select 'CREATE GIS_ABSTACT' " " from dual;                            
drop   table   GARLAND.NEW_GIS_ABSTACT;                               
create table   GARLAND.NEW_GIS_ABSTACT                                
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.GIS_ABSTACT;                                 
select lpad (count(*),20) "GIS_ABSTACT" from GARLAND.GIS_ABSTACT;     
select lpad (count(*),20) "NEW_GIS_ABSTACT" from GARLAND.NEW_GIS_ABSTA
;                                                                     
select 'CREATE GIS_COUNCIL_DIST' " " from dual;                       
drop   table   GARLAND.NEW_GIS_COUNCIL_DIST;                          
create table   GARLAND.NEW_GIS_COUNCIL_DIST                           
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.GIS_COUNCIL_DIST;                            
select lpad (count(*),20) "GIS_COUNCIL_DIST" from GARLAND.GIS_COUNCIL_
select lpad (count(*),20) "NEW_GIS_COUNCIL_DIST" from GARLAND.NEW_GIS_
;                                                                     
select 'CREATE GIS_FIRE_DIST' " " from dual;                          
drop   table   GARLAND.NEW_GIS_FIRE_DIST;                             
create table   GARLAND.NEW_GIS_FIRE_DIST                              
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.GIS_FIRE_DIST;                               
select lpad (count(*),20) "GIS_FIRE_DIST" from GARLAND.GIS_FIRE_DIST; 
select lpad (count(*),20) "NEW_GIS_FIRE_DIST" from GARLAND.NEW_GIS_FIR
;                                                                     
select 'CREATE GIS_ZIP_CODE' " " from dual;                           
drop   table   GARLAND.NEW_GIS_ZIP_CODE;                              
create table   GARLAND.NEW_GIS_ZIP_CODE                               
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.GIS_ZIP_CODE;                                
select lpad (count(*),20) "GIS_ZIP_CODE" from GARLAND.GIS_ZIP_CODE;   
select lpad (count(*),20) "NEW_GIS_ZIP_CODE" from GARLAND.NEW_GIS_ZIP_
;                                                                     
select 'CREATE GPLSRVA' " " from dual;                                
drop   table   GARLAND.NEW_GPLSRVA;                                   
create table   GARLAND.NEW_GPLSRVA                                    
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.GPLSRVA;                                     
select lpad (count(*),20) "GPLSRVA" from GARLAND.GPLSRVA;             
select lpad (count(*),20) "NEW_GPLSRVA" from GARLAND.NEW_GPLSRVA;     
;                                                                     
select 'CREATE IDX' " " from dual;                                    
drop   table   GARLAND.NEW_IDX;                                       
create table   GARLAND.NEW_IDX                                        
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.IDX;                                         
select lpad (count(*),20) "IDX" from GARLAND.IDX;                     
select lpad (count(*),20) "NEW_IDX" from GARLAND.NEW_IDX;             
;                                                                     
select 'CREATE MAPBOOK2' " " from dual;                               
drop   table   GARLAND.NEW_MAPBOOK2;                                  
create table   GARLAND.NEW_MAPBOOK2                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MAPBOOK2;                                    
select lpad (count(*),20) "MAPBOOK2" from GARLAND.MAPBOOK2;           
select lpad (count(*),20) "NEW_MAPBOOK2" from GARLAND.NEW_MAPBOOK2;   
;                                                                     
select 'CREATE MAPCOPAGE' " " from dual;                              
drop   table   GARLAND.NEW_MAPCOPAGE;                                 
create table   GARLAND.NEW_MAPCOPAGE                                  
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MAPCOPAGE;                                   
select lpad (count(*),20) "MAPCOPAGE" from GARLAND.MAPCOPAGE;         
select lpad (count(*),20) "NEW_MAPCOPAGE" from GARLAND.NEW_MAPCOPAGE; 
;                                                                     
select 'CREATE MGSM_ACCIDENT' " " from dual;                          
drop   table   GARLAND.NEW_MGSM_ACCIDENT;                             
create table   GARLAND.NEW_MGSM_ACCIDENT                              
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MGSM_ACCIDENT;                               
select lpad (count(*),20) "MGSM_ACCIDENT" from GARLAND.MGSM_ACCIDENT; 
select lpad (count(*),20) "NEW_MGSM_ACCIDENT" from GARLAND.NEW_MGSM_AC
;                                                                     
select 'CREATE MGSM_ADT' " " from dual;                               
drop   table   GARLAND.NEW_MGSM_ADT;                                  
create table   GARLAND.NEW_MGSM_ADT                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MGSM_ADT;                                    
select lpad (count(*),20) "MGSM_ADT" from GARLAND.MGSM_ADT;           
select lpad (count(*),20) "NEW_MGSM_ADT" from GARLAND.NEW_MGSM_ADT;   
;                                                                     
select 'CREATE MGSM_ATTRIBUTE_CATALOG' " " from dual;                 
drop   table   GARLAND.NEW_MGSM_ATTRIBUTE_CATALOG;                    
create table   GARLAND.NEW_MGSM_ATTRIBUTE_CATALOG                     
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MGSM_ATTRIBUTE_CATALOG;                      
select lpad (count(*),20) "MGSM_ATTRIBUTE_CATALOG" from GARLAND.MGSM_A
select lpad (count(*),20) "NEW_MGSM_ATTRIBUTE_CATALOG" from GARLAND.NE
;                                                                     
select 'CREATE MGSM_CATEGORY' " " from dual;                          
drop   table   GARLAND.NEW_MGSM_CATEGORY;                             
create table   GARLAND.NEW_MGSM_CATEGORY                              
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MGSM_CATEGORY;                               
select lpad (count(*),20) "MGSM_CATEGORY" from GARLAND.MGSM_CATEGORY; 
select lpad (count(*),20) "NEW_MGSM_CATEGORY" from GARLAND.NEW_MGSM_CA
;                                                                     
select 'CREATE MGSM_CONSTRUCTION' " " from dual;                      
drop   table   GARLAND.NEW_MGSM_CONSTRUCTION;                         
create table   GARLAND.NEW_MGSM_CONSTRUCTION                          
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MGSM_CONSTRUCTION;                           
select lpad (count(*),20) "MGSM_CONSTRUCTION" from GARLAND.MGSM_CONSTR
select lpad (count(*),20) "NEW_MGSM_CONSTRUCTION" from GARLAND.NEW_MGS
;                                                                     
select 'CREATE MGSM_CONSTRUCTION_TYPE' " " from dual;                 
drop   table   GARLAND.NEW_MGSM_CONSTRUCTION_TYPE;                    
create table   GARLAND.NEW_MGSM_CONSTRUCTION_TYPE                     
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MGSM_CONSTRUCTION_TYPE;                      
select lpad (count(*),20) "MGSM_CONSTRUCTION_TYPE" from GARLAND.MGSM_C
select lpad (count(*),20) "NEW_MGSM_CONSTRUCTION_TYPE" from GARLAND.NE
;                                                                     
select 'CREATE MGSM_CONTROL_PT' " " from dual;                        
drop   table   GARLAND.NEW_MGSM_CONTROL_PT;                           
create table   GARLAND.NEW_MGSM_CONTROL_PT                            
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MGSM_CONTROL_PT;                             
select lpad (count(*),20) "MGSM_CONTROL_PT" from GARLAND.MGSM_CONTROL_
select lpad (count(*),20) "NEW_MGSM_CONTROL_PT" from GARLAND.NEW_MGSM_
;                                                                     
select 'CREATE MGSM_DOMAIN_CATALOG' " " from dual;                    
drop   table   GARLAND.NEW_MGSM_DOMAIN_CATALOG;                       
create table   GARLAND.NEW_MGSM_DOMAIN_CATALOG                        
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MGSM_DOMAIN_CATALOG;                         
select lpad (count(*),20) "MGSM_DOMAIN_CATALOG" from GARLAND.MGSM_DOMA
select lpad (count(*),20) "NEW_MGSM_DOMAIN_CATALOG" from GARLAND.NEW_M
;                                                                     
select 'CREATE MGSM_DYN_XO_CONFIG' " " from dual;                     
drop   table   GARLAND.NEW_MGSM_DYN_XO_CONFIG;                        
create table   GARLAND.NEW_MGSM_DYN_XO_CONFIG                         
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MGSM_DYN_XO_CONFIG;                          
select lpad (count(*),20) "MGSM_DYN_XO_CONFIG" from GARLAND.MGSM_DYN_X
select lpad (count(*),20) "NEW_MGSM_DYN_XO_CONFIG" from GARLAND.NEW_MG
;                                                                     
select 'CREATE MGSM_FEATURE' " " from dual;                           
drop   table   GARLAND.NEW_MGSM_FEATURE;                              
create table   GARLAND.NEW_MGSM_FEATURE                               
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MGSM_FEATURE;                                
select lpad (count(*),20) "MGSM_FEATURE" from GARLAND.MGSM_FEATURE;   
select lpad (count(*),20) "NEW_MGSM_FEATURE" from GARLAND.NEW_MGSM_FEA
;                                                                     
select 'CREATE MGSM_INTERSTATE' " " from dual;                        
drop   table   GARLAND.NEW_MGSM_INTERSTATE;                           
create table   GARLAND.NEW_MGSM_INTERSTATE                            
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MGSM_INTERSTATE;                             
select lpad (count(*),20) "MGSM_INTERSTATE" from GARLAND.MGSM_INTERSTA
select lpad (count(*),20) "NEW_MGSM_INTERSTATE" from GARLAND.NEW_MGSM_
;                                                                     
select 'CREATE MGSM_INTERSTATES' " " from dual;                       
drop   table   GARLAND.NEW_MGSM_INTERSTATES;                          
create table   GARLAND.NEW_MGSM_INTERSTATES                           
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MGSM_INTERSTATES;                            
select lpad (count(*),20) "MGSM_INTERSTATES" from GARLAND.MGSM_INTERST
select lpad (count(*),20) "NEW_MGSM_INTERSTATES" from GARLAND.NEW_MGSM
;                                                                     
select 'CREATE MGSM_JOIN_CATALOG' " " from dual;                      
drop   table   GARLAND.NEW_MGSM_JOIN_CATALOG;                         
create table   GARLAND.NEW_MGSM_JOIN_CATALOG                          
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MGSM_JOIN_CATALOG;                           
select lpad (count(*),20) "MGSM_JOIN_CATALOG" from GARLAND.MGSM_JOIN_C
select lpad (count(*),20) "NEW_MGSM_JOIN_CATALOG" from GARLAND.NEW_MGS
;                                                                     
select 'CREATE MGSM_MAPS' " " from dual;                              
drop   table   GARLAND.NEW_MGSM_MAPS;                                 
create table   GARLAND.NEW_MGSM_MAPS                                  
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MGSM_MAPS;                                   
select lpad (count(*),20) "MGSM_MAPS" from GARLAND.MGSM_MAPS;         
select lpad (count(*),20) "NEW_MGSM_MAPS" from GARLAND.NEW_MGSM_MAPS; 
;                                                                     
select 'CREATE MGSM_MATER' " " from dual;                             
drop   table   GARLAND.NEW_MGSM_MATER;                                
create table   GARLAND.NEW_MGSM_MATER                                 
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MGSM_MATER;                                  
select lpad (count(*),20) "MGSM_MATER" from GARLAND.MGSM_MATER;       
select lpad (count(*),20) "NEW_MGSM_MATER" from GARLAND.NEW_MGSM_MATER
;                                                                     
select 'CREATE MGSM_MSCATALOG' " " from dual;                         
drop   table   GARLAND.NEW_MGSM_MSCATALOG;                            
create table   GARLAND.NEW_MGSM_MSCATALOG                             
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MGSM_MSCATALOG;                              
select lpad (count(*),20) "MGSM_MSCATALOG" from GARLAND.MGSM_MSCATALOG
select lpad (count(*),20) "NEW_MGSM_MSCATALOG" from GARLAND.NEW_MGSM_M
;                                                                     
select 'CREATE MGSM_PAVEMENT' " " from dual;                          
drop   table   GARLAND.NEW_MGSM_PAVEMENT;                             
create table   GARLAND.NEW_MGSM_PAVEMENT                              
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MGSM_PAVEMENT;                               
select lpad (count(*),20) "MGSM_PAVEMENT" from GARLAND.MGSM_PAVEMENT; 
select lpad (count(*),20) "NEW_MGSM_PAVEMENT" from GARLAND.NEW_MGSM_PA
;                                                                     
select 'CREATE MGSM_PAVEMENT_SAV' " " from dual;                      
drop   table   GARLAND.NEW_MGSM_PAVEMENT_SAV;                         
create table   GARLAND.NEW_MGSM_PAVEMENT_SAV                          
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MGSM_PAVEMENT_SAV;                           
select lpad (count(*),20) "MGSM_PAVEMENT_SAV" from GARLAND.MGSM_PAVEME
select lpad (count(*),20) "NEW_MGSM_PAVEMENT_SAV" from GARLAND.NEW_MGS
;                                                                     
select 'CREATE MGSM_PV_COND' " " from dual;                           
drop   table   GARLAND.NEW_MGSM_PV_COND;                              
create table   GARLAND.NEW_MGSM_PV_COND                               
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MGSM_PV_COND;                                
select lpad (count(*),20) "MGSM_PV_COND" from GARLAND.MGSM_PV_COND;   
select lpad (count(*),20) "NEW_MGSM_PV_COND" from GARLAND.NEW_MGSM_PV_
;                                                                     
select 'CREATE MGSM_ST_HIGHWAY' " " from dual;                        
drop   table   GARLAND.NEW_MGSM_ST_HIGHWAY;                           
create table   GARLAND.NEW_MGSM_ST_HIGHWAY                            
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MGSM_ST_HIGHWAY;                             
select lpad (count(*),20) "MGSM_ST_HIGHWAY" from GARLAND.MGSM_ST_HIGHW
select lpad (count(*),20) "NEW_MGSM_ST_HIGHWAY" from GARLAND.NEW_MGSM_
;                                                                     
select 'CREATE MGSM_TEST' " " from dual;                              
drop   table   GARLAND.NEW_MGSM_TEST;                                 
create table   GARLAND.NEW_MGSM_TEST                                  
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MGSM_TEST;                                   
select lpad (count(*),20) "MGSM_TEST" from GARLAND.MGSM_TEST;         
select lpad (count(*),20) "NEW_MGSM_TEST" from GARLAND.NEW_MGSM_TEST; 
;                                                                     
select 'CREATE MGSM_US_HIGHWAY' " " from dual;                        
drop   table   GARLAND.NEW_MGSM_US_HIGHWAY;                           
create table   GARLAND.NEW_MGSM_US_HIGHWAY                            
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MGSM_US_HIGHWAY;                             
select lpad (count(*),20) "MGSM_US_HIGHWAY" from GARLAND.MGSM_US_HIGHW
select lpad (count(*),20) "NEW_MGSM_US_HIGHWAY" from GARLAND.NEW_MGSM_
;                                                                     
select 'CREATE MGSM_VIEW_CATALOG' " " from dual;                      
drop   table   GARLAND.NEW_MGSM_VIEW_CATALOG;                         
create table   GARLAND.NEW_MGSM_VIEW_CATALOG                          
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MGSM_VIEW_CATALOG;                           
select lpad (count(*),20) "MGSM_VIEW_CATALOG" from GARLAND.MGSM_VIEW_C
select lpad (count(*),20) "NEW_MGSM_VIEW_CATALOG" from GARLAND.NEW_MGS
;                                                                     
select 'CREATE MGSM_VIEW_CONTENT' " " from dual;                      
drop   table   GARLAND.NEW_MGSM_VIEW_CONTENT;                         
create table   GARLAND.NEW_MGSM_VIEW_CONTENT                          
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MGSM_VIEW_CONTENT;                           
select lpad (count(*),20) "MGSM_VIEW_CONTENT" from GARLAND.MGSM_VIEW_C
select lpad (count(*),20) "NEW_MGSM_VIEW_CONTENT" from GARLAND.NEW_MGS
;                                                                     
select 'CREATE MGSM_VIEW_JOIN' " " from dual;                         
drop   table   GARLAND.NEW_MGSM_VIEW_JOIN;                            
create table   GARLAND.NEW_MGSM_VIEW_JOIN                             
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MGSM_VIEW_JOIN;                              
select lpad (count(*),20) "MGSM_VIEW_JOIN" from GARLAND.MGSM_VIEW_JOIN
select lpad (count(*),20) "NEW_MGSM_VIEW_JOIN" from GARLAND.NEW_MGSM_V
;                                                                     
select 'CREATE MGSM_WEATHER' " " from dual;                           
drop   table   GARLAND.NEW_MGSM_WEATHER;                              
create table   GARLAND.NEW_MGSM_WEATHER                               
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.MGSM_WEATHER;                                
select lpad (count(*),20) "MGSM_WEATHER" from GARLAND.MGSM_WEATHER;   
select lpad (count(*),20) "NEW_MGSM_WEATHER" from GARLAND.NEW_MGSM_WEA
;                                                                     
select 'CREATE PARK' " " from dual;                                   
drop   table   GARLAND.NEW_PARK;                                      
create table   GARLAND.NEW_PARK                                       
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.PARK;                                        
select lpad (count(*),20) "PARK" from GARLAND.PARK;                   
select lpad (count(*),20) "NEW_PARK" from GARLAND.NEW_PARK;           
;                                                                     
select 'CREATE PLAN_TABLE' " " from dual;                             
drop   table   GARLAND.NEW_PLAN_TABLE;                                
create table   GARLAND.NEW_PLAN_TABLE                                 
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.PLAN_TABLE;                                  
select lpad (count(*),20) "PLAN_TABLE" from GARLAND.PLAN_TABLE;       
select lpad (count(*),20) "NEW_PLAN_TABLE" from GARLAND.NEW_PLAN_TABLE
;                                                                     
select 'CREATE POPCN_BGR' " " from dual;                              
drop   table   GARLAND.NEW_POPCN_BGR;                                 
create table   GARLAND.NEW_POPCN_BGR                                  
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.POPCN_BGR;                                   
select lpad (count(*),20) "POPCN_BGR" from GARLAND.POPCN_BGR;         
select lpad (count(*),20) "NEW_POPCN_BGR" from GARLAND.NEW_POPCN_BGR; 
;                                                                     
select 'CREATE POPCN_TRACT' " " from dual;                            
drop   table   GARLAND.NEW_POPCN_TRACT;                               
create table   GARLAND.NEW_POPCN_TRACT                                
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.POPCN_TRACT;                                 
select lpad (count(*),20) "POPCN_TRACT" from GARLAND.POPCN_TRACT;     
select lpad (count(*),20) "NEW_POPCN_TRACT" from GARLAND.NEW_POPCN_TRA
;                                                                     
select 'CREATE RI05_T01' " " from dual;                               
drop   table   GARLAND.NEW_RI05_T01;                                  
create table   GARLAND.NEW_RI05_T01                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.RI05_T01;                                    
select lpad (count(*),20) "RI05_T01" from GARLAND.RI05_T01;           
select lpad (count(*),20) "NEW_RI05_T01" from GARLAND.NEW_RI05_T01;   
;                                                                     
select 'CREATE RI05_T06' " " from dual;                               
drop   table   GARLAND.NEW_RI05_T06;                                  
create table   GARLAND.NEW_RI05_T06                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.RI05_T06;                                    
select lpad (count(*),20) "RI05_T06" from GARLAND.RI05_T06;           
select lpad (count(*),20) "NEW_RI05_T06" from GARLAND.NEW_RI05_T06;   
;                                                                     
select 'CREATE RI05_T07' " " from dual;                               
drop   table   GARLAND.NEW_RI05_T07;                                  
create table   GARLAND.NEW_RI05_T07                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.RI05_T07;                                    
select lpad (count(*),20) "RI05_T07" from GARLAND.RI05_T07;           
select lpad (count(*),20) "NEW_RI05_T07" from GARLAND.NEW_RI05_T07;   
;                                                                     
select 'CREATE RI05_T09' " " from dual;                               
drop   table   GARLAND.NEW_RI05_T09;                                  
create table   GARLAND.NEW_RI05_T09                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.RI05_T09;                                    
select lpad (count(*),20) "RI05_T09" from GARLAND.RI05_T09;           
select lpad (count(*),20) "NEW_RI05_T09" from GARLAND.NEW_RI05_T09;   
;                                                                     
select 'CREATE RI05_T10' " " from dual;                               
drop   table   GARLAND.NEW_RI05_T10;                                  
create table   GARLAND.NEW_RI05_T10                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.RI05_T10;                                    
select lpad (count(*),20) "RI05_T10" from GARLAND.RI05_T10;           
select lpad (count(*),20) "NEW_RI05_T10" from GARLAND.NEW_RI05_T10;   
;                                                                     
select 'CREATE RI05_T11' " " from dual;                               
drop   table   GARLAND.NEW_RI05_T11;                                  
create table   GARLAND.NEW_RI05_T11                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.RI05_T11;                                    
select lpad (count(*),20) "RI05_T11" from GARLAND.RI05_T11;           
select lpad (count(*),20) "NEW_RI05_T11" from GARLAND.NEW_RI05_T11;   
;                                                                     
select 'CREATE RI05_T12' " " from dual;                               
drop   table   GARLAND.NEW_RI05_T12;                                  
create table   GARLAND.NEW_RI05_T12                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.RI05_T12;                                    
select lpad (count(*),20) "RI05_T12" from GARLAND.RI05_T12;           
select lpad (count(*),20) "NEW_RI05_T12" from GARLAND.NEW_RI05_T12;   
;                                                                     
select 'CREATE RI05_T13' " " from dual;                               
drop   table   GARLAND.NEW_RI05_T13;                                  
create table   GARLAND.NEW_RI05_T13                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.RI05_T13;                                    
select lpad (count(*),20) "RI05_T13" from GARLAND.RI05_T13;           
select lpad (count(*),20) "NEW_RI05_T13" from GARLAND.NEW_RI05_T13;   
;                                                                     
select 'CREATE TMP_CAMELOT_PID' " " from dual;                        
drop   table   GARLAND.NEW_TMP_CAMELOT_PID;                           
create table   GARLAND.NEW_TMP_CAMELOT_PID                            
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.TMP_CAMELOT_PID;                             
select lpad (count(*),20) "TMP_CAMELOT_PID" from GARLAND.TMP_CAMELOT_P
select lpad (count(*),20) "NEW_TMP_CAMELOT_PID" from GARLAND.NEW_TMP_C
;                                                                     
select 'CREATE US_STATES' " " from dual;                              
drop   table   GARLAND.NEW_US_STATES;                                 
create table   GARLAND.NEW_US_STATES                                  
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.US_STATES;                                   
select lpad (count(*),20) "US_STATES" from GARLAND.US_STATES;         
select lpad (count(*),20) "NEW_US_STATES" from GARLAND.NEW_US_STATES; 
;                                                                     
select 'CREATE UTELETVT' " " from dual;                               
drop   table   GARLAND.NEW_UTELETVT;                                  
create table   GARLAND.NEW_UTELETVT                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.UTELETVT;                                    
select lpad (count(*),20) "UTELETVT" from GARLAND.UTELETVT;           
select lpad (count(*),20) "NEW_UTELETVT" from GARLAND.NEW_UTELETVT;   
;                                                                     
select 'CREATE UTSANLAT' " " from dual;                               
drop   table   GARLAND.NEW_UTSANLAT;                                  
create table   GARLAND.NEW_UTSANLAT                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.UTSANLAT;                                    
select lpad (count(*),20) "UTSANLAT" from GARLAND.UTSANLAT;           
select lpad (count(*),20) "NEW_UTSANLAT" from GARLAND.NEW_UTSANLAT;   
;                                                                     
select 'CREATE UTSANLST' " " from dual;                               
drop   table   GARLAND.NEW_UTSANLST;                                  
create table   GARLAND.NEW_UTSANLST                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.UTSANLST;                                    
select lpad (count(*),20) "UTSANLST" from GARLAND.UTSANLST;           
select lpad (count(*),20) "NEW_UTSANLST" from GARLAND.NEW_UTSANLST;   
;                                                                     
select 'CREATE UTSTOCTY' " " from dual;                               
drop   table   GARLAND.NEW_UTSTOCTY;                                  
create table   GARLAND.NEW_UTSTOCTY                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.UTSTOCTY;                                    
select lpad (count(*),20) "UTSTOCTY" from GARLAND.UTSTOCTY;           
select lpad (count(*),20) "NEW_UTSTOCTY" from GARLAND.NEW_UTSTOCTY;   
;                                                                     
select 'CREATE UTSTOMH' " " from dual;                                
drop   table   GARLAND.NEW_UTSTOMH;                                   
create table   GARLAND.NEW_UTSTOMH                                    
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.UTSTOMH;                                     
select lpad (count(*),20) "UTSTOMH" from GARLAND.UTSTOMH;             
select lpad (count(*),20) "NEW_UTSTOMH" from GARLAND.NEW_UTSTOMH;     
;                                                                     
select 'CREATE UTWATMTR' " " from dual;                               
drop   table   GARLAND.NEW_UTWATMTR;                                  
create table   GARLAND.NEW_UTWATMTR                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.UTWATMTR;                                    
select lpad (count(*),20) "UTWATMTR" from GARLAND.UTWATMTR;           
select lpad (count(*),20) "NEW_UTWATMTR" from GARLAND.NEW_UTWATMTR;   
;                                                                     
select 'CREATE UTWATPSTA' " " from dual;                              
drop   table   GARLAND.NEW_UTWATPSTA;                                 
create table   GARLAND.NEW_UTWATPSTA                                  
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.UTWATPSTA;                                   
select lpad (count(*),20) "UTWATPSTA" from GARLAND.UTWATPSTA;         
select lpad (count(*),20) "NEW_UTWATPSTA" from GARLAND.NEW_UTWATPSTA; 
;                                                                     
select 'CREATE UTWATTNK' " " from dual;                               
drop   table   GARLAND.NEW_UTWATTNK;                                  
create table   GARLAND.NEW_UTWATTNK                                   
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.UTWATTNK;                                    
select lpad (count(*),20) "UTWATTNK" from GARLAND.UTWATTNK;           
select lpad (count(*),20) "NEW_UTWATTNK" from GARLAND.NEW_UTWATTNK;   
;                                                                     
select 'CREATE WORK_MAST' " " from dual;                              
drop   table   GARLAND.NEW_WORK_MAST;                                 
create table   GARLAND.NEW_WORK_MAST                                  
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.WORK_MAST;                                   
select lpad (count(*),20) "WORK_MAST" from GARLAND.WORK_MAST;         
select lpad (count(*),20) "NEW_WORK_MAST" from GARLAND.NEW_WORK_MAST; 
;                                                                     
select 'CREATE XXX_STRTYPES' " " from dual;                           
drop   table   GARLAND.NEW_XXX_STRTYPES;                              
create table   GARLAND.NEW_XXX_STRTYPES                               
tablespace GIS_DATA   pctfree 10  pctused 40                          
           initrans 1 maxtrans 255                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
as select * from GARLAND.XXX_STRTYPES;                                
select lpad (count(*),20) "XXX_STRTYPES" from GARLAND.XXX_STRTYPES;   
select lpad (count(*),20) "NEW_XXX_STRTYPES" from GARLAND.NEW_XXX_STRT
;                                                                     
828 rows selected.
1 row processed.
Statement processed.
Echo                            OFF
Timing                          OFF
Echo                            OFF
Timing                          OFF
Statement processed.
Statement processed.
Statement processed.
101 rows processed.
Statement processed.
Statement processed.
Timing                          OFF
                                                                      
----------------------------------------------------------------------
select 'MSLINK1' " " from dual;                                       
create unique index   GARLAND.MSLINK1                                 
       on      GARLAND.GPLSRVA                                        
(                                                                     
 MSLINK                                                               
)                                                                     
tablespace GISINDX                                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
;                                                                     
select 'PLAN_TABLE_X_REMARKS' " " from dual;                          
create index   GARLAND.PLAN_TABLE_X_REMARKS                           
       on      GARLAND.PLAN_TABLE                                     
(                                                                     
 REMARKS                                                              
)                                                                     
tablespace GISINDX                                                    
storage   (initial 2112K next 32K pctincrease 0                       
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
;                                                                     
select 'POPCN_BGR_MSLINK' " " from dual;                              
create index   GARLAND.POPCN_BGR_MSLINK                               
       on      GARLAND.POPCN_BGR                                      
(                                                                     
 MSLINK                                                               
)                                                                     
tablespace GISINDX                                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
;                                                                     
select 'POPCN_TRACT_MSLINK' " " from dual;                            
create index   GARLAND.POPCN_TRACT_MSLINK                             
       on      GARLAND.POPCN_TRACT                                    
(                                                                     
 MSLINK                                                               
)                                                                     
tablespace GISINDX                                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
;                                                                     
select 'RISXXX_SCHEMAID1' " " from dual;                              
create unique index   GARLAND.RISXXX_SCHEMAID1                        
       on      GARLAND.RI05_T01                                       
(                                                                     
 SCHEMA_NAME                                                          
)                                                                     
tablespace GISINDX                                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
;                                                                     
select 'RISXXX_GRAN1' " " from dual;                                  
create unique index   GARLAND.RISXXX_GRAN1                            
       on      GARLAND.RI05_T06                                       
(                                                                     
 GRANTEE                                                              
,SCHEMA_NAME                                                          
)                                                                     
tablespace GISINDX                                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
;                                                                     
select 'RISXXX_SCHUSR1' " " from dual;                                
create unique index   GARLAND.RISXXX_SCHUSR1                          
       on      GARLAND.RI05_T07                                       
(                                                                     
 SERVER_PID                                                           
)                                                                     
tablespace GISINDX                                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
;                                                                     
select 'RISXXX_USERS1' " " from dual;                                 
create unique index   GARLAND.RISXXX_USERS1                           
       on      GARLAND.RI05_T10                                       
(                                                                     
 USER_NAME                                                            
,SCHEMA_NAME                                                          
)                                                                     
tablespace GISINDX                                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
;                                                                     
select 'RISXXX_T111' " " from dual;                                   
create unique index   GARLAND.RISXXX_T111                             
       on      GARLAND.RI05_T11                                       
(                                                                     
 USER_NAME                                                            
)                                                                     
tablespace GISINDX                                                    
storage   (initial 32K next 32K pctincrease 0                         
           minextents 1  maxextents 249                               
           freelists  1  freelist groups 1)                           
;                                                                     
101 rows selected.
Echo                            OFF
Timing                          ON
Statement processed.
Parse             0.20 (Elapsed)     0.01 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.20               0.01
Statement processed.
Parse             0.03 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.03               0.00
Statement processed.
Parse             0.00 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.00               0.00
25 rows processed.
Parse             0.34 (Elapsed)     0.00 (CPU)
Execute/Fetch    15.62 (Elapsed)     0.00 (CPU)
Total            15.96               0.00
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
select 'WORK_MAST / WORK_MAST_PK' " "  from dual;                     
alter table    GARLAND.WORK_MAST                                      
add constraint WORK_MAST_PK   primary key                             
(                                                                     
 SFG_NUM                                                              
,SUB_TASK_NUM                                                         
)                                                                     
using index                                                           
tablespace GISINDX                                                    
storage (initial 32K next 32K pctincrease 0                           
         minextents 1  maxextents 249                                 
         freelists 1   freelist groups 1)                             
;                                                                     
select 'XXX_STRTYPES / STRTYPE_UNQ' " "  from dual;                   
alter table    GARLAND.XXX_STRTYPES                                   
add constraint STRTYPE_UNQ   unique                                   
(                                                                     
 ADDR_TYPE                                                            
)                                                                     
using index                                                           
tablespace GISINDX                                                    
storage (initial 32K next 32K pctincrease 0                           
         minextents 1  maxextents 249                                 
         freelists 1   freelist groups 1)                             
;                                                                     
25 rows selected.
Echo                            OFF
Timing                          ON
Server Output                   ON
Statement processed.
Parse             0.12 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.01 (Elapsed)     0.00 (CPU)
Total             0.13               0.00
Statement processed.
Parse             0.03 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.03               0.00
Statement processed.
Parse             0.00 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.00               0.00
0 rows processed.
Parse             0.44 (Elapsed)     0.00 (CPU)
Execute/Fetch    32.11 (Elapsed)     0.00 (CPU)
Total            32.55               0.00
Statement processed.
Parse             0.00 (Elapsed)     0.00 (CPU)
Execute/Fetch     0.00 (Elapsed)     0.00 (CPU)
Total             0.00               0.00
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
	drop table ADRDEBUG;   --  cascade constraints                                                     
	drop table BDJURBEAT;   --  cascade constraints                                                    
	drop table BDJURCODEDIST;   --  cascade constraints                                                
	drop table BDJURDST;   --  cascade constraints                                                     
	drop table BDJURPOLDIST;   --  cascade constraints                                                 
	drop table BDJURSECTOR;   --  cascade constraints                                                  
	drop table BUILDING;   --  cascade constraints                                                     
	drop table CDBG;   --  cascade constraints                                                         
	drop table CDRELSUBDV;   --  cascade constraints                                                   
	drop table ESZ_FIRE;   --  cascade constraints                                                     
	drop table EXCEPT_TABLE;   --  cascade constraints                                                 
	drop table GIS_ABSTACT;   --  cascade constraints                                                  
	drop table GIS_COUNCIL_DIST;   --  cascade constraints                                             
	drop table GIS_FIRE_DIST;   --  cascade constraints                                                
	drop table GIS_ZIP_CODE;   --  cascade constraints                                                 
	drop table GPLSRVA;   --  cascade constraints                                                      
	drop table IDX;   --  cascade constraints                                                          
	drop table MAPBOOK2;   --  cascade constraints                                                     
	drop table MAPCOPAGE;   --  cascade constraints                                                    
	drop table MGSM_ACCIDENT;   --  cascade constraints                                                
	drop table MGSM_ADT;   --  cascade constraints                                                     
	drop table MGSM_ATTRIBUTE_CATALOG;   --  cascade constraints                                       
	drop table MGSM_CATEGORY;   --  cascade constraints                                                
	drop table MGSM_CONSTRUCTION;   --  cascade constraints                                            
	drop table MGSM_CONSTRUCTION_TYPE;   --  cascade constraints                                       
	drop table MGSM_CONTROL_PT;   --  cascade constraints                                              
	drop table MGSM_DOMAIN_CATALOG;   --  cascade constraints                                          
	drop table MGSM_DYN_XO_CONFIG;   --  cascade constraints                                           
	drop table MGSM_FEATURE;   --  cascade constraints                                                 
	drop table MGSM_INTERSTATE;   --  cascade constraints                                              
	drop table MGSM_INTERSTATES;   --  cascade constraints                                             
	drop table MGSM_JOIN_CATALOG;   --  cascade constraints                                            
	drop table MGSM_MAPS;   --  cascade constraints                                                    
	drop table MGSM_MATER;   --  cascade constraints                                                   
	drop table MGSM_MSCATALOG;   --  cascade constraints                                               
	drop table MGSM_PAVEMENT;   --  cascade constraints                                                
	drop table MGSM_PAVEMENT_SAV;   --  cascade constraints                                            
	drop table MGSM_PV_COND;   --  cascade constraints                                                 
	drop table MGSM_ST_HIGHWAY;   --  cascade constraints                                              
	drop table MGSM_TEST;   --  cascade constraints                                                    
	drop table MGSM_US_HIGHWAY;   --  cascade constraints                                              
	drop table MGSM_VIEW_CATALOG;   --  cascade constraints                                            
	drop table MGSM_VIEW_CONTENT;   --  cascade constraints                                            
	drop table MGSM_VIEW_JOIN;   --  cascade constraints                                               
	drop table MGSM_WEATHER;   --  cascade constraints                                                 
	drop table PARK;   --  cascade constraints                                                         
	drop table PLAN_TABLE;   --  cascade constraints                                                   
	drop table POPCN_BGR;   --  cascade constraints                                                    
	drop table POPCN_TRACT;   --  cascade constraints                                                  
	drop table RI05_T01;   --  cascade constraints                                                     
	drop table RI05_T06;   --  cascade constraints                                                     
	drop table RI05_T07;   --  cascade constraints                                                     
	drop table RI05_T09;   --  cascade constraints                                                     
	drop table RI05_T10;   --  cascade constraints                                                     
	drop table RI05_T11;   --  cascade constraints                                                     
	drop table RI05_T12;   --  cascade constraints                                                     
	drop table RI05_T13;   --  cascade constraints                                                     
	drop table TMP_CAMELOT_PID;   --  cascade constraints                                              
	drop table US_STATES;   --  cascade constraints                                                    
	drop table UTELETVT;   --  cascade constraints                                                     
	drop table UTSANLAT;   --  cascade constraints                                                     
	drop table UTSANLST;   --  cascade constraints                                                     
	drop table UTSTOCTY;   --  cascade constraints                                                     
	drop table UTSTOMH;   --  cascade constraints                                                      
	drop table UTWATMTR;   --  cascade constraints                                                     
	drop table UTWATPSTA;   --  cascade constraints                                                    
	drop table UTWATTNK;   --  cascade constraints                                                     
	drop table WORK_MAST;   --  cascade constraints                                                    
	drop table XXX_STRTYPES;   --  cascade constraints                                                 
69 rows selected.
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
	rename NEW_ADRDEBUG  to  ADRDEBUG;                                                                 
	rename NEW_BDJURBEAT  to  BDJURBEAT;                                                               
	rename NEW_BDJURCODEDIST  to  BDJURCODEDIST;                                                       
	rename NEW_BDJURDST  to  BDJURDST;                                                                 
	rename NEW_BDJURPOLDIST  to  BDJURPOLDIST;                                                         
	rename NEW_BDJURSECTOR  to  BDJURSECTOR;                                                           
	rename NEW_BUILDING  to  BUILDING;                                                                 
	rename NEW_CDBG  to  CDBG;                                                                         
	rename NEW_CDRELSUBDV  to  CDRELSUBDV;                                                             
	rename NEW_ESZ_FIRE  to  ESZ_FIRE;                                                                 
	rename NEW_EXCEPT_TABLE  to  EXCEPT_TABLE;                                                         
	rename NEW_GIS_ABSTACT  to  GIS_ABSTACT;                                                           
	rename NEW_GIS_COUNCIL_DIST  to  GIS_COUNCIL_DIST;                                                 
	rename NEW_GIS_FIRE_DIST  to  GIS_FIRE_DIST;                                                       
	rename NEW_GIS_ZIP_CODE  to  GIS_ZIP_CODE;                                                         
	rename NEW_GPLSRVA  to  GPLSRVA;                                                                   
	rename NEW_IDX  to  IDX;                                                                           
	rename NEW_MAPBOOK2  to  MAPBOOK2;                                                                 
	rename NEW_MAPCOPAGE  to  MAPCOPAGE;                                                               
	rename NEW_MGSM_ACCIDENT  to  MGSM_ACCIDENT;                                                       
	rename NEW_MGSM_ADT  to  MGSM_ADT;                                                                 
	rename NEW_MGSM_ATTRIBUTE_CATALOG  to  MGSM_ATTRIBUTE_CATALOG;                                     
	rename NEW_MGSM_CATEGORY  to  MGSM_CATEGORY;                                                       
	rename NEW_MGSM_CONSTRUCTION  to  MGSM_CONSTRUCTION;                                               
	rename NEW_MGSM_CONSTRUCTION_TYPE  to  MGSM_CONSTRUCTION_TYPE;                                     
	rename NEW_MGSM_CONTROL_PT  to  MGSM_CONTROL_PT;                                                   
	rename NEW_MGSM_DOMAIN_CATALOG  to  MGSM_DOMAIN_CATALOG;                                           
	rename NEW_MGSM_DYN_XO_CONFIG  to  MGSM_DYN_XO_CONFIG;                                             
	rename NEW_MGSM_FEATURE  to  MGSM_FEATURE;                                                         
	rename NEW_MGSM_INTERSTATE  to  MGSM_INTERSTATE;                                                   
	rename NEW_MGSM_INTERSTATES  to  MGSM_INTERSTATES;                                                 
	rename NEW_MGSM_JOIN_CATALOG  to  MGSM_JOIN_CATALOG;                                               
	rename NEW_MGSM_MAPS  to  MGSM_MAPS;                                                               
	rename NEW_MGSM_MATER  to  MGSM_MATER;                                                             
	rename NEW_MGSM_MSCATALOG  to  MGSM_MSCATALOG;                                                     
	rename NEW_MGSM_PAVEMENT  to  MGSM_PAVEMENT;                                                       
	rename NEW_MGSM_PAVEMENT_SAV  to  MGSM_PAVEMENT_SAV;                                               
	rename NEW_MGSM_PV_COND  to  MGSM_PV_COND;                                                         
	rename NEW_MGSM_ST_HIGHWAY  to  MGSM_ST_HIGHWAY;                                                   
	rename NEW_MGSM_TEST  to  MGSM_TEST;                                                               
	rename NEW_MGSM_US_HIGHWAY  to  MGSM_US_HIGHWAY;                                                   
	rename NEW_MGSM_VIEW_CATALOG  to  MGSM_VIEW_CATALOG;                                               
	rename NEW_MGSM_VIEW_CONTENT  to  MGSM_VIEW_CONTENT;                                               
	rename NEW_MGSM_VIEW_JOIN  to  MGSM_VIEW_JOIN;                                                     
	rename NEW_MGSM_WEATHER  to  MGSM_WEATHER;                                                         
	rename NEW_PARK  to  PARK;                                                                         
	rename NEW_PLAN_TABLE  to  PLAN_TABLE;                                                             
	rename NEW_POPCN_BGR  to  POPCN_BGR;                                                               
	rename NEW_POPCN_TRACT  to  POPCN_TRACT;                                                           
	rename NEW_RI05_T01  to  RI05_T01;                                                                 
	rename NEW_RI05_T06  to  RI05_T06;                                                                 
	rename NEW_RI05_T07  to  RI05_T07;                                                                 
	rename NEW_RI05_T09  to  RI05_T09;                                                                 
	rename NEW_RI05_T10  to  RI05_T10;                                                                 
	rename NEW_RI05_T11  to  RI05_T11;                                                                 
	rename NEW_RI05_T12  to  RI05_T12;                                                                 
	rename NEW_RI05_T13  to  RI05_T13;                                                                 
	rename NEW_TMP_CAMELOT_PID  to  TMP_CAMELOT_PID;                                                   
	rename NEW_US_STATES  to  US_STATES;                                                               
	rename NEW_UTELETVT  to  UTELETVT;                                                                 
	rename NEW_UTSANLAT  to  UTSANLAT;                                                                 
	rename NEW_UTSANLST  to  UTSANLST;                                                                 
	rename NEW_UTSTOCTY  to  UTSTOCTY;                                                                 
	rename NEW_UTSTOMH  to  UTSTOMH;                                                                   
	rename NEW_UTWATMTR  to  UTWATMTR;                                                                 
	rename NEW_UTWATPSTA  to  UTWATPSTA;                                                               
	rename NEW_UTWATTNK  to  UTWATTNK;                                                                 
	rename NEW_WORK_MAST  to  WORK_MAST;                                                               
	rename NEW_XXX_STRTYPES  to  XXX_STRTYPES;                                                         
69 rows selected.
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
SQLWKS> 
SQLWKS> 
SQLWKS> 
SQLWKS> --	optional:  Remove '__ rows selected' from Scripts_ to prevent harmless SQL error messages
SQLWKS> 
SQLWKS> 
SQLWKS> 	@c:\deacutis\scripts\ora_create\03_TABLES.sql;		--	create new table copies
SQLWKS> 
SQLWKS> 	set echo	off;
Echo                            OFF
Timing                          OFF
               
---------------
CREATE ADRDEBUG
1 row selected.
drop   table   GARLAND.NEW_ADRDEBUG
                       *
ORA-00942: table or view does not exist
Statement processed.
ADRDEBUG            
--------------------
                   4
1 row selected.
NEW_ADRDEBUG        
--------------------
                   4
1 row selected.
                
----------------
CREATE BDJURBEAT
1 row selected.
drop   table   GARLAND.NEW_BDJURBEAT
                       *
ORA-00942: table or view does not exist
Statement processed.
BDJURBEAT           
--------------------
                  62
1 row selected.
NEW_BDJURBEAT       
--------------------
                  62
1 row selected.
                    
--------------------
CREATE BDJURCODEDIST
1 row selected.
drop   table   GARLAND.NEW_BDJURCODEDIST
                       *
ORA-00942: table or view does not exist
Statement processed.
BDJURCODEDIST       
--------------------
                  12
1 row selected.
select lpad (count(*),20) "NEW_BDJURCODEDIST" from GARLAND.NEW_BDJURCO
                                                           *
ORA-00942: table or view does not exist
               
---------------
CREATE BDJURDST
1 row selected.
drop   table   GARLAND.NEW_BDJURDST
                       *
ORA-00942: table or view does not exist
Statement processed.
BDJURDST            
--------------------
                  62
1 row selected.
NEW_BDJURDST        
--------------------
                  62
1 row selected.
                   
-------------------
CREATE BDJURPOLDIST
1 row selected.
drop   table   GARLAND.NEW_BDJURPOLDIST
                       *
ORA-00942: table or view does not exist
Statement processed.
BDJURPOLDIST        
--------------------
                  66
1 row selected.
select lpad (count(*),20) "NEW_BDJURPOLDIST" from GARLAND.NEW_BDJURPOL
                                                          *
ORA-00942: table or view does not exist
                  
------------------
CREATE BDJURSECTOR
1 row selected.
drop   table   GARLAND.NEW_BDJURSECTOR
                       *
ORA-00942: table or view does not exist
Statement processed.
BDJURSECTOR         
--------------------
                   4
1 row selected.
select lpad (count(*),20) "NEW_BDJURSECTOR" from GARLAND.NEW_BDJURSECT
                                                         *
ORA-00942: table or view does not exist
               
---------------
CREATE BUILDING
1 row selected.
drop   table   GARLAND.NEW_BUILDING
                       *
ORA-00942: table or view does not exist
Statement processed.
BUILDING            
--------------------
                 108
1 row selected.
NEW_BUILDING        
--------------------
                 108
1 row selected.
           
-----------
CREATE CDBG
1 row selected.
drop   table   GARLAND.NEW_CDBG
                       *
ORA-00942: table or view does not exist
Statement processed.
CDBG                
--------------------
                  39
1 row selected.
NEW_CDBG            
--------------------
                  39
1 row selected.
                 
-----------------
CREATE CDRELSUBDV
1 row selected.
drop   table   GARLAND.NEW_CDRELSUBDV
                       *
ORA-00942: table or view does not exist
Statement processed.
CDRELSUBDV          
--------------------
                  95
1 row selected.
NEW_CDRELSUBDV      
--------------------
                  95
1 row selected.
               
---------------
CREATE ESZ_FIRE
1 row selected.
drop   table   GARLAND.NEW_ESZ_FIRE
                       *
ORA-00942: table or view does not exist
Statement processed.
ESZ_FIRE            
--------------------
                  35
1 row selected.
NEW_ESZ_FIRE        
--------------------
                  35
1 row selected.
                   
-------------------
CREATE EXCEPT_TABLE
1 row selected.
drop   table   GARLAND.NEW_EXCEPT_TABLE
                       *
ORA-00942: table or view does not exist
Statement processed.
EXCEPT_TABLE        
--------------------
                   0
1 row selected.
select lpad (count(*),20) "NEW_EXCEPT_TABLE" from GARLAND.NEW_EXCEPT_T
                                                          *
ORA-00942: table or view does not exist
                  
------------------
CREATE GIS_ABSTACT
1 row selected.
drop   table   GARLAND.NEW_GIS_ABSTACT
                       *
ORA-00942: table or view does not exist
Statement processed.
GIS_ABSTACT         
--------------------
                 122
1 row selected.
select lpad (count(*),20) "NEW_GIS_ABSTACT" from GARLAND.NEW_GIS_ABSTA
                                                         *
ORA-00942: table or view does not exist
                       
-----------------------
CREATE GIS_COUNCIL_DIST
1 row selected.
drop   table   GARLAND.NEW_GIS_COUNCIL_DIST
                       *
ORA-00942: table or view does not exist
Statement processed.
select lpad (count(*),20) "NEW_GIS_COUNCIL_DIST" from GARLAND.NEW_GIS_
*
ORA-00933: SQL command not properly ended
                    
--------------------
CREATE GIS_FIRE_DIST
1 row selected.
drop   table   GARLAND.NEW_GIS_FIRE_DIST
                       *
ORA-00942: table or view does not exist
Statement processed.
GIS_FIRE_DIST       
--------------------
                  18
1 row selected.
select lpad (count(*),20) "NEW_GIS_FIRE_DIST" from GARLAND.NEW_GIS_FIR
                                                           *
ORA-00942: table or view does not exist
                   
-------------------
CREATE GIS_ZIP_CODE
1 row selected.
drop   table   GARLAND.NEW_GIS_ZIP_CODE
                       *
ORA-00942: table or view does not exist
Statement processed.
GIS_ZIP_CODE        
--------------------
                   5
1 row selected.
select lpad (count(*),20) "NEW_GIS_ZIP_CODE" from GARLAND.NEW_GIS_ZIP_
                                                          *
ORA-00942: table or view does not exist
              
--------------
CREATE GPLSRVA
1 row selected.
drop   table   GARLAND.NEW_GPLSRVA
                       *
ORA-00942: table or view does not exist
Statement processed.
GPLSRVA             
--------------------
                 260
1 row selected.
NEW_GPLSRVA         
--------------------
                 260
1 row selected.
          
----------
CREATE IDX
1 row selected.
drop   table   GARLAND.NEW_IDX
                       *
ORA-00942: table or view does not exist
Statement processed.
IDX                 
--------------------
                  34
1 row selected.
NEW_IDX             
--------------------
                  34
1 row selected.
               
---------------
CREATE MAPBOOK2
1 row selected.
drop   table   GARLAND.NEW_MAPBOOK2
                       *
ORA-00942: table or view does not exist
Statement processed.
MAPBOOK2            
--------------------
                 102
1 row selected.
NEW_MAPBOOK2        
--------------------
                 102
1 row selected.
                
----------------
CREATE MAPCOPAGE
1 row selected.
drop   table   GARLAND.NEW_MAPCOPAGE
                       *
ORA-00942: table or view does not exist
Statement processed.
MAPCOPAGE           
--------------------
                 288
1 row selected.
NEW_MAPCOPAGE       
--------------------
                 288
1 row selected.
                    
--------------------
CREATE MGSM_ACCIDENT
1 row selected.
drop   table   GARLAND.NEW_MGSM_ACCIDENT
                       *
ORA-00942: table or view does not exist
Statement processed.
MGSM_ACCIDENT       
--------------------
                  39
1 row selected.
select lpad (count(*),20) "NEW_MGSM_ACCIDENT" from GARLAND.NEW_MGSM_AC
                                                           *
ORA-00942: table or view does not exist
               
---------------
CREATE MGSM_ADT
1 row selected.
drop   table   GARLAND.NEW_MGSM_ADT
                       *
ORA-00942: table or view does not exist
Statement processed.
MGSM_ADT            
--------------------
                  22
1 row selected.
NEW_MGSM_ADT        
--------------------
                  22
1 row selected.
                             
-----------------------------
CREATE MGSM_ATTRIBUTE_CATALOG
1 row selected.
drop   table   GARLAND.NEW_MGSM_ATTRIBUTE_CATALOG
                       *
ORA-00942: table or view does not exist
Statement processed.
select lpad (count(*),20) "NEW_MGSM_ATTRIBUTE_CATALOG" from GARLAND.NE
*
ORA-00933: SQL command not properly ended
                    
--------------------
CREATE MGSM_CATEGORY
1 row selected.
drop   table   GARLAND.NEW_MGSM_CATEGORY
                       *
ORA-00942: table or view does not exist
Statement processed.
MGSM_CATEGORY       
--------------------
                   1
1 row selected.
select lpad (count(*),20) "NEW_MGSM_CATEGORY" from GARLAND.NEW_MGSM_CA
                                                           *
ORA-00942: table or view does not exist
                        
------------------------
CREATE MGSM_CONSTRUCTION
1 row selected.
drop   table   GARLAND.NEW_MGSM_CONSTRUCTION
                       *
ORA-00942: table or view does not exist
Statement processed.
select lpad (count(*),20) "NEW_MGSM_CONSTRUCTION" from GARLAND.NEW_MGS
*
ORA-00933: SQL command not properly ended
                             
-----------------------------
CREATE MGSM_CONSTRUCTION_TYPE
1 row selected.
drop   table   GARLAND.NEW_MGSM_CONSTRUCTION_TYPE
                       *
ORA-00942: table or view does not exist
Statement processed.
select lpad (count(*),20) "NEW_MGSM_CONSTRUCTION_TYPE" from GARLAND.NE
*
ORA-00933: SQL command not properly ended
                      
----------------------
CREATE MGSM_CONTROL_PT
1 row selected.
drop   table   GARLAND.NEW_MGSM_CONTROL_PT
                       *
ORA-00942: table or view does not exist
Statement processed.
select lpad (count(*),20) "NEW_MGSM_CONTROL_PT" from GARLAND.NEW_MGSM_
*
ORA-00933: SQL command not properly ended
                          
--------------------------
CREATE MGSM_DOMAIN_CATALOG
1 row selected.
drop   table   GARLAND.NEW_MGSM_DOMAIN_CATALOG
                       *
ORA-00942: table or view does not exist
Statement processed.
select lpad (count(*),20) "NEW_MGSM_DOMAIN_CATALOG" from GARLAND.NEW_M
*
ORA-00933: SQL command not properly ended
                         
-------------------------
CREATE MGSM_DYN_XO_CONFIG
1 row selected.
drop   table   GARLAND.NEW_MGSM_DYN_XO_CONFIG
                       *
ORA-00942: table or view does not exist
Statement processed.
select lpad (count(*),20) "NEW_MGSM_DYN_XO_CONFIG" from GARLAND.NEW_MG
*
ORA-00933: SQL command not properly ended
                   
-------------------
CREATE MGSM_FEATURE
1 row selected.
drop   table   GARLAND.NEW_MGSM_FEATURE
                       *
ORA-00942: table or view does not exist
Statement processed.
MGSM_FEATURE        
--------------------
                  12
1 row selected.
select lpad (count(*),20) "NEW_MGSM_FEATURE" from GARLAND.NEW_MGSM_FEA
                                                          *
ORA-00942: table or view does not exist
                      
----------------------
CREATE MGSM_INTERSTATE
1 row selected.
drop   table   GARLAND.NEW_MGSM_INTERSTATE
                       *
ORA-00942: table or view does not exist
Statement processed.
select lpad (count(*),20) "NEW_MGSM_INTERSTATE" from GARLAND.NEW_MGSM_
*
ORA-00933: SQL command not properly ended
                       
-----------------------
CREATE MGSM_INTERSTATES
1 row selected.
drop   table   GARLAND.NEW_MGSM_INTERSTATES
                       *
ORA-00942: table or view does not exist
Statement processed.
select lpad (count(*),20) "NEW_MGSM_INTERSTATES" from GARLAND.NEW_MGSM
*
ORA-00933: SQL command not properly ended
                        
------------------------
CREATE MGSM_JOIN_CATALOG
1 row selected.
drop   table   GARLAND.NEW_MGSM_JOIN_CATALOG
                       *
ORA-00942: table or view does not exist
Statement processed.
select lpad (count(*),20) "NEW_MGSM_JOIN_CATALOG" from GARLAND.NEW_MGS
*
ORA-00933: SQL command not properly ended
                
----------------
CREATE MGSM_MAPS
1 row selected.
drop   table   GARLAND.NEW_MGSM_MAPS
                       *
ORA-00942: table or view does not exist
Statement processed.
MGSM_MAPS           
--------------------
                  11
1 row selected.
NEW_MGSM_MAPS       
--------------------
                  11
1 row selected.
                 
-----------------
CREATE MGSM_MATER
1 row selected.
drop   table   GARLAND.NEW_MGSM_MATER
                       *
ORA-00942: table or view does not exist
Statement processed.
MGSM_MATER          
--------------------
                  24
1 row selected.
NEW_MGSM_MATER      
--------------------
                  24
1 row selected.
                     
---------------------
CREATE MGSM_MSCATALOG
1 row selected.
drop   table   GARLAND.NEW_MGSM_MSCATALOG
                       *
ORA-00942: table or view does not exist
Statement processed.
select lpad (count(*),20) "NEW_MGSM_MSCATALOG" from GARLAND.NEW_MGSM_M
*
ORA-00933: SQL command not properly ended
                    
--------------------
CREATE MGSM_PAVEMENT
1 row selected.
drop   table   GARLAND.NEW_MGSM_PAVEMENT
                       *
ORA-00942: table or view does not exist
Statement processed.
MGSM_PAVEMENT       
--------------------
                  15
1 row selected.
select lpad (count(*),20) "NEW_MGSM_PAVEMENT" from GARLAND.NEW_MGSM_PA
                                                           *
ORA-00942: table or view does not exist
                        
------------------------
CREATE MGSM_PAVEMENT_SAV
1 row selected.
drop   table   GARLAND.NEW_MGSM_PAVEMENT_SAV
                       *
ORA-00942: table or view does not exist
Statement processed.
select lpad (count(*),20) "NEW_MGSM_PAVEMENT_SAV" from GARLAND.NEW_MGS
*
ORA-00933: SQL command not properly ended
                   
-------------------
CREATE MGSM_PV_COND
1 row selected.
drop   table   GARLAND.NEW_MGSM_PV_COND
                       *
ORA-00942: table or view does not exist
Statement processed.
MGSM_PV_COND        
--------------------
                   6
1 row selected.
select lpad (count(*),20) "NEW_MGSM_PV_COND" from GARLAND.NEW_MGSM_PV_
                                                          *
ORA-00942: table or view does not exist
                      
----------------------
CREATE MGSM_ST_HIGHWAY
1 row selected.
drop   table   GARLAND.NEW_MGSM_ST_HIGHWAY
                       *
ORA-00942: table or view does not exist
Statement processed.
select lpad (count(*),20) "NEW_MGSM_ST_HIGHWAY" from GARLAND.NEW_MGSM_
*
ORA-00933: SQL command not properly ended
                
----------------
CREATE MGSM_TEST
1 row selected.
drop   table   GARLAND.NEW_MGSM_TEST
                       *
ORA-00942: table or view does not exist
Statement processed.
MGSM_TEST           
--------------------
                  11
1 row selected.
NEW_MGSM_TEST       
--------------------
                  11
1 row selected.
                      
----------------------
CREATE MGSM_US_HIGHWAY
1 row selected.
drop   table   GARLAND.NEW_MGSM_US_HIGHWAY
                       *
ORA-00942: table or view does not exist
Statement processed.
select lpad (count(*),20) "NEW_MGSM_US_HIGHWAY" from GARLAND.NEW_MGSM_
*
ORA-00933: SQL command not properly ended
                        
------------------------
CREATE MGSM_VIEW_CATALOG
1 row selected.
drop   table   GARLAND.NEW_MGSM_VIEW_CATALOG
                       *
ORA-00942: table or view does not exist
Statement processed.
select lpad (count(*),20) "NEW_MGSM_VIEW_CATALOG" from GARLAND.NEW_MGS
*
ORA-00933: SQL command not properly ended
                        
------------------------
CREATE MGSM_VIEW_CONTENT
1 row selected.
drop   table   GARLAND.NEW_MGSM_VIEW_CONTENT
                       *
ORA-00942: table or view does not exist
Statement processed.
select lpad (count(*),20) "NEW_MGSM_VIEW_CONTENT" from GARLAND.NEW_MGS
*
ORA-00933: SQL command not properly ended
                     
---------------------
CREATE MGSM_VIEW_JOIN
1 row selected.
drop   table   GARLAND.NEW_MGSM_VIEW_JOIN
                       *
ORA-00942: table or view does not exist
Statement processed.
select lpad (count(*),20) "NEW_MGSM_VIEW_JOIN" from GARLAND.NEW_MGSM_V
*
ORA-00933: SQL command not properly ended
                   
-------------------
CREATE MGSM_WEATHER
1 row selected.
drop   table   GARLAND.NEW_MGSM_WEATHER
                       *
ORA-00942: table or view does not exist
Statement processed.
MGSM_WEATHER        
--------------------
                   5
1 row selected.
select lpad (count(*),20) "NEW_MGSM_WEATHER" from GARLAND.NEW_MGSM_WEA
                                                          *
ORA-00942: table or view does not exist
           
-----------
CREATE PARK
1 row selected.
drop   table   GARLAND.NEW_PARK
                       *
ORA-00942: table or view does not exist
Statement processed.
PARK                
--------------------
                  65
1 row selected.
NEW_PARK            
--------------------
                  65
1 row selected.
                 
-----------------
CREATE PLAN_TABLE
1 row selected.
drop   table   GARLAND.NEW_PLAN_TABLE
                       *
ORA-00942: table or view does not exist
as select * from GARLAND.PLAN_TABLE
          *
ORA-00997: illegal use of LONG datatype
PLAN_TABLE          
--------------------
                  58
1 row selected.
select lpad (count(*),20) "NEW_PLAN_TABLE" from GARLAND.NEW_PLAN_TABLE
                                                        *
ORA-00942: table or view does not exist
                
----------------
CREATE POPCN_BGR
1 row selected.
drop   table   GARLAND.NEW_POPCN_BGR
                       *
ORA-00942: table or view does not exist
Statement processed.
POPCN_BGR           
--------------------
                 157
1 row selected.
NEW_POPCN_BGR       
--------------------
                 157
1 row selected.
                  
------------------
CREATE POPCN_TRACT
1 row selected.
drop   table   GARLAND.NEW_POPCN_TRACT
                       *
ORA-00942: table or view does not exist
Statement processed.
POPCN_TRACT         
--------------------
                  33
1 row selected.
select lpad (count(*),20) "NEW_POPCN_TRACT" from GARLAND.NEW_POPCN_TRA
                                                         *
ORA-00942: table or view does not exist
               
---------------
CREATE RI05_T01
1 row selected.
drop   table   GARLAND.NEW_RI05_T01
                       *
ORA-00942: table or view does not exist
Statement processed.
RI05_T01            
--------------------
                   1
1 row selected.
NEW_RI05_T01        
--------------------
                   1
1 row selected.
               
---------------
CREATE RI05_T06
1 row selected.
drop   table   GARLAND.NEW_RI05_T06
                       *
ORA-00942: table or view does not exist
Statement processed.
RI05_T06            
--------------------
                   0
1 row selected.
NEW_RI05_T06        
--------------------
                   0
1 row selected.
               
---------------
CREATE RI05_T07
1 row selected.
drop   table   GARLAND.NEW_RI05_T07
                       *
ORA-00942: table or view does not exist
Statement processed.
RI05_T07            
--------------------
                   1
1 row selected.
NEW_RI05_T07        
--------------------
                   1
1 row selected.
               
---------------
CREATE RI05_T09
1 row selected.
drop   table   GARLAND.NEW_RI05_T09
                       *
ORA-00942: table or view does not exist
Statement processed.
RI05_T09            
--------------------
                   0
1 row selected.
NEW_RI05_T09        
--------------------
                   0
1 row selected.
               
---------------
CREATE RI05_T10
1 row selected.
drop   table   GARLAND.NEW_RI05_T10
                       *
ORA-00942: table or view does not exist
Statement processed.
RI05_T10            
--------------------
                   0
1 row selected.
NEW_RI05_T10        
--------------------
                   0
1 row selected.
               
---------------
CREATE RI05_T11
1 row selected.
drop   table   GARLAND.NEW_RI05_T11
                       *
ORA-00942: table or view does not exist
Statement processed.
RI05_T11            
--------------------
                   1
1 row selected.
NEW_RI05_T11        
--------------------
                   1
1 row selected.
               
---------------
CREATE RI05_T12
1 row selected.
drop   table   GARLAND.NEW_RI05_T12
                       *
ORA-00942: table or view does not exist
Statement processed.
RI05_T12            
--------------------
                   1
1 row selected.
NEW_RI05_T12        
--------------------
                   1
1 row selected.
               
---------------
CREATE RI05_T13
1 row selected.
drop   table   GARLAND.NEW_RI05_T13
                       *
ORA-00942: table or view does not exist
Statement processed.
RI05_T13            
--------------------
                   0
1 row selected.
NEW_RI05_T13        
--------------------
                   0
1 row selected.
                      
----------------------
CREATE TMP_CAMELOT_PID
1 row selected.
drop   table   GARLAND.NEW_TMP_CAMELOT_PID
                       *
ORA-00942: table or view does not exist
Statement processed.
select lpad (count(*),20) "NEW_TMP_CAMELOT_PID" from GARLAND.NEW_TMP_C
*
ORA-00933: SQL command not properly ended
                
----------------
CREATE US_STATES
1 row selected.
drop   table   GARLAND.NEW_US_STATES
                       *
ORA-00942: table or view does not exist
Statement processed.
US_STATES           
--------------------
                  51
1 row selected.
NEW_US_STATES       
--------------------
                  51
1 row selected.
               
---------------
CREATE UTELETVT
1 row selected.
drop   table   GARLAND.NEW_UTELETVT
                       *
ORA-00942: table or view does not exist
Statement processed.
UTELETVT            
--------------------
                   0
1 row selected.
NEW_UTELETVT        
--------------------
                   0
1 row selected.
               
---------------
CREATE UTSANLAT
1 row selected.
drop   table   GARLAND.NEW_UTSANLAT
                       *
ORA-00942: table or view does not exist
Statement processed.
UTSANLAT            
--------------------
                  59
1 row selected.
NEW_UTSANLAT        
--------------------
                  59
1 row selected.
               
---------------
CREATE UTSANLST
1 row selected.
drop   table   GARLAND.NEW_UTSANLST
                       *
ORA-00942: table or view does not exist
Statement processed.
UTSANLST            
--------------------
                  20
1 row selected.
NEW_UTSANLST        
--------------------
                  20
1 row selected.
               
---------------
CREATE UTSTOCTY
1 row selected.
drop   table   GARLAND.NEW_UTSTOCTY
                       *
ORA-00942: table or view does not exist
Statement processed.
UTSTOCTY            
--------------------
                  85
1 row selected.
NEW_UTSTOCTY        
--------------------
                  85
1 row selected.
              
--------------
CREATE UTSTOMH
1 row selected.
drop   table   GARLAND.NEW_UTSTOMH
                       *
ORA-00942: table or view does not exist
Statement processed.
UTSTOMH             
--------------------
                 223
1 row selected.
NEW_UTSTOMH         
--------------------
                 223
1 row selected.
               
---------------
CREATE UTWATMTR
1 row selected.
drop   table   GARLAND.NEW_UTWATMTR
                       *
ORA-00942: table or view does not exist
Statement processed.
UTWATMTR            
--------------------
                   0
1 row selected.
NEW_UTWATMTR        
--------------------
                   0
1 row selected.
                
----------------
CREATE UTWATPSTA
1 row selected.
drop   table   GARLAND.NEW_UTWATPSTA
                       *
ORA-00942: table or view does not exist
Statement processed.
UTWATPSTA           
--------------------
                   1
1 row selected.
NEW_UTWATPSTA       
--------------------
                   1
1 row selected.
               
---------------
CREATE UTWATTNK
1 row selected.
drop   table   GARLAND.NEW_UTWATTNK
                       *
ORA-00942: table or view does not exist
Statement processed.
UTWATTNK            
--------------------
                   8
1 row selected.
NEW_UTWATTNK        
--------------------
                   8
1 row selected.
                
----------------
CREATE WORK_MAST
1 row selected.
drop   table   GARLAND.NEW_WORK_MAST
                       *
ORA-00942: table or view does not exist
Statement processed.
WORK_MAST           
--------------------
                 295
1 row selected.
NEW_WORK_MAST       
--------------------
                 295
1 row selected.
                   
-------------------
CREATE XXX_STRTYPES
1 row selected.
drop   table   GARLAND.NEW_XXX_STRTYPES
                       *
ORA-00942: table or view does not exist
Statement processed.
XXX_STRTYPES        
--------------------
                  20
1 row selected.
select lpad (count(*),20) "NEW_XXX_STRTYPES" from GARLAND.NEW_XXX_STRT
                                                          *
ORA-00942: table or view does not exist
828 rows selected.
*
ORA-00900: invalid SQL statement
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
69 rows selected.
*
ORA-00900: invalid SQL statement
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
	rename NEW_PLAN_TABLE  to  PLAN_TABLE
*
ORA-04043: object NEW_PLAN_TABLE does not exist
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
69 rows selected.
*
ORA-00900: invalid SQL statement
       
-------
MSLINK1
1 row selected.
Statement processed.
                    
--------------------
PLAN_TABLE_X_REMARKS
1 row selected.
       on      GARLAND.PLAN_TABLE                                     
                       *
ORA-00942: table or view does not exist
                
----------------
POPCN_BGR_MSLINK
1 row selected.
Statement processed.
                  
------------------
POPCN_TRACT_MSLINK
1 row selected.
Statement processed.
                
----------------
RISXXX_SCHEMAID1
1 row selected.
Statement processed.
            
------------
RISXXX_GRAN1
1 row selected.
Statement processed.
              
--------------
RISXXX_SCHUSR1
1 row selected.
Statement processed.
             
-------------
RISXXX_USERS1
1 row selected.
Statement processed.
           
-----------
RISXXX_T111
1 row selected.
Statement processed.
101 rows selected.
*
ORA-00900: invalid SQL statement
                        
------------------------
WORK_MAST / WORK_MAST_PK
1 row selected.
Statement processed.
                          
--------------------------
XXX_STRTYPES / STRTYPE_UNQ
1 row selected.
Statement processed.
25 rows selected.
*
ORA-00900: invalid SQL statement
Echo                            OFF
Termout                         ON
                                                                                                    
----------------------------------------------------------------------------------------------------
analyze table GARLAND.ADRDEBUG   compute statistics;                                                
analyze table GARLAND.BDJURBEAT   compute statistics;                                               
analyze table GARLAND.BDJURCODEDIST   compute statistics;                                           
analyze table GARLAND.BDJURDST   compute statistics;                                                
analyze table GARLAND.BDJURPOLDIST   compute statistics;                                            
analyze table GARLAND.BDJURSECTOR   compute statistics;                                             
analyze table GARLAND.BUILDING   compute statistics;                                                
analyze table GARLAND.CDBG   compute statistics;                                                    
analyze table GARLAND.CDRELSUBDV   compute statistics;                                              
analyze table GARLAND.ESZ_FIRE   compute statistics;                                                
analyze table GARLAND.EXCEPT_TABLE   compute statistics;                                            
analyze table GARLAND.GIS_ABSTACT   compute statistics;                                             
analyze table GARLAND.GIS_COUNCIL_DIST   compute statistics;                                        
analyze table GARLAND.GIS_FIRE_DIST   compute statistics;                                           
analyze table GARLAND.GIS_ZIP_CODE   compute statistics;                                            
analyze table GARLAND.GPLSRVA   compute statistics;                                                 
analyze table GARLAND.IDX   compute statistics;                                                     
analyze table GARLAND.MAPBOOK2   compute statistics;                                                
analyze table GARLAND.MAPCOPAGE   compute statistics;                                               
analyze table GARLAND.MGSM_ACCIDENT   compute statistics;                                           
analyze table GARLAND.MGSM_ADT   compute statistics;                                                
analyze table GARLAND.MGSM_ATTRIBUTE_CATALOG   compute statistics;                                  
analyze table GARLAND.MGSM_CATEGORY   compute statistics;                                           
analyze table GARLAND.MGSM_CONSTRUCTION   compute statistics;                                       
analyze table GARLAND.MGSM_CONSTRUCTION_TYPE   compute statistics;                                  
analyze table GARLAND.MGSM_CONTROL_PT   compute statistics;                                         
analyze table GARLAND.MGSM_DOMAIN_CATALOG   compute statistics;                                     
analyze table GARLAND.MGSM_DYN_XO_CONFIG   compute statistics;                                      
analyze table GARLAND.MGSM_FEATURE   compute statistics;                                            
analyze table GARLAND.MGSM_INTERSTATE   compute statistics;                                         
analyze table GARLAND.MGSM_INTERSTATES   compute statistics;                                        
analyze table GARLAND.MGSM_JOIN_CATALOG   compute statistics;                                       
analyze table GARLAND.MGSM_MAPS   compute statistics;                                               
analyze table GARLAND.MGSM_MATER   compute statistics;                                              
analyze table GARLAND.MGSM_MSCATALOG   compute statistics;                                          
analyze table GARLAND.MGSM_PAVEMENT   compute statistics;                                           
analyze table GARLAND.MGSM_PAVEMENT_SAV   compute statistics;                                       
analyze table GARLAND.MGSM_PV_COND   compute statistics;                                            
analyze table GARLAND.MGSM_ST_HIGHWAY   compute statistics;                                         
analyze table GARLAND.MGSM_TEST   compute statistics;                                               
analyze table GARLAND.MGSM_US_HIGHWAY   compute statistics;                                         
analyze table GARLAND.MGSM_VIEW_CATALOG   compute statistics;                                       
analyze table GARLAND.MGSM_VIEW_CONTENT   compute statistics;                                       
analyze table GARLAND.MGSM_VIEW_JOIN   compute statistics;                                          
analyze table GARLAND.MGSM_WEATHER   compute statistics;                                            
analyze table GARLAND.PARK   compute statistics;                                                    
analyze table GARLAND.PLAN_TABLE   compute statistics;                                              
analyze table GARLAND.POPCN_BGR   compute statistics;                                               
analyze table GARLAND.POPCN_TRACT   compute statistics;                                             
analyze table GARLAND.RI05_T01   compute statistics;                                                
analyze table GARLAND.RI05_T06   compute statistics;                                                
analyze table GARLAND.RI05_T07   compute statistics;                                                
analyze table GARLAND.RI05_T09   compute statistics;                                                
analyze table GARLAND.RI05_T10   compute statistics;                                                
analyze table GARLAND.RI05_T11   compute statistics;                                                
analyze table GARLAND.RI05_T12   compute statistics;                                                
analyze table GARLAND.RI05_T13   compute statistics;                                                
analyze table GARLAND.TMP_CAMELOT_PID   compute statistics;                                         
analyze table GARLAND.US_STATES   compute statistics;                                               
analyze table GARLAND.UTELETVT   compute statistics;                                                
analyze table GARLAND.UTSANLAT   compute statistics;                                                
analyze table GARLAND.UTSANLST   compute statistics;                                                
analyze table GARLAND.UTSTOCTY   compute statistics;                                                
analyze table GARLAND.UTSTOMH   compute statistics;                                                 
analyze table GARLAND.UTWATMTR   compute statistics;                                                
analyze table GARLAND.UTWATPSTA   compute statistics;                                               
analyze table GARLAND.UTWATTNK   compute statistics;                                                
analyze table GARLAND.WORK_MAST   compute statistics;                                               
analyze table GARLAND.XXX_STRTYPES   compute statistics;                                            
69 rows selected.
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
analyze table GARLAND.PLAN_TABLE   compute statistics
*
ORA-00942: table or view does not exist
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
69 rows selected.
*
ORA-00900: invalid SQL statement
Echo                            OFF
                                                                                                    
----------------------------------------------------------------------------------------------------
alter VIEW GARLAND.ADRRESOLVE_VIEW compile;                                                         
alter VIEW GARLAND.ADRVIEW compile;                                                                 
alter PROCEDURE GARLAND.ADR_MATCH_LENGTH compile;                                                   
alter PROCEDURE GARLAND.ADR_RESOLVE_ADDRESS compile;                                                
alter FUNCTION GARLAND.ADR_STRING_CLEANER compile;                                                  
alter PROCEDURE GARLAND.CHANGES_CUSTOMER_ID compile;                                                
alter PROCEDURE GARLAND.DELETE_ROWS compile;                                                        
alter FUNCTION GARLAND.DT_ADDUSEROBJECT compile;                                                    
alter PROCEDURE GARLAND.DT_DROPUSEROBJECTBYID compile;                                              
alter PROCEDURE GARLAND.DT_SETPROPERTYBYID compile;                                                 
alter VIEW GARLAND.GDLVIEW135 compile;                                                              
alter VIEW GARLAND.GDLVIEW338 compile;                                                              
alter VIEW GARLAND.POPCN_BGRINCVW compile;                                                          
alter VIEW GARLAND.POPCN_BGR_AGE_VW compile;                                                        
alter VIEW GARLAND.POPCN_BGR_BASIC_VW compile;                                                      
alter VIEW GARLAND.POPCN_BGR_EDUC_VW compile;                                                       
alter VIEW GARLAND.POPCN_BGR_EMPLY_VW compile;                                                      
alter VIEW GARLAND.POPCN_BGR_HSNG_VW compile;                                                       
alter VIEW GARLAND.POPCN_BGR_INCM_VW compile;                                                       
alter VIEW GARLAND.POPCN_BGR_POP_VW compile;                                                        
alter VIEW GARLAND.RIS5DBS compile;                                                                 
alter VIEW GARLAND.RIS5SCHEMAS compile;                                                             
alter VIEW GARLAND.RIS5SCHPRIV compile;                                                             
alter VIEW GARLAND.RIS5USERS compile;                                                               
alter VIEW GARLAND.RISDBS compile;                                                                  
alter VIEW GARLAND.RISSCHEMAS compile;                                                              
alter PROCEDURE GARLAND.RISTABDEL2 compile;                                                         
alter PROCEDURE GARLAND.RISVIEWDEL2 compile;                                                        
alter VIEW GARLAND.RIS_SCHEMAID compile;                                                            
alter VIEW GARLAND.RIS_SCHUSR compile;                                                              
alter VIEW GARLAND.SHOW_DEBUG1_VW compile;                                                          
alter PROCEDURE GARLAND.SHOW_VIEW_DEFINITION compile;                                               
alter PROCEDURE GARLAND.TST_JOHN_PROC1 compile;                                                     
alter PROCEDURE GARLAND.TST_RESOLVE_ADDRESS compile;                                                
34 rows selected.
Statement processed.
Statement processed.
Statement processed.
MGR-00073: Warning: PROCEDURE GARLAND.ADR_RESOLVE_ADDRESS created with compilation errors.
Statement processed.
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
MGR-00073: Warning: PROCEDURE GARLAND.TST_RESOLVE_ADDRESS created with compilation errors.
34 rows selected.
*
ORA-00900: invalid SQL statement
Echo                            OFF
OWNER                          TABLE_NAME                     TABLESPACE_NAME                CLUSTER_NAME                   PCT_FREE   PCT_USED   INI_TRANS  MAX_TRANS  INITIAL_EX NEXT_EXTEN MIN_EXTENT MAX_EXTENT PCT_INCREA FREELISTS  FREELIST_G B NUM_ROWS   BLOCKS     EMPTY_BLOC AVG_SPACE  CHAIN_CNT  AVG_ROW_LE DEGREE     INSTANCES  CACHE TABLE_LO
------------------------------ ------------------------------ ------------------------------ ------------------------------ ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- - ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----- --------
GARLAND                        ADRDEBUG                       GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          4          1         18       1890          0         15          1          1     N ENABLED 
GARLAND                        BDJURBEAT                      GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N         62          1         18        661          0         19          1          1     N ENABLED 
GARLAND                        BDJURCODEDIST                  GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N         12          1         18       1776          0         13          1          1     N ENABLED 
GARLAND                        BDJURDST                       GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N         62          1         18        974          0         14          1          1     N ENABLED 
GARLAND                        BDJURPOLDIST                   GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N         66          1         18        726          0         17          1          1     N ENABLED 
GARLAND                        BDJURSECTOR                    GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          4          1         18       1898          0         13          1          1     N ENABLED 
GARLAND                        BUILDING                       GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N        108          3         16        620          0         35          1          1     N ENABLED 
GARLAND                        CDBG                           GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N         39          1         18       1490          0         10          1          1     N ENABLED 
GARLAND                        CDRELSUBDV                     GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N         95          2         17        325          0         32          1          1     N ENABLED 
GARLAND                        ESZ_FIRE                       GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N         35          1         18       1398          0         14          1          1     N ENABLED 
GARLAND                        EXCEPT_TABLE                   GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          0          0         19          0          0          0          1          1     N ENABLED 
GARLAND                        GIS_ABSTACT                    GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N        122          2         17        396          0         24          1          1     N ENABLED 
GARLAND                        GIS_COUNCIL_DIST               GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          8          1         18       1846          0         12          1          1     N ENABLED 
GARLAND                        GIS_FIRE_DIST                  GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N         18          1         18       1697          0         12          1          1     N ENABLED 
GARLAND                        GIS_ZIP_CODE                   GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          5          1         18       1868          0         16          1          1     N ENABLED 
GARLAND                        GPLSRVA                        GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N        260          2         17        268          0         11          1          1     N ENABLED 
GARLAND                        IDX                            GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N         34          1         18        770          0         33          1          1     N ENABLED 
GARLAND                        MAPBOOK2                       GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N        102          2         17        717          0         22          1          1     N ENABLED 
GARLAND                        MAPCOPAGE                      GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N        288          3         16        396          0         14          1          1     N ENABLED 
GARLAND                        MGSM_ACCIDENT                  GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N         39          2         17        331          0         81          1          1     N ENABLED 
GARLAND                        MGSM_ADT                       GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N         22          1         18       1188          0         33          1          1     N ENABLED 
GARLAND                        MGSM_ATTRIBUTE_CATALOG         GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N        108          2         17        309          0         29          1          1     N ENABLED 
GARLAND                        MGSM_CATEGORY                  GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          1          1         18       1931          0         25          1          1     N ENABLED 
GARLAND                        MGSM_CONSTRUCTION              GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N         11          1         18       1580          0         32          1          1     N ENABLED 
GARLAND                        MGSM_CONSTRUCTION_TYPE         GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          7          1         18       1744          0         29          1          1     N ENABLED 
GARLAND                        MGSM_CONTROL_PT                GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N         73          2         17       1081          0         22          1          1     N ENABLED 
GARLAND                        MGSM_DOMAIN_CATALOG            GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          4          1         18       1817          0         33          1          1     N ENABLED 
GARLAND                        MGSM_DYN_XO_CONFIG             GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          1          1         18       1925          0         31          1          1     N ENABLED 
GARLAND                        MGSM_FEATURE                   GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N         12          1         18       1290          0         54          1          1     N ENABLED 
GARLAND                        MGSM_INTERSTATE                GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          6          1         18       1820          0         21          1          1     N ENABLED 
GARLAND                        MGSM_INTERSTATES               GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          5          1         18       1876          0         14          1          1     N ENABLED 
GARLAND                        MGSM_JOIN_CATALOG              GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          1          1         18       1902          0         54          1          1     N ENABLED 
GARLAND                        MGSM_MAPS                      GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N         11          1         18       1716          0         20          1          1     N ENABLED 
GARLAND                        MGSM_MATER                     GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N         24          1         18        284          0         68          1          1     N ENABLED 
GARLAND                        MGSM_MSCATALOG                 GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N         35          1         18        917          0         28          1          1     N ENABLED 
GARLAND                        MGSM_PAVEMENT                  GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N         15          1         18       1536          0         26          1          1     N ENABLED 
GARLAND                        MGSM_PAVEMENT_SAV              GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          8          1         18       1733          0         26          1          1     N ENABLED 
GARLAND                        MGSM_PV_COND                   GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          6          1         18       1836          0         18          1          1     N ENABLED 
GARLAND                        MGSM_ST_HIGHWAY                GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          5          1         18       1836          0         22          1          1     N ENABLED 
GARLAND                        MGSM_TEST                      GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N         11          1         18       1811          0         11          1          1     N ENABLED 
GARLAND                        MGSM_US_HIGHWAY                GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          2          1         18       1910          0         22          1          1     N ENABLED 
GARLAND                        MGSM_VIEW_CATALOG              GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          1          1         18       1939          0         17          1          1     N ENABLED 
GARLAND                        MGSM_VIEW_CONTENT              GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N         16          1         18       1260          0         42          1          1     N ENABLED 
GARLAND                        MGSM_VIEW_JOIN                 GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          1          1         18       1942          0         14          1          1     N ENABLED 
GARLAND                        MGSM_WEATHER                   GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          5          1         18       1863          0         17          1          1     N ENABLED 
GARLAND                        PARK                           GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N         65          2         17        939          0         29          1          1     N ENABLED 
GARLAND                        POPCN_BGR                      GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N        157          4         15        564          0         34          1          1     N ENABLED 
GARLAND                        POPCN_TRACT                    GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N         33          1         18        446          0         44          1          1     N ENABLED 
GARLAND                        RI05_T01                       GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          1          1         18       1933          0         23          1          1     N ENABLED 
GARLAND                        RI05_T06                       GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          0          0         19          0          0          0          1          1     N ENABLED 
GARLAND                        RI05_T07                       GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          1          1         18       1932          0         24          1          1     N ENABLED 
GARLAND                        RI05_T09                       GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          0          0         19          0          0          0          1          1     N ENABLED 
GARLAND                        RI05_T10                       GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          0          0         24          0          0          0          1          1     N ENABLED 
GARLAND                        RI05_T11                       GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          1          1         18       1943          0         13          1          1     N ENABLED 
GARLAND                        RI05_T12                       GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          1          1         18       1933          0         23          1          1     N ENABLED 
GARLAND                        RI05_T13                       GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          0          0         19          0          0          0          1          1     N ENABLED 
GARLAND                        TMP_CAMELOT_PID                GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N        376          9         10        351          0         36          1          1     N ENABLED 
GARLAND                        US_STATES                      GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N         51          1         18       1057          0         16          1          1     N ENABLED 
GARLAND                        UTELETVT                       GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          0          0         19          0          0          0          1          1     N ENABLED 
GARLAND                        UTSANLAT                       GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N         59          2         17        376          0         52          1          1     N ENABLED 
GARLAND                        UTSANLST                       GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N         20          1         18        784          0         57          1          1     N ENABLED 
GARLAND                        UTSTOCTY                       GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N         85          4         15        351          0         74          1          1     N ENABLED 
GARLAND                        UTSTOMH                        GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N        223          4         15        363          0         26          1          1     N ENABLED 
GARLAND                        UTWATMTR                       GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          0          0         19          0          0          0          1          1     N ENABLED 
GARLAND                        UTWATPSTA                      GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          1          1         18       1920          0         36          1          1     N ENABLED 
GARLAND                        UTWATTNK                       GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N          8          1         18       1671          0         34          1          1     N ENABLED 
GARLAND                        WORK_MAST                      GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N        295          7         12        303          0         37          1          1     N ENABLED 
GARLAND                        XXX_STRTYPES                   GIS_DATA                                                              10         40          1        255      32768      32768          1        249          0          1          1 N         20          1         18       1738          0          7          1          1     N ENABLED 
68 rows selected.
OWNER                          INDEX_NAME                     TABLE_OWNER                    TABLE_NAME                     TABLE_TYPE  UNIQUENES TABLESPACE_NAME                INI_TRANS  MAX_TRANS  INITIAL_EX NEXT_EXTEN MIN_EXTENT MAX_EXTENT PCT_INCREA FREELISTS  FREELIST_G PCT_FREE   BLEVEL     LEAF_BLOCK DISTINCT_K AVG_LEAF_B AVG_DATA_B CLUSTERING STATUS     
------------------------------ ------------------------------ ------------------------------ ------------------------------ ----------- --------- ------------------------------ ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- -----------
GARLAND                        MSLINK1                        GARLAND                        GPLSRVA                        TABLE       UNIQUE    GISINDX                                 2        255      32768      32768          1        249          0          1          1         10          1          3        260          1          1          2 VALID      
GARLAND                        POPCN_BGR_MSLINK               GARLAND                        POPCN_BGR                      TABLE       NONUNIQUE GISINDX                                 2        255      32768      32768          1        249          0          1          1         10          1          2        157          1          1          4 VALID      
GARLAND                        POPCN_TRACT_MSLINK             GARLAND                        POPCN_TRACT                    TABLE       NONUNIQUE GISINDX                                 2        255      32768      32768          1        249          0          1          1         10          0          1         33          1          1          1 VALID      
GARLAND                        RISXXX_SCHEMAID1               GARLAND                        RI05_T01                       TABLE       UNIQUE    GISINDX                                 2        255      32768      32768          1        249          0          1          1         10          0          1          1          1          1          1 VALID      
GARLAND                        RISXXX_GRAN1                   GARLAND                        RI05_T06                       TABLE       UNIQUE    GISINDX                                 2        255      32768      32768          1        249          0          1          1         10          0          0          0          0          0          0 VALID      
GARLAND                        RISXXX_SCHUSR1                 GARLAND                        RI05_T07                       TABLE       UNIQUE    GISINDX                                 2        255      32768      32768          1        249          0          1          1         10          0          1          1          1          1          1 VALID      
GARLAND                        RISXXX_USERS1                  GARLAND                        RI05_T10                       TABLE       UNIQUE    GISINDX                                 2        255      32768      32768          1        249          0          1          1         10          0          0          0          0          0          0 VALID      
GARLAND                        RISXXX_T111                    GARLAND                        RI05_T11                       TABLE       UNIQUE    GISINDX                                 2        255      32768      32768          1        249          0          1          1         10          0          1          1          1          1          1 VALID      
GARLAND                        WORK_MAST_PK                   GARLAND                        WORK_MAST                      TABLE       UNIQUE    GISINDX                                 2        255      32768      32768          1        249          0          1          1         10          1          3        295          1          1         73 VALID      
GARLAND                        STRTYPE_UNQ                    GARLAND                        XXX_STRTYPES                   TABLE       UNIQUE    GISINDX                                 2        255      32768      32768          1        249          0          1          1         10          0          1         20          1          1          1 VALID      
10 rows selected.
OWNER                          CONSTRAINT_NAME                C TABLE_NAME                     SEARCH_CONDITION                                                                 R_OWNER                        R_CONSTRAINT_NAME              DELETE_RU STATUS  
------------------------------ ------------------------------ - ------------------------------ -------------------------------------------------------------------------------- ------------------------------ ------------------------------ --------- --------
GARLAND                        SYS_C006992                    C BDJURBEAT                      MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C006993                    C BDJURCODEDIST                  MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C006994                    C BDJURDST                       MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C006995                    C BDJURPOLDIST                   MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C006996                    C BDJURSECTOR                    MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C006997                    C BUILDING                       MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C006998                    C CDBG                           MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C006999                    C CDRELSUBDV                     MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007000                    C ESZ_FIRE                       MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007001                    C GIS_ABSTACT                    MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007002                    C GIS_COUNCIL_DIST               MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007003                    C GIS_FIRE_DIST                  MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007004                    C GIS_ZIP_CODE                   MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007005                    C GPLSRVA                        MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007006                    C IDX                            TABLE_NAME IS NOT NULL                                                                                                                                   ENABLED 
GARLAND                        SYS_C007007                    C IDX                            TABLESPACE_NAME IS NOT NULL                                                                                                                              ENABLED 
GARLAND                        SYS_C007008                    C IDX                            INDEX_NAME IS NOT NULL                                                                                                                                   ENABLED 
GARLAND                        SYS_C007009                    C MAPBOOK2                       MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007010                    C MAPCOPAGE                      MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007011                    C MGSM_ADT                       MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007012                    C MGSM_ATTRIBUTE_CATALOG         TABLENAME IS NOT NULL                                                                                                                                    ENABLED 
GARLAND                        SYS_C007013                    C MGSM_ATTRIBUTE_CATALOG         COLUMNNAME IS NOT NULL                                                                                                                                   ENABLED 
GARLAND                        SYS_C007014                    C MGSM_CATEGORY                  MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007015                    C MGSM_CONSTRUCTION_TYPE         LDOMAIN IS NOT NULL                                                                                                                                      ENABLED 
GARLAND                        SYS_C007016                    C MGSM_CONTROL_PT                MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007017                    C MGSM_DOMAIN_CATALOG            MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007018                    C MGSM_DOMAIN_CATALOG            DOMAINTYPE IS NOT NULL                                                                                                                                   ENABLED 
GARLAND                        SYS_C007019                    C MGSM_DOMAIN_CATALOG            TABLENAME IS NOT NULL                                                                                                                                    ENABLED 
GARLAND                        SYS_C007020                    C MGSM_FEATURE                   MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007021                    C MGSM_FEATURE                   FCODE IS NOT NULL                                                                                                                                        ENABLED 
GARLAND                        SYS_C007022                    C MGSM_INTERSTATE                MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007023                    C MGSM_INTERSTATES               LDOMAIN IS NOT NULL                                                                                                                                      ENABLED 
GARLAND                        SYS_C007024                    C MGSM_JOIN_CATALOG              JOINID IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007025                    C MGSM_JOIN_CATALOG              TABLE1 IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007026                    C MGSM_JOIN_CATALOG              TABLE2 IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007027                    C MGSM_JOIN_CATALOG              RELATIONSHIP IS NOT NULL                                                                                                                                 ENABLED 
GARLAND                        SYS_C007028                    C MGSM_MAPS                      MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007029                    C MGSM_MSCATALOG                 TABLENAME IS NOT NULL                                                                                                                                    ENABLED 
GARLAND                        SYS_C007030                    C MGSM_MSCATALOG                 ENTITYNUM IS NOT NULL                                                                                                                                    ENABLED 
GARLAND                        SYS_C007031                    C MGSM_PAVEMENT                  MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007032                    C MGSM_PAVEMENT_SAV              MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007033                    C MGSM_PV_COND                   LDOMAIN IS NOT NULL                                                                                                                                      ENABLED 
GARLAND                        SYS_C007034                    C MGSM_ST_HIGHWAY                MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007035                    C MGSM_US_HIGHWAY                MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007036                    C MGSM_VIEW_CATALOG              ENTITYNUM IS NOT NULL                                                                                                                                    ENABLED 
GARLAND                        SYS_C007037                    C MGSM_VIEW_CATALOG              VIEWNAME IS NOT NULL                                                                                                                                     ENABLED 
GARLAND                        SYS_C007038                    C MGSM_VIEW_CATALOG              VIEWTYPE IS NOT NULL                                                                                                                                     ENABLED 
GARLAND                        SYS_C007039                    C MGSM_VIEW_CONTENT              VIEWNAME IS NOT NULL                                                                                                                                     ENABLED 
GARLAND                        SYS_C007040                    C MGSM_VIEW_CONTENT              TABLENAME IS NOT NULL                                                                                                                                    ENABLED 
GARLAND                        SYS_C007041                    C MGSM_VIEW_CONTENT              COLUMNNAME IS NOT NULL                                                                                                                                   ENABLED 
GARLAND                        SYS_C007042                    C MGSM_VIEW_CONTENT              ALIASNAME IS NOT NULL                                                                                                                                    ENABLED 
GARLAND                        SYS_C007043                    C MGSM_VIEW_JOIN                 VIEWNAME IS NOT NULL                                                                                                                                     ENABLED 
GARLAND                        SYS_C007044                    C MGSM_VIEW_JOIN                 JOINID IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007045                    C MGSM_WEATHER                   LDOMAIN IS NOT NULL                                                                                                                                      ENABLED 
GARLAND                        SYS_C007046                    C PARK                           MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007047                    C POPCN_BGR                      MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007048                    C POPCN_BGR                      TRACT IS NOT NULL                                                                                                                                        ENABLED 
GARLAND                        SYS_C007049                    C POPCN_BGR                      BLOCK_GROUP IS NOT NULL                                                                                                                                  ENABLED 
GARLAND                        SYS_C007050                    C POPCN_TRACT                    MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007051                    C POPCN_TRACT                    TRACT IS NOT NULL                                                                                                                                        ENABLED 
GARLAND                        SYS_C007052                    C RI05_T01                       SCHEMA_NAME IS NOT NULL                                                                                                                                  ENABLED 
GARLAND                        SYS_C007053                    C RI05_T01                       SCHEMA_PASSWORD IS NOT NULL                                                                                                                              ENABLED 
GARLAND                        SYS_C007054                    C RI05_T01                       SCHEMA_OWNER IS NOT NULL                                                                                                                                 ENABLED 
GARLAND                        SYS_C007055                    C RI05_T01                       SCHEMA_TYPE IS NOT NULL                                                                                                                                  ENABLED 
GARLAND                        SYS_C007056                    C RI05_T06                       SCHEMA_NAME IS NOT NULL                                                                                                                                  ENABLED 
GARLAND                        SYS_C007057                    C RI05_T06                       GRANTEE IS NOT NULL                                                                                                                                      ENABLED 
GARLAND                        SYS_C007058                    C RI05_T07                       SERVER_PID IS NOT NULL                                                                                                                                   ENABLED 
GARLAND                        SYS_C007059                    C RI05_T07                       SCHEMA_NAME IS NOT NULL                                                                                                                                  ENABLED 
GARLAND                        SYS_C007060                    C RI05_T07                       SCHEMA_USER IS NOT NULL                                                                                                                                  ENABLED 
GARLAND                        SYS_C007061                    C RI05_T09                       SCHEMA_NAME IS NOT NULL                                                                                                                                  ENABLED 
GARLAND                        SYS_C007062                    C RI05_T09                       SCHEMA_OWNER IS NOT NULL                                                                                                                                 ENABLED 
GARLAND                        SYS_C007063                    C RI05_T09                       DATABASE_ID IS NOT NULL                                                                                                                                  ENABLED 
GARLAND                        SYS_C007064                    C RI05_T09                       SCHEMA_TYPE IS NOT NULL                                                                                                                                  ENABLED 
GARLAND                        SYS_C007065                    C RI05_T09                       DICTIONARY_OWNER IS NOT NULL                                                                                                                             ENABLED 
GARLAND                        SYS_C007066                    C RI05_T09                       SRVID IS NOT NULL                                                                                                                                        ENABLED 
GARLAND                        SYS_C007067                    C RI05_T09                       MAJOR IS NOT NULL                                                                                                                                        ENABLED 
GARLAND                        SYS_C007068                    C RI05_T09                       FEATURE IS NOT NULL                                                                                                                                      ENABLED 
GARLAND                        SYS_C007069                    C RI05_T10                       SCHEMA_NAME IS NOT NULL                                                                                                                                  ENABLED 
GARLAND                        SYS_C007070                    C RI05_T10                       USER_NAME IS NOT NULL                                                                                                                                    ENABLED 
GARLAND                        SYS_C007071                    C RI05_T10                       USER_PRIVILEGE IS NOT NULL                                                                                                                               ENABLED 
GARLAND                        SYS_C007072                    C RI05_T11                       USER_NAME IS NOT NULL                                                                                                                                    ENABLED 
GARLAND                        SYS_C007073                    C RI05_T11                       USER_PRIVILEGE IS NOT NULL                                                                                                                               ENABLED 
GARLAND                        SYS_C007074                    C RI05_T12                       LASTID IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007075                    C RI05_T12                       DICTIONARY_OWNER IS NOT NULL                                                                                                                             ENABLED 
GARLAND                        SYS_C007076                    C RI05_T12                       FIRST_SCHEMA IS NOT NULL                                                                                                                                 ENABLED 
GARLAND                        SYS_C007077                    C RI05_T13                       DATABASE_ID IS NOT NULL                                                                                                                                  ENABLED 
GARLAND                        SYS_C007078                    C RI05_T13                       DATABASE_TYPE IS NOT NULL                                                                                                                                ENABLED 
GARLAND                        SYS_C007079                    C RI05_T13                       DATABASE_NAME IS NOT NULL                                                                                                                                ENABLED 
GARLAND                        SYS_C007080                    C RI05_T13                       SRVID IS NOT NULL                                                                                                                                        ENABLED 
GARLAND                        SYS_C007081                    C UTELETVT                       MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007082                    C UTELETVT                       COORD_ID IS NOT NULL                                                                                                                                     ENABLED 
GARLAND                        SYS_C007083                    C UTSANLAT                       MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007084                    C UTSANLST                       MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007085                    C UTSTOCTY                       PARCEL_ID IS NOT NULL                                                                                                                                    ENABLED 
GARLAND                        SYS_C007086                    C UTSTOCTY                       ACCOUNT IS NOT NULL                                                                                                                                      ENABLED 
GARLAND                        SYS_C007087                    C UTSTOMH                        MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007088                    C UTWATMTR                       MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007089                    C UTWATPSTA                      MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007090                    C UTWATTNK                       MSLINK IS NOT NULL                                                                                                                                       ENABLED 
GARLAND                        SYS_C007091                    C WORK_MAST                      SFG_NUM IS NOT NULL                                                                                                                                      ENABLED 
GARLAND                        WORK_MAST_PK                   P WORK_MAST                                                                                                                                                                               ENABLED 
GARLAND                        STRTYPE_UNQ                    U XXX_STRTYPES                                                                                                                                                                            ENABLED 
102 rows selected.
OWNER                          SEGMENT_NAME                                                                      SEGMENT_TYPE      TABLESPACE_NAME                HEADER_FIL HEADER_BLO BYTES      BLOCKS     EXTENTS    INITIAL_EX NEXT_EXTEN MIN_EXTENT MAX_EXTENT PCT_INCREA FREELISTS  FREELIST_G
------------------------------ --------------------------------------------------------------------------------- ----------------- ------------------------------ ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
GARLAND                        ADRDEBUG                                                                          TABLE             GIS_DATA                                4      43907      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        BDJURBEAT                                                                         TABLE             GIS_DATA                                4     133677      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        BDJURCODEDIST                                                                     TABLE             GIS_DATA                                4      82327      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        BDJURDST                                                                          TABLE             GIS_DATA                                4        382      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        BDJURPOLDIST                                                                      TABLE             GIS_DATA                                4     152977      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        BDJURSECTOR                                                                       TABLE             GIS_DATA                                4      99987      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        BUILDING                                                                          TABLE             GIS_DATA                                4      51372      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        CDBG                                                                              TABLE             GIS_DATA                                4      47622      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        CDRELSUBDV                                                                        TABLE             GIS_DATA                                4      59942      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        ESZ_FIRE                                                                          TABLE             GIS_DATA                                4      42897      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        EXCEPT_TABLE                                                                      TABLE             GIS_DATA                                4      13987      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        GIS_ABSTACT                                                                       TABLE             GIS_DATA                                4       2177      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        GIS_COUNCIL_DIST                                                                  TABLE             GIS_DATA                                4     173132      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        GIS_FIRE_DIST                                                                     TABLE             GIS_DATA                                4      17047      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        GIS_ZIP_CODE                                                                      TABLE             GIS_DATA                                4      17067      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        GPLSRVA                                                                           TABLE             GIS_DATA                                4     121322      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        IDX                                                                               TABLE             GIS_DATA                                4     121342      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        MAPBOOK2                                                                          TABLE             GIS_DATA                                4     156977      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        MAPCOPAGE                                                                         TABLE             GIS_DATA                                4     156997      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        MGSM_ACCIDENT                                                                     TABLE             GIS_DATA                                4     123272      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        MGSM_ADT                                                                          TABLE             GIS_DATA                                4     123292      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        MGSM_ATTRIBUTE_CATALOG                                                            TABLE             GIS_DATA                                4     123312      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        MGSM_CATEGORY                                                                     TABLE             GIS_DATA                                4     123332      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        MGSM_CONSTRUCTION                                                                 TABLE             GIS_DATA                                4     123352      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        MGSM_CONSTRUCTION_TYPE                                                            TABLE             GIS_DATA                                4       7212      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        MGSM_CONTROL_PT                                                                   TABLE             GIS_DATA                                4       7232      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        MGSM_DOMAIN_CATALOG                                                               TABLE             GIS_DATA                                4       7252      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        MGSM_DYN_XO_CONFIG                                                                TABLE             GIS_DATA                                4       7272      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        MGSM_FEATURE                                                                      TABLE             GIS_DATA                                4       7292      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        MGSM_INTERSTATE                                                                   TABLE             GIS_DATA                                4     184627      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        MGSM_INTERSTATES                                                                  TABLE             GIS_DATA                                4     184647      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        MGSM_JOIN_CATALOG                                                                 TABLE             GIS_DATA                                4     184667      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        MGSM_MAPS                                                                         TABLE             GIS_DATA                                4     184687      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        MGSM_MATER                                                                        TABLE             GIS_DATA                                4     184707      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        MGSM_MSCATALOG                                                                    TABLE             GIS_DATA                                4     184727      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        MGSM_PAVEMENT                                                                     TABLE             GIS_DATA                                4     184747      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        MGSM_PAVEMENT_SAV                                                                 TABLE             GIS_DATA                                4     184767      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        MGSM_PV_COND                                                                      TABLE             GIS_DATA                                4     184787      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        MGSM_ST_HIGHWAY                                                                   TABLE             GIS_DATA                                4     184807      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        MGSM_TEST                                                                         TABLE             GIS_DATA                                4     184827      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        MGSM_US_HIGHWAY                                                                   TABLE             GIS_DATA                                4     184847      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        MGSM_VIEW_CATALOG                                                                 TABLE             GIS_DATA                                4     184867      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        MGSM_VIEW_CONTENT                                                                 TABLE             GIS_DATA                                4     184887      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        MGSM_VIEW_JOIN                                                                    TABLE             GIS_DATA                                4     184907      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        MGSM_WEATHER                                                                      TABLE             GIS_DATA                                4     184927      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        PARK                                                                              TABLE             GIS_DATA                                4     184947      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        POPCN_BGR                                                                         TABLE             GIS_DATA                                4     184967      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        POPCN_TRACT                                                                       TABLE             GIS_DATA                                4     184987      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        RI05_T01                                                                          TABLE             GIS_DATA                                4     185007      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        RI05_T06                                                                          TABLE             GIS_DATA                                4     185047      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        RI05_T07                                                                          TABLE             GIS_DATA                                4     185067      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        RI05_T09                                                                          TABLE             GIS_DATA                                4     185107      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        RI05_T10                                                                          TABLE             GIS_DATA                                4     185147      51200         25          1      32768      32768          1        249          0          1          1
GARLAND                        RI05_T11                                                                          TABLE             GIS_DATA                                4     184082      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        RI05_T12                                                                          TABLE             GIS_DATA                                4     184102      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        RI05_T13                                                                          TABLE             GIS_DATA                                4     184142      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        TMP_CAMELOT_PID                                                                   TABLE             GIS_DATA                                4     184162      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        US_STATES                                                                         TABLE             GIS_DATA                                4     184182      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        UTELETVT                                                                          TABLE             GIS_DATA                                4     184222      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        UTSANLAT                                                                          TABLE             GIS_DATA                                4     184242      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        UTSANLST                                                                          TABLE             GIS_DATA                                4     184262      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        UTSTOCTY                                                                          TABLE             GIS_DATA                                4     184282      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        UTSTOMH                                                                           TABLE             GIS_DATA                                4     184302      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        UTWATMTR                                                                          TABLE             GIS_DATA                                4     184342      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        UTWATPSTA                                                                         TABLE             GIS_DATA                                4     184362      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        UTWATTNK                                                                          TABLE             GIS_DATA                                4     184382      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        WORK_MAST                                                                         TABLE             GIS_DATA                                4     184402      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        XXX_STRTYPES                                                                      TABLE             GIS_DATA                                4     184422      40960         20          1      32768      32768          1        249          0          1          1
68 rows selected.
OWNER                          SEGMENT_NAME                                                                      SEGMENT_TYPE      TABLESPACE_NAME                HEADER_FIL HEADER_BLO BYTES      BLOCKS     EXTENTS    INITIAL_EX NEXT_EXTEN MIN_EXTENT MAX_EXTENT PCT_INCREA FREELISTS  FREELIST_G
------------------------------ --------------------------------------------------------------------------------- ----------------- ------------------------------ ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
GARLAND                        MSLINK1                                                                           INDEX             GISINDX                                 5       2692      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        POPCN_BGR_MSLINK                                                                  INDEX             GISINDX                                 5       2642      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        POPCN_TRACT_MSLINK                                                                INDEX             GISINDX                                 5       2667      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        RISXXX_GRAN1                                                                      INDEX             GISINDX                                 5      28172      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        RISXXX_SCHEMAID1                                                                  INDEX             GISINDX                                 5       2617      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        RISXXX_SCHUSR1                                                                    INDEX             GISINDX                                 5      28192      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        RISXXX_T111                                                                       INDEX             GISINDX                                 5       7192      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        RISXXX_USERS1                                                                     INDEX             GISINDX                                 5      28212      51200         25          1      32768      32768          1        249          0          1          1
GARLAND                        STRTYPE_UNQ                                                                       INDEX             GISINDX                                 5       7232      40960         20          1      32768      32768          1        249          0          1          1
GARLAND                        WORK_MAST_PK                                                                      INDEX             GISINDX                                 5       7212      40960         20          1      32768      32768          1        249          0          1          1
10 rows selected.
