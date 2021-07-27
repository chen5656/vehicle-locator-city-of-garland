	set echo off;
--	=================================================================================
--	WATER = UMS  Cross Reference

	create or replace view	garland.temp_view1
(
			serial,	account,	location
)
	as select	item01,	item02,	item03

	from		garland.GIS_Temp1;


--	=================================================================================
--	UMS	Address / Location No / Serial No

	create or replace view	garland.temp_view2
(
		serial,
		location,
		addr_num, addr_pfx, addr_name, addr_type, addr_sfx, addr_bldg, addr_unit
)

	as select	item01, item02, 
			item03, item04, item05, item06, item07, item08, item09

	from		garland.GIS_Temp2;

--	=================================================================================
	set echo off;
