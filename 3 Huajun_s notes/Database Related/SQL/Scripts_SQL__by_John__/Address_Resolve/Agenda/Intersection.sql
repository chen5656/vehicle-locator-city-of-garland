
\\ Address_Resolve\agenda\build_intersection.sql
-------------------------------------------


terms

	segment
	node
	spoke
	side

	block				100 block
	terminal			from / to		(lo / hi)
	endpoint			at opposite end from terminal
	side				left / right
	parity			even / odd		(0,1)
	clock				clockwise (+1) counter_clockwise (-1)
	compass			N, E, NE, etc

extracts

	node mslink			mslink + from & to nodes

	node coord			node id + x & y coords

	segment coord		mslink & lo x,y & hi x,y

tables

	trvehrcl			mslink	
					addr_name + addr_lo

					potential range
					actual range

	segment spoke		node + terminal (F/T) + mslink
					addr_name + addr_type
					(mslink idx)

					block
					compass	(vector direction)
					delta x	(sign)
					delta y	(sign)
				
	segment side		mslink + side (L/R)
					addr_name + addr_type

					block	
					compass	(side direction)
					parity	( 0	1)
					clock		(+1, -1)
				
					actual range
					geocodes

unique key

	node
	mslink 1	
	mslink 2	
	side	 1
	side	 2
	terminal


find intersection matching user specs	(....x = user field)

	select	node1,  mslink1, mslink2
	from		spoke1, spoke2

	where		node1 = node2
	
	and		name1x = name1	
	and		name2x = name2

	and		type1x  in (' ', type1)
	and		type2x  in (' ', type2); 

	and		block1x in (0, block1)
	and		block2x in (0, block2)

	and		translate  (compass1x, '/'||spoke1_compass, '/') is null
	and		translate  (compass2x, '/'||spoke2_compass, '/') is null


DEFINITIONS
===========

a.	delta x = 	(x at endpoint) - (x at node)
	delta y = 	(y at endpoint) - (y at node)

	delta x >= 0	pos
	delta x <  0	neg

	delta y >= 0	pos
	delta y <  0	neg


b.	deltas ==> compass of segment vector 
	opposite compass directions = diagonal directions

		NE = +1		delta y = pos	delta x = pos
		SW = -1		delta y = neg	delta x = neg

		NW = +2		delta y = pos	delta x = neg
		SE = -2		delta y = neg	delta x = pos
	

WHAT ARE ADJACENT SIDES OF SPOKES AT COMMON NODE
=================================================

a.	clock 		= +1
	counter-clock 	= -1

b.	side					(decode)
		right		= +1
		left		= -1

c.	terminal
		lo		= +1		(from)
		hi		= -1		(to)

d.	sides are adjacent when 

	clock 1 + clock 2 = 0

e.	sides are adjacent when 

	(side 1 * terminal 1) + (side2 * terminal 2) = 0


FIND CLOSEST SPOKES
===================

	match_key = function (node, mslink1, mslink2)
	match key ~ angular distance of segment coords

	intersection defined by segment spokes
	segment spoke contains terminal
	segment coord contains coordinates

	filter for clock1 + clock2 = 0
	
	match key = abs(cross product of segment coords)
	adjacent  = segment sides having the smallest match key > 0

	which side of each segment determined by
		sign of cross product
		terminal of each spoke

	Normalize Length

		Let standard length = 1000
		sf = scale factor = 1000 / length(segment)
		SF = sf^2

		Pythagorean
		h^2 = x^2 + y^2
		(SF * h^2)	= (SF * x^2) + (SF * y^2)
		(sf * h)^2	= (sf * x)^2 + (sf * y)^2

		Multiply delta-x and delta-y 
		by	   sf 
		giving   segment length = 1000



DETERMINE GEOCODES
===================

	address table <<==>> 1 parcel table with geocodes
	segment table <<==>> 2 side tables  with geocodes

	parcel table (cdrelpar) contains geocode bitmap indexes
	side table			contains geocode bitmap indexes

