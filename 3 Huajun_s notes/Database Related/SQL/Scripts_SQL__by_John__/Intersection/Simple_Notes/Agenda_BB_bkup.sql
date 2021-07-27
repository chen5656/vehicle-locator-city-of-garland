=====================================================================================
How to distinguish the FROM & TO endpoints of a given ROAD.
This is necessary when the ROAD spans many hundred blocks.
An Intersection BB record must associate the right endrange with the right endpoint.
=====================================================================================

	A STREET consists of many ROAD features.

	Each ROAD feature contains two "end points" with different coordinates
	and two "end blocks" with hundred blocks based on RangeLo & Range Hi



1)				E BUCKINGAM RD

	XY1		 XY2		   XY3	     XY4   	       XY5
	O-------------O-------------O-------------O-------------O
	   101 - 121      201 - 221     301 - 532     602 - 632
	   100 - 100	200 - 200	  300 - 500	    600 - 600	 	


	XY2 corresponds to Hi Block 100 & Lo Block  200


2)	0-------------O
	   101 - 121
	   100 - 200


	If a ROAD spans only a single hundred block, then the same hundred block corresponds 
	to both end points of the ROAD

3)	What about the ROAD at the end of a STREET?

	XY1		 XY2		   XY3	     XY4   	       XY5
	O-------------O-------------O-------------O-------------O
	   101 - 121      201 - 221     301 - 532     602 - 632
	   100 - 100	200 - 200	  300 - 500	    600 - 600	 	


	XY1 is associated with whichever end block that XY2 is not.


4)	0-------------O
	   101 - 221
	   100 - 200

	If a Street consists of only 1 Road and the range spans multiple hundred blocks,
	then consider which quadrant of the city the street lies within.

	Horizontal Street numbers increase eastward and westward from FIRST ST.
	Vertical Street numbers increase northward and southward from FOREST & MAIN & COMMERCE.

		
5)	If the associatiion of Endpoints and the Street Numbers for a ROAD cannot be resolve automatically
	then prepare an Exception table:

		RoadID
		X,Y		(Lo Block Point)

=========================================================================
=========================================================================

RECORD
		ROAD ID
		X,Y
		STREET ID
		AT BLOCK	(set to LO or HI)
		LO BLOCK
		HI BLOCK
		QUADRANT	(NE NW SE SW)

INDEX		ROAD ID
INDEX		X
		
=========================================================================
get ROAD coordinates from ESRI

	TOOLBOX > Samples  
		input = gis.ROAD
		Extract shape coordinates for ROAD feature
		output = TB		

=========================================================================
get ROAD ID & First Point
get ROAD ID & Last  Point

PLSQL
	input		TB
	output	OB

		objectid
		first X,Y

		objectid
		last X,Y

=========================================================================
get ROAD info

SQL
	input		OB
	input		ROAD
	output	R1
	set
		Road ID	(overlay ObjectID)
		Street ID
		Lo Block
		Hi BLock
		Quadrant

=========================================================================
get CONNECTED Road
set Adjacent At Blocks

	input		R1, rowid
	input		R2, rowid
	where		r1.XY = r2.XY
	and		r1.street = r2.street
	and		r1.hi_block <= r2.lo_block
	sort		Street 
			Lo Block

	set		r1.At Block = r1.Hi Block
	set		r2.At Block = r2.Lo Block

=========================================================================
get ROAD that spans only 1 hundred block

	input		R1, rowid
	where		r1.roadid = r2.roadid
	and		r1.lo_block = r1.hi_block
	and		r1.at_block is null
	
	set		r1_at.block = r1.lo_block

=========================================================================
get ROAD with only 1 end block assigned

	input		R1, rowid
	input		R2, rowid
	where		r1.roadid = r2.roadid
	and		r1.at_block is not null
	and		r2.at_block is null

	set		r2.at_block	 = decode (r1.at_block, r1.lo_block, r1.hi_block, r1.hi_block, r1.lo_block, r2.at_block);

=========================================================================
set ROAD quadrant	(see Fred's feature class)

	quadrant = decode(sign (Y - EW_Line), +1, 'N', 'S') || decode(sign (X - NS_Line), +1, 'E', 'W') ;

=========================================================================


