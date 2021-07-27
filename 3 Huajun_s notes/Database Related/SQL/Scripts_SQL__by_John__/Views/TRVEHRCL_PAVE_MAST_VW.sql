
create or replace view	 GARLAND.TRVEHRCL_PAVE_MAST_VW

(
 MSLINK
,MAPID
,CLINE_ID
,BRANCH1
,SECTION1
,NUM_LANES
,FR_COORD
,TO_COORD
,CLINE_LEN
,ST_NAME
,COUN_DIST1
,BOND_PROJ
,ADR1_NUM
,ADR1_PFX
,ADR1_NAM
,ADR1_TYP
,ADR1_SFX
,ADR_LF_FR
,ADR_LF_TO
,ADR_RT_FR
,ADR_RT_TO
,PILOT
,SOURCE
,NOTCARRIED
,ADR_LO
,ADR_HI
,SEGMENT_ID
,SPEED_LIMIT

,CATEGORY                      
,BRANCH2                       
,SECTION2                      
,SEGMENT2                      
,LENG                          
,LANES                         
,SURF_TYPE                     
,REAR_ENTRY                    
,CDBG                          
,CONST_DATE                    
,LAST_INSP                     
,NEXT_INSP                     
,PCI                           
,CLASS                         
,CRACK_SEAL                    
,DISTRESSES                    
,POTHOLE_RQ                    
,COUN_DIST2                    
,THOR_TYPE                     
,ADR2_NUM                      
,ADR2_PFX                      
,ADR2_NAM                      
,ADR2_TYP                      
,ADR2_SFX                      
,FR_ADR_NUM                    
,FR_ADR_PFX                    
,FR_ADR_NAM                    
,FR_ADR_TYP                    
,FR_ADR_SFX                    
,TO_ADR_NUM                    
,TO_ADR_PFX                    
,TO_ADR_NAM                    
,TO_ADR_TYP                    
,TO_ADR_SFX                    
,REMARKS                       
,NO_SDWK                       
,THOR_NEW                      
,CPI_YN                        
)   

as  select

 t.MSLINK                        
,t.MAPID                         
,t.CLINE_ID                      
,t.BRANCH_NO                     
,t.SECTION_NO                    
,t.NUM_LANES                     
,t.FR_COORD                      
,t.TO_COORD                      
,t.CLINE_LENGTH                  
,t.ST_NAME                       
,t.COUNCIL_DISTRICT              
,t.BOND_PROJ                     
,t.ADDR_NUM                      
,t.ADDR_PFX                      
,t.ADDR_NAME                     
,t.ADDR_TYPE                     
,t.ADDR_SFX                      
,t.ADDR_LEFT_FROM                
,t.ADDR_LEFT_TO                  
,t.ADDR_RGHT_FROM                
,t.ADDR_RGHT_TO                  
,t.PILOT                         
,t.SOURCE                        
,t.NOTCARRIED                    
,t.ADDR_LO                       
,t.ADDR_HI                       
,t.SEGMENT_ID                    
,t.SPEED_LIMIT                   

,p.CATEGORY                      
,p.BRANCH                        
,p.SECTION                       
,p.SEGMENT                       
,p.LENG                          
,p.LANES                         
,p.SURF_TYPE                     
,p.REAR_ENTRY                    
,p.CDBG                          
,p.CONST_DATE                    
,p.LAST_INSPECT_DATE             
,p.NEXT_INSPECT_DATE             
,p.PCI                           
,p.CLASS                         
,p.CRACK_SEAL                    
,p.DISTRESSES                    
,p.POT_HOLE_REQ                  
,p.COUN_DIST                     
,p.THOR_TYPE                     
,p.ADDR_NUM                      
,p.ADDR_PFX                      
,p.ADDR_NAME                     
,p.ADDR_TYPE                     
,p.ADDR_SFX                      
,p.FROM_ADDR_NUM                 
,p.FROM_ADDR_PFX                 
,p.FROM_ADDR_NAME                
,p.FROM_ADDR_TYPE                
,p.FROM_ADDR_SFX                 
,p.TO_ADDR_NUM                   
,p.TO_ADDR_PFX                   
,p.TO_ADDR_NAME                  
,p.TO_ADDR_TYPE                  
,p.TO_ADDR_SFX                   
,p.REMARKS                       
,p.MISSING_SDWK                  
,p.THOR_TYPE_NEW                 
,p.CPI_YN                        

	from		garland.trvehrcl		t,
			garland.pave_mast		p

	where	t.branch_no  = p.branch  (+)
	and	t.section_no = p.section (+)
	and	p.category (+) = 'S';

