	set echo 		off;
	set fetchrows	111;
--	========================================================================

	select

--		DISTINCT
		rpad(MACCTNO,10)		"ACCOUNT",

		rpad(hscode,02)		"HS", 
		lpad(dvcode,02)		"DV",
		rpad(exempt,02)		"EX",
		sptlnd			"LND",
		sptimp			"IMP",
		sptprd			"PRD",
		sptper			"PER",
		rpad(mprptyp,03)		"PRP",
		rpad(' ',06)		"giving",

		substr (SPT,  01, instr(SPT, '/') - 01)					"SPT",

		decode (rpad(SPT,01), 'A', 'SFR', 'B', 'MULTI', 'COMMERCIAL')	"ZONE",

		substr (CLASS, 01, instr(CLASS,'/') - 01)					"EXEMPT"

	from
(
	select

		macctno,
		hscode, 
		dvcode,
		exempt,
		sptlnd,
		sptimp,
		sptprd,
		sptper,
		mprptyp,

		sptlnd ||'/'|| sptimp ||'/'|| sptprd ||'/'|| decode(mprptyp, 'R', sptper, null)	SPT,

		decode(hscode, 'H', 'HOMESTEAD/', 'S', '>65/', 'D', 'DISABLED/', '5/', 'AGRICULTURE', null)
		||
		decode (dvcode, 0, null, 'DISABLED VET/')
		||
		decode (exempt, ' ', null, 'TOTAL/')								CLASS


	from	garland.Tax
	where macctno > '0'

	and	ltrim(hscode,'0') || ltrim(dvcode,'0') || ltrim(exempt) is not null

	and	hscode > '0'
--	and	hscode not in ('H', 'S', 'D', '5')
--	and	dvcode > '0'
--	and	exempt > ' '


	and	rownum < 51

);


--	========================================================================
	set fetchrows;
	set echo		on;

