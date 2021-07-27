	set echo off;
--	=============================================================
	
--	desc user_object_size;

--	=============================================================

	select * 
	from	user_object_size
	where name in 
( 

	'FIND_ADDRESS',  			-- 14,000
	'FIND_STREET_NAME',


	'COMPARE_NAMES',  		--  3.900
	'FUZZY_MATCH',	  		-- 

	'ADR_FIND_01',			-- 
	'ADR_FINDER_01',			-- 16,200

--	'NIRANJAN',				-- 11,200
--	'NIRANJAN_UTLS',

	null
);


--	=============================================================

	select name, sum(code_size) "size"
	from	user_object_size
	where name in 
( 
	'FIND_ADDRESS',  			
	'FIND_STREET_NAME',

	'COMPARE_NAMES',  
	'FUZZY_MATCH',	  

	'ADR_FINDER_01',			
	'ADR_FIND_01',			

--	'NIRANJAN',				
--	'NIRANJAN_UTLS',

	null
)
	group by name;

--	=============================================================
	set echo on;
