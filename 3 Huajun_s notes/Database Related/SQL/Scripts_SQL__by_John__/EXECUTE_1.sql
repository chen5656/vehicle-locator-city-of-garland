                                                                                                                                                                                            
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	select count(*) "SOURCE" from GARLAND.UTSTOOUTF;                                                                                                                                           
	select count(*) "TARGET" from GARLAND.GIS_OBJECTS;
                                                                                                                                        
	TRUNCATE table	GARLAND.GIS_OBJECTS	reuse storage;

	alter rollback segment rb1  online;	
	commit;  
	set transaction use rollback segment  rb1; 
                                          
	insert /*+ append */	into GARLAND.GIS_OBJECTS
(                                                                                                                                            
	 ITEM01                                                                                                                                                                                    
	,ITEM02                                                                                                                                                                                    
	,ITEM03                                                                                                                                                                                    
	,ITEM04                                                                                                                                                                                    
	,ITEM05                                                                                                                                                                                    
	,ITEM06                                                                                                                                                                                    
	,ITEM07                                                                                                                                                                                    
	,ITEM08                                                                                                                                                                                    
	,ITEM09                                                                                                                                                                                    
	,ITEM10                                                                                                                                                                                    
	,ITEM11                                                                                                                                                                                    
	,ITEM12                                                                                                                                                                                    
	,ITEM13                                                                                                                                                                                    
	,ITEM14                                                                                                                                                                                    
	,ITEM15                                                                                                                                                                                    
	,ITEM16                                                                                                                                                                                    
	,ITEM17                                                                                                                                                                                    
	,ITEM18                                                                                                                                                                                    
	,ITEM19                                                                                                                                                                                    
	,ITEM20                                                                                                                                                                                    
	,ITEM21                                                                                                                                                                                    
	,ITEM22                                                                                                                                                                                    
	,ITEM23                                                                                                                                                                                    
	,ITEM24                                                                                                                                                                                    
	,ITEM25                                                                                                                                                                                    
)
	select                                                                                                                                                                                   
	 MSLINK                                                                                                                                                                                    
	,MAPID                                                                                                                                                                                     
	,PROJECT_NUM                                                                                                                                                                               
	,SCAN_NUM                                                                                                                                                                                  
	,OUTFALL_ID                                                                                                                                                                                
	,MAP_GRID                                                                                                                                                                                  
	,MAP_QUAD                                                                                                                                                                                  
	,OUTFALL_NUM                                                                                                                                                                               
	,PARENT_ID                                                                                                                                                                                 
	,LATITUDE                                                                                                                                                                                  
	,LONGITUDE                                                                                                                                                                                 
	,ACCESS_INSTRUCTION                                                                                                                                                                        
	,OUTFALL_DIMENSION                                                                                                                                                                         
	,OUTFALL_TYPE                                                                                                                                                                              
	,OUTFALL_MATERIAL                                                                                                                                                                          
	,QUANTITY                                                                                                                                                                                  
	,DISCHARGE                                                                                                                                                                                 
	,RECV_SUB_BASIN                                                                                                                                                                            
	,EPA_TOTAL_SCORE                                                                                                                                                                           
	,INSPECT_DATE                                                                                                                                                                              
	,BASIN                                                                                                                                                                                     
	,SUB_BASIN                                                                                                                                                                                 
	,OUTFALL_COND                                                                                                                                                                              
	,GENERAL_COMMENTS                                                                                                                                                                          
	,OWNERSHIP                                                                                                                                                                                 
	from GARLAND.UTSTOOUTF;                                                                                                                                                                    

	commit;  
	alter rollback segment rb1  offline;	  
                                                                                                                                       

	select count(*) "SOURCE" from GARLAND.UTSTOOUTF;                                                                                                                                          
	select count(*) "TARGET" from GARLAND.GIS_OBJECTS;
                                                                                                                                        
