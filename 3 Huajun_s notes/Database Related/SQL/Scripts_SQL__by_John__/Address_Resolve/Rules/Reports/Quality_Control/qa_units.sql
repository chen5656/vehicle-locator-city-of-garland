

	select distinct	
		rpad(addr_code1,10) " ", 
		rpad(addr_unit1,10) " ", 
		rpad(addr_code2,10) " ", 
		rpad(addr_unit2,10) " "
	from	garland.adrResult;