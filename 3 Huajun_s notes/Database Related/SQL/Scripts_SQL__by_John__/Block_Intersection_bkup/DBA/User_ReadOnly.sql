
--	===================================================================

	create user	readonly
		identified by		gis2221read
		default tablespace	gis_data
		temporary tablespace	gistemp_segs;

--	===================================================================

	grant 	create session		to readonly;
	grant 	select any table		to readonly;
	grant 	execute any procedure	to readonly;
	grant 	alter session		to readonly;

--	===================================================================
