
/*
	select count(*) from adrResult1 
	where	(addr_name, addr_num, addr_unit)	in

(
	select	addr_name, addr_num, addr_unit
	from		adrResult1

	minus

	select	addr_name, addr_num, addr_unit
	from		adrResult
);


	select addr_unit	from adrResult1
	intersect
	select addr_unit	from adrResult;


	select addr_unit	from adrResult
	intersect
	select addr_unit	from sani_asset;

	select distinct addr_unit from sani_asset;
	select distinct addr_unit from adrResult;

	select count(*) from adrResult;
	select count(*) from adrResult1;

	select distinct addr_code, addr_unit 
	from adrResult;

*/


