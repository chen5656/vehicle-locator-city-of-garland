--	================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';
--	===========================================================================
--	Find Exemption Codes for each TAX Account
--	===========================================================================

	Truncate table	garland.GIS_Temp2		reuse storage;

--	===========================================================================

	create or replace view	garland.Temp_View2	AS

	select
		item01	account,
		item02	exempt1,
		item03	exempt2,
		item04	exempt3
	from	garland.GIS_Temp2;

--	as select item01, item02, item03, item04 from garland.GIS_Temp2;

--	===========================================================================
--	truncate table	garland.plan_table	reuse storage;
--	explain plan set statement_id =  'exempt1'	into garland.plan_table	for
--	===========================================================================

	insert --+ append
	into	 garland.Temp_View2

	select --+ use_hash (e)

			A.account, E.exempt_code, null, null

	from		garland.GDS_Account		A,
			garland.GDS_Exemption		E,	
		(
			select max(tax_year)	tax_year
			from	garland.GDS_Exemption
		)						Y

	where		a.account		= ltrim(e.account,'0') 
	and		e.tax_year 		= y.tax_year
	and		e.exempt_code   	in ( 'HS', 'AG', 'SR' )	
	;

--	===========================================================================

	commit;

--	===========================================================================
--	explain plan set statement_id =  'exempt2'	into garland.plan_table	for

	insert --+ append
	into	 garland.Temp_View2

	select --+ use_hash (e)

			A.account, E.exempt_code, null, null

	from		garland.GDS_Account		A,
			garland.GDS_Exemption		E,	
		(
			select max(tax_year)	tax_year
			from	garland.GDS_Exemption
		)						Y

	where		a.account		= ltrim(e.account,'0') 
	and		e.tax_year 		= y.tax_year
	and		e.exempt_code   	in ( 'DV' )	

	and not exists
(
	select 'x'
	from	 garland.Temp_View2
	where	 account = rtrim (a.account)
);

--	===========================================================================

	commit;

--	===========================================================================
--	explain plan set statement_id =  'exempt3'	into garland.plan_table	for

	insert --+ append
	into	 garland.Temp_View2

	select --+ use_hash (e)

			A.account, E.exempt_code, null, null

	from		garland.GDS_Account		A,
			garland.GDS_Exemption		E,	
		(
			select max(tax_year)	tax_year
			from	garland.GDS_Exemption
		)						Y

	where		a.account		= ltrim(e.account,'0') 
	and		e.tax_year 		= y.tax_year
	and		e.exempt_code   	in ( 'AS' )	

	and not exists
(
	select 'x'
	from	 garland.Temp_View2
	where	 account = rtrim (a.account)
);

--	===========================================================================
--	select * from garland.explain_plan;
--	select * from garland.explain_indexed;

	commit;

--	===========================================================================
--	SUMMARY

	select exempt1		exemption,  
	count(*) 			total
	from garland.temp_view2
	group by exempt1;

	select sum(count(*))	duplicates
	from	garland.temp_view2
	group by account
	having count(*) > 1;

--	---------------------------------------------------------------------------

	select exempt_code, count(*) total
	from garland.gds_exemption
	group by exempt_code;

	select  sum(count(*))	conflicts
	from	garland.GDS_Exemption
	where		exempt_code   	in ( 'HS',  'AG', 'SR' )	
	and		tax_year = '2004'	
	group by account, tax_year
	having count(*) > 1;

	select  sum(count(*))	conflicts
	from	garland.GDS_Exemption
	where		exempt_code   	in ( 'DV' )	
	and		tax_year = '2004'	
	group by account, tax_year
	having count(*) > 1;


--	Coexisting exemptions
--		SR & HM
--		DV & DP

--	===========================================================================
/*	what is the current tax year - which officially starts on Oct 1st

		select
		decode (	sign( to_char(sysdate,'mm')   - 09	),
				1,	to_char(sysdate,'yyyy') + 01, 
					to_char(sysdate,'yyyy') + 00	)	tax_year
		from	Dual;


================
EXEMPTION CODES
================
AB ABATEMENT 
AG AGRICULTURE DEFERAL
AS ABSOLUTE EXEMPT
DP DISABLED PERSON 
DV DISABLED VET 
FP FREEPORT 
HC HOMESTEAD CAP
HM HOMESTEAD 
HS HOMESTEAD 
NV NOMINAL VALUE (HB366 OR UNDER 500 PERSONAL PROPERTY)
PC POLLUTION CONTROL
SR > 65 

*/
--	===========================================================================
