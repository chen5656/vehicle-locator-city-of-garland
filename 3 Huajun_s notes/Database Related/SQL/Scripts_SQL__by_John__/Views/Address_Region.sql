
	create or replace view	Address_Region	as

	select	a.addr_num,
			a.addr_pfx,
			a.addr_name,
			a.addr_type,
			a.addr_sfx,
			a.unit_type,
			a.unit_num,

			a.x_coord,
			a.y_coord,
			p.parcel_id,

			p.tax_acct,
			p.subdiv_id,
			p.council_id,
			p.police_beat,
			p.zip_code,
			p.code_inspect_area,
			p.fire_district

	from		cdreladr		a,
			cdrelpar		p
	where		a.parcel_id		= p.parcel_id;
	
--	==========================================================================

--	select	'		' || lower(column_name)	||','	" "
--	from		user_tab_columns
--	where		table_name = 'CDRELPAR';

--	==========================================================================
