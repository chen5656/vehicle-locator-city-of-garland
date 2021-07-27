	set echo	off;
    set linesize	2000;
--	========================================================================

	analyze table	GARLAND.Common_Address_Keys		compute statistics;

	analyze table	GARLAND.Common_GIS			compute statistics;

	analyze table	GARLAND.Common_TAX			compute statistics;

	analyze table	GARLAND.Common_UMS			compute statistics;

	analyze table	GARLAND.CDRELPAR				compute statistics;

--	========================================================================
	set echo	on;
