	set echo		off;
	set fetchrows	111;
--	===========================================================================
	truncate table	garland.plan_table	reuse storage;
--	===========================================================================

	truncate table	garland.Common_TAX	reuse storage;

	alter rollback segment rb1 online;
	commit;
	set transaction use rollback segment rb1;

--	===========================================================================
--	explain plan	set statement_id = 'xxx'	for

	insert --+ append
	into	 garland.Common_TAX

	select
		to_number(r.segment_id),		--  SHOULD BE ADDRESS ID

		rtrim (t.macctno),	
		rtrim (t.geoacct),

		substr(t.propaddr,21,06),		-- addr num
		substr(t.propaddr,19,02),		-- addr pfx
		rpad  (t.propaddr,18),			-- addr name
		substr(t.propaddr,27,04),		-- addr type
		null,						-- addr sfx
		null,						-- addr bldg
		rtrim (t.street),				-- addr unit
	
		n.tax_payer,
		n.addr1,
		n.addr2,
		n.city,
		n.state,
		t.anumber || decode(t.sfx, '    ', null, '-') || t.sfx	zip_code,

		decode (rpad(SPT,01), 'A', '1', 'B', '2', '3')				PROP_TYPE,

		decode (rpad(SPT,01), 'A', 'SFR', 'B', 'MULTI', 'COMMERCIAL')	ZONING_CODE,

		substr (c.EXEMPT, 01, instr(c.EXEMPT,'/') - 01)				EXEMPTION,


		null,		-- mortgage
		null,		-- agent
		null,		-- lender
	
		t.ownrchngdt,

		to_number(r.segment_id)		--  SHOULD BE MSLINK


	from	garland.TAX					T,
		garland.TAX_NAME				N,
		garland.adrREsult_Tax_Account		R,
(
		select	macctno,
		
		sptlnd ||'/'|| sptimp ||'/'|| sptprd ||'/'|| decode(mprptyp, 'R', sptper, null)	SPT,

		decode(hscode, 'H', 'HOMESTEAD/', 'S', '>65/', 'D', 'DISABLED/', '5/', 'AGRICULTURE', null)
		||
		decode (dvcode, 0, null, 'DISABLED VET/')
		||
		decode (exempt, ' ', null, 'TOTAL/')								EXEMPT
		from garland.TAX
)								C

	where	rtrim(t.owner)	= n.acct_owner
	and	rtrim(t.macctno)	= r.rec_key
	and	t.macctno		= c.macctno
	;

--	===========================================================================

	commit;
	alter rollback segment rb1 offline;

	analyze table	garland.Common_Tax	compute statistics;

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	===========================================================================
	set echo	on;
	set fetchrows;

