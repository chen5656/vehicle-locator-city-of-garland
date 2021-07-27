--	====================================================================================
--	Assign ID's to records in a Utility table
--	Example:  UTWATVALV
--	====================================================================================

x.	Populate UTILITY_NUM_CONTROL table 
	with UTWATVALV control records (for example)


	//utility_conversion/Assign_ID/Build_Num_Control.sql


		Table name
		Grid
		Quad
		Num		(last assigned value)


x.	TRIGGER


	//utility_conversion/Assign_ID/Trigger_Script.sql


		Define UTWATVALV trigger 

		On Insert 

		Record must have Grid & Quad already assigned

		Read Utility_Num_Control
		Get next valve_Num

		Assign Valve_ID according to Grid, Quad, Num


x.	BATCH UPDATE

	x.	//utility_conversion/name/Build_Name_Cases.sql
		
		giving  Temp_View	of GIS_Objects

	x.	build gis_app_rowid
		filter for records needing valve id

	x.	Read UTWATVALV
		having Grid & Quad
		missing Valve_id

	x.	Call function:	Assign_Utility_Num

	x.	Format Valve_ID
		per Temp_View

	x.	Update UTWATVALV  
		with Valve_ID

