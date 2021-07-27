	set echo off;
--	================================================================

/*
		ALTER existing TABLE

			TRUNCATE	application table
			ALTER		application table
			DISABLE triggers
	


		CREATE new TABLE

			DROP		old version of application table
			CREATE	new version of application table
			CREATE	indexes on new application table

*/

--	================================================================

	select count(*) "application" from garland.TEMP_SYN1;

	select count(*) "gis_object"  from garland.TEMP_SYN2;	

	select count(*) "gis_object"  from garland.Gis_Objects_Copy;

--	================================================================
--	Check List

--	Disable  triggers;				Alter table		garland.	disable all triggers;

--	Truncate application table			Truncate table	garland.	reuse storage;
--	Drop	   application table			Drop	   table	garland.	;

--	Alter	or Create application table.		Alter table		garland.

--	Make any modifications to Copy_From script.

--	================================================================
	set echo on;

