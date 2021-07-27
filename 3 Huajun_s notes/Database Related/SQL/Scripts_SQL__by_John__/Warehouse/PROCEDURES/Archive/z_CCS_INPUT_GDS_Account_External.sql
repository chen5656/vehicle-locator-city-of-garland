--	=====================================================================
set echo		off;
set linesize	2000;
set pagesize	9999;
set sqlblanklines	on;
set timing		off;
set serveroutput	on	size 99999;
--	=====================================================================
--	Load GDS_ACCOUNT from EXTERNAL_GDS_ACCOUNT
--	=====================================================================

--	execute	garland.CCS_INPUT_GDS_Account;

	create or replace procedure garland.CCS_INPUT_GDS_Account	AS

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

	select '*** CCS INPUT GDS Account '||to_char(sysdate,'Mon dd hh24:mi') into heading from dual; 
	dbms_output.put_line(heading);

--	=====================================================================

	script := 'Truncate table garland.GDS_ACCOUNT reuse storage';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (Script);

--	===========================================================================

	insert --+ append
	into garland.GDS_ACCOUNT
(
	Account,		
	PIDN,			
	Owner_Name,		
	Owner_Addr1,		
	Owner_Addr2,		
	Owner_Addr3,		
	Owner_Addr4,		
	Owner_Zip,		
	Addr_Num,		
	Addr_Name,		
	Legal1,		
	Legal2,		
	Legal3,		
	Legal4,		
	mortgage_co,			
	Acct_Type,		
	Acct_Use		
)
	select
	ltrim(Account,'0'),
	rtrim(PIDN),			
	rtrim(Owner_Name),		
	rtrim(Owner_Addr1),		
	rtrim(Owner_Addr2),		
	rtrim(Owner_Addr3),		
	rtrim(Owner_Addr4),		
	rtrim(Owner_Zip),		
	rtrim(Addr_Num),		
	rtrim(Addr_Name),		
	rtrim(Legal1),		
	rtrim(Legal2),		
	rtrim(Legal3),		
	rtrim(Legal4),		
	null,			
	rtrim(Acct_Type),		
	rtrim(Acct_Use)		
	from garland.GDS_ACCOUNT_EXTERNAL;

	total_processed := sql%rowcount;
	dbms_output.put_line ( '  total = ' || total_processed);

	COMMIT;

--	==============================================================================

	title := '*** CCS INPUT GDS ACCOUNT Analyze  ';  dbms_output.put_line(title);

	script := 'analyze table garland.GDS_ACCOUNT  compute statistics';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

END;

