--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
--	================================================================


	update garland.Code_District		C
	set	(rental_inspector, rental_phone) = 
(
	select inspector, phone
	from	gis.Code_rental_Districts	R
	where	r.rental_district = c.rental_district
);

	COMMIT;
