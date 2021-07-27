	set echo off;

--	display procedure, function, and package compile errors

	select
		 	rpad (name,24)			"object name",
			type					"object type",
			lpad (line,04)			"line",
			text					"text 1",	 
			substr(text, 081, 80)		"text 2" 
	from 		user_errors

	where		name =  'ASSIGN_UTILITY_NUM' 
	;

	
	set echo on;


 