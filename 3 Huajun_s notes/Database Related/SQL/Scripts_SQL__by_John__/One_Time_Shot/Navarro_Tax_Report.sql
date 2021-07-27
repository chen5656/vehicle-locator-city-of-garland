--	=====================================================================
set echo		off
set timing		off
set sqlblanklines	on
set serveroutput	on	size 99999
set linesize	2000
set pagesize	9999
-- set pagesize	74
-- set pagesize	57
-- alter session set nls_date_format = 'yyyymmdd hh24miss'  
--	=====================================================================

--	eileen navarro report

--	=====================================================================

	create or replace view	garland.Temp_View1	as
	select
		item01	parcel_id,
		item02	account,
		item03	exemption,
		item04	year,
		item05	streetnum,
		item06	streetprefix,
		item07	streetname,
		item08	streettype,
		item09	streetsuffix
	from	garland.GIS_Temp1;

--	=====================================================================

	truncate table	garland.GIS_Temp1		reuse storage;

--	=====================================================================
--	truncate table	jdeacutis.plan_table	reuse storage;
--	explain plan	set statement_id = ' '	into jdeacutis.plan_table for
--	=====================================================================

	insert into garland.Temp_View1

--	select count(distinct t.rec_key || e.exempt_code || y.year)
--	85,250

	select distinct 
		t.parcel_id, t.rec_key,
		e.exempt_code, y.year, 
		t.addr_num, t.addr_pfx, t.addr_name, t.addr_type, t.addr_sfx
  
	from	garland.adrResult_TAX_GDS	T,
		garland.GDS_Exemption		E,
		garland.GDS_Year			Y

	where	t.rec_key	= ltrim(e.account,'0')
	and	e.account	= y.account
	and	y.year	= 2006
	and	e.tax_year	= 2006
	and	e.exempt_code in ( 'HM', 'HS')
	and	t.verify_code = 55
	;

--	=====================================================================
--	select * from jdeacutis.explain_Plan;
--	execute	  jdeacutis.explain_More;
--	select * from jdeacutis.explain_Indexed;
--	select * from jdeacutis.explain_Analyze;
--	select * from jdeacutis.explain_Column;
--	=====================================================================

	select count(*) tax_accounts				from garland.adrResult_TAX_GDS;

	select count(*) verified				from garland.adrResult_TAX_GDS where verify_code = 55;
	
	select count(*) output					from garland.Temp_View1;

	select count(distinct account) out_accounts	from garland.Temp_View1;      


	select Counter		"EXEMPTS/ACCT", 
		 count(*)		occurs	
	from	
(
	select count(distinct Exemption) Counter	
	from garland.Temp_View1
	group by Account
)
	group by Counter;

--	=====================================================================


