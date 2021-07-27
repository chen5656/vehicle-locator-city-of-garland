--	=====================================================================
	apply manual region specifications to override automated assignments
--	=====================================================================

	specify Block Side   regions
	specify Intersection regions


--	Job Flow

	maintain manual specifications on Excel
	maintain different Excel for different departments

	download Excel to ASCII

	SQL*Loader	ASCII	to gis_temp1	Block Side   
	SQL*Loader	ASCII	to gis_temp2	Intersection

	execute Block Side   update
	execute Intersection update


--	Rules

	later specifications over-write previous specifications

	lower block range		"from" node
	upper block range		"to"   node


--	===============================================================================
--	===============================================================================

--	Block specifications

beat	58	0	800	900	S	Country Club	Rd	E
		1
		2


--	Intersection specifications

beat	58	0	800	900	S	Country Club	Rd	E
		1
		2

beat	58		800		S	Country Club	Rd	E
			1200			Dairy			Rd	


beat	58		800	900	S	Country Club	Rd	E
			1200			Dairy			Rd	

		

--	address ranges

beat	58	0	600	600	S	Country Club	Rd	E


beat	58	0	0	900	S	Country Club	Rd	E
				1300	S	Country Club	Rd	E
				2700	S	Country Club	Rd	E
				9999	S	Country Club	Rd	E


