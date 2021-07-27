	set echo	off;
	set termout on;
--	===========================================================================
--	DCAD INITIALS

--	Reformat extract of DCAD key and owners
--	Extract out people's initials instead of their names
--	NONE = place name    ONE = one person    TWO = two people

--	===========================================================================
	truncate table	garland.plan_table	reuse storage;

--	spool	c:\deacutis\extract\dcad_initial.txt

--	explain plan set statement_id =  'xxx'		into garland.plan_table	for

--	===========================================================================

--	----------------------------------------------------------------

	select	count(*)
	from	
(
	select item01, item02 
	from	 garland.gis_objects

	where
(
	(instr(item02,' ') <= 2    and	item02 not like 'O %'	)

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
);


--	----------------------------------------------------------------
(
	select	count(*)

	from
(
	select item01					dcad, 
		 rtrim(item02,' &') ||'   '		name
	from	garland.gis_objects

	where	instr(rtrim(item02,' &'), '&') = 0

	and ( instr(item02,' ') > 2    or   item02 like 'O %')

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
);	
--	----------------------------------------------------------------

(
	select	count(*)
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

	where (instr(item02,' ') > 2  or item02 like 'O %')

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
);

--	----------------------------------------------------------------

--	spool off

--	select * from garland.explain_plan;

--	===========================================================================
	set echo on;
	set termout	on;
