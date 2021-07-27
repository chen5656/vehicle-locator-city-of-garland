	set echo		off;

	spool	c:\deacutis\scripts\address_resolve\reports\Made_Report\A1_Summary.sql;

--	=================================================================================

	select	count(*)		"TOTAL RECS"
	from		garland.adrResult
	where		rec_seq > 0;						-- jan 2004

--	summary by verify id

	select 
		rpad(trunc(verify_code, -1),2,'0')	" ",
		decode (trunc(verify_code, -1),
			00,	'Invalid Name  ',
			10,	'Missing Number',
			20,	'Invalid Block',
			30,	'Invalid Range',
			40,	'Invalid Number',
			50,	'Valid   Number',
				'Unknown'	)	"CATEGORY",
		count(*)					"     Total"
	from 		garland.adrResult
--	where		rec_seq > 1							-- jan 2004
	group by	trunc(verify_code, -1);	

	select 
		lpad(mod(verify_code, 10),2,'0')	" ",
		rpad(decode (mod(verify_code, 10),
			0,	'Unknown',
			1,	'Poor',
			2,	'Mixed',
			3,	'Wrong',
			4,	'Partial',
			5,	'Full',
				'Unknown'), 08)		"CATEGORY",
		count(*)					"     Total"
	from 		garland.adrResult
	where		verify_code > 9						-- dec 2004
	group by	mod(verify_code, 10);	


	select	rpad	 (
			decode (lpad(verify_code,2,'0'),
				'00',	'00: non address',	
				'01',	'01: non garland',	
				'02',	'02: non correct',
				'03',	'03: non complete',

				'10',	'10: valid   name',
				'11',	'11: poor    name',
				'12',	'12: mixed   name',
				'13',	'13: wrong   name',
				'14',	'14: partial name',
				'15',	'15: full    name',

				'21',	'21: poor    orphan',
				'22',	'22: mixed   orphan',
				'23',	'23: wrong   orphan',
				'24',	'24: partial orphan',
				'25',	'25: full    orphan',

				'31',	'31: poor    block',
				'32',	'32: mixed   block',
				'33',	'33: wrong   block',
				'34',	'34: partial block',
				'35',	'35: full    block',

				'41',	'41: poor    range',
				'42',	'42: mixed   range',
				'43',	'43: wrong   range',
				'44',	'44: partial range',
				'45',	'45: full    range',

				'51',	'51: poor    address',
				'52',	'52: mixed   address',
				'53',	'53: wrong   address',
				'54',	'54: partial address',
				'55',	'55: full    address',

					' '			)  	
					,30)			"VERIFY CODE",
			count(*)			"     Total"

	from		garland.adrResult
--	where		rec_seq > 1							-- jan 2004
	group by	lpad(verify_code,2,'0');

--	=================================================================================
--	summarize parsing actions

--	select	rpad(do_parse,30)			"PARSED",
--			count(*)				"     total"
--	from		garland.adrResult
--	where		do_parse <> '.........'
--	group by	do_parse;


	select count(*)					"LONE UNITS"
	from garland.adrResult
	where	do_qual	like '%u%'
	and	do_qual not like '%c%'
	and	addr_code1 <> 'DPLX';

--	=================================================================================
--	summarize name corrections

	select	lpad (count(*),13)	"ALIAS RENAMES"
	from		garland.adrResult
	where		do_alias > '0'
	and		do_name  > '0';

	select	rpad('name corrections',30)				"NAME CHANGE",
			count(rtrim(do_alias)) + count(rtrim(do_name))	"     total"
	from		garland.adrResult;

--	=================================================================================
--	summarize qualifier corrections

	select	rpad(do_qual,30)			"AUDIT",
			count(*)				"     total"
	from		garland.adrResult
	where		do_qual > '0'
	group by	do_qual;


--	=================================================================================
--	invalid addresses

	select	distinct
			'partial     '		"PARTIAL",
			lpad (addr_num,06)	"numb", 
			rpad(addr_pfx, 02)	"pfx", 
			rpad(addr_name,20)	"name", 
			rpad(addr_type,04)	"type", 
			rpad(addr_sfx, 02)	"sf" 	
--			,rpad(rec_key, 18)	"key"
--			,lpad(rec_seq, 06)	"seq"
	from		garland.adrResult
	where		verify_code = 54
	order by	4,5,3,6,2;


	select	distinct
			'wrong       '		"WRONG ",
			lpad (addr_num,06)	"numb", 
			rpad(addr_pfx, 02)	"pfx", 
			rpad(addr_name,20)	"name", 
			rpad(addr_type,04)	"type", 
			rpad(addr_sfx, 02)	"sf" 	
--			,rpad(rec_key, 18)	"key"
--			,lpad(rec_seq, 06)	"seq"
	from		garland.adrResult
	where		verify_code = 53
	order by	4,5,3,6,2;


	select	distinct
			'mixed       '		"MIXED",
			lpad (addr_num,06)	"numb", 
			rpad(addr_pfx, 02)	"pfx", 
			rpad(addr_name,20)	"name", 
			rpad(addr_type,04)	"type", 
			rpad(addr_sfx, 02)	"sf" 	
--			,rpad(rec_key, 18)	"key"
--			,lpad(rec_seq, 06)	"seq"
	from		garland.adrResult
	where		verify_code = 52
	order by	4,5,3,6,2;


	select	distinct
			'poor        '		"POOR",
			lpad (addr_num,06)	"numb", 
			rpad(addr_pfx, 02)	"pfx", 
			rpad(addr_name,20)	"name", 
			rpad(addr_type,04)	"type", 
			rpad(addr_sfx, 02)	"sf" 	
--			,rpad(rec_key, 18)	"key"
--			,lpad(rec_seq, 06)	"seq"

	from		garland.adrResult
	where		verify_code = 51

	order by	4,5,3,6,2;


	select rpad(' ',70) " " from dual;

--	=================================================================================
--	show valid names (verify code = 10) with valid numbers

	select
		'Wrong Verify Code '			" ",
		rpad(r.rec_key,10)			"key",
		lpad(nvl(r.addr_num,   0),05)		"num", 
		rpad(nvl(r.addr_pfx, ' '),02)		"pf", 
		rpad(nvl(r.addr_name,' '),20)		"name",
		rpad(nvl(r.addr_type,' '),04)		"type",	 
		rpad(nvl(r.addr_sfx, ' '),02)		"sf",
		rpad(r.verify_code,06)			" ",
		decode(a.addr_name, null,' ','55')	" "

	from	garland.adrResult		R,
		garland.cdreladr		A

	where verify_code = 10
	and	r.addr_name		= a.addr_name	(+)
	and	r.addr_num		= a.addr_num	(+)
	and	r.addr_type		= a.addr_type	(+)
	and	r.addr_pfx		= a.addr_pfx	(+)
	and	r.addr_sfx		= a.addr_sfx	(+)
	and exists
(
	select 'x'
	from	garland.cdreladr
	where	addr_name = r.addr_name
	and	addr_num  = r.addr_num
);

--	=================================================================================
	spool off;
	set fetchrows;
--	=================================================================================

