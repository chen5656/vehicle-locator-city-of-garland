--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	1000;
set pagesize	9999;
--	=====================================================================

--	execute garland.CCS_TAX

--	create or replace procedure garland.CCS_TAX_Build_Common_Tax	as

	DECLARE

--	=====================================================================

	compile_only		integer	:= 0;
	do_insert			integer	:= 01;

	total_processed		integer	:= 0;

	this_Tax_Account		varchar2(100);
	this_Exempt_Code		varchar2(100);

	put_attn			varchar2(80);
	put_name			varchar2(80);
	put_unit			varchar2(80);
	put_strt			varchar2(80);
	put_city			varchar2(80);
	put_state			varchar2(80);
	put_cast			varchar2(80);
	put_error			varchar2(80);

	title				varchar2(100);
	heading			varchar2(100);
	script			varchar2(100);

cursor  Read_TAX_ADR	is

	select
		T.rowid	TAX_rowid,
		R.rowid	RES_rowid,
		A.rowid	ADR_rowid

	from	garland.GDS_Account		T,
		garland.adrResult_TAX_GDS	R,
		garland.cdrelADR			A

	where	t.account		= r.rec_key
	and	a.mslink   (+)	= to_number(r.segment_id)	
	and	a.addr_num (+) > '0'					
	and	a.addr_num (+) <> 9999 					
--	and	a.addr_num (+) not between 9000 and 9999
	and	ltrim(r.addr_code1) is null
	and	ltrim(r.addr_unit1) is null
	and	ltrim(r.addr_name) is not null			
	and	r.addr_num		 is not null			
--	and	r.verify_code 	= '55'				

--	AND ROWNUM < 11
	;

--	===========================================================================
--	truncate table	garland.plan_table		reuse storage;
--	explain plan	set statement_id = 'common tax'  into garland.plan_table  for
--	===========================================================================
--	=====================================================================
--	select * from garland.explain_Plan;
--	insert   into garland.plan_table (object_owner, object_name) values ('', '');
--	execute	  garland.explain_More;
--	select * from garland.explain_Indexed;
--	select * from garland.explain_Analyze;
--	select * from garland.explain_Column;
--	=====================================================================

	ADR	garland.CDRELADR%rowtype;
	RES	garland.adrResult_TAX_GDS%rowtype;
	TAX	garland.GDS_Account%rowtype;
	EXM	garland.GDS_Exemption%rowtype;
	
BEGIN

	if	compile_only > 0		then
		return;
	end if;

	title := 'BUILD COMMON TAX'; dbms_output.put_line(title);

	if	do_insert > 0		then
		script := 'Truncate table garland.Common_Tax reuse storage';	
		execute immediate (script);
	end if;

for	READ in Read_TAX_ADR	loop

	select * into TAX from garland.GDS_Account 	 where rowid = read.TAX_rowid;
	select * into RES from garland.adrResult_TAX_GDS where rowid = read.RES_rowid;

	if	read.ADR_rowid is null		then
		ADR := null;
	else
		select * into ADR from garland.CDRELADR  	 where rowid = read.ADR_rowid;
	end if;

	this_tax_account := lpad(TAX.Account,10,'0');

	select max(exempt_code)
	into	this_exempt_code
	from	garland.GDS_Exemption	E	
	where	e.account = this_TAX_Account
	and	e.exempt_code in ( 'HS', 'AG', 'SR' );

	if	this_exempt_code is null	then
		select max(exempt_code)
		into	this_exempt_code
		from	garland.GDS_Exemption	E	
		where	e.account = this_TAX_Account
		and	e.exempt_code in ( 'DV' );
	end if;

	garland.FORMAT_TAX_OWNER 
	( TAX.owner_addr1, TAX.owner_addr2, TAX.owner_addr3, TAX.owner_addr4, 
	  put_attn,  put_unit, put_strt, put_city, put_state, put_name, put_cast, put_error);

--	=====================================================================

	if	do_insert > 0			then
	insert
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

		,tax_deed_chng_date
		,legal_desc
		,occupied

--		,tax_collect_mortgage
--		,tax_collect_agent
--		,tax_collect_lender
--		,parent_id
--		,blk
--		,lot
--		,subdivision
	)
	select
		to_number(res.segment_id)							address_id,	
		lpad	(rtrim (tax.account),10,'0')						account,
		rtrim (tax.pidn)									pidn,

		res.addr_num									addr_num,		
		res.addr_pfx									addr_pfx,
		res.addr_name									addr_name,
		res.addr_type									addr_type,
		res.addr_sfx									addr_sfx,
		res.addr_code1									addr_bldg,
		res.addr_unit1									addr_unit,
		adr.zip_code									tax_addr_zip,

		tax.owner_name									tax_owner,
		nvl(put_attn, put_name)								tax_addr1,		
		put_strt ||' '|| put_unit							tax_addr2,
		put_city										tax_city,
		put_state										tax_state,
		rpad(tax.owner_zip,5) ||'-'|| substr(tax.owner_zip,6)			tax_zip,

		decode(rpad(tax.acct_use,01), 'A', '1', 'B', '2', '3')		prop_type,
		decode(rpad(tax.acct_use,01),'A','SFR','B','MULTI','COMMERCIAL')	zoning_code,
		this_exempt_code									tax_exempt,

		sysdate										deed_chng_date,

		tax.legal1||' '||tax.legal2||' '||tax.legal3||' '||tax.legal4	legal_desc,
		'1'											occupied

	from dual;

--	-------------------------------------------------------------------------------
--		NULL											mortgage,
--		NULL											agent,
--		NULL											lender,
--		null											parent_id,
--		null											blk, 
--		null											lot,
--		null											subdivision
--	-------------------------------------------------------------------------------
	end if;

end loop;

	COMMIT;

	script :=  'analyze table garland.Common_Tax compute statistics';
	execute immediate (script);
END;


