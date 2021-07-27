
--	street names with only 1 valid prefix 
--	and that prefix is not blank


	select distinct addr_name, addr_pfx

	from	garland.adrStreets
--	from garland.cdreladr
--	from garland.trvehrcl

	where addr_pfx > ' '
	and	addr_name in
(
	select	addr_name

	from		garland.adrStreets
--	from 		garland.cdreladr
--	from 		garland.trvehrcl

	group by	addr_name
	having 	count(distinct addr_pfx) = 1
);
