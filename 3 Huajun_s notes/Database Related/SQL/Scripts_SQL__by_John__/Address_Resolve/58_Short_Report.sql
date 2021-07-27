	set echo off;
--	===========================================================

	select 
		rpad(rec_key,  08)	key,
		lpad(addr_num, 06)	" ", 
		rpad(addr_pfx, 02)	" ", 
		rpad(addr_name,20)	address, 
		rpad(addr_type,04)	" ",
		rpad(addr_sfx, 02)	" ",

		decode ( trunc(verify_code,-1),
			50,		'good number',
			40,		'bad number / good block',
			30,		'bad number / good block',
			20,		'bad number / bad  block',
			10,		'no  number',
			00,		'bad name',
					rpad(' ',30)	)	" ",

		decode ( mod(verify_code,10),
			5,		'good name',
			4,		'partial address',
			3,		'wrong street',
			2,		'inconsistent street',
			1,		'bad street',
					' '	)		" "

	from	garland.adrResult

	where	verify_code < 55

	order by
		rpad(addr_name,20),
		rpad(addr_type,04),
		rpad(addr_pfx, 02),
		lpad(addr_num, 06);

--	===========================================================
	set echo on;



