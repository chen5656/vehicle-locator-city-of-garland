	set echo off;	
--	=================================================================================

	create or replace view		garland.Common_Address_Keys	as

	select
			item01		addr_name,
			item02		addr_num,
			item03		addr_type,
			item04		addr_pfx,
			item05		addr_sfx,
			item06		addr_code,		--  APT
			item07		addr_bldg,		--  E
			item08		addr_unit,		--  101

			item11		GIS_key,
			item12		TAX_key,
			item13		UMS_key,
			item14		UNIT_key,
--			item15		CODE_key,		--  SEQ

			item18		GIS_ID,		
			item19		Parcel_ID,
			item20		Source

	from	garland.GIS_Temp1;

--	=================================================================================

	create or replace view		garland.Common_Address_IDS	as

	select
			item01		addr_name,
			item02		addr_num,
			item03		addr_type,
			item04		addr_pfx,
			item05		addr_sfx,
			item06		addr_code,		--  APT
			item07		addr_bldg,		--  E
			item08		addr_unit,		--  101

			item11		GIS_key,
			item12		TAX_key,
			item13		UMS_key,
			item14		UNIT_key,
--			item15		CODE_key,		--  SEQ

			item18		GIS_ID,		
			item19		Parcel_ID,
			item20		Source

	from	garland.GIS_Temp2;

--	=================================================================================

	create or replace view		garland.Common_Archive_Keys		as

	select
			item01		addr_name,
			item02		addr_num,
			item03		addr_type,
			item04		addr_pfx,
			item05		addr_sfx,
			item06		addr_code,		--  APT
			item07		addr_bldg,		--  E
			item08		addr_unit,		--  101

			item11		GIS_key,
			item12		TAX_key,
			item13		UMS_key,
			item14		UNIT_key,
--			item15		CODE_key,		--  SEQ

			item18		GIS_ID,		
			item19		Parcel_ID,
			item20		Source

	from	garland.GIS_Temp3;

--	=================================================================================

