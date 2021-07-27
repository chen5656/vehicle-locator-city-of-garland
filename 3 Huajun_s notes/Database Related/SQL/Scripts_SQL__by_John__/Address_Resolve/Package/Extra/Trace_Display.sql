
--	===========================================
--	display trace information on gis_objects
--	===========================================


	select	item02 " " 											-- track data
			,rpad(item01,09) " " 									-- sequence
--			,rpad(item03,08) " " ,rpad(item04,08) " " ,rpad(item05,08) " "		-- who,what1,what2
	from		gis_objects
	where		item01 like 'data%';

--	-----------------------------------------------------------------------------------------------------------


	select	item02 " " 					-- trace flow			
			,rpad(item01,09) " " 			-- sequence
	from		gis_objects
	where		item01 like 'flow%';

--	-----------------------------------------------------------------------------------------------------------