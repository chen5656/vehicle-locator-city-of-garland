	set echo off;
--	=============================================================================
--	Street Signs
--	=============================================================================

	create or replace view		garland.temp_view
(
	key,		
	intersects,

	addr1_pfx,	
	addr1_name,	
	addr1_type,	
	addr1_sfx,	

	addr2_pfx,	
	addr2_name,	
	addr2_type,	
	addr2_sfx,	

	verify1,
	verify2,
	street1,	
	street2
)
	as	select

		item01, 
		item11, 

		item02, item03, item04, item09,			-- addr1

		item05, item06, item07, item08,			-- addr2

		item12, item13, item14, item15 
 
	from	garland.GIS_Temp1; 

--	=============================================================================
	set echo on;

