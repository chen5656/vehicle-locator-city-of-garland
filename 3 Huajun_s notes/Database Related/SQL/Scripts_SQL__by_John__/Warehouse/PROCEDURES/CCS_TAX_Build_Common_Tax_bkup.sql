--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

--	execute	garland.CCS_TAX_Build_Common_Tax;

	create or replace procedure garland.CCS_TAX_Build_Common_Tax		as

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

	title := 'BUILD COMMON TAX   ';
	dbms_output.put_line(title);

	script := 'Truncate table garland.Common_Tax reuse storage';	
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

--	===========================================================================
--	truncate table	garland.plan_table		reuse storage;
--	explain plan	set statement_id = 'common tax'		for
--	===========================================================================

	insert --+ append
	into	 garland.Common_TAX		
	(
		 tax_address_id
		,tax_account
		,tax_dcad
		,tax_addr_num
		,tax_addr_pfx
		,tax_addr_name
		,tax_addr_type
		,tax_addr_sfx
		,tax_addr_bldg
		,tax_addr_unit
		,tax_addr_zip
		,tax_owner
		,tax_addr1
		,tax_addr2
		,tax_city
		,tax_state
		,tax_zip
		,tax_prop_type
		,tax_zoning_code
		,tax_exempt
		,tax_collect_mortgage
		,tax_collect_agent
		,tax_collect_lender
		,tax_deed_chng_date
		,legal_desc
		,occupied
		,parent_id
		,blk
		,lot
		,subdivision
	)
	select Distinct
--	-------------------------------------------------------------------------------
		to_number(R.segment_id)							address_id,	
--	-------------------------------------------------------------------------------
		LPAD(rtrim (t.account),10,'0'),
		rtrim (t.pidn),
		r.addr_num,		
		r.addr_pfx,
		r.addr_name,
		r.addr_type,
		r.addr_sfx,
--	-------------------------------------------------------------------------------
		R.addr_code1									addr_bldg,
		R.addr_unit1									addr_unit,
--	-------------------------------------------------------------------------------
		a.zip_code										tax_addr_zip,
		t.owner_name									tax_owner,
--	-------------------------------------------------------------------------------
		nvl(o.attn, o.name)								tax_addr1,		
		o.strt ||' '|| o.unit								tax_addr2,
		o.city										tax_city,
		o.state										tax_state,
--	-------------------------------------------------------------------------------
		rpad(t.owner_zip,5) ||'-'|| substr(t.owner_zip,6)				tax_zip,

		decode (rpad(t.acct_use,01), 'A', '1', 'B', '2', '3')				prop_type,

		decode (rpad(t.acct_use,01), 'A', 'SFR', 'B', 'MULTI', 'COMMERCIAL')	zoning_code,

		e.exempt1 										exempt,
		NULL											mortgage,
		NULL											agent,
		NULL											lender,
		NULL											deed_chng_date,

		t.legal1 ||' '|| t.legal2 ||' '|| t.legal3 ||' '|| t.legal4		legal_desc,
		'1'											occupied,
--	-------------------------------------------------------------------------------
		null											parent_id,
		null											blk, 
		null											lot,
		null											subdivision
--	-------------------------------------------------------------------------------
	from	garland.GDS_Account			T,
		garland.adrResult_TAX_GDS		R,
		garland.cdrelADR				A,
		garland.CCS_TAX_FORMAT_VIEW		O,	
		garland.CCS_TAX_EXEMPTION_VIEW	E	
	where	t.account		= r.rec_key
	and	t.account		= e.account (+)
	and	rtrim(t.account)	= o.account (+)
	and	a.mslink (+)	= to_number(r.segment_id)	
	and	a.addr_num (+) > '0'					
	and	a.addr_num (+) <> 9999 					
--	and	a.addr_num (+) not between 9000 and 9999
	and	ltrim(r.addr_code1) is null
	and	ltrim(r.addr_unit1) is null
	and	ltrim(r.addr_name) is not null			
	and	r.addr_num		 is not null			
--	and	r.verify_code 	= '55'				
--	AND   LENGTH(R.ADDR_NAME) <= 20
--	)
	;
--	=====================================================================
	select * from jdeacutis.explain_Plan;
	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================

	total_processed := sql%rowcount;
	dbms_output.put_line ( 'Total Inserts: ' || total_processed);

	COMMIT;

--	===========================================================================

	script :=  'analyze table garland.Common_Tax compute statistics';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

END;

