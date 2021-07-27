	set echo	off;	
--	=================================================================================

	create or replace view		garland.Extract1_Address_Keys	as

	select
			item01		addr_name,
			item02		addr_num,
			item03		addr_type,
			item04		addr_pfx,
			item05		addr_sfx,
			item06		addr_code,		--  APT
			item07		addr_bldg,		--  E
			item08		addr_unit,		--  101
			item09		GIS_key,
			item10		TAX_key,
			item11		UMS_key,
			item12		UNIT_key,
			item13		CODE_key,		--  SEQ
			item14		Parcel_ID,
			item15		Source,
			item16		Sequence

	from	garland.GIS_Temp1;

--	=================================================================================

	create or replace view		garland.Extract2_Address_Keys	as

	select
			item01		addr_name,
			item02		addr_num,
			item03		addr_type,
			item04		addr_pfx,
			item05		addr_sfx,
			item06		addr_code,		--  APT
			item07		addr_bldg,		--  E
			item08		addr_unit,		--  101
			item09		GIS_key,
			item10		TAX_key,
			item11		UMS_key,
			item12		UNIT_key,
			item13		CODE_key,		--  SEQ
			item14		Parcel_ID,
			item15		Source,
			item16		Sequence
	from	garland.GIS_Temp2;

--	=================================================================================
	set echo	on;	
