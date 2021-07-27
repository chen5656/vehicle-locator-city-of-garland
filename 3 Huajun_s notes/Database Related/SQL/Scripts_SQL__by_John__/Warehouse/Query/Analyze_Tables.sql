	set echo	off;
--	========================================================================

	analyze table	GARLAND.Common_GIS		compute statistics;
	analyze table	JDEACUTIS.Common_GIS		compute statistics;

	analyze table	GARLAND.Common_TAX		compute statistics;
	analyze table	JDEACUTIS.Common_TAX		compute statistics;

	analyze table	GARLAND.Common_UMS		compute statistics;
	analyze table	JDEACUTIS.Common_UMS		compute statistics;

--	========================================================================

	analyze table	garland.cdreladr			compute statistics;

	analyze table	garland.cdrelpar			compute statistics;

--	analyze table	garland.block			compute statistics;
--	analyze table	garland.trvehrcl			compute statistics;
--	analyze table	garland.intersection		compute statistics;

--	========================================================================
	set echo	on;
