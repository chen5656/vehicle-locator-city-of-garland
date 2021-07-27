	set linesize 2000;
	set pagesize 200;
--	===============================================================================	
--	Review DCAD Initials output results before extracting
--	===============================================================================	
	
	select 	account, owner_name,
		rtrim(
		substr(owner_name, instr(owner_name||' ', ' ') + 01, 01) 	||
		substr(owner_name, 01,01))
	from	garland.Temp_View
	where(	instr(owner_name||' ',' OF ') <> instr(owner_name||' ',' ') 
	and	instr(owner_name||' ',' AT ') <> instr(owner_name||' ',' ') 
	)
	and	rownum < 11		--  T E M P O R A R Y 
	; 

--	=============================================================================== 
	select 	account, owner_name,
		rtrim(
		substr(owner_name, 01,01) 					||
		substr(owner_name, instr(owner_name||' ', ' ',01,02) + 01, 01) 	||
		substr(owner_name, instr(owner_name||'  ',' ',01,03) + 01, 01)),
		' '
	from	garland.Temp_View
	where(	instr(owner_name||' ',' OF ') = instr(owner_name||' ',' ') 
	or	instr(owner_name||' ',' AT ') = instr(owner_name||' ',' ') 
	)
	and	rownum < 111		--  T E M P O R A R Y 
	;

--	=============================================================================== 