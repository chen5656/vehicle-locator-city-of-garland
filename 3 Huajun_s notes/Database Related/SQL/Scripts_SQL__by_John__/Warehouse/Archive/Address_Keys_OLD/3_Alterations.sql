	set echo off;

--	====================================================================

	update garland.Common_Record_Seq
	set	gis_key	= nvl(gis_key,'0'),
		tax_key	= nvl(tax_key,'0'),
		ums_key	= nvl(ums_key,'0');

	commit;

--	====================================================================


