
	In order to update adrBlock_Side regions, both the Intersection & Corner tables must exist.
	These tables may be recreated using scripts in \\Scripts\Intersections


===========
Spoke View
===========

	gis_temp1


=========================
Duplicate Intersect View
=========================

	gis_temp2



==========
Node View
==========

	gis_temp2

===========
Corner View		permanent table
===========

	gis_temp3

	intersect id	index
	esri node
	mslink1
	mslink2
	term1
	term2
	parity1
	parity2

=============
Intersection	permanent table
=============

	gis_objects


	nam1 nam2				index
	sid1 / sid2		(node id)	index
	type / id / id	(intersect id)

	str & blk	2

	varray regions

--	sid		2
--	rid		2	BB	
--	term		2	F/T	(rcl)
--	parity		2	0/1	BB
--	hand		2	L/R	BB
--	esri node


	Intersection looks for Excel region
	If none, then looks at BB 
	If none, then looks at all sid.sid regions

	street_id1
	street_id2
	road_id1
	road_id2

	esri_node			(not node id)

	node_id			street ids		1234.5678		1,2 or 2,1
	intersect_id		unique id		BB1234.5678
	
	corner compass		compass of quadrant
	twin compass		relative to twin intersection


	varray for each region	(for non-BB)

	varray of  region table REFs (seq)
	Region Table - bitmap for each region
