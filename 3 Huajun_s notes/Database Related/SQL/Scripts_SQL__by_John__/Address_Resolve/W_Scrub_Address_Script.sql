

declare

	do_compile		number := 01;

	adr_num		varchar2(20);
	adr_pfx		varchar2(20);
	adr_name		varchar2(40);
	adr_type		varchar2(20);
	adr_sfx		varchar2(20);
	adr_bldg1		varchar2(20);
	adr_unit1		varchar2(20);
	adr_bldg2		varchar2(20);
	adr_unit2		varchar2(20);

	form_pfx		varchar2(20);
	form_name		varchar2(40);
	form_type		varchar2(20);
	form_sfx		varchar2(20);
	form_bldg1		varchar2(20);
	form_unit1		varchar2(20);
	form_bldg2		varchar2(20);
	form_unit2		varchar2(20);

	verify_code	number;
	gis_key	varchar2(20);
	audit		varchar2(80);

	spec1		number;
	spec2		number;
	spec3		number;
	spec4		varchar2(20);
	spec5		varchar2(20);

--	===============================================================
	cursor	Read_Address		is

	select

			ITEM01	user_key,

			null		addr_num, 
			ITEM02	addr_pfx, 
			ITEM03	addr_name, 
			ITEM04	addr_type, 
			null		addr_sfx,

			null		addr_bldg1, 
			null		addr_unit1, 
			null		addr_bldg2, 
			null		addr_unit2

	from		garland.GIS_OBJECTS;


--	===============================================================

begin

	if	do_compile > 0		then
		return;
	end if;


for look in	read_address		loop


	garland.Resolve_Address.Query_Driver 

	(
		look.addr_num,	look.addr_pfx,	look.addr_name,	look.addr_type,	look.addr_sfx,
		look.addr_bldg1,	look.addr_unit1,	look.addr_bldg2,	look.addr_unit2,

		form_pfx,	form_name,	form_type,	form_sfx,
		form_bldg1,	form_unit1,	form_bldg2,	form_unit2,

		verify_code, gis_key,	 audit,		

		spec1, spec2, spec3, spec4, spec5


--		addr_num,	 addr_pfx,	 addr_name,	 addr_type,	addr_sfx,	
--		addr_code1,	 addr_unit1, addr_code2, addr_unit2,	
--				 form_pfx,	 form_name,	 form_type,	form_sfx,	
--		form_code1,	 form_unit1, form_code2, form_unit2,	
--		verify_code, gis_key,	 audit,		
--		spec_insert, spec_seq, 
--		spec_trace,  spec_show, spec_focus	
	);


end loop;


end;