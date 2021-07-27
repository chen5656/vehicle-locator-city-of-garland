
	==========================================================================
	work flow for creating nsa code inspection file for ODT
	==========================================================================

	x.	Extract NSA_CODE_INSPECT = Inspection (+) CodeAddr & Code_Violation

	x.	Extract adrResult = NSA_CODE_INSPECT
		(using Address_Resolve package)

	x.	Update NSA_CODE_INSPECT		w/ adrResult

	x.	Extract NSA_CODE_CITATION = Citation

	x.	Update NSA_CODE_INSPECT		w/ NSA_CODE_CITATION

	x.	Update NSA_CODE_INSPECT		w/ CDRELPAR.subdivision
		( c:\deacutis\scripts\regions\subdivision\Assign_Addr_Subdiv.sql)


	x.	Build ASCII for loading into Excel = NSA_CODE_INSPECT 

	x.	Archive NSA_CODE_INSPECT_yyyy	= NSA_CODE_INSPECT

	================================================
	================================================
