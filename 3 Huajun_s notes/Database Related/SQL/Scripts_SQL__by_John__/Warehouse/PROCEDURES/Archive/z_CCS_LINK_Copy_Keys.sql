--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

--	=====================================================================

--	execute	garland.CCS_LINK_Copy_Keys;

	create or replace procedure garland.CCS_LINK_Copy_Keys	as

--	DECLARE

--	=====================================================================

	compile_only	integer	:= 0;

	total_processed	integer	:= 0;
	title			varchar2(100);
	heading		varchar2(100);
	script		varchar2(2000);

BEGIN

	if	compile_only > 0		then
		return;
	end if;

	title := '***  CCS LINK Copy';  dbms_output.put_line(title);

--	=============================================================================

	script := 'Truncate table garland.Common_Address_Keys reuse storage';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

--	=============================================================================

	insert --+ append
	into	 garland.Common_Address_Keys
	select
		addr_num,		
		addr_pfx,		
		addr_name,		
		addr_type,		
		addr_sfx,		
		Source,		
		Parcel_ID,
		Sequence,		
		GIS_Key,	
		TAX_Key,
		UMS_Key	
	from  garland.Extract1_Address_Keys;

	total_processed := sql%rowcount;
	dbms_output.put_line ( 'Copy Key total = ' || total_processed);

	COMMIT;

--	=============================================================================

	script := 'Analyze table garland.Common_Address_Keys compute statistics';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

--	=============================================================================
/*
	update garland.Common_Record_Seq
	set	gis_key	= nvl(gis_key,'0'),
		tax_key	= nvl(tax_key,'0'),
		ums_key	= nvl(ums_key,'0');

	total_processed := sql%rowcount;
	dbms_output.put_line ( '  total =' || total_processed);

	COMMIT;
*/
--	====================================================================

END;
