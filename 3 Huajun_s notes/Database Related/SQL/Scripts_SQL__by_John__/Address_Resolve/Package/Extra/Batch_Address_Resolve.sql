	set echo off;
--	===========================================================================================================
	
	truncate table	garland.gis_verify_addr		reuse storage;


--	drop index	garland.gis_verify_addr_PARCEL_ID;
--	drop index	garland.gis_verify_addr_MSLINK;
--	drop index	garland.gis_verify_addr_NAME;

--	===========================================================================================================

declare

	spec_insert			number	:= 01;
	spec_seq			number	:= 0;
	spec_trace			number	:= 0;
	spec_show			number	:= 0;
	spec_focus			varchar2(80):= null;

begin

	garland.Resolve_Address.Batch_Driver 
				(	spec_insert,	spec_seq 
--					,spec_trace		,spec_show		,spec_focus	
				);	

end;

--	===========================================================================================================

