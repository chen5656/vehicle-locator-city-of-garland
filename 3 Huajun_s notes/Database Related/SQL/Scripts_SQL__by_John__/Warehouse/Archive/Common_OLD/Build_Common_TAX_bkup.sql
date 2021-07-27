	set echo		off;
    set linesize	2000;
	set fetchrows	111;
--	==========================================================================

--	EXPAND CCS_  Street & Unit	from 30 to 50	<<<<<<<<<=================

--	==========================================================================

	Truncate table	GARLAND.Common_Tax		reuse storage;
--	Truncate table	JDEACUTIS.Common_Tax		reuse storage;

--	===========================================================================
/*
	truncate table	garland.GIS_Objects		reuse storage;

	insert --+ append
	into	 garland.GIS_Objects  (item01, item02)
	select segment_id, max(rowid)
	from	 garland.adrResult_TAX_GDS	
	group  by segment_id;

	analyze table	garland.GIS_Objects		compute statistics;
*/
--	===========================================================================

	truncate table	garland.plan_table		reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	===========================================================================
--	explain plan	set statement_id = 'xxx'	for

--	select count(*) from (

	insert --+ append

	into	 GARLAND.Common_TAX
--	into	 JDEACUTIS.Common_TAX

	select

--	-------------------------------------------------------------------------------
		to_number(R.segment_id)								address_id,	
--	-------------------------------------------------------------------------------

		rtrim (t.account),	
		rtrim (x.dcad_acct),

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
		o.attn 										tax_addr1,
	RPAD(	o.strt ||' '|| o.unit	,30)							tax_addr2,		-- TEMP
		o.city										tax_city,
		o.state										tax_state,

--		t.owner_addr1									tax_addr1,
--		o.street										tax_addr2,
--		rpad(substr(o.city_st, 01,   instr(o.city_st,',') - 01) ,15)	tax_city,
--		rpad(ltrim(substr(o.city_st, instr(o.city_st,',') + 01)),02)	tax_state,
--	-------------------------------------------------------------------------------

		rpad(t.owner_zip,5) ||'-'|| substr(t.owner_zip,6)				tax_zip,

		decode (rpad(t.acct_use,01), 'A', '1', 'B', '2', '3')				prop_type,
		decode (rpad(t.acct_use,01), 'A', 'SFR', 'B', 'MULTI', 'COMMERCIAL')	zoning_code,


		NULL											exempt,
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
--		garland.GDS_Exemption			E,
		garland.GDS_Crossref			X,
		garland.adrResult_Tax_GDS		R,
		garland.cdrelADR				A,
		garland.GIS_Objects			G,	--  specify single TAX Account occurrence
		garland.Temp_View1			O	--  Owner Address fields

/*
(
	select

	decode(
	decode(owner_addr2,null,0,100) + decode(owner_addr3,null,0,10) + decode(owner_addr4,null,0,1),
	110,owner_addr2,	111,owner_addr3,	null)						street,

	decode(
	decode(owner_addr2,null,0,100) + decode(owner_addr3,null,0,10) + decode(owner_addr4,null,0,1),
	100, owner_addr2,	110, owner_addr3,	111, owner_addr4,	null)			city_st

	from		garland.GDS_Account
)								O
*/

	where	t.account		= r.rec_key

	and	r.segment_id	= g.item01
	and	r.rowid		= chartorowid(g.item02)

	and	t.account		= x.gds_acct

	and	o.account		= rtrim(t.account)

	and	a.mslink		= to_number(r.segment_id)

	and	r.verify_code 	= '55'

	and	rtrim(r.addr_code1) is null
	and	rtrim(r.addr_unit1) is null
	;

--	===========================================================================

	commit;
	alter rollback segment rb1 offline;

--	analyze table	GARLAND.Common_Tax		compute statistics;
--	analyze table	JDEACUTIS.Common_Tax		compute statistics;

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	===========================================================================

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
	from	GARLAND.common_tax
--	from	JDEACUTIS.common_tax
	group by tax_address_id
	having count(*) > 1

*/
--	===========================================================================
	set echo	on;
	set fetchrows;

