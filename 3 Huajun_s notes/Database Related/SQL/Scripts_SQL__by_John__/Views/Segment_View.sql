
	create or replace view		segment_view
	(
		addr_lo,
		addr_hi,
		addr_pfx,
		addr_name,
		addr_type,
		addr_sfx
	)

	as	select	

		addr_lo,
		addr_hi,
		addr_pfx,
		addr_name,
		addr_type,
		addr_sfx

		from		trvehrcl;


	



