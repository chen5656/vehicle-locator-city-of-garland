	set echo off;


	delete from garland.code_district_new
	where	rowid in
(
	select min(rowid) row_id
	from	garland.code_district_new
	group by parcel_id
	having count(*) > 1
);

	Commit;