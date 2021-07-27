	set echo off;
--	======================================================

	insert --+ append
	into garland.verizon

	select parcel_id, rec_key
	from	garland.adrResult_VERIZON_INFO
	where	verify_code = 55;

	commit;

	analyze table	garland.verizon	compute statistics;

--	======================================================
	set echo on;

