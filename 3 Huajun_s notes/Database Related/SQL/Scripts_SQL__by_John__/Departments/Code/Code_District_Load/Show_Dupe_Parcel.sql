	set echo off;
--	===========================================================
--	Show duplicate Parcel ID in Code District New
--	===========================================================

--	select count(counter), sum(counter)	
--	from

	select * from garland.code_district_new
	where parcel_id	in
(
	select parcel_id 
--		,count(*) counter
	from	 garland.code_district_new
	group by	parcel_id
	having 	count(*) > 1
);
