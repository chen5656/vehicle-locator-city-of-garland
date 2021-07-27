	set echo off;
--	===================================================================================

	select
		 	rpad (name,24)			"object name",
			type					"object type",
			lpad (line,04)			"line",
			text					"text 1",	 
			substr(text, 081, 80)		"text 2" 


	from 		ALL_Errors

	where		name = upper ( 'WATER_PIPE_CLUSTER' )
	;
	
--	===================================================================================

	


