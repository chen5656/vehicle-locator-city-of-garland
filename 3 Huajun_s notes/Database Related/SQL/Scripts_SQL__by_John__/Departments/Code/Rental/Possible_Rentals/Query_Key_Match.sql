	set echo off;
--	=================================================================================

	select

		lpad(count(*),05)									"TOTAL",

--		' ' " ",

		rpad(decode (sign(KNOWN),	1, 'KNOWN', ' '),		15)		KNOWN,
		rpad(decode (sign(DCAD),	1, 'DCAD',  ' '),		15)		DCAD,
		rpad(decode (sign(SECTION8),	1, 'SECTION8',  ' '),	15)		SECTION8,
		rpad(decode (sign(HOMESTEAD),	1, 'HOMESTEAD', ' '),	15)		HOMESTEAD,
		rpad(decode (sign(ADDRESS_ID),1, 'VERIFY', ' '),	15)		VERIFY
													

	from		garland.Temp_View1

	group by
		rpad(decode (sign(KNOWN),	1, 'KNOWN', ' '),		15),
		rpad(decode (sign(DCAD),	1, 'DCAD',  ' '),		15),
		rpad(decode (sign(SECTION8),	1, 'SECTION8',  ' '),	15),
		rpad(decode (sign(HOMESTEAD),	1, 'HOMESTEAD', ' '),	15),
		rpad(decode (sign(ADDRESS_ID),1, 'VERIFY', ' '),	15)

	order by	1 desc, 2 desc, 3 desc, 4 desc, 5 desc;

--	=================================================================================

	select 'INPUT' " ",	
	count( decode(source, 'KNOWN',	1,null))	KNOWN,
	count( decode(source, 'DCAD',		1,null))	DCAD,
	count( decode(source, 'SECTION8',	1,null))	SECTION8,
	count( decode(source, 'HOMESTEAD',	1,null))	HOMESTEAD,
	count(*)							TOTAL
	from garland.Temp_View;

--	=================================================================================

	select count(*) 	known		from garland.Temp_View1	where known > '0';
	select count(*) 	possible	from garland.Temp_View1	where known = '0';
	select count(*) 	total		from garland.Temp_View1;

--	=================================================================================
	set echo on;
