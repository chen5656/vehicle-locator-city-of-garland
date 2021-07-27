

--	create or replace view	ADR_parse_test_vw

	create or replace view	TST_parse_test_vw


	(key, addr_num,	addr_pfx,	addr_name,	addr_type,	addr_sfx, 
		addr_code1, addr_unit1, addr_code2, addr_unit2,
		note,		addr_audit, note_audit )

	as select	

	item01,item02,item03,item04,item05,item06,
	item07,item08,item09,item10,	
	item11,item12,item13

	from	gis_objects;		
