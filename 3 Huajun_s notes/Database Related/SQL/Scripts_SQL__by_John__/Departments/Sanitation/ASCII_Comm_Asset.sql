
--	build ascii file of sanitation commercial assets


	select item01 ||','|| item03 " "
	from gis_objects
	where	item03 > '0';
