	set echo	off;

	variable	spec_mslink	number;
	execute  :spec_mslink := 13520;
--	=====================================================================
/*
MSLINK 13520  1726 COMMERCE ST PID CHANGES FROM 6400024.000  TO  6400260.000  
		XY CHANGES TO   2550143.98  7018685.50

MSLINK 13523   1500 COMMERCE ST CHANGES TO 1500 STATE HIGHWAY 66 HWY
*/
--	=====================================================================

	select * from cdreladr where mslink = :spec_mslink;

--	=====================================================================

/*
	update cdreladr
	set	addr_name		= 'STATE HIGHWAY 66' ,
		addr_type		= 'HWY',
		addr_num		= '1500'
	where	mslink = :spec_mslink;
*/	

--	=====================================================================

	update cdreladr
	set	parcel_id = '6400260.000',
		x_coord =  2550143.98,
		y_coord =  7018685.50
	where	mslink = :spec_mslink;

--	=====================================================================

	select * from cdreladr where mslink = :spec_mslink;
--	=====================================================================

--	rollback;

	commit;
