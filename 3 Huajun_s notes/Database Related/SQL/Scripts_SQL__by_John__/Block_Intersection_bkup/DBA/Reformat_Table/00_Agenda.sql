
--	===============================================================================
--	Reformat the layout of an Oracle table
--	===============================================================================


01_Job1_Scripts
================


	Step 1:		Create script to copy application table TO TEMPorary table	

				<11_Copy_To_Script>

	Step 2:		Create script to populate application table FROM TEMPorary table	

				(12_Copy_From_Script)

	Step 3:		Create script to Backup the temporary copy of the application table
				Giving 2 copies of original application data
				<13_Backup_Script>



02_Job2_Backup
==============

	Step 4:		Execute Copy of Application table to Temp table

				<21_Copy_To_Temp>

	Step 5:		Execute Copy of Temp table to Backup table
				DO NOT REPEAT THIS JOB !!!  
				<80_Copy_To_Backup>





	Step 5a:		(ALTER existing TABLE)

				TRUNCATE	application table
				ALTER		application table
				DISABLE triggers
	
	Step 5b:		<CREATE new TABLE>

				DROP		old version ofapplication table
				CREATE	new version of application table





	Step 6:		Modify 2nd script if additional columns need populating
				c:\deacutis\scripts\Execute_2.sql

	Step 7:		Execute 2nd script

				<04_Copy_From>

	Step 8:		Enable triggers

--	===============================================================================
