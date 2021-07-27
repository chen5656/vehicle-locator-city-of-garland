
	create or replace view		address_view
	(
		addr_num,
		addr_pfx,
		addr_name,
		addr_type,
		addr_sfx
	)

	as	select	

		addr_num,
		addr_pfx,
		addr_name,
		addr_type,
		addr_sfx

		from		cdreladr;

	


