
--		display procedure, function, and package compile errors

	set echo on;

	select
		 	rpad (name,24)			"object name",
			type					"object type",
			lpad (line,04)			"line",
			text					"text 1",	 
			substr(text, 081, 80)		"text 2" 

--			substr(text, 161, 80)		"text 3"

	from 		user_errors

--	where		name = upper ( 'TST_PARSE_ADDRESS' )

--	where		name = upper ( 'ADR_RESOLVE_PARSED_EXIT' )

	where		name = upper ( 'ADR_RESOLVE_UNPARSED_EXIT' )
	;
	
--	===================================================================================

	



