

	select
		max(length(addr_num)),		
		max(length(addr_pfx)),		
		max(length(addr_name)),		
		max(length(addr_type)),		
		max(length(addr_sfx)),		

		max(length(Source)),		
		max(length(Parcel_ID)),		

		max(length(GIS_Key)),	
		max(length(TAX_Key)),	
		max(length(UMS_Key))	

	from garland.Extract1_Address_Keys;


