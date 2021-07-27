--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

--	=====================================================================

--	execute	garland.CCS_VERIFY_UMS;

--	create or replace procedure garland.CCS_VERIFY_UMS		AS

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
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

	insert --+ append
	into	 garland.adrResult_Input
	(	rec_key,	rec_seq,	
		appl_num,	appl_pfx,	appl_name,	appl_type,	appl_sfx, 
		appl_code1, appl_unit1, appl_code2, appl_unit2 )
	Select 
		ucbprem_code		rec_key, 
		0				rec_seq, 
		ucbprem_street_number	addr_num,
		ucbprem_pdir_code_pre	addr_pfx,
		ucbprem_street_name	addr_name,
		ucbprem_ssfx_code		addr_type,
		ucbprem_pdir_code_post	addr_sfx,
		ucbprem_utyp_code		addr_code1,
		ucbprem_unit		addr_unit1,
		null				addr_code2, 
		null				addr_unit2
	from	ucbprem@banbprd

	where	ucbprem_street_name not like 'FLOATING%' 
	and	ucbprem_street_name not like 'FIRE HYDRANT%' 
	and	translate (ucbprem_street_number, '/1234567890 ', '/') is null
	and	rtrim(ucbprem_unit) is null
	;

	total_processed := sql%rowcount;
	dbms_output.put_line ( 'Input Total ' || total_processed );

	COMMIT;

--	===============================================================================

	garland.SCRUB_ADDRESS;

--	===============================================================

	script := 'Truncate table garland.adrResult_UMS_Location reuse storage';
	execute immediate (script);

	insert --+ append
	into	garland.adrResult_UMS_Location
	select * from garland.adrRESULT;

	total_processed := sql%rowcount;
	dbms_output.put_line ( 'CCS VERIFY UMS Result total =    ' || total_processed );

	COMMIT;

	script := 'analyze table garland.adrResult_UMS_Location compute statistics';
	execute immediate (script);

--	===============================================================================

END;
