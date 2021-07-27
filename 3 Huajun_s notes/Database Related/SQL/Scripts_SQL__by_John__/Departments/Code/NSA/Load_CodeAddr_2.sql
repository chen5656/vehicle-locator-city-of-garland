--	=========================================================
--	build nsa_codeaddr_full
--	=========================================================

	truncate table	jdeacutis.nsa_codeaddr_full	reuse storage;

	alter rollback segment	rb1	online;
	set transaction use rollback segment rb1;


	insert into	jdeacutis.nsa_codeaddr_full

	select	address_number,
			address_prefix,
			address_name,
			address_type,
			address_suffix,
			address_sullp_type,		
			address_suppl#,		

			null,					--	verify code
			null,					--	parcel id
			null,					--	segment id
			council_district,
			null,					--	subdivision
			null,					--	inspect area
			addr_id

	from		codeaddr@cdep.world
	;

	commit;
	alter rollback segment	rb1	offline;

