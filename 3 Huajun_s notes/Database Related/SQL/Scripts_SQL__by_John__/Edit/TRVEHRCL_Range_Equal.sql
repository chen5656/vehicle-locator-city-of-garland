	set echo off;

--	display address range problems in trvehrcl
--	choose problem filter & include it in main query

--	======================================================================================
	select 

	'equal range boundaries ' 	" ",

		' at mslink = ' || rpad(mslink,05) || 
		'   branch = '  || branch_no || ' section = ' || section_no	" "

		,chr(10),'street    = ', addr_pfx "pf", rpad(addr_name,15) "name", addr_type "type", addr_sfx "sf" 

		,chr(10),'actual LR = ', addr_left_from "ll", addr_left_to "lh", addr_rght_from "rl", addr_rght_to "rh"

		,chr(10),'potential = ', addr_lo "lo", addr_hi "hi"

		,chr(10)

	from	trvehrcl
	where	mslink > 0	

	and	addr_lo < 9999
	and	addr_hi < 9999

	and	nvl(addr_name,' ') > '0'
	and	nvl(addr_left_from,0) + nvl(addr_left_to,0) + nvl(addr_rght_from,0) + nvl(addr_rght_to,0) > 0

--	===========================================================
--	'equal range boundaries ' 	" ",

	and (	addr_left_from	= addr_rght_from
	or	addr_left_to	= addr_rght_to	)

--	-------------------------------------------------
;


