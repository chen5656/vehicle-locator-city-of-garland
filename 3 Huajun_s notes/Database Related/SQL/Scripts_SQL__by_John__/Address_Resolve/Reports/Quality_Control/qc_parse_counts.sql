	set echo	off;
--	=========================================================================================================

--	display parse schemes

	select	rpad (do_parse,30)	"PARSE",
			lpad(count(*),5)		"TOTAL", 

			decode ( rpad(do_parse,3),
					'!71',	' Non Address',
					'!81',	' Code',
					'!82',	' Unit',
					'!83',	' Fraction',
					'!90',	' Length',
					'!91',	' Format',
					'!92',	' Parts',
					'!93',	' Redo',
					'!94',	' Loop',
					' '		)	"  ERROR"

	from		garland.adrResult
	where		do_parse > ' '
	group by	do_parse;


--	display all suffixes
 

	select	rpad(addr_sfx,06)			"SUFFIX",
			count(*)				"     total"
	from		garland.adrResult
	where 	verify_code >= 0
	group by 	addr_sfx; 


--	display all parsed address codes

	select	addr_code1				"CODE"
			,count(*)				"    TOTAL"
	from		garland.adrResult
	where		do_parse like '%c%'
	group by	addr_code1;


--	display all parsed address units

	select	addr_unit1				"UNIT"
			,count(*)				"    TOTAL"
	from		garland.adrResult
	where		do_parse like '%u%'
	group by	addr_unit1;


--	display address units with punctuation

	select	--+ rule
			distinct
--			'punctuated '			"UNIT"

			 a.addr_pfx  			" "
			,a.addr_name 			"original"
			,a.addr_type 			" "
			,a.addr_sfx  			" "
			,a.addr_code 			"code"
			,a.addr_unit 			"unit"

--			 rpad (a.addr_pfx,  02)		" "
--			,rpad (a.addr_name, 20)		"original"
--			,rpad (a.addr_type, 04)		" "
--			,rpad (a.addr_sfx,  02)		" "
--			,rpad (a.addr_code, 10)		"code"
--			,rpad (a.addr_unit, 10)		"unit"

			,' || '				" "

			,rpad (v.addr_pfx,  02)		" "
			,rpad (v.addr_name, 20)		"parse"
			,rpad (v.addr_type, 04)		" "
			,rpad (v.addr_sfx,  02)		" "
			,rpad (v.addr_code1,10)		"code"
			,rpad (v.addr_unit1,10)		"unit"

--			,rpad (a.rec_key, 20)		"key"

	from		garland.adrResult			v,
			garland.gis_app_addr		a

	where		v.rec_key = a.rec_key
	and		v.verify_code > -1
	and		v.addr_unit1  > ' '

	and	(	translate (lower (v.addr_unit1),'/0123456789 abcdefghijklmnopqrstuvwxyz',   '/') is not null
	or		translate (lower (a.addr_name), '/0123456789 abcdefghijklmnopqrstuvwxyz.#', '/') is not null)
	;

--	=========================================================================================================
--	desc garland.adrResult;
--	desc garland.gis_app_addr;
--	=========================================================================================================

	set echo	on;
