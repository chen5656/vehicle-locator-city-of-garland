	set echo	off;
--	=============================================================
--	show sample of adrAlias
--	sort by method
--	=============================================================
/*

	select	alias_how				" ",	
			rpad(alias_reduced,	20)	" ",
			rpad(alias_compact,	20)	" ",
			rpad(alias_compress,	20)	" ",
			chr(10)				" ",

			rpad(alias_pfx, 		02)	" ",	
			rpad(alias_name,		20)	" ", 
			rpad(alias_type,		04)	" ", 
			rpad(alias_sfx, 		02)	" ",	
			chr(10)				" ",

			rpad(nvl(addr_pfx, ' '),02)	" ", 
			rpad(addr_name,		20)	" ",	
			rpad(nvl(addr_type,' '),04)	" ", 
			rpad(nvl(addr_sfx, ' '),02)	" ",
			chr(10)				" "

		
	from		adralias
	where		alias_how > 'a'
	and		rowid in
(
	select	min(rowid)
	from		adrAlias
	group by	alias_how		

	union

	select	max(rowid)
	from		adrAlias
	group by	alias_how		
)
	order by	1,2;

*/

--	=================================================================

	select
--		chr(10)				" "
		rpad(alias_how,40)		" ",	
		lpad(alias_lo, 06)		" ",	
		lpad(alias_hi, 06)		" ",	
		lpad(addr_min, 08)		" ",	

		chr(10)				" ",
		rpad(alias_pfx, 		02)	" ",	
		rpad(alias_name,		20)	" ", 
		rpad(alias_type,		04)	" ", 
		rpad(alias_sfx, 		02)	" ",	

		chr(10)				" ",
		rpad(nvl(addr_pfx, ' '),02)	" ", 
		rpad(addr_name,		20)	" ",	
		rpad(nvl(addr_type,' '),04)	" ", 
		rpad(nvl(addr_sfx, ' '),02)	" ",

--		chr(10)				" ",
--		rpad(nvl(' ', ' '),	02)	" ", 
--		rpad(alias_reduced,	20)	" ",
--		rpad(alias_compact,	20)	" ",
--		rpad(alias_compress,	20)	" ",

		' '					" "

	from		adrAlias

	where		alias_how > 'a'
	and		alias_how not in ( 'asis', 'tpush', 'tpull')

	order by	alias_how, rpad(alias_name, 20);

--	=================================================================
	
	set echo	on;
