====================================================================================
incident 130622
LSTALEY
9/22/2011 1:30:11 PM
U:\U Drive\STANDARD\ODT\LauraStaley\TAX_CUS


This request should be assigned to John DeAcutis in GIS.  John--this is the data we request annually for our survey mailout.  I need this data no later than September 5th.    

Please provide information linking addresses to Customer Service and Tax databases for the upcoming survey mailout using the following parameters:  
a) Info for matching TAX & CUS addresses
b) Info for TAX addresses without corresponding CUS addresses
c) Info for CUS addresses without corresponding TAX addresses 

The extract needs to include the following fields:
1) Parcel ID
2) Address ID
3) Address (Using separate fields for Num, Prefix, Street Name, Type, Suffix) 
4) DCAD Account #            
5) Tenant First & Last Name

====================================================================================

The first extract takes info from CCS ADDRESS.  
It includes records with both TAX and CUS plus those with TAX only.

The second extract takes info from COMMON CUS which is a copy of COMMON UMS.
It contains records with CUS only.

=======================================================================================

TABLES
	TEMP VIEW		OUTPUT
	COMMON CUS		from scratch
	CCS ADDRESS ODT		from CCS ADDRESS NEW
	aR Banner

JOB FLOW

	BUILD COMMON CUS	view of joined Banner tables
				aR Banner

	BUILD CCS ADDRESS ODT	copy CCS ADDRESS NEW


	CCS ADDRESS ODT		for BLOCK match	set ROADID = 1

	Build Output		TAX / GIS
		from	jdeacutis.CCS_ADDRESS_ODT
		where	TAX_ID > 0
		and	nvl(address_id,0) + nvl(ROAD_id,0) > 0

	Extend Output		UMS / GIS
		from Common CUS
		matching Block and possibly Address
		where not not already in Output view

	Assign Parcel ID	ar Banner
				from Roadside	verify code = 45
				from Roadside	verify code = 25

	Assign Parcel ID	Temp View
				ar Banner

	Remove Dupes

	ASCII Output		from Temporary Output

===================

	scrub	CCS ADDRESS NEW		rec_key = record_seq
	assign	roadid, parcelid	for verify = 45
	assign	streetid, parcelid	for verify = 25
	Block ID = Verify Code

	ar Banner	
	assign	roadid, parcelid	for verify = 45
	assign	streetid, parcelid	for verify = 25

===================
