--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
--	================================================================


	update garland.Code_District		C
	set	(nuisance_inspector, nuisance_phone) = 
(
	select inspector, phone
	from	gis.Code_Nuisance_Districts	N
	where	n.district_number = c.nuisance_district
);

	COMMIT;