	set echo off;
--	===============================================================

	truncate table	garland.parcel_convert	reuse storage;

--	===============================================================

	insert --+ append
	into	 garland.parcel_convert
(
	select  distinct
		  parcel_id,
		  garland.convert_old_parcelid(parcel_id)
	from	  garland.cdreladr
);

	commit;

--	===============================================================
--	check for duplicate parcel id

--	select parcel_id, count(*) counter
--	from	 garland.parcel_convert
--	group by old_parcel_id
--	having count(*) > 1
	;

--	===============================================================


