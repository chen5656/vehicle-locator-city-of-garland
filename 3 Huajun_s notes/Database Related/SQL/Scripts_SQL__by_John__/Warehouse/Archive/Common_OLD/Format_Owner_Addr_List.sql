	set echo off;
    set linesize	2000;
--	==========================================================
--	Show Tax Owner formatting errors
--	==========================================================

	select distinct error from garland.Temp_View1;

--	==========================================================

	select 
		rpad(account,10)		account,
		rpad(attn,   20)		attn,
		rpad(name,   20)		name,
		rpad(unit,   10)		unit,
		rpad(strt,   20)		street,
		rpad(city,   20)		city,
		rpad(state,  02)		state
--		,rpad(error, 10)		error
--		,rpad(cast,  20)		case

	from	garland.Temp_View1

--	where error > '0'
--	where error = 'unknown'
	where error = 'street?'

	and	rownum < 111;

--	==========================================================
--	desc garland.temp_view1
--	==========================================================

