
	create or replace view  garland.Temp_View		AS
(
	select
		item01	extension,		
		item02	phone,		
		item03	addrnum,	
		item04	addrpfx,	
		item05	addrname,	
--		item06	addrtype,	
		item07	addrsfx,	
		item08	city,		
		item09	state,		
		item10	addrunit,		
		item11	customer,	
		item12	source,
		item17	junk01,	
		item18	junk02,	
		item19	junk03,	
		item21	junk11,	
		item22	junk12,	
		item23	junk13,	
		item24	junk14,	
		item25	junk15,	
		item26	junk16,	
		item27	junk17,	
		item28	junk18,	
		item29	junk19,	
		item31	junk21,	
		item32	junk22,	
		item33	junk23	

	from	garland.GIS_Objects
);
