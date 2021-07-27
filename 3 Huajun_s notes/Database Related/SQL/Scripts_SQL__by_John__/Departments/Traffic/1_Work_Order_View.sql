
--	Work Orders

	create or replace view		garland.temp_view
(
	key,		
	street1,	
	street2,
	verify1,
	verify2,
	intersects,

	addr1_pfx,	
	addr1_name,	
	addr1_type,	
	addr1_sfx,	

	addr2_pfx,	
	addr2_name,	
	addr2_type,	
	addr2_sfx	
)
	as	select
		item01, item02, item03, item04, item05, item06,
		item11, item12, item13, item14, 
		item21, item22, item23, item24

	from	garland.GIS_Temp1; 


--	=============================================================================

