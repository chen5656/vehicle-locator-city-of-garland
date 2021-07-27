
create or replace view	 GARLAND.TRVEHACL_PAVE_MAST_VW

(
	 MSLINK                        
	,MAPID                         
	,ALLEY_ID                      
	,BRANCH_NO                     
	,SECTION_NO                    
	,ALLEY_AREA                    

	,CATEGORY                      
	,BRANCH                        
	,SECTION                       
	,SEGMENT                       
	,LENG                          
	,LANES                         
	,SURF_TYPE                     
	,REAR_ENTRY                    
	,CDBG                          
	,CONST_DATE                    
	,LAST_INSPECT_DATE             
	,NEXT_INSPECT_DATE             
	,PCI                           
	,CLASS                         
	,CRACK_SEAL                    
	,DISTRESSES                    
	,POT_HOLE_REQ                  
	,COUN_DIST                     
	,THOR_TYPE                     
	,ADDR_NUM                      
	,ADDR_PFX                      
	,ADDR_NAME                     
	,ADDR_TYPE                     
	,ADDR_SFX                      
	,FROM_ADDR_NUM                 
	,FROM_ADDR_PFX                 
	,FROM_ADDR_NAME                
	,FROM_ADDR_TYPE                
	,FROM_ADDR_SFX                 
	,TO_ADDR_NUM                   
	,TO_ADDR_PFX                   
	,TO_ADDR_NAME                  
	,TO_ADDR_TYPE                  
	,TO_ADDR_SFX                   
	,REMARKS                       
	,MISSING_SDWK                  
	,THOR_TYPE_NEW                 
	,CPI_YN                        
)   

as  

(
	select	t.*,
			p.*

	from		trvehacl		t,
			pave_mast		p

	where	t.branch_no  = p.branch  (+)
	and	t.section_no = p.section (+)
);
   

