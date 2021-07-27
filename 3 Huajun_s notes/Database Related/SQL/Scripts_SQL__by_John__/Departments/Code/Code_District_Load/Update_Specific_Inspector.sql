	set timing off;
	set echo off;
--	=======================================================================================
/*
	desc garland.code_district_new;

	select distinct nuisance_district, nuisance_inspector, nuisance_phone
	from garland.code_district_new;

	select distinct rental_district, rental_inspector,  rental_phone
	from garland.code_district_new;

	update garland.code_district_new
	set	nuisance_inspector = '',
		nuisance_phone = '(972) '
	where	nuisance_district = 0;

	update garland.code_district_new
	set	rental_inspector = '',
		rental_phone = '(972) '
	where	rental_district = 0;

*/
--	=======================================================================================

	update garland.code_district_new
	set	nuisance_inspector = 'Obed Balderas'
	where	nuisance_district =4;
	update garland.code_district_new
	set	nuisance_inspector = 'Rudy Morales',
		nuisance_phone = '(972) 485-6412'
	where	nuisance_district =8;


	select distinct nuisance_district,	nuisance_inspector, nuisance_phone
	from garland.code_district_new;

	select distinct rental_district,	rental_inspector,	rental_phone
	from garland.code_district_new;

--	commit;
	rollback;

--	=======================================================================================

	select distinct nuisance_district, nuisance_inspector, nuisance_phone
	from garland.code_district_new;

	select distinct rental_district, rental_inspector,  rental_phone
	from garland.code_district_new;

--	=======================================================================================
