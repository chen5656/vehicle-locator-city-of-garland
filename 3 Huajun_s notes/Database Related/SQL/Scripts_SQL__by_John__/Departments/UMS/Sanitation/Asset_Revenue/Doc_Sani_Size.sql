
	select 	location_no,
		ums_attrib_value ( 'SW', 'FL', asset_no, 'SIZE' )
	from	sfg.um00100m@umsp.world
	where	location_no between 01 and 1000;


/*

Function
	
	UMS_ATTRIB_VALUE		(copy of UMS function ATTRIB_VALUE)

Input

	asset_area, 
	asset_type, 
	asset_no, 
	attribute_cd

Output

	Container Size


Asset_No

	UM00100M				--	contains location_no, asset_no
 
	select count(distinct location_no)	--	83508
	from sfg.um00100m@umsp.world;

	select count(distinct asset_no)		--	61862
	from sfg.um00100m@umsp.world;

*/

