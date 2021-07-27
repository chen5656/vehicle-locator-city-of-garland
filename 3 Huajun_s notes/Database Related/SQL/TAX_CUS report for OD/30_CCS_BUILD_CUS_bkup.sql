	select * from viewer.me;
--	BEGIN  SERVER USER  SERVER USER  SERVER USER  SERVER USER  SERVER USER  SERVER USER  END;
set	TIMING		ON;
set	sqlblanklines	on;
set	serveroutput	on	size 99999;
set	linesize		1000;
set	pagesize		50000;
--	execute jdeacutis.show_table_column	('ucracct ucbprem ucbcust', '', '@banbprd');
--	execute jdeacutis.show_table_column	('common_ums common_tax', 'garland', '');
--	execute jdeacutis.show_source		('test_proc', 'jdeacutis', '');
--	execute jdeacutis.show_error		('test_proc', 'jdeacutis', '');
--	execute jdeacutis.show_view		('', '', '');
--	execute jdeacutis.show_index_column	('', '', '');
--	SELECT  to_char(sysdate,'Mon dd,yyyy hh24:mi')||'  ***  ' " "  from dual;
--	EXECUTE jdeacutis.TEST_PROC;
--	CREATE or replace procedure jdeacutis.TEST_PROC  as
--	DECLARE
--	=====================================================================	
--	BUILD COMMON UMS
--	=====================================================================	

--	select count(*) extview	from garland.CCS_UMS_EXTRACT_VIEW;

--	select count( distinct UCRACCT_ACCT_CODE) 	from uimsmgr.ucrACCT@banbprd;
--	select count( distinct ucracct_old_account)	from uimsmgr.ucrACCT@banbprd;
--	select count( distinct account_no) 		from garland.common_ums;
--	select count( distinct ums_key) 		from garland.common_address_keys;

--	exec jdeacutis.show_column_values ( 'garland.common_ums', 0);
--	exec jdeacutis.show_column_values ( 'garland.common_address_keys', 0);

--	=====================================================================
/*	

--	dupe addresses with latest activity date
--	almost all have same last_name

	select 
		c.addr_name, c.addr_type, c.addr_pfx, c.addr_sfx, c.addr_num 
		,count(*), min(c.activity_date),max(c.activity_date), min(last_name),max(last_name)
	from		garland.Common_CUS	C
	group by	c.addr_name, c.addr_type, c.addr_pfx, c.addr_sfx, c.addr_num 
--			,c.activity_date
	having	count(*) > 1;

*/
--	=====================================================================

--	=====================================================================
/*

	CREATE or replace view	garland.CCS_UMS_EXTRACT_VIEW
(
	UCRACCT_ACCT_CODE,
	UCBPREM_CODE,
	UCBCUST_CUST_CODE,

	ucbprem_street_number,
	ucbprem_pdir_code_pre,
	ucbprem_street_name,
	ucbprem_ssfx_code,
	ucbprem_pdir_code_post,

	ucracct_old_account,
	ucbcust_last_name,
	ucbcust_first_name,
	ucbcust_drivers_license,
	ucbcust_birth_date,
	ucbcust_activity_date
)
	AS
(
	select --+ no_merge

		a.UCRACCT_ACCT_CODE,
		p.UCBPREM_CODE,
		c.UCBCUST_CUST_CODE,

		ucbprem_street_number,
		ucbprem_pdir_code_pre,
		ucbprem_street_name,
		ucbprem_ssfx_code,
		ucbprem_pdir_code_post,

		a.ucracct_old_account,
		c.ucbcust_last_name,
		c.ucbcust_first_name,
		c.ucbcust_drivers_license,
		c.ucbcust_birth_date,
		c.ucbcust_activity_date

	from	uimsmgr.ucrACCT@banbprd		A,
		uimsmgr.ucbPREM@banbprd		P,
		uimsmgr.ucbCUST@banbprd		C

	where	a.ucracct_prem_code	= p.ucbprem_code
	and	a.ucracct_cust_code	= c.ucbcust_cust_code
	and	a.ucracct_status_ind	= 'A'
	and	c.ucbcust_status_ind	= 'A'
	and	translate(p.ucbprem_street_number,'x1234567890','x') is null
	and	p.ucbprem_date_retired	is null
	and	rtrim(p.ucbprem_unit)	is null
	and	length(ucbprem_street_name) <= 20
	and	length(ucbcust_last_name)   <= 40
);

*/
--	=====================================================================

	select 'garland.CCS_BUILD_UMS  ' || to_char(sysdate,'hh24:mi:ss') 	" " from dual;

--	EXECUTE 	garland.CCS_BUILD_UMS;
--	CREATE or replace procedure garland.CCS_BUILD_UMS	AS

	DECLARE

--	=====================================================================

	compile_only		integer := 0;
	do_print			integer := 0;

	total_insert		integer := 01;
	total_delete1		integer := 01;
	total_delete2		integer := 01;
	total_addr_error		integer := 0;
	total_update		integer := 0;
	total_ignore		integer := 0;
	counter			integer := 0;
	script			varchar2(100);

	UMS			garland.Common_CUS%rowtype;

--	=====================================================================
Cursor	READ_ACCT_PREM_CUST		is

	select
		a.rowid		addr_rowid,
		u.*

	from	
		garland.adrResult_Banner		A,
		garland.CCS_UMS_EXTRACT_VIEW		U

	where	a.rec_key	= u.ucbprem_code
--	AND	a.VERIFY_CODE >= 10
	;

--	=====================================================================

--	ACCT			uimsmgr.ucracct@banbprd%rowtype;
--	PREM			uimsmgr.ucbprem@banbprd%rowtype;
--	CUST			uimsmgr.ucbcust@banbprd%rowtype;

	ADDR			garland.adrResult_BANNER%rowtype;
	BAN			garland.adrResult_BANNER%rowtype;

--	=====================================================================
--	=====================================================================
BEGIN

	if	compile_only > 0	then
		return;
	end if;

	dbms_output.put_line ( '*** Build Common CUS ***');

	script	:= 'truncate table  garland.Common_CUS  reuse storage';
	execute immediate (script);

	BAN := null;

for	read in READ_ACCT_PREM_CUST		loop

	select * into ADDR 	from garland.adrResult_Banner		where rowid = read.addr_rowid;

	if	Addr.Rec_Key = Ban.Rec_Key		then
		null;
	else

	INSERT into	 garland.Common_CUS
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

		,activity_date

--	jun 2011
		,account_no_now

)
	select
		ADDR.segment_id,

		nvl(ADDR.addr_num,	read.ucbprem_street_number),
		nvl(ADDR.addr_pfx,	read.ucbprem_pdir_code_pre),
		nvl(ADDR.addr_name,	read.ucbprem_street_name),
		nvl(ADDR.addr_type,	read.ucbprem_ssfx_code),
		nvl(ADDR.addr_sfx,	read.ucbprem_pdir_code_post),
		null, null,

		read.ucbprem_code,
		read.ucracct_old_account,
		read.ucbcust_cust_code,

		rtrim(rpad(read.ucbcust_last_name,40)),
		read.ucbcust_first_name,
		read.ucbcust_drivers_license,
		read.ucbcust_birth_date,
		ADDR.rec_key,

		read.ucbcust_activity_date,

--	jun  2011
		read.UCRACCT_ACCT_CODE


	from	dual;

	total_insert := total_insert + 01;
	end if;

	BAN := ADDR;

end loop;

	COMMIT;

	dbms_output.put_line ( '-----');
	dbms_output.put_line ( 'TOTAL INSERT:        ' || total_insert);
--	dbms_output.put_line ( 'TOTAL UNVALIDATED:   ' || total_addr_error);

	script	:= 'analyze table  garland.Common_CUS  compute statistics';
	execute immediate (script);


--	=====================================================================

	UPDATE	garland.Common_CUS
	set		addr_type	= nvl(addr_type,' '),
			addr_pfx	= nvl(addr_pfx, ' '),
			addr_sfx	= nvl(addr_sfx, ' ')
	where	addr_type	is null
	or	addr_pfx	is null
	or	addr_sfx	is null
	;
	COMMIT;

--	=====================================================================
--	DELETE DUPLICATE ADDRESSES

--	remove inactive duplicates

	DELETE from garland.Common_CUS
	where	rowid in
(
	select	
		UMS.rowid			ums_rowid
--		,UMS.addr_name, UMS.addr_type, UMS.addr_pfx, UMS.addr_sfx, UMS.addr_num 
--		,UMS.location_no
	from	garland.Common_CUS	UMS,
(
	select 
		c.addr_name, c.addr_type, c.addr_pfx, c.addr_sfx, c.addr_num, 
		max(c.activity_date) activity_date
	from		garland.Common_CUS	C
	group by	c.addr_name, c.addr_type, c.addr_pfx, c.addr_sfx, c.addr_num 
	having	count(*) > 1
)						ADR
	where	ums.addr_name		= adr.addr_name
	and	ums.addr_type		= adr.addr_type
	and	ums.addr_pfx		= adr.addr_pfx
	and	ums.addr_sfx		= adr.addr_sfx
	and	nvl(ums.addr_num,0)	= nvl(adr.addr_num,0)
	and	ums.activity_date		<> adr.activity_date
)	;

	total_delete1 := sql%rowcount;

	COMMIT;

--	remove active duplicates

	DELETE from garland.Common_CUS
	where	rowid in
(
	select	
		UMS.rowid			ums_rowid
	from	garland.Common_CUS	UMS,
(
	select 
		c.addr_name, c.addr_type, c.addr_pfx, c.addr_sfx, c.addr_num, 
		max(rowid) maxrow
	from		garland.Common_CUS	C
	group by	c.addr_name, c.addr_type, c.addr_pfx, c.addr_sfx, c.addr_num 
	having	count(*) > 1
)						ADR
	where	ums.addr_name		= adr.addr_name
	and	ums.addr_type		= adr.addr_type
	and	ums.addr_pfx		= adr.addr_pfx
	and	ums.addr_sfx		= adr.addr_sfx
	and	nvl(ums.addr_num,0)	= nvl(adr.addr_num,0)
	and 	ums.rowid			<> adr.maxrow
)	;

	total_delete2 := sql%rowcount;

	COMMIT;

--	=====================================================================

--	dbms_output.put_line ( '-----');
	dbms_output.put_line ( 'TOTAL DELETE INACTIVE: ' || total_delete1);
	dbms_output.put_line ( 'TOTAL DELETE DUPES:    ' || total_delete2);

	select count(*) into counter from garland.Common_CUS;
	dbms_output.put_line ( 'TOTAL REMAINING:        ' || counter);

--	dbms_output.put_line ( 'TOTAL UPDATE:           ' || total_update);
--	select count(*) into total_ignore from garland.Common_CUS where location_no <> parent_id;
--	=====================================================================

END;



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
