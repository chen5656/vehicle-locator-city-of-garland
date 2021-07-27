	set echo off;
--	================================================================================
--	Special modifications to Common TAX
--	================================================================================

	drop synonym	garland.Test_Syn;

--	create synonym	garland.Test_Syn		for	garland.Common_TAX;
	create synonym	garland.Test_Syn		for	jdeacutis.Common_TAX;

--	================================================================================

--	--------------------------------------------------------------------------------
--	ERASE EXEMPTION STATUS
--	--------------------------------------------------------------------------------

	update 	garland.Test_Syn
	set		Tax_Exempt = null
	where		tax_address_id in  ( 58440	);


	select	tax_account "Account", tax_address_id "GIS ID",
			tax_addr_num " ",tax_addr_pfx " ",tax_addr_name " ",tax_addr_type " ",tax_addr_sfx " ",
			TAX_EXEMPT
	from		garland.Test_Syn
	where		tax_address_id in  ( 58440	)
	order by	tax_addr_name, tax_addr_type, tax_addr_pfx, tax_addr_sfx, tax_addr_num;

--	================================================================================
--	DISPLAY ALL MODIFIED TAX RECORDS
--	================================================================================

	select *	from garland.Test_Syn 
	where		tax_address_id in  ( 58440	)
	or		tax_address_id in  ( null	)
	order by	tax_addr_name, tax_addr_type, tax_addr_pfx, tax_addr_sfx, tax_addr_num;

--	================================================================================

	Savepoint	xxx;
	Rollback;

	Commit;

--	================================================================================
	set echo on;

