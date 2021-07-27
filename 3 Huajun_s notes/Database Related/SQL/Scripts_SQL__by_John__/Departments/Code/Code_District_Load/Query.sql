	set echo off;
--	===============================================================================
--	Does ASCII load contain duplicate Parcel IDs with different Code Districts
--	===============================================================================

	select distinct item01, item02
	from	 garland.gis_objects
	where	 item01 in
(
	select	item01
	from		garland.gis_objects
	group by	item01
	having	count(distinct item02) > 1
);

--	===============================================================================
	set echo on;
