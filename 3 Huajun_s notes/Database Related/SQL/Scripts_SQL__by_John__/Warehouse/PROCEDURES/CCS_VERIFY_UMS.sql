--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

--	=====================================================================

--	execute	garland.CCS_VERIFY_UMS;

	create or replace procedure garland.CCS_VERIFY_UMS		AS

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

	select '***  CCS VERIFY UMS ' into heading from dual; 
	dbms_output.put_line(heading);

--	===============================================================================

	script := 'truncate table garland.AdrResult_Input reuse storage';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

	insert --+ append
	into	 garland.adrResult_Input
	(	rec_key, rec_seq,	appl_num, appl_pfx, appl_name,	
		appl_type, appl_sfx, appl_code1, appl_unit1, appl_code2, appl_unit2 )
	Select location_no rec_key, 0 rec_seq, 
	rtrim(ltrim(house_no)) addr_num, rtrim(street_pfx_dir) addr_pfx, rtrim(street_nm) addr_name, 
	rtrim(street_nm_sfx) addr_type, rtrim(street_sfx_dir) addr_sfx, 
	rtrim(sec_addr_id) addr_code1, rtrim(sec_addr_range) addr_unit1, null addr_code2, null addr_unit2 
	from	sfg.um00100m@umsrep.world 
	where location_stat = 'ACT' 
	and	street_nm not like 'FLOATING%' 
	and	street_nm not like 'FIRE HYDRANT%' 
	and	translate (house_no, '/1234567890 ', '/') is null;

	total_processed := sql%rowcount;
	dbms_output.put_line ( 'Input Total ' || total_processed );

	COMMIT;

--	===============================================================================

	garland.SCRUB_ADDRESS;

--	===============================================================

	script := 'Truncate table garland.adrResult_UMS_Location reuse storage';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

	insert --+ append
	into	garland.adrResult_UMS_Location
	select * from garland.adrRESULT;

	total_processed := sql%rowcount;
	dbms_output.put_line ( 'CCS VERIFY UMS Result total =    ' || total_processed );

	COMMIT;

	script := 'analyze table garland.adrResult_UMS_Location compute statistics';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);


--	===============================================================================
/*
	script :=
		' create or replace view garland.adrResult_User As Select'
	||	' location_no rec_key, null rec_rowid, rtrim(ltrim(house_no)) addr_num, rtrim(street_pfx_dir) addr_pfx,'
	||	' rtrim(street_nm) addr_name, rtrim(street_nm_sfx) addr_type, rtrim(street_sfx_dir) addr_sfx,'
	||	' rtrim(sec_addr_id) addr_code1, rtrim(sec_addr_range) addr_unit1, null addr_code2, null addr_unit2'
	||	' from sfg.um00100m@umsrep.world where location_stat = ''ACT'''
	||	' and	street_nm not like ''FLOATING%'' and street_nm not like ''FIRE HYDRANT%'''
	||	' and	translate (house_no, ''/1234567890 '', ''/'') is null'
	;
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);
*/
--	===============================================================================

END;
