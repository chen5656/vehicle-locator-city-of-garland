--	=====================================================================
set echo		off;
set timing		off;
set sqlblanklines	on;
set serveroutput	on	size 9999;
set linesize	400;
set pagesize	9999;
--	=====================================================================

--	execute	garland.CCS_TAX_VERIFY_INPUT;

	create or replace procedure garland.CCS_TAX_VERIFY_INPUT		As

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

--	=================================================================================
	title := '***  CCS TAX   ';
	dbms_output.put_line(title);
--	=================================================================================

	script := 'truncate table garland.AdrResult_Input reuse storage';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (script);

	insert --+ append
	into	 garland.adrResult_Input

	(	 rec_key, 			rec_seq, 	appl_num, 			appl_name	)
	select ltrim(a.Account,'0'),  0,		ltrim(a.addr_num,'0'),	a.addr_name	)

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

	DBMS_UTILITY.EXEC_DDL_STATEMENT ('analyze table GARLAND.ADRRESULT_INPUT compute statistics');

--	===============================================================

END;
