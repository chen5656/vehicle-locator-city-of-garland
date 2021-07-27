
--	====================================================================
--	Show Unit Counts	(GIS TAX UMS)

	select count(rtrim(addr_unit))	from JDEACUTIS.Common_GIS;

	select count(rtrim(tax_addr_unit))	from Common_TAX;

	select count(rtrim(addr_unit))	from Common_UMS;

--	====================================================================
--	Show Unit Samples	(GIS TAX UMS)

	select addr_bldg, addr_unit	
	from  garland.Common_GIS
	where	tax_addr_unit > '0'
--	and	tax_addr_bldg > '0'
	and	rownum < 11;

	select tax_addr_bldg, tax_addr_unit	
	from  garland.Common_TAX
	where	tax_addr_unit > '0'
--	and	tax_addr_bldg > '0'
	and	rownum < 11;

	select addr_bldg, addr_unit	
	from  garland.Common_UMS
	where	tax_addr_unit > '0'
--	and	tax_addr_bldg > '0'
	and	rownum < 11;

--	====================================================================
--	ADRRESULT

--	TAX UNITS

	select addr_unit1, form_unit1, form_unit2  
	from adrResult_Tax_GDS
	where	rownum < 22
	and	addr_unit1 > '0'
	;



--	UMS UNITS

	select addr_code1, addr_unit1, addr_unit2
	from adrResult_UMS_Location
	where	rownum < 22

	and	rtrim(addr_unit1) is not null

	and (	translate (rtrim(addr_unit1), '/ 0123456789', '/') is null
	or	length(rtrim(addr_unit1)) = 1	)
	;

--	====================================================================



