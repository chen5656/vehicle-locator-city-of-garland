	set echo off;
--	===========================================================================================================
	
	truncate table	garland.gis_verify_addr		reuse storage;

	drop synonym	garland.adrResult;
	create synonym	garland.adrResult		for garland.gis_verify_addr;

--	drop index	garland.gis_verify_addr_PARCEL_ID;
--	drop index	garland.gis_verify_addr_MSLINK;
--	drop index	garland.gis_verify_addr_NAME;

--	===========================================================================================================

declare
	spec_insert			number	:= 01;
	spec_seq			number	:= 0;
begin
	garland.Resolve_Address.Batch_Driver 
			(	spec_insert,	spec_seq 		);	
end;

--	===========================================================================================================
