	set echo 	off;

/*
	Excel Format:
		Loc. #,Asset #,Set dt,Type,%,ROUTE,MULT,	
		M,T,W,R,F,S,Su,
		Sizes,Can #,Owner,Business,
		St #,Pfx,Street Name,Sfx,Addr ID,Range,City

	\\excel\sani_assets_aug2002.xls
*/


	create or replace	view	sani_asset_view
(
	location_no,
	asset_no,
	set_date,
	asset_type,
	percentage,
	parcel_id,						--	replaces route
	multiplier,
	mon, tue, wed, thu, fri, sat, sun,
	sizes,
	container_no,
	owned,
	business,
	addr_num,
	addr_pfx,
	addr_name,
	addr_sfx,
	addr_code,
	addr_unit
--	city
)
	as

	select	item01, item02, item03, item04, item05, item06, item07, item08, item09, item10,
			item11, item12, item13, item14, item15, item16, item17, item18, item19, item20,
			item21, item22, item23, item24
	from		gis_temp3;

	
	set echo 	on;



