



	insert into	adrBlock
	select	addr_pfx, addr_name, addr_type, addr_sfx, trunc(addr_num,-2), 	null,null,0
	from		cdreladr
	where		addr_num > 0
	minus
	select	addr_pfx, addr_name, addr_type, addr_sfx, addr_block,			null,null,0	
	from		adrBlock;

	commit;

