
	=======================================================================
	GENERATE BUILDING INSPECTION ASCII FILE FROM BUILDING INSPECTION REPORT
	=======================================================================


	x.	receive email from Planning having bldg insp report attachment

	x.	save report attachment to \\scripts\Loader

	x.	click GIS_2K3_DBS icon:   gis-2k3-dbs\jdeacuti	john1947
		this is the "external directory"

	x.	copy & paste above Loader file to "external directory"

	x.	\\external_access\external_table\EXTERNAL_VIEW1.sql

		change "location" to point to file in "external directory"
		execute script

	x.	execute		\\departments\bldg_permit\1_ASCI_bldg_insp_rept.sql

	x.	execute		\\departments\bldg_permit\2_ASCI_bldg_insp_out.sql
		copy & paste to	\\EXCEL\<file name>

	x.	email \\EXCEL\<file name>  to Planning dept