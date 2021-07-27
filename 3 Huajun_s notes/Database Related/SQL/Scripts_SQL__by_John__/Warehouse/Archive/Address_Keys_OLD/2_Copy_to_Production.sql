	set echo off;
--	=============================================================================

	truncate table	garland.Common_Address_Keys		reuse storage;

--	=============================================================================

	insert --+ append
	into	 garland.Common_Address_Keys
	select
		addr_num,		
		addr_pfx,		
		addr_name,		
		addr_type,		
		addr_sfx,		
		Source,		
		Parcel_ID,
		Sequence,		
		GIS_Key,	
		TAX_Key,
		UMS_Key	
	from  garland.Extract1_Address_Keys;

	Commit;

--	=============================================================================

--	@c:\deacutis\scripts\warehouse\Address_Keys\2A_REMOVE_NULL_UMS.sql

--	=============================================================================




