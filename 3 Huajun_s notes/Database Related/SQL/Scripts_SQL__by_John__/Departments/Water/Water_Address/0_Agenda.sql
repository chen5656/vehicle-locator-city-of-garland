
--	========================================================================================================

	Fred provides \\Loader\WATER_ADDRESS_UMS.dat

	PARCEL_ID, LOCATION_NO, WATER_ID
	if Location_No = 0, then use Water_ID

--	========================================================================================================

	Fred provides \\Loader\WATER_ADDRESS_ZONE_BASIN.dat

	ADDRESS_ID, ZONE, BASIN

--	========================================================================================================

	This extract is to be provided to David Jacobs on a quarterly basis for Address Verification purposed.

	It includes:

		Address
		UMS Account
		Mapsco		N,S
		Zone			E,W
		Basin			ROWL, DUCK


	Issue:

		For Commercial property there can be multiple accounts at 1 address.
		