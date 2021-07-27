	set echo off;
--	===========================================================================
--	Define CCS_ADDRESSES view as query of CCS_ADDRESS table

--	drop view			garland.CCS_Addresses;

	create or replace view	  garland.CCS_Addresses
		as	select * from garland.CCS_Address;

--	===========================================================================
