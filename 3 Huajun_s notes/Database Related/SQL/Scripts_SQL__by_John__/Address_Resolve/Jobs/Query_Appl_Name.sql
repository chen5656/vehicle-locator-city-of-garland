
	select 
		rpad(appl_name,20)					name, 
		length(appl_name)						length, 
		translate(garland.string_cleaner(appl_name),' ','_')	cleaner
	from	garland.adrResult
	where	appl_unit2 = 'HOMESTEAD'
	and rownum < 11
	;