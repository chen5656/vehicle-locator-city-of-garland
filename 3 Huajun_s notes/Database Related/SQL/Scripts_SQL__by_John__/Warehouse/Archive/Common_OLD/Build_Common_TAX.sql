--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';
--	==========================================================================

	Truncate table	JDEACUTIS.Common_Tax		reuse storage;	

--	===========================================================================
--	truncate table	garland.plan_table		reuse storage;
--	explain plan	set statement_id = 'common tax'		for
--	===========================================================================

--	select count(*) from (

	insert --+ append
	into	 JDEACUTIS.Common_TAX		
	select
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
		null											parent_id
--	-------------------------------------------------------------------------------
	from	garland.GDS_Account			T,
		garland.adrResult_TAX_GDS		R,
		garland.cdrelADR				A,
--  Owner Address fields
		garland.Temp_View1			O,	
--  Exemptions
		garland.Temp_View2			E	
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
	AND   LENGTH(R.ADDR_NAME) <= 20
--	)
	;

--	===========================================================================

	commit;

	analyze table	JDEACUTIS.Common_Tax		compute statistics;

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	===========================================================================
/*

	analyze table	garland.GDS_Account		compute statistics;
	analyze table	garland.GDS_Crossref		compute statistics;
	analyze table	garland.GDS_Exemption		compute statistics;
	analyze table	garland.Address_Unit		compute statistics;
	analyze table	garland.adrResult_TAX_GDS	compute statistics;

	select count(*) account			from garland.gds_account;
	select count(*) crossref		from garland.gds_crossref;
	select count(*) exemption		from garland.gds_exemption;
	select count(*) address_unit		from garland.address_unit;
	select count(*) adrResult		from garland.adrResult_TAX_GDS;

	select count(count(*))
	from	GARLAND.Common_Tax
	group by tax_address_id
	having count(*) > 1

*/
--	===========================================================================


