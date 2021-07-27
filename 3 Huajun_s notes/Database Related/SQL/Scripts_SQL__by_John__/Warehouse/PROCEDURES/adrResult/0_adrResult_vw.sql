
	create or replace view adrResult_vw
	as 
	select  	
	 ADDR_NUM                      
	,ADDR_PFX                      
	,replace(ADDR_NAME, '''', '''''')		addr_name
	,ADDR_TYPE                     
	,ADDR_SFX                      
	,ADDR_CODE1                    
	,ADDR_UNIT1                    
	,ADDR_CODE2                    
	,ADDR_UNIT2                    
	,VERIFY_CODE                   
	,DO_PARSE                      
	,DO_ALIAS                      
	,DO_NAME                       
	,DO_QUAL                       
	,REC_SEQ                       
	,REC_ROWID                     
	,REC_KEY                       
	,PARCEL_ID                     
	,SEGMENT_ID                    
	,FORM_PFX                      
	,replace(FORM_NAME, '''', '''''')		form_name   
	,FORM_TYPE                     
	,FORM_SFX                      
	,FORM_CODE1                    
	,FORM_UNIT1                    
	,FORM_CODE2                    
	,FORM_UNIT2                    
	,APPL_PFX                      
	,replace(APPL_NAME, '''', '''''')		appl_name
	,APPL_TYPE                     
	,APPL_SFX                      
	,APPL_CODE1                    
	,APPL_UNIT1                    
	,APPL_CODE2                    
	,APPL_UNIT2                    
	,APPL_NUM                      
	from	garland.adrResult_Input
;

