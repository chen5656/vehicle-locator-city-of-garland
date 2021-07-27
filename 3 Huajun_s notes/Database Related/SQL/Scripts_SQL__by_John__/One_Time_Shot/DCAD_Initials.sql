	set echo	off;
	set termout off;
--	===========================================================================
--	DCAD INITIALS

--	Reformat extract of DCAD key and owners
--	Extract out people's initials instead of their names
--	NONE = place name    ONE = one person    TWO = two people

--	===========================================================================
	truncate table	garland.plan_table	reuse storage;

	SPOOL	c:\deacutis\extract\dcad_initial.txt

--	explain plan set statement_id =  'xxx'		into garland.plan_table	for

--	===========================================================================

	select dcad ||','|| init11 || last_name	
--		 ||'    /    '|| name	
	" "
	from
(
--	----------------------------------------------------------------

	select
--		DISTINCT						--  TEMPORARY 1
		'NONE  '			type,
		item01			dcad,	
		item02			name,
		''				init11,
		''				init12,
		''				init21,
		''				init22,
--		item02			last_name

		rpad(item02,1)								|| 
		substr(item02, ltrim(instr(item02,' ',1,1),'0') + 1,1)	||
		substr(item02, ltrim(instr(item02,' ',1,2),'0') + 1,1)	||
		substr(item02, ltrim(instr(item02,' ',1,3),'0') + 1,1)
						last_name
	from	
(
	select item01, item02 
	from	 garland.gis_objects

	where	instr(rtrim(item02,' &'), '&') = 0	
	and
(

	(   	instr(item02,' ') <= 2    and	  item02 not like 'O %'	)

	or	item02||' '	like '% CITY %'
	or	item02||' '	like '% CHURCH %'
	or	item02||' '	like '% INC %'
	or	item02||' '	like '% CORP %'
	or	item02||' '	like '% ASN %'
	or	item02||' '	like '% CTR %'
	or	item02||' '	like '% EST %'
	or	item02||' '	like '% LTD %'
	or	item02||' '	like '% MTG %'
	or	item02||' '	like '% OF %'

	or	translate(item02, '/1234567890', '/') <> item02
)

--	and	rownum < 22
)


--	----------------------------------------------------------------

--	union all
--	select '**************',
--		 '','','','','',''  from dual

	union all


--	----------------------------------------------------------------
(
	select
--		DISTINCT						--  TEMPORARY 2
		'ONE   '								type,
		dcad,	
		name,
		substr(name, instr(name,' ',01,01) + 01, 01)		init1,
		substr(name, instr(name,' ',01,02) + 01, 01)		init2,
		''									init3,
		''									init4,

		rpad(substr(name, 01, instr(name,' ',01) - 01), 01)	last_name
		

	from
(
	select item01					dcad, 
		 rtrim(item02,' &') ||'   '		name
	from	garland.gis_objects

	where	instr(rtrim(item02,' &'), '&') = 0		
	and	(instr(item02,' ') > 2    or   item02 like 'O %')

	and	item02||' '	not like '% CITY %'
	and	item02||' '	not like '% CHURCH %'
	and	item02||' '	not like '% INC %'
	and	item02||' '	not like '% CORP %'
	and	item02||' '	not like '% ASN %'
	and	item02||' '	not like '% CTR %'
	and	item02||' '	not like '% EST %'
	and	item02||' '	not like '% LTD %'
	and	item02||' '	not like '% MTG %'
	and	item02||' '	not like '% OF %'

	and	translate(item02, '/1234567890', '/') = item02
)


--	where	rtrim(substr(name, instr(name,' ',01,02) + 01)) like '% %'		-- TEMPORARY

--	and	rownum < 22										-- TEMPORARY
)	
--	----------------------------------------------------------------

--	union all
--	select '**************',
--		 '','','','','',''  from dual

	union all

--	----------------------------------------------------------------

(
	select
--		DISTINCT						--  TEMPORARY 4
		'TWO   '											type,
		first.dcad,	
		first.name,

		substr(first.name, instr(first.name,' ',01,01) + 01, 01)			init1,
		ltrim(substr(first.name, instr(first.name,' ',01,02) + 01, 01), ' &')	init2,


		'','',
--		substr(second.name, instr(second.name,' ',01,01) + 01, 01)			init3,
--		substr(second.name, instr(second.name,' ',01,02) + 01, 01)			init4,

		rpad(substr(first.name, 01, instr(first.name,' ',01) - 01), 01)		last_name

	from

(
	select item01				dcad, 
		 rtrim(item02,' &') 		name
	from	garland.gis_objects

	where	instr(rtrim(item02,' &'), '&') > 0	

	and	(instr(item02,' ') > 2    or   item02 like 'O %')

	and	item02||' '	not like '% CITY %'
	and	item02||' '	not like '% CHURCH %'
	and	item02||' '	not like '% INC %'
	and	item02||' '	not like '% CORP %'
	and	item02||' '	not like '% ASN %'
	and	item02||' '	not like '% CTR %'
	and	item02||' '	not like '% EST %'
	and	item02||' '	not like '% LTD %'
	and	item02||' '	not like '% MTG %'
	and	item02||' '	not like '% OF %'

	and	translate(item02, '/1234567890', '/') = item02
)							FIRST


/*
(
	select item01									dcad, 
		 substr(rtrim(item02,' &'), instr(item02,'&') + 01) 		name
	from	garland.gis_objects

	where	instr(rtrim(item02,' &'), '&') > 0		

	and	(instr(item02,' ') > 2  or item02 like 'O %')

	and	item02||' '	not like '% CITY %'
	and	item02||' '	not like '% CHURCH %'
	and	item02||' '	not like '% INC %'
	and	item02||' '	not like '% CORP %'
	and	item02||' '	not like '% ASN %'
	and	item02||' '	not like '% CTR %'
	and	item02||' '	not like '% EST %'
	and	item02||' '	not like '% LTD %'
	and	item02||' '	not like '% MTG %'
	and	item02||' '	not like '% OF %'

	and	translate(item02, '/1234567890', '/') = item02

)							SECOND
*/

--	where	first.dcad = second.dcad

--	and	rownum < 22						-- TEMPORARY
)

--	----------------------------------------------------------------
)	;

	SPOOL off

--	select * from garland.explain_plan;

--	===========================================================================
	set echo on;
	set termout	on;



