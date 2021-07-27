	set echo	off;
	set timing	off;

	select '*** build App Adr View ***  ' " ", to_char(sysdate, 'mm-dd-yyyy hh24:mi:ss') " "	from dual;

--	=========================================================================================================

--	IMPORTANT

--	These views are actually executed from \\Address_Resolve\Jobs\001_Table_View.sql

--	This document is merely a backup listing

--	=========================================================================================================

	drop synonym	adrResult;
	create synonym	adrResult	for gis_verify_addr;

--	=========================================================================================================

	@c:\deacutis\scripts\address_resolve\views\vw_Tax_Commercial.sql;		--	TAX Commercial

--	=========================================================================================================
/*

	@c:\deacutis\scripts\address_resolve\views\vw_UMS_Location.sql;		--	UMS Location

	@c:\deacutis\scripts\address_resolve\views\vw_Bldg_Permit.sql;		--	building inspection

	@c:\deacutis\scripts\address_resolve\views\vw_Library.sql;			--	library

	analyze table	garland.animal_control_log	compute statistics;
	@c:\deacutis\scripts\address_resolve\views\vw_Animal_Control.sql;		--	animal control

	analyze table	garland.nsa_code_inspect	compute statistics;
	@c:\deacutis\scripts\address_resolve\views\vw_Code_Inspect.sql;		--	code inspect

	analyze table	jdeacutis.codeaddr	compute statistics;
	@c:\deacutis\scripts\address_resolve\views\vw_CodeAddr.sql;			--	code address

	@c:\deacutis\scripts\address_resolve\views\vw_Code_Rental.sql;		--	code rental

	analyze table	garland.gis_objects		compute statistics;
	@c:\deacutis\scripts\address_resolve\views\vw_Esri_Tax.sql;			--	esri tax

	analyze table	garland.gis_objects	compute statistics;
	@c:\deacutis\scripts\address_resolve\views\vw_DCAD.sql;			--	DCAD

	analyze table	garland.gis_objects	compute statistics;
	@c:\deacutis\scripts\address_resolve\views\vw_MLS.sql;			--	MLS

	analyze table	garland.gis_temp4		compute statistics;
	@c:\deacutis\scripts\address_resolve\views\vw_Water_Meter.sql;		--	water meter

	@c:\deacutis\scripts\address_resolve\views\vw_Nsa_Crime.sql;		--	nsa crime

	@c:\deacutis\scripts\address_resolve\views\vw_RMS_Lomain.sql;		--	police rms

	analyze table	garland.sani_commercial		compute statistics;
	@c:\deacutis\scripts\address_resolve\views\vw_Sani_Commercial.sql;	--	sanitation commercial

	analyze table	garland.sani_asset		compute statistics;
	@c:\deacutis\scripts\address_resolve\views\vw_Sani_Asset.sql;		--	sanitation asset


	@c:\deacutis\scripts\address_resolve\views\vw_Multi_Family.sql;		--	Multi-Family


	@c:\deacutis\scripts\address_resolve\views\vw_GIS_Objects.sql;		--	gis objects

	@c:\deacutis\scripts\address_resolve\views\vw_GIS_Verify_Addr.sql;	--	gis verify

*/
--	=========================================================================================================





