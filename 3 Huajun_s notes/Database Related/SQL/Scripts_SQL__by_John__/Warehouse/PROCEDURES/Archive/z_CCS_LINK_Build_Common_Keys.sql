--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================
--	LINK  GIS / TAX / UMS  keys into Common Keys record
--	=====================================================================

--	execute	garland.CCS_LINK_Build_Common_Keys;

	create or replace procedure garland.CCS_LINK_Build_Common_Keys	as

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

--	=================================================================================
--	Obtain all addresses from GIS, TAX, and UMS
--	Store source application keys for GIS, TAX, UMS with each address
--	=================================================================================

	title := '***  Build GIS Keys  ';  dbms_output.put_line(title);

--	garland.Extract1_Address_Keys		
	script := 'truncate table garland.GIS_Temp1 reuse storage';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan set statement_id = '1-GIS'		into garland.plan_table	for
--	=================================================================================

--	OBTAIN GIS ADDRESSES

	insert --+	append
	into	garland.EXTRACT1_ADDRESS_KEYS
(
	addr_name, addr_num, addr_type, addr_pfx, addr_sfx, addr_code, addr_bldg, addr_unit, 
	GIS_key, Parcel_ID, Source
)
	select distinct
	addr_name, addr_num, addr_type, addr_pfx, addr_sfx, ' ', ' ', ' ',
	mslink, parcel_id, 'GIS'
	from	garland.CDRELADR

	where	addr_num > 0
	and	addr_num not between 9000 and 9999
	and	rtrim(unit_type) is null
	and	rtrim(unit_num)  is null
	;

	total_processed := sql%rowcount;
	dbms_output.put_line ( 'GIS Insert total = ' || total_processed);

	COMMIT;

--	=================================================================================

	title := '***  Build TAX Keys  ';  dbms_output.put_line(title);

--	garland.Extract2_Address_Keys
	script := 'truncate table garland.GIS_Temp2 reuse storage';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan set statement_id = '2-TAX'		into garland.plan_table	for
--	=================================================================================

	insert --+	append
	into	garland.EXTRACT2_ADDRESS_KEYS
(
	addr_name, addr_num, addr_type, addr_pfx, addr_sfx, addr_code, addr_bldg, addr_unit, 
	GIS_key, TAX_key, Parcel_ID, Source
)
	select							--	OBTAIN TAX ADDRESSES THAT MATCH GIS
		a.addr_name, a.addr_num, a.addr_type, a.addr_pfx, a.addr_sfx, ' ', ' ', ' ',
		a.GIS_key, ltrim(t.TAX_ACCOUNT,'0'), a.Parcel_ID, Source
	from	garland.EXTRACT1_ADDRESS_KEYS		A,
		garland.COMMON_TAX			T
	where	a.addr_name		= t.tax_addr_name	(+)
	and	a.addr_type		= t.tax_addr_type	(+)
	and	a.addr_pfx		= t.tax_addr_pfx	(+)
	and	a.addr_sfx		= t.tax_addr_sfx	(+)
--	and	a.addr_bldg		= t.tax_addr_bldg	(+)
--	and	a.addr_unit		= t.tax_addr_unit	(+)
	and	a.addr_num		= ltrim(t.tax_addr_num (+),'0')	

--	OBTAIN TAX ADDRESSES THAT DON'T MATCH GIS
	UNION ALL						
	select
		t.tax_addr_name, t.tax_addr_num||'', t.tax_addr_type, t.tax_addr_pfx, t.tax_addr_sfx, ' ', ' ', ' ',
		null, ltrim(t.TAX_ACCOUNT,'0'), null, 'TAX'
	from	garland.COMMON_TAX			T
	where not exists
(
	select 'x'
	from	garland.EXTRACT1_ADDRESS_KEYS		A
	where	a.addr_name		= t.tax_addr_name	
	and	a.addr_type		= t.tax_addr_type	
	and	a.addr_pfx		= t.tax_addr_pfx	
	and	a.addr_sfx		= t.tax_addr_sfx	
--	and	a.addr_bldg		= t.tax_addr_bldg
--	and	a.addr_unit		= t.tax_addr_unit	
	and	a.addr_num		= ltrim(t.tax_addr_num,'0')	
)
	and	ltrim(t.tax_addr_num) > 0
	and	ltrim(t.tax_addr_num) not between 9000 and 9999
	and	rtrim(t.tax_addr_bldg) is null
	and	rtrim(t.tax_addr_unit) is null
	;

	total_processed := sql%rowcount;
	dbms_output.put_line ( 'Insert TAX total = ' || total_processed);

	COMMIT;

--	=================================================================================

	title := '***  Build UMS Keys  ';  dbms_output.put_line(title);

--	garland.Extract1_Address_Keys
	script := 'truncate table garland.GIS_Temp1 reuse storage';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

--	=================================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan set statement_id = '3-GIS'		into garland.plan_table	for
--	=================================================================================

--	OBTAIN UMS ADDRESSES THAT MATCH GIS OR TAX

	insert --+	append
	into	garland.EXTRACT1_ADDRESS_KEYS
(
	addr_name, addr_num, addr_type, addr_pfx, addr_sfx, addr_code, addr_bldg, addr_unit, 
	GIS_key, TAX_key, UMS_key, Parcel_ID, Source
)
	select distinct
		a.addr_name, a.addr_num, a.addr_type, a.addr_pfx, a.addr_sfx, ' ', ' ', ' ',
		a.GIS_key, a.TAX_key, c.LOCATION_NO, a.Parcel_ID, Source

	from	garland.EXTRACT2_ADDRESS_KEYS		A,
		garland.COMMON_UMS			C

	where	a.addr_name		= c.addr_name	(+)
	and	a.addr_type		= c.addr_type	(+)
	and	a.addr_pfx		= c.addr_pfx	(+)
	and	a.addr_sfx		= c.addr_sfx	(+)
--	and	a.addr_bldg		= c.addr_bldg	(+)
--	and	a.addr_unit		= c.addr_unit	(+)
	and	a.addr_num		= ltrim(c.addr_num(+),'0')	

	and	ltrim(c.addr_num (+)) > 0
	and	rtrim(c.addr_bldg(+)) is null
	and	rtrim(c.addr_unit(+)) is null
	;

	total_processed := sql%rowcount;
	dbms_output.put_line ( 'Insert UMS total = ' || total_processed);

	COMMIT;

--	=================================================================================
--	select * from garland.explain_Plan;
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Column;
--	select * from garland.explain_Analyze;
--	=================================================================================

END;

