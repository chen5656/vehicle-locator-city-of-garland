
--	view of streets having the only occurrence of a street name


	create or replace view	unique_street	as

	select	addr_pfx,
			addr_name,
			addr_type,
			addr_sfx
	from		adrstreet
	where		addr_name		in
	(
		select	addr_name
		from		adrstreet
		group by	addr_name
		having	count(*) = 1
	);


