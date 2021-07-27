--	====================================================================

	truncate table	garland.verizon_sbc_info	reuse storage;
	
	insert --+ append
	into garland.verizon_sbc_info
      (
           PHONE               
          ,STREETNUM           
          ,STREETPREFIX        
          ,STREETNAME          
--          ,STREETTYPE          
          ,STREETSUFFIX        
          ,UNITNUM             
          ,CITY                
          ,STATE               
          ,CUSTOMER            
--          ,MAIN              
--          ,PARCEL_ID         
--          ,ZIP_CODE          
          ,SOURCE			
      )
		select
			extension || phone,		
			addrnum,	
			addrpfx,	
			addrname,	
--			addrtype,	
			addrsfx,	
			addrunit,		
			city,		
			state,		
			customer,	
			source
		from	garland.Temp_View;


	commit;

--	====================================================================
                                                                                                                             

