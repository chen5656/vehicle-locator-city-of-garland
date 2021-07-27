--	=====================================================================
set echo		off;
set linesize	2000;
set pagesize	999;
set sqlblanklines	on;
set serveroutput	on	size 99999;
-- alter session set nls_date_format = 'yyyy-mm-dd  hh24:mi:ss';  

--	=====================================================================

	create or replace view	garland.CCS_UMS_KEYS_VIEW  as 
	select item01 location_no, item02 account_no, item03 service_seq, item04 person_no, item05 effective_dt  
	from	garland.gis_TEMP4;

--	=====================================================================

--	execute	garland.CCS_UMS_Get_Keys;

	create or replace procedure garland.CCS_UMS_Get_Keys	as

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

	title := 'GET UMS KEYS ';	dbms_output.put_line(title);

	script := 'Truncate table garland.GIS_TEMP4 reuse storage';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

	insert --+ append
	into garland.CCS_UMS_KEYS_VIEW
	(
		 location_no
		,account_no
		,service_seq
		,person_no
		,effective_dt
	)
	select 
		l.location_no, 
		a.account_no, 
		x.service_seq, 
		p.person_no, 
		to_char(x.effective_dt,'yyyymmdd') 
	from	sfg.um00250t@umsrep.world		X,	
		sfg.um00100m@umsrep.world		L,	
		sfg.um00200m@umsrep.world		A,	
		sfg.sg00100m@umsrep.world		P	
	where	x.location_no = l.location_no
	and	x.account_no  = a.account_no
	and	p.person_no	  = a.person_no
	and	rtrim(x.service_stat)	  	   =  'CUTON'
	and	nvl(rtrim(l.location_stat),' ') in ('ACT')
	and	nvl(rtrim(p.person_stat),  ' ') in ('ACT', ' ')
	and	ltrim(l.city) 			like  'G%'
	and	rtrim		(l.sec_addr_id)	  is null
	and	rtrim(ltrim	(l.sec_addr_range)) is null
	;

	total_processed := sql%rowcount;
	dbms_output.put_line ( 'Total UMS Keys: ' || total_processed);

	COMMIT;

	script := 'analyze table garland.GIS_TEMP4 compute statistics';
	DBMS_UTILITY.EXEC_DDL_STATEMENT(script);

END;

