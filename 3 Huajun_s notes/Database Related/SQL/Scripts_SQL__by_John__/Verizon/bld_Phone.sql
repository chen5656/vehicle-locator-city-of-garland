	set echo off;
--	=================================================================

	truncate table	garland.phone   reuse storage;


	insert --+ append
	into	 garland.Phone
	select parcel_id, phone, zip_code, 'V'
	from	 garland.Phone_VERIZON;

	commit;


	insert --+ append
	into	 garland.Phone
	select parcel_id, phone, zip_code, 'A'
	from	 garland.Phone_SBC;

	commit;


