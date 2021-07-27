
--	Parcel Update view

	create or replace view 		tmp_view1 
	(	parcel_id, mslink, region	)

	as	select 
		parcel_id, 
		mslink,	

		CODE_INSPECT_AREA 

	from	cdrelpar;



--	adrBLOCK view

	create or replace view		tmp_view
(		addr_name, addr_type, addr_pfx, addr_sfx, addr_block, addr_parity,
		region_id
)
	as select
		addr_name, addr_type, addr_pfx, addr_sfx, addr_block, addr_parity,
		CODE_INSPECT_AREA

	from adrBlock_Side;

