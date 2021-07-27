	set echo	off;

	select	

		lpad(count(*),1)				"#",	

		min(lpad(node_id,08))			"    Node",	
		max(lpad(node_id,05))			" ",	

		min(lpad(intersect_type,08))		"      ID",
		max(lpad(intersect_type,02))		" ",

		lpad(addr1_block,08)			"  Block1", 
		rpad(addr1_pfx,  02)			" ", 
		rpad(addr1_name, 20)			"Street1", 
		rpad(addr1_type, 04)			" ", 
		rpad(addr1_sfx,  02)			" ", 

		lpad(addr2_block,08)			"  Block2", 
		rpad(addr2_pfx,  02)			" ", 
		rpad(addr2_name, 20)			"Street2", 
		rpad(addr2_type, 04)			" ", 
		rpad(addr2_sfx,  02)			" " 

	from	intersection

	group by	addr1_name, addr1_type, addr1_pfx, addr1_sfx, addr1_block, 
			addr2_name, addr2_type, addr2_pfx, addr2_sfx, addr2_block
	having	count(*) > 1;


	set echo	on;
