	set echo off;
--	===============================================================
--	adrResult_Source = adrResult_User
--	===============================================================

	create or replace	view	garland.adrResult_Source
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
		verify_code,
		do_parse,
		do_alias,
		do_name,
		do_qual,
		rec_seq,
		rec_rowid,
		rec_key,
		parcel_id,
		segment_id,
		form_pfx,	
		form_name,	
		form_type,	
		form_sfx,
		form_code1,
		form_unit1,
		form_code2,
		form_unit2,
		appl_pfx,	
		appl_name,	
		appl_type,	
		appl_sfx,
		appl_code1,
		appl_unit1,
		appl_code2,
		appl_unit2,
		appl_num,
		alias_score,
		name_score,
		qual_score
	)
	as
	select
		null,						
		null, null, null, null, null, null, null, null,	
		null, null, null, null, null,			
		0,						
		rec_rowid,					
		rec_key,					
		null, null, 					
		null, null, null, null, null, null, null, null,	
		addr_pfx,					
		addr_name,
		addr_type,
		addr_sfx,
		addr_code1,
		addr_unit1,
		addr_code2,
		addr_unit2,
		addr_num,	
		null, null, null
	from	garland.adrResult_User;

--	===============================================================



