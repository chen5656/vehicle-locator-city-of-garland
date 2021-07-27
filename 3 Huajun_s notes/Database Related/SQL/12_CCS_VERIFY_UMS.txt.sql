--	=====================================================================
--	select * from viewer.me;
--	BEGIN  SERVER USER  SERVER USER  SERVER USER  SERVER USER  SERVER USER  SERVER USER  END;
set	TIMING		ON;
set	sqlblanklines	on;
set	serveroutput	on	size 99999;
set	linesize		1000;
set	pagesize		0000;
--	execute jdeacutis.show_table_column	('', '', '');
--	execute jdeacutis.show_source		('CCS_VERIFY_UMS', 'garland', '');
--	execute jdeacutis.show_error		('CCS_VERIFY_UMS', 'garland', '');
--	execute jdeacutis.show_view		('', '', '');
--	execute jdeacutis.show_index_column	('', '', '');
--	SELECT  to_char(sysdate,'Mon dd,yyyy hh24:mi')||'  ***  ' " "  from dual;
--	EXECUTE jdeacutis.TEST_PROC;
--	CREATE or replace procedure jdeacutis.TEST_PROC  as
--	DECLARE
--	=====================================================================	
/*

	CREATE or replace View	garland.CCS_Verify_UMS_View	as
	select --+ no_merge
		p.ucbprem_code			rec_key,

--		0					rec_seq,
		rownum					rec_seq,

		p.ucbprem_street_number		addr_num,
		p.ucbprem_pdir_code_pre		addr_pfx,
		p.ucbprem_street_name		addr_name,
		p.ucbprem_ssfx_code		addr_type,
		p.ucbprem_pdir_code_post	addr_sfx,

--		p.ucbprem_utyp_code		addr_code1,
--		p.ucbprem_unit			addr_unit1,
		null					addr_code1,
		null					addr_unit1,
		null					addr_code2,
		null					addr_unit2

	from	ucrACCT@banbprd		A,
		ucbPREM@banbprd		P,
		ucbCUST@banbprd		C
	where	a.ucracct_prem_code	= p.ucbprem_code
	and	a.ucracct_cust_code	= c.ucbcust_cust_code
	and	ucracct_status_ind	= 'A'
	and	ucbcust_status_ind	= 'A'
	and	p.ucbprem_date_retired	is null
	and	translate(p.ucbprem_street_number,'x1234567890','x') is null
--	and	rtrim(p.ucbprem_unit)	is null
--	and	length(ucbprem_street_name) <= 20
--	and	length(ucbcust_last_name)   <= 40
	;
	
*/
--	=====================================================================	

--	EXECUTE 			garland.CCS_VERIFY_UMS;

--	CREATE or replace procedure	garland.CCS_VERIFY_UMS		AS

	DECLARE

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

	select '***  CCS VERIFY UMS ' into heading from dual;
	dbms_output.put_line(heading);

--	===============================================================================

	script := 'truncate table garland.AdrResult_Input reuse storage';
	execute immediate (script);

	INSERT
	into	 garland.adrResult_Input
	(	rec_key,	rec_seq,
		appl_num,	appl_pfx,	appl_name,	appl_type,	appl_sfx,
		appl_code1, appl_unit1, appl_code2, appl_unit2 )

	select * from garland.CCS_Verify_UMS_View;

	total_processed := sql%rowcount;
	dbms_output.put_line ( 'Input Total ' || total_processed );

	COMMIT;

--	===============================================================================

	garland.SCRUB_ADDRESS;

--	===============================================================

--	duplicates exist due to multiple services (electric,water,sewer) at the same address

	DELETE from garland.adrResult	
	where rec_seq in
(
	select	a.rec_seq from
	( select rec_key, rec_seq
 	  from garland.adrResult	 )		A,
	( select rec_key, min(rec_seq) 	minseq		
	  from garland.adrResult 
	  group by rec_key having count(*) > 1 )	B
	where	a.rec_key	= b.rec_key
	and	a.rec_seq	> b.minseq
);

	COMMIT;

--	===============================================================

	script := 'Truncate table garland.adrResult_Banner reuse storage';
	execute immediate (script);

	insert --+ append
	into	garland.adrResult_Banner
	select * from garland.adrRESULT;

	total_processed := sql%rowcount;
	dbms_output.put_line ( 'CCS VERIFY UMS Result total =    ' || total_processed );

	COMMIT;

	script := 'analyze table garland.adrResult_Banner compute statistics';
	execute immediate (script);

--	===============================================================================

END;


--	============================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan set	statement_id = 'x'	into jdeacutis.plan_table for
--	============================================================

--	============================================================
--	select * from jdeacutis.explain_Plan;
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	insert   into jdeacutis.plan_table (object_owner, object_name) values ('', '');
--	============================================================