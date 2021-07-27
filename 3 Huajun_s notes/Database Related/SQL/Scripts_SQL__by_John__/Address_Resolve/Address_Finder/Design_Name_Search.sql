
===========
NAME SEARCH
===========

	compact initial name

	this name				(1st name or null)

	adrFind varchar$v	

		2nd name			(alias transform)
		partial			(alias or soundex)
		also names			(alias)

	fuzzy names

notes
=====

	this name == 1st name

	adrFinder:	where addr_name like this_name
	
==============
QUAL VARIABLES
==============

	initial quals or transform first quals
	
	this_pfx
	this_type
	this_sfx

==========
FIRST NAME
==========

	initial name
	transform initial name

	best fuzzy name
	transform best fuzzy name (score <= 100)


============
IGNORE NAMES
============

	compact transform names

	compact fuzzy names

=====
ALIAS
=====

	asis	=>  valid

	asis weight = biggest weight
