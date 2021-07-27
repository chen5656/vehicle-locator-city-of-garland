================================================================================
Match ALPHA5 against UMS using scrubbed Addresss & Serial Number
================================================================================

x.	SQL Loader  Alpha5	Account & Address
x.	Scrub		Alpha5	Account & Address

x.	Scrub		UMS		Location No & Address

x.	SQL Loader	Alpha5	Water Serial & Account				GIS_TEMP2


<Extract_Serial_Location>
x.	Extract	UMS		Water Serial & Location	No & Address	GIS_OBJECTS


<Set_Water_Location_No>
x.	Obtain 	UMS Location 
	for 		Alpha5 Serial
	giving	Alpha5	Water Serial & Account & Location No


x.	Match		UMS & ALPHA5 adrResult Segment_ID (mslink)
			Get UMS Location for ALPHA5 Account


x.	Output	Water Account / Water Serial / UMS Location No		GIS_TEMP2

