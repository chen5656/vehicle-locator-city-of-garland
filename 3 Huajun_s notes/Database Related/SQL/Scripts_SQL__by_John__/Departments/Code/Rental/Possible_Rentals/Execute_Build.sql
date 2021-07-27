	set echo off;
--	===================================================================================================

--	drop   synonym  garland.adrResult;
--	create synonym  garland.adrResult		for garland.ADRRESULT_EXTRACT;

	@c:\deacutis\scripts\departments\code\rental\possible_rentals\Rental_In_View.sql
	@c:\deacutis\scripts\departments\code\rental\possible_rentals\Rental_View1.sql
	@c:\deacutis\scripts\departments\code\rental\possible_rentals\Rental_View2.sql

	@c:\deacutis\scripts\departments\code\rental\possible_rentals\Prep_Input.sql

--	===================================================================================================

	analyze table	garland.GIS_Temp2		compute statistics;	--  Original Application Data

	truncate table  garland.GIS_Temp1	reuse storage;		-- Merge View1
	truncate table  garland.GIS_Objects reuse storage;		-- Merge View2

	variable	spec_source		varchar2(10);

--	===================================================================================================
--	===================================================================================================

	drop   synonym	garland.Temp_Syn1;
	create synonym	garland.Temp_Syn1			for garland.Temp_View1;		-- input  Syn1

	drop   synonym	garland.Temp_Syn2;
	create synonym	garland.Temp_Syn2			for garland.Temp_View2;		-- output Syn2 

				--	truncate table  garland.GIS_Temp1	reuse storage;	-- View1 
					truncate table  garland.GIS_Objects reuse storage;	-- View2 
	
	execute	:spec_source := 'KNOWN';

	@c:\deacutis\scripts\departments\code\rental\possible_rentals\Merge_Extracts.sql

--	analyze table	garland.GIS_Objects		compute statistics;		-- View2

--	===================================================================================================

	drop   synonym	garland.Temp_Syn1;
	create synonym	garland.Temp_Syn1			for garland.Temp_View2;		-- input  Syn1

	drop   synonym	garland.Temp_Syn2;
	create synonym	garland.Temp_Syn2			for garland.Temp_View1;		-- output Syn2 

				--	truncate table  garland.GIS_Objects reuse storage;	-- View2 
					truncate table  garland.GIS_Temp1	reuse storage;	-- View1 
	
	execute	:spec_source := 'DCAD';

	@c:\deacutis\scripts\departments\code\rental\possible_rentals\Merge_Extracts.sql

	analyze table	garland.GIS_Temp1		compute statistics;		-- View2

--	=================================================================================

	drop   synonym	garland.Temp_Syn1;
	create synonym	garland.Temp_Syn1			for garland.Temp_View1;		-- input  Syn1

	drop   synonym	garland.Temp_Syn2;
	create synonym	garland.Temp_Syn2			for garland.Temp_View2;		-- output Syn2 

				--	truncate table  garland.GIS_Temp1	reuse storage;	-- View1 
					truncate table  garland.GIS_Objects reuse storage;	-- View2 
	
	execute	:spec_source := 'SECTION8';

	@c:\deacutis\scripts\departments\code\rental\possible_rentals\Merge_Extracts.sql

	analyze table	garland.GIS_Objects		compute statistics;		-- View2

--	=================================================================================

	drop   synonym	garland.Temp_Syn1;
	create synonym	garland.Temp_Syn1			for garland.Temp_View2;		-- input  Syn1

	drop   synonym	garland.Temp_Syn2;
	create synonym	garland.Temp_Syn2			for garland.Temp_View1;		-- output Syn2 

				--	truncate table  garland.GIS_Objects reuse storage;	-- View2 
					truncate table  garland.GIS_Temp1	reuse storage;	-- View1 
	
	execute	:spec_source := 'HOMESTEAD';

	@c:\deacutis\scripts\departments\code\rental\possible_rentals\Merge_Extracts.sql

	analyze table	garland.GIS_Temp1		compute statistics;		-- View2

--	=================================================================================
--	=================================================================================

	select
		rpad(	sign(known) || sign(dcad) || sign(section8) || sign(homestead),  30)
								"known dcad section8 homestead",
			count(*)				total
	from		garland.Temp_Syn2
	group by	sign(known) || sign(dcad) || sign(section8) || sign(homestead);



	select count(*) 	known		from garland.Temp_View1	where known > '0';
	select count(*) 	possible	from garland.Temp_View1	where known = '0';


	select 'INPUT' " ",	
	count( decode(source, 'KNOWN',	1,null))	KNOWN,
	count( decode(source, 'DCAD',		1,null))	DCAD,
	count( decode(source, 'SECTION8',	1,null))	SECTION8,
	count( decode(source, 'HOMESTEAD',	1,null))	HOMESTEAD
	from garland.Temp_View;


--	===================================================================================================

--	drop   synonym  garland.adrResult;
--	create synonym  garland.adrResult		for garland.GIS_VERIFY_ADDR;

--	select * from all_synonyms where synonym_name = 'ADRRESULT';

--	===================================================================================================

	set echo on;
