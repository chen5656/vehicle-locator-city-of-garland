	set echo off;
--	===============================================================================


--	desc cdreladr_audit;
--	select count(*) from cdreladr_audit;

	select

		distinct

		' '

--		||' '|| num_bef  ||' '|| num_aft  

		||' '|| pfx_bef  ||' '|| pfx_aft  

		||' '|| name_bef ||' '|| name_aft 

		||' '|| type_bef ||' '|| type_aft 
		||' '|| sfx_bef  ||' '|| sfx_aft 	

	" "
	from	cdreladr_audit

	where	to_char(timestamp, 'yyyy') = '2004'			-- 635

--	and	action = 'I'						-- 406
--	and	action = 'D'						--  52
	and	action = 'U'						-- 177


--	and 	num_bef || num_aft > rpad(' ',20)			-- 83
--	and 	num_bef || num_aft is null				-- 94


	and 	name_bef || name_aft > rpad(' ',20)			-- 74
--	and 	name_bef || num_aft is null				-- 34


--	and	   pfx_bef  || pfx_aft  || sfx_bef  || sfx_aft 	
--		|| name_bef || name_aft || type_bef || type_aft 
--		 > rpad(' ',40)						-- 108
--		is null							--  69
		

--	update both num & str						--  14	

	;


--	===============================================================================
	set echo on;
