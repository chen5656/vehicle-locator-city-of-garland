
--	display "dime" listing

--	desc trvehrcl;

	set echo		off;
	set fetchrows;

	select
			addr_pfx			pf,
			addr_name			street,
			addr_type			type,
			rpad(addr_sfx,5)		sf,

			rpad (
			rpad(addr_left_from, sign(abs(mod(addr_left_from,2) -1)) * 5)	||
			rpad(addr_rght_from, sign(abs(mod(addr_rght_from,2) -1)) * 5)
			,05)											low, 

			rpad (
			rpad(addr_left_to, sign(abs(mod(addr_left_to,2) -1)) * 5)		||
			rpad(addr_rght_to, sign(abs(mod(addr_rght_to,2) -1)) * 5)
			,10)											high, 

			rpad (
			rpad(addr_left_from, sign(abs(mod(addr_left_from,2) )) * 5)		||
			rpad(addr_rght_from, sign(abs(mod(addr_rght_from,2) )) * 5)
			,05)											" ", 

			rpad (
			rpad(addr_left_to, sign(abs(mod(addr_left_to,2) )) * 5)		||
			rpad(addr_rght_to, sign(abs(mod(addr_rght_to,2) )) * 5)		
			,05)											" "

	from		trvehrcl
	where		addr_name > ' '
	and		rtrim(nvl(addr_left_to, 9999)) not like '9999%' 


	union
	select
			addr_pfx			pf,
			addr_name			street,
			addr_type			type,
			rpad(addr_sfx,5)		sf,

			rpad (addr_lo, 05)		lo,
			rpad (' ' ,10)			" ", 

			rpad (addr_hi, 05)		" ",
			rpad (' ' ,10)			" " 

	from		trvehrcl
	where		addr_name > ' '
	and		rtrim(nvl(addr_left_to, 9999)) like '9999%' 

	order by	street,
			type,
			pf,
			sf,
			low;
	
	set echo on;







