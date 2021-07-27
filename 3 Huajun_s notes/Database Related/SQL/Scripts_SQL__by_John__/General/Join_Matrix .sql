
========
PURPOSE
========

	Some GIS addresses are for apartment units.
	These "addressed units" are owned by the complex address.
	The complex address is on TAX.  
	The addressed units are not on TAX.
	Need to insert addressed units into Common TAX.
	The tax info for each addressed unit should be the same as that for the complex address.

==================================================================================================================

sean			msl	CID	.....	.....	.....
ar cplx		msl	CID	.....	adr	.....
A			msl	CID

sean			msl	CID	.....	.....	.....
bldg 			.....	Cid	BID	.....	.....		
ar  bldg		Msl	.....	BID	adr	.....
ar  tax		Msl	.....	.....	adr	ACCT		
com tax		msl	.....	.....	adr	ACCT		$tax
B			msl	CID   bid   adr   ACCT		$tax		

A			msl	CID
B			msl	CID   bid   adr   ACCT		$tax		
COM TAX		msl	.....	bid	adr	ACCT		$tax			

where			A.cid =  B.cid
and			A.msl <> B.msl

==================================================================================================================
METHODOLOGY
===========

	sean		input  record set
	COM TAX	output record set

	CID		join on ONE  value
	Msl		join on MANY values
	msl		passive data

	msl		active  single column
	adr		active  group of columns
	$tax		passive group of columns (eg. tax info)

	rtrim
	msl		function(rtrim) of column(msl)  

	aaa		record set aaa joins to bbb ccc & ddd
	...
	bbb
	ccc
	ddd


Outer Join
===========

large		x1	x2	x3	x4	x5	
..............................................................................................
						rtrim
medium	y1	y2	y3	y4	y5	y5	
..............................................................................................
							trunc
small		z1	z2	z3	z4		z5	z5

CURSOR	x1	x2	x3	x4	x5	
CURSOR						y5	
CURSOR							z5

==================================================================================================================
CARDINALITY
===========

	1-1			1
	1-m			m
	m-m			m

	func(m)		1

	1-max.min		1
	m ^ m ...		1	(intersection of sets)

	m-1-1	...		assign unq info to each m recs

		