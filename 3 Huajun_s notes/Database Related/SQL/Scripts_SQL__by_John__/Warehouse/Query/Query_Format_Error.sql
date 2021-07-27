	set echo off;
--	====================================================================================
--	display owner formatting errors
--	====================================================================================

	select	rpad(account,12) "Account" 

			,rpad(attn,30) "Attn" 	 ,rpad(name,30) "Name"
			,rpad(strt,30) "ADDRESS" ,rpad(city,15) "City" 

--			,rpad(unit,20) "Unit"

--			,rpad(cast,25) "Cast" ,rpad(error,15) "Error"
	
	from		garland.temp_view1
	where		error > '0';

--	====================================================================================
--	examine input for particular cases

	select * from gds_account 
	where rownum < 	0
	and	account	in 
	(

	0000000330, 0000000366, 0000000477, 0000000621

	);

--	====================================================================================

--	desc temp_view1;

--	====================================================================================
	set echo on;