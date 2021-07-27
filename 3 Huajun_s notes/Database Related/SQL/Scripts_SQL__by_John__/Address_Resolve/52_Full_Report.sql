
--	------------------------------------------------------------------------------------------
--	C A U T I O N 

--	drop   synonym	garland.adrResult;
--	create synonym	garland.adrResult		for garland.GIS_VERIFY_ADDR;
--	create synonym	garland.adrResult		for garland.adrResult_TAX_GDS		;

--	C A U T I O N 
--	------------------------------------------------------------------------------------------
 
	@c:\deacutis\scripts\address_resolve\50_Base_Report.sql;

	@c:\deacutis\scripts\address_resolve\51_Name_Report.sql;


--	@c:\deacutis\scripts\address_resolve\reports\quality_control\QC_Parse_Sample.sql;

	@c:\deacutis\scripts\address_resolve\reports\quality_control\QC_Street_Sample.sql;


--	@c:\deacutis\scripts\address_resolve\Parse_Refine_Display.sql;

--	------------------------------------------------------------------------------------------
--	C A U T I O N 

--	drop   synonym	garland.adrResult;
--	create synonym	garland.adrResult		for garland.GIS_VERIFY_ADDR;

--	C A U T I O N 
--	------------------------------------------------------------------------------------------
