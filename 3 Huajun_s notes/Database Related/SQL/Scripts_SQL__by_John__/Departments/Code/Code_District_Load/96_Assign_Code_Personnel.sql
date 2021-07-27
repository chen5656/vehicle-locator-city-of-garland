	set echo off;

--	desc garland.code_district;

--	update garland.code_district
--	set	nuisance_inspector = 'Abner Avila'
--	where	nuisance_district  = 10;


--	update garland.code_district
--	set	rental_inspector = 'Jason Wilhite'
--	where	rental_district  = 25;


--	select count(*) 
--	select distinct nuisance_district, nuisance_inspector, nuisance_phone
	select distinct rental_district, rental_inspector, rental_phone
	from garland.code_district;


	commit;