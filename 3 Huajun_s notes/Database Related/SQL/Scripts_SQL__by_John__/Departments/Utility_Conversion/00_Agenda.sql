
=======================
	AGENDA
=======================

--	===============================================================================
--	Conversion package root directory

	c:\deacutis\scripts\departments\utility_conversion

--	===============================================================================

x.	Specify utility tables for processing

		\\dba\dba_redefine\0_specs.sql

x	Save Old Table Definitions	GARLAND

		\\dba\dba_redefine\create_table.sql

x	Save Old Index Definitions	GARLAND

		\\dba\dba_redefine\create_index.sql

--	===============================================================================

x	Export all Utitlity Tables	GARLAND

x	Backup all Utility Tables	GARLAND

		\\copy\make_backup_current.sql

--	===============================================================================

x	Build Name Cases		GIS_Objects			Temp_View

		\\name\build_name_cases.sql

x	Build Clone Cases		GIS_Temp1			Temp_View1

		\\name\build_clone_cases.sql

--	===============================================================================

	Create New Tables			JDEACUTIS

x		\\Sanitation\tbl_

x		\\Storm\tbl_

x		\\Water\tbl_

	Build  New Tables			GARLAND to JDEACUTIS

x		\\build\build_new_tables.sql

--	===============================================================================

--	Drop   New Tables			GARLAND
--	Create New Tables			GARLAND  as JDEACUTIS

--	===============================================================================

	Create Constraints		GARLAND

	Create Triggers			GARLAND

--	===============================================================================
--	===============================================================================

		mslink
		mapid
		project num
		xxx id
		map grid
		map quad
		xxx num

--	===============================================================================
	
	UTSANFIT / UTSANCLEN

	UTSTOARW / UTWATARW

	Assign ID
	Review ID prefix/suffix

	UPstream,DNstream			UTSTOJUNC, UTSTOPIPE
	DESCRIPTION				UTSANLSTA

--	===============================================================================

	Drop new GARLAND

		\\build\make_drop_table.sql


	Define newer GARLAND

		\\define\define_utility.sql


	Copy new JDEACUTIS new to newer GARLAND

		\\build\make_build_new.sql

		FIT / CLEN

--	===============================================================================
--	===============================================================================

