=======================
Spoke Vectors
=======================

	read	spoke
	get	nodes		(2)
	put	vectors	(2)

=======================
"Corner" Region Update
=======================

	read	intersection type BB
	got	street
	got	block

	if	region is filled, then next intersection

	get	trvehrcl 1	per mslink
	get	trvehrcl 2	per mslink
	got	left/rght 

	get	spoke 1	per mslink & terminal 
	get	spoke 2	per mslink & terminal
	got	vectors
	got	terminals

	if	terminal1 = 'H'
		factor1   = -1
	else
		factor1   = +1

	Vx * factor1
	Vy * factor1

	calc	cross product

	if	cp < 0
		factor1 * -1 
		factor2 * -1

	if	factor1 = +1
		side1 = L
	else
		side1 = R

	if	factor2 = +1
		side2 = R
	else
		side2 = L

	if	side = L
		street = BB
		block	 = BB
		parity = mod (left_from)

	get	secondary block side		
	if	region exists
		upd	primary block side


=======================
Updates
=======================

	Now

		Update adrBlock_Side	for primary street only

	Later

		Update Type B Intersections

		Update other Intersections per Type B

