	set echo	off;
	set timing	off;
--	========================================================================
--	Update view of
--	========================================================================

--	drop view			garland.temp_view1;

	create or replace view	garland.temp_view1
(
		 rec_key

		,addr_name
		,addr_type
		,addr_pfx
		,addr_sfx
		,addr_num

		,addr_code1
		,addr_unit1

		,parcel_id
		,address_id
		,verify_code

)
	as select	

		 XXX

		,addr_name
		,addr_type
		,addr_pfx
		,addr_sfx
		,addr_num

		,addr_code1
		,addr_unit1

		,parcel_id
		,address_id
		,verify_code

	from 	garland.XXXX;

--	====================================================================

