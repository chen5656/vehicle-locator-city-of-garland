
	create or replace view	Address_Unit_Region	as

	select	u.addr_num,
			u.addr_pfx,
			u.addr_name,
			u.addr_type,
			u.addr_sfx,

			u.addr_bldg1,
			u.addr_unit1,
			u.addr_bldg2,
			u.addr_unit2,

			u.x_coord,
			u.y_coord,
			u.parcel_id,

			p.tax_acct,
			p.subdiv_id,
			p.council_id,
			p.police_beat,
			p.zip_code,
			p.code_inspect_area,
			p.fire_district

	from		address_unit	u,
			cdreladr		a,
			cdrelpar		p

	where		a.parcel_id		= p.parcel_id

	and		a.addr_name		= u.addr_name
	and		a.addr_type		= u.addr_type
	and		a.addr_pfx		= u.addr_pfx
	and		a.addr_sfx		= u.addr_sfx
	and		a.addr_num		= u.addr_num
	;
	
--	==========================================================================

--	select	'		' || lower(column_name)	||','	" "
--	from		user_tab_columns
--	where		table_name = 'CDRELPAR';

--	==========================================================================
