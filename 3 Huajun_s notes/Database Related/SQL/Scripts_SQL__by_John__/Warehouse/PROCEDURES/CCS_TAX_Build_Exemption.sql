--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
--	===========================================================================
--	Find Exemption Codes for each TAX Account
--	===========================================================================

	create or replace view garland.CCS_TAX_EXEMPTION_VIEW AS 
	select item01 account, item02	exempt1, item03 exempt2, item04 exempt3 
	from garland.GIS_Temp2;

--	===========================================================================


--	execute	garland.CCS_TAX_BUILD_EXEMPTION;

	create or replace procedure garland.CCS_TAX_BUILD_EXEMPTION		as

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

	title := 'BUILD EXEMPTION   ';
	dbms_output.put_line(title);

	script := 'Truncate table garland.GIS_Temp2 reuse storage';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

--	script := 
--	'create or replace view garland.Temp_View2 AS '		||
--	'select item01 account, item02	exempt1, item03 exempt2, item04 exempt3 from garland.GIS_Temp2';
--	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

--	===========================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan set statement_id =  'exempt1'	into garland.plan_table	for
--	===========================================================================

	insert --+ append
	into		garland.CCS_Tax_Exemption_View
	(
		 account
		,exempt1
		,exempt2
		,exempt3
	)
	select --+ use_hash (e)
			A.account, E.exempt_code, null, null
	from		garland.GDS_Account		A,
			garland.GDS_Exemption		E,	
		(	select max(tax_year) tax_year	from garland.GDS_Exemption)	Y
	where		a.account		= ltrim(e.account,'0') 
	and		e.tax_year 		= y.tax_year
	and		e.exempt_code   	in ( 'HS', 'AG', 'SR' )	
	;

	total_processed := sql%rowcount;
	dbms_output.put_line ( 'Total Exemption1 ' || total_processed);

	COMMIT;

--	===========================================================================
--	explain plan set statement_id =  'exempt2'	into garland.plan_table	for

	insert --+ append
	into		garland.CCS_Tax_Exemption_View
	(
		 account
		,exempt1
		,exempt2
		,exempt3
	)
	select --+ use_hash (e)
			A.account, E.exempt_code, null, null
	from		garland.GDS_Account		A,
			garland.GDS_Exemption		E,	
		(	select max(tax_year) tax_year	from garland.GDS_Exemption)		Y
	where		a.account		= ltrim(e.account,'0') 
	and		e.tax_year 		= y.tax_year
	and		e.exempt_code   	in ( 'DV' )	
	and not exists
(	select 'x' from  garland.CCS_Tax_Exemption_View where account = rtrim (a.account));

	total_processed := sql%rowcount;
	dbms_output.put_line ( 'Total Exemption2 ' || total_processed);

	COMMIT;

--	===========================================================================
--	explain plan set statement_id =  'exempt3'	into garland.plan_table	for

	insert --+ append
	into		garland.CCS_Tax_Exemption_View
	(
		 account
		,exempt1
		,exempt2
		,exempt3
	)
	select --+ use_hash (e)
			A.account, E.exempt_code, null, null
	from		garland.GDS_Account		A,
			garland.GDS_Exemption		E,	
		(	select max(tax_year) tax_year	from garland.GDS_Exemption)	Y
	where		a.account		= ltrim(e.account,'0') 
	and		e.tax_year 		= y.tax_year
	and		e.exempt_code   	in ( 'AS' )	
	and not exists
(	select 'x' from garland.CCS_Tax_Exemption_View where account = rtrim (a.account));

	total_processed := sql%rowcount;
	dbms_output.put_line ( 'Total Exemption3 ' || total_processed);

	COMMIT;

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;
--	===========================================================================

END;

