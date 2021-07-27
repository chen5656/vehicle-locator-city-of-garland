	set 	echo		off;
--	set	fetchrows;

--	ad hoc query of TRVEHRCL 
--	===============================================================================

	select
			addr_pfx " ", addr_name "street", addr_type " ", addr_sfx " ",
			addr_left_from	"      left",		
			addr_left_to	" ", 
			addr_rght_from	"     right",		
			addr_rght_to	" ",
			addr_lo 		"      low",	
			addr_hi 		"      high"

			,chr(10) " "	,'  msl = '|| mslink  ||'  br.sec = '|| branch_no  ||' '|| section_no " "

	from		trvehrcl

	where		mslink = 238

	and		branch_no < 9999

	;


--	set	fetchrows;
