
--	show parsed (form_) & final (addr_)

	create or replace view	adrResult_Part_vw
	(
		addr_num,	
		addr_pfx,	
		addr_name,	
		addr_type,	
		addr_sfx,	

		addr_code1,	
		addr_unit1,	
		addr_code2,	
		addr_unit2,	

		form_pfx,	
		form_name,	
		form_type,	
		form_sfx,	

		form_code1,	
		form_unit1,	
		form_code2,	
		form_unit2,	

		appl_num,
		appl_pfx,	
		appl_name,	
		appl_type,	
		appl_sfx,	

		appl_code1,
		appl_unit1,	
		appl_code2,	
		appl_unit2,	

		verify_code,	
		do_parse,	
		do_alias,	
		do_name,	
		do_qual,	
		rec_seq,	
		rec_key,

		spec_verify,
		spec_parse,
		spec_alias,
		spec_name,
		spec_qual,
		spec_seq,
		spec_key
	)
	as
	select
		addr_num,	
		addr_pfx,	
		addr_name,	
		addr_type,	
		addr_sfx,	
		null, null, null, null,

		form_pfx,	
		form_name,	
		form_type,	
		form_sfx,	
		null, null, null, null,

		null, null, null, null, null, 		--	appl addr
		null, null, null, null,				--	appl unit

		verify_code,	
		do_parse,	
		do_alias,	
		do_name,	
		do_qual,	
		rec_seq,	
		rec_key,	

		null, null, null, null, null,			--	verify,parse,alias,name,qual
		null, null						--	seq,key

		from	garland.adrResult;

