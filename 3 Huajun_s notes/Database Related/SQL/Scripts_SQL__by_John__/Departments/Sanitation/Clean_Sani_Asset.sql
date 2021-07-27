


	update	sani_asset
	set		addr_type = ' '
	where		addr_type is null;


	update	sani_asset
	set		addr_pfx = ' '
	where		addr_pfx is null;

	commit;