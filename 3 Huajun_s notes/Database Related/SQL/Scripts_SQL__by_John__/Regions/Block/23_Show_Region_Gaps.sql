
--	show all block side gaps for a particular region


	select	addr_block " ", addr_pfx " ", addr_name " ", addr_type " ", addr_sfx " ", 
			addr_parity " ", lpad(region_type,10) " "
	from		garland.block_region_view
	where		nvl(rtrim(region_id),' ') <= empty_id;

