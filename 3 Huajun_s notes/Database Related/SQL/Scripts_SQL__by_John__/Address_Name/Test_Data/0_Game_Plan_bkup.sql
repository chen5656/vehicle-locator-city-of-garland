=================================================================
INPUT

	name1_input
	name2_input

=================================================================
ARRAYS

	name1
	name2

	sound1
	sound2

=================================================================
SCAN		(integers)

	bef				bef = this - vector
	this
	that
	aft				aft = that + vector

	doubled				index
	spaced				index

	next				next = 0 = unconfirmed
	weight

FRONT
	SCAN1
	SCAN2
BACK
	SCAN1
	SCAN2

=================================================================
TEXT

	bef1
	this1
	that1
	aft1

	bef2
	this2
	that2
	aft2

=================================================================
GENERAL

	name1_length
	name2_length

	vector

	error
	confirm

	weight
	score

=================================================================
CONTROLS

	error weights
	soundex transform
	symbol  transform

=================================================================
SOUNDEX

	Translate
		A-Z / 		0-9 / 		space & symbols
		group numbers / 	nulls /		0

	Letters map to group number or null
	Digits map to null

=================================================================
PREP

	If length of longest name > 6, then pare down front & back
	Populate TRACER array from front.bef to back.aft 

=================================================================
ANALYSIS

	if	[here1] = [here2] 
		next1 = aft1
		next1 = aft2

	Wrong / Extra / Missing / Transpose
		set	next1 & next2 accordingly

		if	[next1 + vector] = [next2 + vector]
			next1 = next1 + vector + vector
			next2 = next2 + vector + vector
		else
			reverse

	bef1  = next1 - vector	

	at1	= next1
	here1	= next1

	"double"
	look = here1 + vector
	if	[here1] = [look]
		double1 = 1
		here1 = look
		loop back
	else
		double1 = 0

	"space"
	if	[here1] = space
		space1 = 1
		here1 = here1 + vector
		loop back
	else
		space1 = 0
	
	aft1 = here1 + vector

LEGEND

	here1 is subscript of TRACER array
	[here1] is letter  at here1 subscript
	<here1> is soundex at here1 subscript

=================================================================
ISSUES

	double followed by a space

=================================================================
TASKS

	soundex

	dipthong

	plural

	orphan

	transplace

=================================================================
