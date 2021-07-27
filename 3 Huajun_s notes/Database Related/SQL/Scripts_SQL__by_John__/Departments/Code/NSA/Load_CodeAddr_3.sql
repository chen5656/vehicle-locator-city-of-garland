--	=========================================================
--	build nsa_codeaddr
--	=========================================================

	truncate table	jdeacutis.nsa_codeaddr	reuse storage;

	alter rollback segment	rb1	online;
	set transaction use rollback segment rb1;

--	truncate table	plan_table;
--	explain plan	set statement_id = 'aaa'	for

	insert into	jdeacutis.nsa_codeaddr

	select	c.addr_num,
			c.addr_pfx,
			c.addr_name,
			c.addr_type,
			c.addr_sfx,
			c.addr_code,		
			c.addr_unit,		

			null,					--	verify code
			null,					--	parcel id
			null,					--	segment id
			council_district,
			null,					--	subdivision
			null,					--	inspect area
			addr_id

	from		nsa_codeaddr_full			c,
			garland.adrResult_codeaddr	r
	where		c.addr_id = r.rec_key;


--	select * from explain_plan;

	commit;
	alter rollback segment	rb1	offline;

