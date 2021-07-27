	set echo off;
--	======================================================

	truncate table  garland.verizon	reuse storage;

	insert --+ append
	into garland.verizon

	select parcel_id, rec_key
	from	garland.adrResult_VERIZON
	where	verify_code = 55;

	commit;

	analyze table	garland.verizon	compute statistics;

--	======================================================
	set echo on;

