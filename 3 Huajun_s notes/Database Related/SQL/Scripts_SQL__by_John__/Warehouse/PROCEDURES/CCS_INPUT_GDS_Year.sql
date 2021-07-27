--	=====================================================================
set echo		off;
set linesize	2000;
set pagesize	9999;
set sqlblanklines	on;
set timing		off;
set serveroutput	on	size 99999;
--	=====================================================================
--	INPUT GDS_ACCOUNT from EXTERNAL_GDS_ACCOUNT
--	=====================================================================

--	execute	garland.CCS_INPUT_GDS_YEAR;

	create or replace procedure garland.CCS_INPUT_GDS_YEAR	AS

--	DECLARE

--	=====================================================================

	compile_only	integer	:= 0;

	total_processed	integer	:= 0;
	counter		integer	:= 0;
	test_year		integer	:= 0;
	this_year		integer	:= 0;
	title			varchar2(100);
	heading		varchar2(100);
	script		varchar2(2000);

BEGIN
	if	compile_only > 0		then
		return;
	end if;

	select count(*) into counter from TaxRecords@gdstax;
	if	counter < 60000	then
		dbms_output.put_line ('*** ERROR *** Tax Year not available');
		return;
	end if;

	select '*** CCS INPUT GDS YEAR ' into heading from dual; 
	dbms_output.put_line(heading);

--	=====================================================================

	this_year := to_char(sysdate,'yyyy');

	select count(*) into counter 
	from	garland.GDS_Year
	where	year = this_year;

	dbms_output.put_line ( 'This TAX Year = ' || counter);

	if	counter < 65000			then
		this_year := this_year - 01;		

		select count(*) into counter 
		from TaxRecords@gdstax 
		where "TaxYear" = this_year;
	end if;

	dbms_output.put_line ( 'Last TAX Year = ' || counter);
	
	if	counter < 65000			then
		dbms_output.put_line ( '*** ERROR *** Insufficient records found for Tax Year');
		return;
	end if;

--	=====================================================================

	script := 'Truncate table garland.GDS_YEAR reuse storage';
	DBMS_UTILITY.EXEC_DDL_STATEMENT (Script);

--	=====================================================================

	insert --+ append
	into   garland.GDS_YEAR
	(	   account,  year,      acct_type,	    entity,	     tax_flag,  net_taxable_value, base_tax )
	select "Account", "TaxYear", "PropertyType", "TaxEntity", "TaxFlag", "NetTaxableValue", "BaseTax" 
	from	TaxRecords@gdstax
	where	"TaxYear" = this_year;

	total_processed := sql%rowcount;

	select '*** CCS INPUT GDS YEAR Total = ' || total_processed into heading from dual; 
	dbms_output.put_line(heading);

	COMMIT;

--	=====================================================================

--	title := '*** CCS INPUT GDS YEAR Analyze  ';  dbms_output.put_line(title);

	script := 'analyze table garland.GDS_YEAR  compute statistics';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

--	=====================================================================

END;

