
	set echo 	off;

--	select count(*)

	select
			' ' ||
			rpad(intersect_id,16)	" ", 
			chr(10)			" ",

			rpad(addr1_block,05)	" ", 
			rpad(addr1_pfx,  02)	" ",
			rpad(addr1_name, 20)	" ",
			rpad(addr1_type, 04)	" ",
			rpad(addr1_sfx,  02)	" ",
			chr(10)			" ",

			rpad(addr2_block,05)	" ", 
			rpad(addr2_pfx,  02)	" ",
			rpad(addr2_name, 20)	" ",
			rpad(addr2_type, 04)	" ",
			rpad(addr2_sfx,  02)	" ",
			chr(10)			" "


	from		dupe_intersect

	order by	intersect_id, addr1_name, addr2_name;

