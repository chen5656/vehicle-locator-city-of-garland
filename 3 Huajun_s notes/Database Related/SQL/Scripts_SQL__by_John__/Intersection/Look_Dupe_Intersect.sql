	set echo 	off;

	select	' ' ||
			rpad(node_id,     14)	" ",
			rpad(intersect_id,14)	" ",
			chr(10)			" ",

			rpad(terminal1,  05)	" ", 
			rpad(addr1_block,05)	" ", 
			rpad(addr1_pfx,  02)	" ",
			rpad(addr1_name, 20)	" ",
			rpad(addr1_type, 04)	" ",
			rpad(addr1_sfx,  02)	" ",
			lpad(segment1_id,10)	" ", 
			chr(10)			" ",

			rpad(terminal2,  05)	" ", 
			rpad(addr2_block,05)	" ", 
			rpad(addr2_pfx,  02)	" ",
			rpad(addr2_name, 20)	" ",
			rpad(addr2_type, 04)	" ",
			rpad(addr2_sfx,  02)	" ",
			lpad(segment2_id,10)	" ", 
			chr(10)			" "
		

	from		dupe_intersect

	where		addr1_name =	'ABERDEEN'
	and		addr2_name = 	'TARTAN'

--	where		addr1_name =	'ANGELINA'
--	and		addr2_name = 	'NUECES'

	;

