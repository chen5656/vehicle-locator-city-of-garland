	===============================
	GIS_RESOLVE_ADDRESS	OUTLINE
	===============================


READ THE APP ADDRESS 

1.	read next app address

2.	initialize app & out

	app = input  address info	(application file)
	out = output address info	(adrResult table )  

PARSE THE APP ADDRESS

11.	Parse
		this name = concatenated app address
		parse [this addr]
		app addr  = this addr 

12.	preliminary street match  (removable feature)

		is there unique benign adrStreet match for app address
		then	bypass alias match
			bypass do_street phase 

		problem:  does not allow alias number range record to take effect

MATCH AGAINST ALIAS

21.	Alias Match
			
	a.	set out.addr_ to alias results
	b.	set do_alias = alias method
			normal correction
			accepted invalid
			corrected accepted
			boomerang correction
			safe, risk
			none, many
				

MATCH AGAINST STREET, SEGMENT, AND ADDRESS TABLES

30.	initialize phase parameters

	a.	str controls
	b.	seg controls
	c.	[for str, seg, adr] [fetch & match count = 0] 

31.	phase loop
	
	a.	set phase per step
	b.	if invalid name or number then bypass seg & adr
	c.	set permissions per segment step	[prev, permit]
	c.	initialize work record			[phase id, audit values, counts]
	d.	open gis cursor for phase

READ & KEEP QUALIFIERS FOR NAME & NUMBER
WHAT CAN BE REMOVED & WHAT IS UNIQUE TO NAME & NUMBER

41.	fetch loop per phase id

	a.	read gis record per phase id
	b.	for str 
			set weight,name, name chg, name count
			ignore per weight
	c.	for seg 
			set block count	
			ignore per range
	d.	queue previous address qualifiers in array
	e.	obtain read_ info
	f.	fetch + 1
	g.	for any phase
			test for unique qualifiers for app street name
			test for app qualifier match (existence)
	x.	end loop

42.	close fetch cursor	

43.	if name count is not unique, then end of str phase

REMOVE IRRELEVANT QUALIFIERS & APPEND UNIQUE QUALIFIERS

44.	remove app qualifiers invalid for street name
45.	append unique qualifiers
46.	initial audit = audit of removals & appends


FIND THE BEST QUALIFIERS FOR ADDRESS

50.	initialize match

	a.	initialize app qualifier acceptance (are they blank?)
	b.	best = 0

51.	match loop

	a.	get record info from qualifier array
	b.	compare out.qualifiers w/ read_qualifiers
		1.	set weight
		2.	set audit
	c.	keep best info per weight
		1.	keep record info
		2.	nullify weight if seg/adr change permit fails
		3.	keep best weight & level
		4.	best audit = initial audit + qualifier audits
	d.	update match count
	e.	end loop

AFTER STREET MATCH, DO FUZZY MATCH & RETRY ALIAS MATCH

61.	if unique valid name not found, do fuzzy name match
62.	if name correction occurred, then exit

FOR UNIQUE BEST MATCH, UPDATE THE ADDRESS 

63. 	for unique match, get best street
64.	for unique match, set do_name, parcel_id, & segment_id

65.	if street phase, set accept count 

66.	copy word record to phase record
67.	end loop

RETRY STREET VERIFICATION

71.	if name correction occurred then go back to either alias match or phase process


SET THE VERIFY CODE
WRITE OUT THE RESULTS

91.	set verify code
92.	if app street changed, then set ver.old_
93.	insert results into adrResult
94.	print totals



==========
DATA FLOW
==========

	read_
			get	from fetch cursor
			put	qualifier table
			put	unique qualifiers
			get	qualifier table
			put	best qualifiers

	work.
			init	for each phase
			set	fetch count for unrejected gis record
			use	fetch count as  qualifier index
			use	rule			


