	set echo	off;
--	=============================================

	select 

		STREET,

		decode (instr(rtrim(street),'  '), 
				0, null,
				1,null,
				rtrim(rpad(street,3))	)					BLDG,

		decode (instr(rtrim(street),'  '), 
				0, rtrim(street), 
				1, ltrim(street),  
				ltrim(substr(street, instr(rtrim(street),'  '))))	UNIT

	from garland.tax 
	where rtrim(street) is not null

	and	instr(rtrim(street),'  ') > 1
	and rownum < 111;

--	=============================================
	set echo	on;
