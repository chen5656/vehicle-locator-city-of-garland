	set echo off;

--	display procedure, function, and package compile errors

	select
		 	rpad (name,24)			"object name",
			type					"object type",
			lpad (line,04)			"line",
			text					"text 1",	 
			substr(text, 081, 80)		"text 2" 

	from 		ALL_errors

	where		name =  'RESOLVE_ADDRESS' 

--	where		name =  'TEST_PKG' 

	and		owner = 'GARLAND'
	;

	
	set echo on;
