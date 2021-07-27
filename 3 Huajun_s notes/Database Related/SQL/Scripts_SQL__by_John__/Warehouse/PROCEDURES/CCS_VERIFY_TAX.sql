--	=====================================================================
set echo		on;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	=====================================================================

--	execute	garland.CCS_VERIFY_TAX;

	create or replace procedure garland.CCS_VERIFY_TAX	AS

--	DECLARE

--	=====================================================================

	compile_only	integer	:= 0;

	total_processed	integer	:= 0;
	title			varchar2(100);
	heading		varchar2(100);
	script		varchar2(2000);
	this_year		integer;

BEGIN
	if	compile_only > 0		then
		return;
	end if;

	select '***  CCS VERIFY TAX ' into heading from dual; 
	dbms_output.put_line(heading);

--	===============================================================================

	script := 'truncate table garland.AdrResult_Input reuse storage';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

	insert --+ append
	into	 garland.adrResult_Input
	(	 rec_key, 			rec_seq, 	appl_num, 			appl_name	)

	select ltrim(a.Account,'0'),  0,		ltrim(a.addr_num,'0'),	a.addr_name	
	from	 garland.GDS_Account	A,

	(	select	ltrim(Account,'0')	Account, 
				Year				Year 
		from	garland.GDS_Year
		where year in (select max(year) from garland.GDS_Year)
	)					Y

	where		a.account	= y.account
	and		a.acct_type	= 'R'
	;

	total_processed := sql%rowcount;
	dbms_output.put_line ( 'Input Total ' || total_processed );

	COMMIT;

--	DBMS_UTILITY.EXEC_DDL_STATEMENT ('analyze table GARLAND.ADRRESULT_INPUT compute statistics');

--	===============================================================

	garland.SCRUB_ADDRESS;

--	===============================================================

	script := 'Truncate table garland.adrResult_TAX_GDS reuse storage';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

	insert --+ append
	into	garland.adrResult_TAX_GDS
	select * from garland.adrRESULT;

	total_processed := sql%rowcount;
	dbms_output.put_line ( 'CCS VERIFY TAX Result total =    ' || total_processed );

	COMMIT;

	script := 'analyze table garland.adrResult_TAX_GDS compute statistics';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

--	===============================================================================
/*
	select max(year) into this_year from garland.gds_year;
	script := 
		'create or replace view	garland.adrResult_User	AS'
	||	' select ltrim(a.Account,''0'') rec_key, a.rowid rec_rowid,'
	||	' ltrim(addr_num,''0'') addr_num, null addr_pfx,addr_name addr_name,'
	||	' null addr_type, null addr_sfx, null addr_code1, null addr_unit1, null addr_code2, null addr_unit2'
	||	' from	garland.GDS_Account A, garland.GDS_Year Y'
	||	' where a.acct_type = ''R'' and a.account = ltrim(y.account,''0'') and y.year = ' ||this_year
	;
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);
*/
--	===============================================================================

END;