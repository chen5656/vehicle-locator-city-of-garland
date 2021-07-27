
	An Excel file may contain manually specified region assignments 
	for the adrBlock_Side table.  These assignments override all others.

	The file may be loaded into GIS_Temp4

	Below is a description of the format and usage of the information.	


EXCEL
=====

	parity	lo block	hi block	street	regions (name,value)		[sequence]


RULES
=====

	Records loaded & read in sequential order
	Later records may override previous records

	Parity = 0		even
	Parity = 1		odd
	Parity = 2		all

	Empty region = above region
	Empty parity = above parity

	Zero hi blk	 = lo blk
	Zero blocks	 = all 



EXAMPLES
========

	0		800	S	COUNTRY CLUB	RD	E	beat	58	dist	45
	1									beat	57	
	2	900	1200									dist	44
	0	1300								beat	56
	2				LITTLE RUN		DR		beat	31
