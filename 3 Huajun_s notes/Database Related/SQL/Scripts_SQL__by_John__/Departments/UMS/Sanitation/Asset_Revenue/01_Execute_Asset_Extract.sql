
/*

--	====================================================================================
--	SANITATION ASSET REVENUE EXTRACTION
--	====================================================================================

--	-----------------------------------------------------------------------------------------
--	Address Resolve UMS Location	(UM00100M)

	Specify the following	\\Address_Resolve\Views\vw_UMS_Location.sql
	in				\\Address_Resolve\Jobs\01_Table_View.sql

	Specify the following	\\Address_Resolve\User_Exits\01_Default_Unparsed_exit.sql;	
					\\Address_Resolve\User_Exits\01_Default_Parsed_exit.sql;	
	in				\\Address_Resolve\32_User_Exit.sql	

	Copy the contents of	\\Address_Resolve\Alterations\UMS.sql
	into				\\Address_Resolve\Alterations\01_Load.sql	

	Execute			\\Address_Resolve\Jobs\051_Full_Remote.sql

--	-----------------------------------------------------------------------------------------
--	Load UMS Location table		xx

	@C:\Deacutis\Scripts\Departments\UMS\Sanitation\Asset_Revenue\10_Load_UMS_Location.sql;

--	-----------------------------------------------------------------------------------------
--	Extract UMS Keys			xx

	@C:\Deacutis\Scripts\Departments\UMS\Sanitation\Asset_Revenue\11A_Extract_Keys.sql;

--	-----------------------------------------------------------------------------------------
--	Sanitation Views			xx

	@C:\Deacutis\Scripts\Departments\UMS\Sanitation\Asset_Revenue\UMS_Keys_Sanitation.sql;

--	-----------------------------------------------------------------------------------------
--	Attach Container Size from UMS_Attrib_Value function		xx

	@C:\Deacutis\Scripts\Departments\UMS\Sanitation\Asset_Revenue\21_Attach_Size_Share.sql;

--	-----------------------------------------------------------------------------------------
--	Extract Sanitation Detail	xx		

--	Set desired date range in the following command file, and then execute

	@C:\Deacutis\Scripts\Departments\UMS\Sanitation\Asset_Revenue\22_Extract_Consumption.sql;

--	-----------------------------------------------------------------------------------------
--	Build ASCII file including adrResolve Address   (for Access/Excel)	xx

	@C:\Deacutis\Scripts\Departments\UMS\Sanitation\Asset_Revenue\23_ASCII_Revenue_Com.sql;

--	====================================================================================

*/

