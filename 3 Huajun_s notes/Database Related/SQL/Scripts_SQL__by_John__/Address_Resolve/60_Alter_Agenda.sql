
	================
	adrAlter Formats
	================

		adrAlter contains 3 lines of street specifications
		Each line is preceded by a Flag field
		The following describe the possible combinations of the 3 Flag fields


	x.	unparsed is non-address			(no further processing)
		0 - -
		/ - -

		(place '0' or '/' on line 1  and leave lines 2 and 3 empty)
		

	x.	unparsed is non-garland			(no further processing)
		1 - -
		$ - -


	x.	unparsed is parsed non-garland 	(no further processing)
		S 1 -
		S $ -


	x.	unparsed is parsed			(no further processing)
		S S -


	x	unparsed is parsed			(continue processing)
		S - S


	x.	parsed is non-garland			(no further processing)
		- 1 -
		- $ -


	x.	parsed is corrected			(continue processing)
		- S S


	

	============================
	adrAlias Methods (alias_how)
	============================

	x.	12%		"Like" method
				means alias_name specifies a subtext
				eg.	process unparsed names containing 'bob%' or '%bob' or '%bob%'

	x.	12%%		"Replace" method
				means alias_name specifies a subtext, which should be replaced by addr_name
				eg.	if user name contains 'bob%', replace it with 'tom'



	===============
	adrAlter Target
	===============
	
		"Notes"  is a column name in the adrAlter table
		It contains descriptive information  (eg. non-address, non-garland, etc)
		and may contain an indicator of the target ASCII file 


	x.	Notes = 'U=.....)		means place alias record in Common  Unparsed
						else  place alias record in Special Unparsed

	x.	Notes = 'P=.....)		means place alias record in Common  Parsed
						else  place alias record in Special Parsed

		HOW IS IT USED ???





