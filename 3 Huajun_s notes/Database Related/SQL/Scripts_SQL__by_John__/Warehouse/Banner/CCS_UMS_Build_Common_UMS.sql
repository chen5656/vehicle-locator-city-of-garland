--	=====================================================================
set echo		off;
set timing		on;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	800;
set pagesize	9999;
--	=====================================================================
--	BUILD COMMON UMS
--	=====================================================================

DECLARE

	compile_only		integer := 0;
	do_print			integer := 1000;

	total_insert		integer := 0;
	total_addr_error		integer := 0;
	total_update		integer := 0;
	total_ignore		integer := 0;
	counter			integer := 0;
	script			varchar2(100);

	UMS				garland.common_ums%rowtype;

--	=====================================================================
cursor	READ_ACCT_PREM_CUST		is

	select 
		a.rowid	acct_rowid, 
		p.rowid	prem_rowid, 
		c.rowid	cust_rowid
	from	ucrACCT@banbprd		A,
		ucbPREM@banbprd		P,
		ucbCUST@banbprd		C

	where	a.ucracct_prem_code	= p.ucbprem_code
	and	a.ucracct_cust_code	= c.ucbcust_cust_code
	and	ucracct_status_ind	= 'A'
	and	ucbcust_status_ind	= 'A'
	and	translate(p.ucbprem_street_number,'x1234567890','x') is null
	and	p.ucbprem_date_retired	is null
	and	rtrim(p.ucbprem_unit)	is null
	and	length(ucbprem_street_name) <= 20
	and	length(ucbcust_last_name)   <= 40
	;

	ACCT			ucracct@banbprd%rowtype;
	PREM			ucbprem@banbprd%rowtype;
	CUST			ucbcust@banbprd%rowtype;

	ADDR			garland.adrResult_UMS_Location%rowtype;
	ADDR_ROWID		rowid;

--	=====================================================================
cursor	READ_DUPE_ADDRESS		is

	select	UMS.rowid		ums_rowid,
			ADR.location_no
	from		garland.Common_UMS	UMS,
(
	select 
		max(location_no)	location_no,
		addr_name,
		addr_num,
		addr_type,
		addr_pfx,
		addr_sfx
	from		garland.Common_UMS
	group by	addr_name, addr_type, addr_pfx, addr_sfx, addr_num 
	having	count(*) > 1
)							ADR
	where	ums.addr_name	= adr.addr_name
	and	ums.addr_num	= adr.addr_num
	and	ums.addr_type	= adr.addr_type
	and	ums.addr_pfx	= adr.addr_pfx
	and	ums.addr_sfx	= adr.addr_sfx
	order by	ums.addr_name, ums.addr_type, ums.addr_pfx, ums.addr_sfx, ums.addr_num ;

--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan set	statement_id = 'x'	into jdeacutis.plan_table for
--	=====================================================================
--	=====================================================================
--	select * from jdeacutis.explain_Plan;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================

--	=====================================================================
BEGIN

	if	compile_only > 0	then
		return;
	end if;

	dbms_output.put_line ( '*** CCS UMS Build Common UMS ***');

	script	:= 'truncate table  garland.Common_UMS  reuse storage';
	execute immediate (script);

for	read in READ_ACCT_PREM_CUST		loop

	select * into ACCT 	from ucracct@banbprd	where rowid = read.acct_rowid;
	select * into PREM 	from ucbprem@banbprd	where rowid = read.prem_rowid;
	select * into CUST 	from ucbcust@banbprd	where rowid = read.cust_rowid;

	select count(*), max(A.rowid)
	into	counter, addr_rowid
	from	garland.adrResult_UMS_Location	A
	where	rec_key = prem.ucbprem_code;

	if	counter = 1		then
		select * into ADDR	from garland.adrResult_UMS_Location	where rowid = addr_rowid;
	else
		ADDR := null;
		total_addr_error := total_addr_error + 01;
	end if;

	insert into	 garland.Common_UMS
(
		 address_id
		,addr_num
		,addr_pfx
		,addr_name
		,addr_type
		,addr_sfx
		,addr_bldg	,addr_unit

		,location_no
		,account_no
		,person_no

		,last_name
		,first_name
		,drivers_license
		,birth_date
		,parent_id
)
	select
		ADDR.segment_id,
		nvl(ADDR.addr_num,	PREM.ucbprem_street_number),
		nvl(ADDR.addr_pfx,	PREM.ucbprem_pdir_code_pre),
		nvl(ADDR.addr_name,	PREM.ucbprem_street_name),
		nvl(ADDR.addr_type,	PREM.ucbprem_ssfx_code),
		nvl(ADDR.addr_sfx,	PREM.ucbprem_pdir_code_post),
		null, null,

		PREM.ucbprem_code,
		ACCT.ucracct_old_account,
		CUST.ucbcust_cust_code,

		CUST.ucbcust_last_name,
		CUST.ucbcust_first_name,
		CUST.ucbcust_drivers_license,
		CUST.ucbcust_birth_date,
		ADDR.rec_key
	from	dual;

	total_insert := total_insert + 01;

end loop;

	COMMIT;

	dbms_output.put_line ( '-----');
	dbms_output.put_line ( 'TOTAL INSERT:      ' || total_insert);
	dbms_output.put_line ( 'TOTAL UNVALIDATED: ' || total_addr_error);

	script	:= 'analyze table  garland.Common_UMS  compute statistics';
	execute immediate (script);

--	=====================================================================
--	MARK DUPLICATE ADDRESSES

for	read in READ_DUPE_ADDRESS		loop

	if	do_print > 0		then
		do_print := do_print - 01;
		select * into UMS from garland.Common_UMS where rowid = read.UMS_rowid;
		dbms_output.put_line('DUPE ADDRESS: '||rpad(ums.location_no,10)||' '||
			ums.addr_num||' '||ums.addr_pfx||' '||ums.addr_name||' '||ums.addr_type||' '||ums.addr_sfx); 
	end if;

	update  garland.Common_UMS
	set	parent_id = read.location_no
	where	rowid = read.ums_rowid;

	total_update := total_update + 01;

end loop;

	COMMIT;

	select count(*) into total_ignore from garland.common_ums where location_no <> parent_id;

	dbms_output.put_line ( '-----');
	dbms_output.put_line ( 'TOTAL UPDATE: ' || total_update);
	dbms_output.put_line ( 'TOTAL IGNORE: ' || total_ignore);

--	=====================================================================

END;

