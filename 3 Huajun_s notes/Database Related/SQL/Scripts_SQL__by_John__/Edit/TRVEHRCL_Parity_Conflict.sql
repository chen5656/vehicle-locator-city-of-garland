	set echo off;

--	display address range problems in trvehrcl
--	choose problem filter & include it in main query

--	======================================================================================
	select 

	'conflicting parities ' 	" ",

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
--	'conflicting parities ' 	" ",

	and (	mod(addr_left_from,2) in ( mod(addr_rght_from,2),  mod(addr_rght_to,2) )
	or	mod(addr_left_to,  2) in ( mod(addr_rght_from,2),  mod(addr_rght_to,2) )	
	or 	mod(addr_left_from,2) <> mod(addr_left_to,2)
	or	mod(addr_rght_from,2) <> mod(addr_rght_to,2)	)

--	valid conflicts
--		2900 		CANIS		CIR
--		2800		CAPELLA	CIR
--		2800 		URSA		CIR
--		700		VALIANT	CIR
--		600 - 2900	SANDERS	DR


